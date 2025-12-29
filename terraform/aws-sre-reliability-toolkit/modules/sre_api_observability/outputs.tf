output "dashboard_name" {
  description = "SRE CloudWatch dashboard name"
  value       = aws_cloudwatch_dashboard.sre_dashboard.dashboard_name
}

output "latency_sli_alarm" {
  description = "Latency SLI alarm name"
  value       = aws_cloudwatch_metric_alarm.latency_sli.alarm_name
}

output "error_rate_sli_alarm" {
  description = "Error rate SLI alarm name"
  value       = aws_cloudwatch_metric_alarm.error_rate_sli.alarm_name
}

