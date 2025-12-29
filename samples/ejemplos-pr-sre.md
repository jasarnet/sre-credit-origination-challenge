# Ejemplos de Pull Requests SRE

## PR: Agregar alerta de burn-rate para SLO

Motivo:
Las alertas por error rate no detectaban degradación lenta.

Cambio:
- Alerta basada en consumo del error budget

Riesgo:
Bajo (solo monitoreo)

---

## PR: Reducir timeout del proveedor de scoring

Motivo:
Acción derivada de incidente productivo.

Cambio:
- Timeout de 800 ms a 300 ms
- Reintentos deshabilitados

Impacto:
Menor latencia cola y menor error en cascada

