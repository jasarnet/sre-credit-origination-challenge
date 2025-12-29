## Módulo de Observabilidad SRE para APIs

Este módulo de Terraform proporciona una base estandarizada de observabilidad para APIs en AWS, alineada con los principios de Site Reliability Engineering (SRE).

### SLIs de Confiabilidad

Los siguientes SLIs están implementados y automatizados:

- **Disponibilidad** (medida de forma indirecta a través de la tasa de errores)
- **Latencia**
- **Tasa de errores**

Los siguientes SLIs se documentan intencionalmente, pero no se automatizan:

- **Tasa de éxito de autenticación**
- **Dependencia del proveedor externo de scoring**

Esta decisión evita el sobre-diseño y refleja la priorización típica en entornos reales de SRE, donde algunos SLIs requieren métricas de negocio o métricas personalizadas de la aplicación.

### Tipos de API soportados
- Application Load Balancer (ALB)
- API Gateway

### Qué crea este módulo
- Alarmas de CloudWatch para los SLIs de Latencia y Tasa de Errores
- Un dashboard de CloudWatch para visibilidad operativa

### Salidas (Outputs)
- Nombre del dashboard
- Nombres de las alarmas para cada SLI

