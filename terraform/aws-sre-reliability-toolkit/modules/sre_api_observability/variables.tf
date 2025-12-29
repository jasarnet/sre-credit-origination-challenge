variable "service_name" {
  description = "Name of the API or service"
  type        = string
}

variable "api_type" {
  description = "API type: alb or apigateway"
  type        = string
}

variable "metric_namespace" {
  description = "CloudWatch metric namespace"
  type        = string
}

variable "sli_latency_metric" {
  description = "Latency SLI metric name"
  type        = string
}

variable "sli_error_metric" {
  description = "Error rate SLI metric name"
  type        = string
}

variable "latency_threshold" {
  description = "Latency SLI threshold"
  type        = number
  default     = 1000
}

variable "error_threshold" {
  description = "Error rate SLI threshold"
  type        = number
  default     = 5
}

variable "alarm_actions" {
  description = "SNS topic ARNs for notifications"
  type        = list(string)
  default     = []
}

