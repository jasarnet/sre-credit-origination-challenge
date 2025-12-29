# 1. Introducción

## 1.1 Contexto del Servicio

La API de originación de créditos es un servicio crítico para el negocio, ya que cualquier degradación o indisponibilidad impacta directamente en la capacidad de generar nuevos créditos, afectando ingresos y la experiencia del usuario.

## 1.2 Arquitectura General del Servicio

La API de originación de créditos se expone a través de un **Application Load Balancer (ALB)**, el cual actúa como punto único de entrada y como la principal fuente de señales de confiabilidad a nivel de usuario, incluyendo disponibilidad, latencia y tasa de errores.

El backend está implementado sobre **Amazon ECS (Fargate)** y procesa la lógica de negocio mediante múltiples servicios, entre ellos:

- Credit Application  
- Eligibility Service  
- Decision Service  

Estos servicios dependen tanto de la capa de datos como de servicios internos y externos, lo que introduce riesgos adicionales de confiabilidad que deben ser gestionados de forma explícita.

### Componentes principales de la arquitectura

- **Capa de entrada:**  
  Application Load Balancer (ALB)

- **Cómputo:**  
  Amazon ECS (Fargate)

- **Datos:**  
  Amazon Aurora PostgreSQL

- **Dependencias:**  
  - Proveedor externo de scoring crediticio  
  - Servicio interno de autenticación  

- **Observabilidad actual:**  
  Logs y métricas básicas, sin una estrategia unificada ni orientada a objetivos de nivel de servicio (SLOs)

Esta API es crítica para el negocio: cualquier degradación impacta directamente la originación de créditos, afectando ingresos y la experiencia del cliente.

Actualmente, no existe una estrategia formal de confiabilidad ni una arquitectura de observabilidad estructurada, lo que limita la capacidad de detección temprana, diagnóstico y respuesta ante incidentes.

## Arquitectura Actual del Servicio

![Arquitectura de la API de Originación de Créditos](./diagrams/arquitectura-general.png)
