## 2. Arquitectura de Observabilidad

### Métricas

#### ¿Qué capturar?
- **Disponibilidad:** porcentaje de respuestas exitosas (HTTP 2xx/3xx) vs total de solicitudes en el ALB.
- **Latencia:** percentiles p95 y p99 de tiempos de respuesta en ALB y backend.
- **Errores:** tasa de respuestas HTTP 5xx en ECS Fargate y Aurora.
- **Recursos:** uso de CPU, memoria y resultados de health checks en ECS Fargate.
- **Autenticación:** tasa de fallos internos y latencia de validación en Amazon Cognito.
- **Dependencias externas:** latencia y tasa de errores del proveedor de scoring (FICO).
- **Base de datos:** conexiones activas, tiempos de commit y locks en Amazon Aurora.

#### ¿Dónde almacenar?
- **Amazon CloudWatch Metrics** como repositorio central de métricas.
- **Métricas personalizadas en CloudWatch** enviadas desde el backend para dependencias externas.
- **RDS Performance Insights** para métricas detalladas de Aurora.

---

### Logs

#### Estructura recomendada (JSON)

```json
{
  "timestamp": "2025-12-27T18:25:43Z",
  "request_id": "abc123",
  "user_id": "cliente_789",
  "endpoint": "/loan/apply",
  "method": "POST",
  "status_code": 200,
  "latency_ms": 245,
  "service": "DecisionService",
  "error_type": null,
  "auth_provider": "Cognito",
  "external_dependency": "FICO",
  "external_latency_ms": 180,
  "region": "us-east-1"
}

```json

### Información clave (Logs)

- **request_id:** permite la correlación entre servicios.
- **user_id:** habilita la trazabilidad de la experiencia del usuario.
- **endpoint, status_code, latency_ms:** métricas de confiabilidad y rendimiento.
- **service:** identifica el microservicio afectado.
- **external_dependency:** mide el impacto de servicios de terceros.
- **error_type:** categoriza fallos (infraestructura, negocio, dependencia externa).

#### ¿Dónde almacenar?
- **Amazon CloudWatch Logs** con **Logs Insights** para consultas.
- Políticas de **retención ajustadas según criticidad**:
  - 30 días para debugging.
  - 90 días para auditoría y cumplimiento.

---

### Trazas (Tracing distribuido)

#### Implementación
- **AWS X-Ray** integrado en:
  - Application Load Balancer (ALB)
  - ECS Fargate
  - Amazon Aurora
- Cada solicitud transporta un **trace_id** que se propaga entre servicios.
- Se capturan los siguientes *spans*:
  - **ALB:** punto de entrada.
  - **ECS:** Credit Application, Eligibility y Decision Service.
  - **Aurora:** consultas SQL.
  - **FICO:** llamadas a dependencias externas.

#### Beneficio
Permite visualizar el recorrido completo de una solicitud y detectar con precisión dónde se genera la latencia  
(por ejemplo, backend lento vs proveedor de scoring externo).



### Dashboards por audiencia

#### Equipo técnico (SRE / DevOps)
- Latencia p95/p99 por endpoint.
- Tasa de errores HTTP 5xx por servicio.
- Uso de CPU y memoria en ECS.
- Aurora: conexiones activas y tiempos de commit.
- Dependencias externas: latencia y tasa de error.

#### Liderazgo / Negocio
- Disponibilidad mensual vs SLO (ej. 99.9%).
- Error budget consumido.
- Volumen de solicitudes procesadas.
- Impacto de dependencias externas en la originación.

#### Soporte / Operaciones
- Alertas activas y estado de incidentes.
- Tendencias de fallos de autenticación.
- Distribución geográfica de errores (si aplica).

