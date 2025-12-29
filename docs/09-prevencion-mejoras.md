## Observabilidad

### Gaps de visibilidad identificados
- No existen SLIs / SLOs definidos que reflejen la experiencia real del usuario.
- Falta visibilidad específica sobre dependencias externas (latencia, errores, timeouts).
- Logging poco estructurado, sin correlación entre solicitudes.
- Ausencia de trazas distribuidas para identificar cuellos de botella end-to-end.
- Alertas reactivas, basadas en infraestructura y no en impacto al negocio.

### Mejoras clave
- Definir SLIs y SLOs por servicio y por dependencia crítica.
- Incorporar métricas dedicadas para servicios externos.
- Estandarizar logging estructurado con identificadores de correlación.
- Implementar tracing distribuido (AWS X-Ray / OpenTelemetry).
- Alertar sobre violaciones de SLOs y consumo de error budget.

---

## Arquitectura

### Problemas actuales
- Dependencias externas fuertemente acopladas al flujo crítico.
- Falta de mecanismos de aislamiento ante fallas.
- Degradación no controlada del servicio.

### Cambios propuestos
- Definir timeouts y retries consistentes, alineados a los SLOs.
- Implementar circuit breakers para dependencias externas.
- Diseñar modos degradados ante fallas de servicios externos.
- Desacoplar procesos críticos mediante asincronía cuando sea viable.
- Reducir el blast radius entre microservicios.

---

## Procesos

### Debilidades
- Despliegues sin validación explícita contra objetivos de confiabilidad.
- Postmortems inconsistentes o inexistentes.
- Baja automatización de controles de resiliencia.

### Mejoras propuestas
- Integrar SLOs como gates en los pipelines de CI/CD.
- Realizar postmortems sin culpa para incidentes P0 y P1.
- Ejecutar pruebas periódicas de resiliencia y simulación de fallas externas.
- Gestionar alertas y monitoreo como código.
- Realizar revisiones periódicas de confiabilidad del servicio.

---

## Cultura

### Estado actual
- La confiabilidad se aborda de forma reactiva ante incidentes.
- La responsabilidad recae principalmente en el equipo de operaciones.

### Acciones para fortalecer la cultura
- Compartir métricas de confiabilidad con todo el equipo.
- Involucrar a desarrollo en esquemas de on-call y análisis de incidentes.
- Promover responsabilidad compartida (**You build it, you run it**).
- Priorizar trabajo de confiabilidad junto con el desarrollo de nuevas funcionalidades.
- Medir el éxito por estabilidad y experiencia del usuario, no solo por velocidad de entrega.

