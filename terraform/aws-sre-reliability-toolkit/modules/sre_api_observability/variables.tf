variable "service_name" {
  description = "Nombre del servicio o API"
  type        = string
}

variable "api_type" {
  description = "Tipo de API: alb o apigateway"
  type        = string
}

variable "metric_namespace" {
  description = "Namespace de métricas en CloudWatch"
  type        = string
}

variable "sli_latency_metric" {
  description = "Nombre de la métrica del SLI de latencia"
  type        = string
}

variable "sli_error_metric" {
  description = "Nombre de la métrica del SLI de tasa de errores"
  type        = string
}

variable "latency_threshold" {
  description = "Umbral del SLI de latencia"
  type        = number
  default     = 1000
}

variable "error_threshold" {
  description = "Umbral del SLI de tasa de errores"
  type        = number
  default     = 5
}

variable "alarm_actions" {
  description = "Lista de ARNs de tópicos SNS para notificaciones"
  type        = list(string)
  default     = []
}

