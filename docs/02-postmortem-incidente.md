# Postmortem – Timeout en Proveedor de Scoring

## Resumen

El 18/11/2024 la API de originación sufrió degradación parcial
por aumento de latencia del proveedor externo de scoring.

## Impacto

- Duración: 37 minutos
- Solicitudes fallidas: ~18%
- Impacto en negocio: moderado
- Clientes afectados: sí

## Línea de Tiempo

- 10:02 – Aumento de latencia detectado
- 10:08 – Alerta de burn-rate activada
- 10:12 – On-call responde
- 10:18 – Causa raíz identificada
- 10:24 – Ajuste de timeout
- 10:39 – Servicio estable

## Causa Raíz

El proveedor de scoring incrementó su latencia.
El timeout del cliente (800 ms) provocó acumulación de requests
y agotamiento de recursos.

## Detección

- Alertas basadas en error budget
- Trazas X-Ray evidenciaron la dependencia

## Resolución

- Timeout reducido a 300 ms
- Reintentos deshabilitados
- Recuperación inmediata

## Acciones Correctivas

| Acción | Responsable | Estado |
|------|------------|--------|
| Circuit breaker scoring | SRE | Planeado |
| SLO para dependencias | SRE | Completado |
| Fallback funcional | Backend | En progreso |

## Aprendizajes

- Fallar rápido reduce impacto
- Las dependencias requieren SLOs explícitos

