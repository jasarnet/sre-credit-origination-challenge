## 1. Estrategia de Confiabilidad

La estrategia de confiabilidad para la API de originación de créditos se basa en medir y proteger la experiencia real del usuario, priorizando señales accionables y alineando la operación técnica con el impacto al negocio. Dado que el servicio es crítico, la confiabilidad se trata como un requerimiento funcional, no como un objetivo aspiracional.

La estrategia se fundamenta en tres pilares:

1. Definición clara de indicadores de confiabilidad (SLIs)
2. Establecimiento de objetivos de servicio (SLOs) alineados al negocio
3. Obtención de señales confiables mediante fuentes de datos consistentes

### 1.1 Métricas de Confiabilidad (SLIs)

Los indicadores de confiabilidad definidos se centran en el comportamiento observado por el usuario y en los puntos de mayor riesgo operativo del sistema:

- **Disponibilidad**
- **Latencia**
- **Tasa de errores**
- **Autenticación**
- **Dependencia del proveedor de scoring**


| Métrica            | ¿Qué mide?                    | Ejemplo                                                                 |
|--------------------|-------------------------------|-------------------------------------------------------------------------|
| Disponibilidad     | ¿Responde el sistema?         | De cada 100 solicitudes, 99 respondieron bien (HTTP 200).              |
| Latencia           | ¿Qué tan rápido responde?     | El 95% de los usuarios recibió respuesta en menos de 500 ms.           |
| Tasa de errores    | ¿Cuántas fallas hubo?         | Solo 1 de cada 100 solicitudes terminó en error 500.                   |
| Autenticación      | ¿Funciona el login?           | De cada 1,000 intentos de login, solo 5 fallaron por error interno.    |
| Scoring externo    | ¿Responde FICO?               | El proveedor tardó más de 2 segundos en responder 3 veces seguidas.    |



## Disponibilidad

**Definición:**  
Porcentaje de solicitudes válidas que reciben una respuesta exitosa.

**Fórmula:**

Disponibilidad = (Respuestas exitosas (HTTP 2xx, 3xx) / Total de solicitudes) × 100

**Fuente de datos:**  
- Application Load Balancer (ALB): métricas de *RequestCount* y códigos HTTP.

**Ejemplo:**
- **Datos:** 98,500 respuestas 2xx/3xx de 98,700 solicitudes.
- **Cálculo:**

Disponibilidad = (98,500 / 98,700) × 100 = **99.80%**

**Notas:**
- No se incluyen errores 4xx, ya que son errores del cliente atribuibles a validaciones.
- Ventana de medición:
  - **SLO:** mensual  
  - **Monitoreo:** continuo en intervalos de 1–5 minutos.

---

## Latencia

**Definición:**  
Tiempo de respuesta observado por el usuario, medido en percentiles altos.

**Fórmulas:**
- **p95:** tiempo tal que el 95% de las respuestas son menores o iguales.
- **p99:** tiempo tal que el 99% de las respuestas son menores o iguales.

**Fuente de datos:**  
- ALB *Target Response Time*  
- Logs de backend con tiempo de respuesta.

**Ejemplo:**
- **Datos (ms):**  
  `[120, 180, 220, 250, 260, 270, 280, 300, 1200, 1500]`
- **Cálculo conceptual:**  
  Se ordenan los tiempos y se toman los valores en las posiciones correspondientes al 95% y 99%.
- **Resultados aproximados:**  
  - p95 ≈ **1,200 ms**  
  - p99 ≈ **1,500 ms**

**Notas:**
- Se utilizan percentiles en lugar de promedios para capturar degradaciones.
- La latencia mide el tiempo de respuesta percibido por el usuario.
- Los percentiles p95 y p99 del ALB permiten detectar problemas no visibles en métricas promedio.

---

## Tasa de errores

**Definición:**  
Proporción de respuestas con errores del servidor.

**Fórmula:**

Error rate (5xx) = (Respuestas HTTP 5xx / Total de solicitudes) × 100

**Fuente de datos:**  
- ALB  
- Logs del backend con códigos HTTP.

**Ejemplo:**
- **Datos:** 420 respuestas 5xx de 42,000 solicitudes.
- **Cálculo:**

Error rate (5xx) = (420 / 42,000) × 100 = **0.1%**

**Notas:**
- Se pueden separar los errores por tipo:
  - **5xx:** errores del servidor  
  - **4xx:** errores del cliente (para análisis, no para SLO)

---

## Autenticación

**Definición:**  
Éxito y rendimiento del proceso de validación de identidad (login y verificación de tokens).

**Fórmulas:**

- **Tasa de fallos de autenticación:**

Auth error rate = (Validaciones fallidas por error interno / Total de validaciones) × 100

- **Latencia de validación:**  
  Medida en p95 y p99 del tiempo de verificación de tokens.

**Fuente de datos:**  
- Logs del backend durante la validación de tokens.
- Eventos de autenticación.

**Ejemplo:**
- **Datos:** 12 validaciones fallidas internas de 2,400 validaciones totales.
- **Cálculo:**

Auth error rate = (12 / 2,400) × 100 = **0.5%**

