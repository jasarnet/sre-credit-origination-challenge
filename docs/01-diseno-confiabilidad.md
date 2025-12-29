# Diseño de Confiabilidad – API de Originación de Créditos

## 1. Criticidad del Servicio

La API de originación de créditos es un servicio crítico.
Cualquier indisponibilidad o aumento de latencia provoca:
- Pérdida directa de solicitudes de crédito
- Impacto en ingresos
- Deterioro de la experiencia del cliente

La confiabilidad se trata como un requerimiento funcional del sistema.

---

## 2. Arquitectura General

## Arquitectura

Clientes
  |
[ ALB ]
  |
[ ECS Fargate – API ]
  |        \
  |         -> Proveedor externo de scoring
  |
[ Aurora PostgreSQL ]
