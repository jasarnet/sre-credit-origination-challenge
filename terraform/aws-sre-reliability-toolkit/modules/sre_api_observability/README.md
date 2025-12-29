# SRE API Observability Module

This Terraform module provides a standardized observability baseline for APIs in AWS,
aligned with Site Reliability Engineering (SRE) principles.

## Reliability SLIs

The following SLIs are implemented and automated:

- Availability (measured indirectly via error rate)
- Latency
- Error rate

The following SLIs are intentionally documented but not automated:

- Authentication success rate
- External scoring dependency

This decision avoids overengineering and reflects real-world SRE prioritization,
where some SLIs require business or custom application metrics.

## Supported API types
- Application Load Balancer (ALB)
- API Gateway

## What this module creates
- CloudWatch alarms for Latency and Error Rate SLIs
- A CloudWatch dashboard for operational visibility

## Outputs
- Dashboard name
- Alarm names for each SLI

