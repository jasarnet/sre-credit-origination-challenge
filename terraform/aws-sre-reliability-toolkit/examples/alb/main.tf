module "credit_origination_api_observability" {
  source = "../../modules/sre_api_observability"

  ##############Identificación del servicio##############
  service_name = "credit-origination-api"
  api_type     = "alb"

  ############### Métricas de CloudWatch para ALB ##############
  metric_namespace = "AWS/ApplicationELB"
  sli_latency_metric = "TargetResponseTime"
  sli_error_metric   = "HTTPCode_Target_5XX_Count"

  ############### Umbrales de SLIs
  ############### Latencia promedio en segundos
  latency_threshold = 1

  ############### Número de errores 5XX permitidos por periodo
  error_threshold = 10
}
