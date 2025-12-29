# SLIs y SLOs

## Service Level Indicators (SLIs)

Los SLIs representan el comportamiento percibido por el usuario:

- Disponibilidad
- Latencia (p95 / p99)
- Tasa de errores (5xx)
- Éxito de autenticación
- Latencia de dependencias externas

## Service Level Objectives (SLOs)

| Métrica | Objetivo |
|-------|----------|
| Disponibilidad | 99.9% mensual |
| Latencia | p95 ≤ 500 ms |
| Errores 5xx | ≤ 1% |
| Fallos de autenticación | ≤ 0.5% |

Los SLOs se evalúan en ventanas móviles mensuales.