**Notas:**
- Se distinguen:
  - Tokens inválidos por el usuario (no cuentan para el SLO).
  - Fallos internos del sistema (sí cuentan).
- Se recomienda reportar también la latencia p95/p99 de la validación de tokens.

### 1.2 Objetivos de Servicio (SLOs)

| Métrica          | Compromiso (SLO)            | Ejemplo                                                                 | Justificación de negocio                                                                 |
|------------------|-----------------------------|-------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| Disponibilidad   | 99.9% mensual               | El sistema puede fallar como máximo 43 minutos al mes.                 | Cada minuto de caída significa solicitudes perdidas y pérdida directa de ingresos.     |
| Latencia         | p95 ≤ 500 ms                | De cada 100 usuarios, 95 deben recibir respuesta en menos de medio segundo. | La rapidez es clave: si tarda más de 1 segundo, el cliente abandona o pierde confianza. |
| Errores 5xx      | ≤ 1% mensual                | Máximo 1 error interno por cada 100 solicitudes.                        | Los errores internos afectan directamente la continuidad del proceso de crédito.       |
| Autenticación    | ≤ 0.5% de fallos internos   | De cada 1,000 logins, máximo 5 pueden fallar por error del sistema.     | Si el login falla, el usuario ni siquiera entra al flujo de crédito.                    |
| Scoring externo  | Latencia p95 ≤ 1,000 ms y ≤ 2% errores | El proveedor de scoring debe responder en menos de 1 segundo para el 95% de las solicitudes. | El scoring es un cuello de botella externo: si falla, el crédito no puede aprobarse.   |



### 1.3 Fuentes de Datos

| Métrica / Capacidad        | Fuentes / Herramientas AWS                                | Ejemplo literal                                                                 | Justificación                                                                 | Servicio externo                    | ¿Por qué se decide AWS?                                                                 |
|----------------------------|------------------------------------------------------------|----------------------------------------------------------------------------------|--------------------------------------------------------------------------------|-------------------------------------|----------------------------------------------------------------------------------------|
| Disponibilidad             | Amazon CloudWatch Metrics (ALB)                            | El ALB nos dice cuántas solicitudes entraron y cuántas respondieron bien.         | El ALB es el punto único de entrada y refleja la experiencia real del usuario. | Datadog, New Relic                  | CloudWatch expone métricas nativas del ALB sin agentes adicionales ni costos extra.     |
| Latencia                   | ALB Target Response Time + ECS Logs + AWS X-Ray            | Cada log guarda el tiempo de respuesta, luego calculamos p95 y p99.              | Percentiles altos muestran degradaciones que el promedio oculta.              | Prometheus + Grafana                | X-Ray y CloudWatch entregan latencia distribuida evitando complejidad externa.         |
| Errores 5xx                | CloudWatch Logs Insights (ECS Fargate)                     | Si el Decision Service devuelve un 500, lo vemos en los logs.                    | Los errores internos afectan la continuidad del proceso de crédito.           | Splunk, ELK                         | CloudWatch centraliza logs nativamente sin clusters externos.                          |
| Autenticación              | Amazon Cognito Metrics + Logs del backend                  | De cada 1,000 logins, máximo 5 pueden fallar por error del sistema.              | Si el login falla, el usuario no entra al flujo de crédito.                    | Okta, Auth0                         | Cognito integra métricas de login y validación con CloudWatch.                         |
| Scoring externo            | Métricas personalizadas en CloudWatch + AWS X-Ray         | Registramos la latencia y errores de cada llamada a FICO.                        | El scoring es un cuello de botella externo crítico para la aprobación.         | Dynatrace, AppDynamics              | Métricas custom permiten medir dependencias sin licencias adicionales.                |
| Persistencia (Aurora)      | Aurora Performance Insights + CloudWatch Metrics           | Medimos tiempos de commit y errores de conexión a la base de datos.              | Si Aurora falla, no se guarda el crédito y se pierde la operación.              | Percona Monitoring, MySQL Workbench | Aurora expone métricas nativas integradas con CloudWatch.                              |
| Capacidad de cómputo       | ECS Fargate Service Metrics (CPU, memoria, health checks)  | Si un contenedor se queda sin memoria, lo detectamos en CloudWatch.              | Permite anticipar saturación antes de impactar al usuario.                     | Datadog, Prometheus                 | CloudWatch recolecta métricas de ECS sin agentes externos.                              |
| Trazabilidad distribuida   | AWS X-Ray                                                  | Podemos seguir una solicitud completa: ALB → ECS → FICO → Aurora.               | Identifica cuellos de botella y latencias en dependencias internas y externas. | AppDynamics, Dynatrace              | X-Ray está integrado con AWS y evita dependencias externas para trazabilidad.          |
| Alertas y dashboards       | Amazon CloudWatch Alarms + Dashboards                      | Si la latencia p95 supera 500 ms, se dispara una alarma al equipo.               | Permite respuesta rápida y decisiones basadas en SLOs.                        | PagerDuty, Grafana Cloud            | CloudWatch ofrece alarmas y dashboards nativos sin mayor complejidad ni costo extra.  |

