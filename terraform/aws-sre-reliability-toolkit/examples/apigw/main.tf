module "credit_origination_apigw_observability" {
  source = "../../modules/sre_api_observability"

  ############### Identificación del servicio ##############
  service_name = "credit-origination-apigw"
  api_type     = "apigateway"

  ############### Métricas de CloudWatch para API Gateway ##############
  metric_namespace   = "AWS/ApiGateway"
  sli_latency_metric = "Latency"
  sli_error_metric   = "5XXError"

  ############### Umbrales de SLIs ##############
  ############### Latencia en milisegundos ##############
  latency_threshold = 1000

  ############### Número de errores 5XX permitidos por periodo ##############
  error_threshold = 5
}
