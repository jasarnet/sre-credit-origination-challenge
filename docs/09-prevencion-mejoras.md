Observabilidad
Gaps de visibilidad identificados

•	No existen SLIs/SLOs definidos que reflejen la experiencia real del usuario.
•	Falta visibilidad específica sobre dependencias externas (latencia, errores, timeouts).
•	Logging poco estructurado, sin correlación entre solicitudes.
•	Ausencia de trazas distribuidas para identificar cuellos de botella end-to-end.
•	Alertas reactivas, basadas en infraestructura y no en impacto al negocio.

Mejoras clave

•	Definir SLIs y SLOs por servicio y dependencia crítica.
•	Incorporar métricas dedicadas para servicios externos.
•	Estandarizar logging estructurado con identificadores de correlación.
•	Implementar tracing distribuido (X-Ray / OpenTelemetry).
•	Alertar sobre violaciones de SLOs y consumo de error budget.

Arquitectura

Problemas actuales
•	Dependencias externas acopladas al flujo crítico.
•	Falta de mecanismos de aislamiento ante fallas.
•	Degradación no controlada del servicio.
 

Cambios propuestos
•	Timeouts y retries consistentes y alineados a SLOs.
•	Implementación de circuit breakers.
•	Diseño de modos degradados para fallas externas.
•	Desacoplar procesos críticos mediante asincronía cuando sea viable.
•	Reducción del blast radius entre microservicios.

Procesos

Debilidades
•	Despliegues sin validación explícita contra objetivos de confiabilidad.
•	Postmortems inconsistentes o inexistentes.
•	Poca automatización de controles de resiliencia.

Mejoras propuestas

•	Integrar SLOs como gates en CI/CD.
•	Postmortems sin culpa para incidentes P0 y P1.
•	Pruebas periódicas de resiliencia y fallas externas.
•	Gestión de alertas y monitoreo como código.
•	Revisiones periódicas de confiabilidad del servicio.

Cultura
Estado actual

•	Confiabilidad vista como reacción ante incidentes.
•	Responsabilidad concentrada en operaciones.

Acciones para fortalecer la cultura

•	Compartir métricas de confiabilidad con todo el equipo.
•	Involucrar a desarrollo en on-call y análisis de incidentes.
•	Promover responsabilidad compartida (You build it, you run it).
•	Priorizar trabajo de confiabilidad junto con nuevas funcionalidades.
•	Medir éxito por estabilidad y experiencia, no solo por velocidad.


