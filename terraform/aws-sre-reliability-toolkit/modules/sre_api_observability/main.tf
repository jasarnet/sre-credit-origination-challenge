resource "aws_cloudwatch_metric_alarm" "latency_sli" {
  alarm_name          = "${var.service_name}-sli-latency"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = var.sli_latency_metric
  namespace           = var.metric_namespace
  period              = 60
  statistic           = "Average"
  threshold           = var.latency_threshold

  alarm_description   = "Se excedió el umbral de latencia del SLI para ${var.service_name}"
  alarm_actions       = var.alarm_actions
}

resource "aws_cloudwatch_metric_alarm" "error_rate_sli" {
  alarm_name          = "${var.service_name}-sli-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = var.sli_error_metric
  namespace           = var.metric_namespace
  period              = 60
  statistic           = "Sum"
  threshold           = var.error_threshold

  alarm_description   = "Se excedió el umbral de tasa de errores del SLI para ${var.service_name}"
  alarm_actions       = var.alarm_actions
}

resource "aws_cloudwatch_dashboard" "sre_dashboard" {
  dashboard_name      = "${var.service_name}-sre-dashboard"

  dashboard_body      = jsonencode({
    widgets = [
      {
        type          = "metric"
        width         = 12
        height        = 6
        properties    = {
          title       = "SLI de Latencia"
          metrics     = [
            [ var.metric_namespace, var.sli_latency_metric ]
          ]
          stat       = "Average"
          period     = 60
        }
      },
      {
        type         = "metric"
        width        = 12
        height       = 6
        properties   = {
          title      = "SLI de Tasa de Errores"
          metrics    = [
            [ var.metric_namespace, var.sli_error_metric ]
          ]
          stat       = "Sum"
          period     = 60
        }
      }
    ]
  })
}

