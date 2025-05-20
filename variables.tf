variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "flask-app-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "flaskappacr"
}

variable "container_group_name" {
  description = "Name of the container group"
  type        = string
  default     = "flask-app-aci"
}

variable "dns_name_label" {
  description = "DNS name label for the container group"
  type        = string
  default     = "flask-app-poc"
}