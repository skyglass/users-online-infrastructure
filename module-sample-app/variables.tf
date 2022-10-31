variable "aws_region" {
  type = string
}

variable "business_division" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_certificate_authority_data" {
  type = string
}

variable "cluster_token" {
  type = string
}

variable "aws_iam_openid_connect_provider_arn" {
  type = string
}

variable "aws_iam_openid_connect_provider_extract_from_arn" {
  type = string
}

variable "ebs_csi_iam_role_arn" {
  type = string
}

variable "ebs_csi_driver_id" {
  type = string
}

variable "externaldns_iam_role_arn" {
  type = string
}

variable "lbc_controller_id" {
  type = string
}

variable "node_group_public_id" {
  type = string
}

variable "sample_app_depends_on" {
  type    = any
  default = []
}