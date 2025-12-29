## 2. Análisis de Causa Raíz

### 2.1 Causa raíz principal

La causa raíz del incidente fue la **degradación del proveedor externo de scoring crediticio**, lo que incrementó significativamente la latencia y la tasa de errores en las llamadas realizadas desde los servicios de **Eligibility** y **Decision**.

El sistema no contaba con mecanismos efectivos de **aislamiento de fallas** (timeouts estrictos, circuit breakers o degradación controlada). Como resultado, las solicitudes quedaron bloqueadas esperando respuestas del proveedor externo, lo que generó:
- Acumulación de solicitudes en los servicios backend
- Aumento de la latencia end-to-end
- Errores visibles para los usuarios durante la originación de créditos

---

### 2.2 Factores contribuyentes

Varios factores técnicos y operativos permitieron que el problema se propagara:

- Dependencia síncrona del proveedor externo de scoring en el camino crítico de la originación.
- Timeouts elevados o no estandarizados, amplificando el impacto de la latencia externa.
- Ausencia de **circuit breakers**, impidiendo cortar tráfico hacia el proveedor degradado.
- Falta de **SLIs específicos para dependencias externas**, lo que retrasó la detección del problema.
- Escalamiento automático de **ECS**, que absorbió carga pero no resolvió la causa raíz, incrementando el consumo de recursos sin mejorar la experiencia del usuario.
- Observabilidad limitada, sin trazas distribuidas que permitieran identificar rápidamente el punto exacto de bloqueo.

---

### 2.3 Puntos de falla (defensas que no funcionaron)

Las defensas del sistema fallaron en los siguientes puntos críticos:

- **Capa de aplicación:**  
  No existía control de fallas para llamadas externas (timeouts estrictos, retries controlados, fallback).

- **Capa de arquitectura:**  
  El proveedor externo no estaba adecuadamente aislado del flujo principal de negocio.

- **Capa de monitoreo:**  
  Las alertas estaban basadas en métricas de infraestructura y no en el impacto real percibido por el usuario.

- **Capa operativa:**  
  No había procedimientos claros para la degradación controlada del servicio ante fallas externas.

Estas fallas permitieron que un problema externo se propagara al sistema interno y afectara directamente la **originación de créditos**.

