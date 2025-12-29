## Respuesta a Incidentes – Primeros 60 minutos

### Investigación inicial (minutos 0–15)

**Orden de revisión:**
1. **Dashboard de producto**  
   → caída del 40% en finalización de créditos.
2. **CloudWatch Metrics (ALB)**  
   → disponibilidad y latencia p95/p99 en `/loan/apply`.
3. **CloudWatch Logs Insights (ECS)**  
   → errores 5xx, timeouts y reintentos.
4. **AWS X-Ray**  
   → trazas completas para identificar cuellos de botella  
   (scoring externo vs Aurora).
5. **Aurora Performance Insights**  
   → errores de conexión, locks y tiempos de commit.
6. **Historial de despliegues**  
   → cambios recientes en servicios críticos (ej. scoring).

**Ejemplo:**  
> “Primero revisamos si el problema viene del frontend, backend o proveedor externo. Luego analizamos errores y latencia en logs y trazas.”

### 1.1 Formulación de hipótesis (minutos 15–30)

**Posibles causas:**
- Cambio en la política de reintentos en el servicio de scoring → saturación de dependencias.
- Timeouts acumulados hacia el proveedor externo → aumento de latencia y errores.
- Errores de conexión a Aurora → fallos en la persistencia de solicitudes.
- Carga inesperada por reintentos → presión sobre ECS y la base de datos.
- Despliegue nocturno sin validación de impacto → regresión funcional.

**Ejemplo:**  
> “Sospechamos que el nuevo servicio de scoring está generando reintentos excesivos que saturan Aurora y provocan timeouts.”

---

### 1.2 Estrategia de mitigación (minutos 30–45)

**Acciones priorizadas:**
1. Rollback inmediato del servicio de scoring a una versión estable.
2. Ajuste de configuración de reintentos:
   - Limitar a 2 intentos.
   - Aplicar backoff exponencial.
3. Reinicio controlado de pods en caso de saturación de CPU o memoria.
4. Monitoreo en tiempo real de:
   - Latencia
   - Tasa de errores post-rollback.
5. Validación funcional del flujo `/loan/apply` mediante pruebas manuales.
6. Activación de alerta **P1** por degradación severa con alto impacto.

**Ejemplo:**  
> “Hicimos rollback del scoring, limitamos los reintentos y monitoreamos si la latencia bajaba.”

---

### 1.3 Comunicación (minutos 0–60)

#### Stakeholders técnicos
- Actualización en **Slack / Teams** cada 15 minutos.
- Registro en el canal de incidentes con:
  - Timestamp
  - Acciones tomadas
- Elaboración de un **postmortem preliminar** al finalizar la primera hora.

---

### 1.4 Comunicación con stakeholders no técnicos (negocio)

**Mensaje claro y conciso:**

> “Estamos observando latencia alta en el flujo de crédito debido a un cambio en el servicio de scoring. Ya realizamos un rollback y estamos monitoreando la plataforma. Esperamos normalización en los próximos minutos.”

- Envío de gráficos de:
  - Recuperación de latencia
  - Créditos procesados
- Evitar tecnicismos; explicar en términos de impacto y recuperación.

**Ejemplo:**  
> “Informamos al negocio que el problema provenía del servicio de scoring, que ya fue revertido y que el sistema se está normalizando.”

