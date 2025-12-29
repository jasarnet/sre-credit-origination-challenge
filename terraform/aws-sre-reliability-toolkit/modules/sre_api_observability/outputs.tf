output "dashboard_name" {
  description = "Nombre del dashboard de CloudWatch para SRE"
  value       = aws_cloudwatch_dashboard.sre_dashboard.dashboard_name
}

output "latency_sli_alarm" {
  description = "Nombre de la alarma del SLI de latencia"
  value       = aws_cloudwatch_metric_alarm.latency_sli.alarm_name
}

output "error_rate_sli_alarm" {
  description = "Nombre de la alarma del SLI de tasa de errores"
  value       = aws_cloudwatch_metric_alarm.error_rate_sli.alarm_name
}
