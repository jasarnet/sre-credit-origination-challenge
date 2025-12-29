module "credit_origination_apigw_observability" {
  source = "../../modules/sre_api_observability"

  service_name     = "credit-origination-apigw"
  api_type         = "apigateway"
  metric_namespace = "AWS/ApiGateway"

  sli_latency_metric = "Latency"
  sli_error_metric   = "5XXError"

  latency_threshold = 1000
  error_threshold   = 5
}

