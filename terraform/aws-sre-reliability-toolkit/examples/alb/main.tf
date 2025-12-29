module "credit_origination_api_observability" {
  source = "../../modules/sre_api_observability"

  service_name     = "credit-origination-api"
  api_type         = "alb"
  metric_namespace = "AWS/ApplicationELB"

  sli_latency_metric = "TargetResponseTime"
  sli_error_metric   = "HTTPCode_Target_5XX_Count"

  latency_threshold = 1
  error_threshold   = 10
}

