output "ebs_csi_iam_policy" {
  value = data.http.ebs_csi_iam_policy.response_body
}

output "ebs_csi_iam_role_arn" {
  description = "EBS CSI IAM Role ARN"
  value = aws_iam_role.ebs_csi_iam_role.arn
}

output "ebs_csi_iam_role_policy_attach" {
  value = aws_iam_role_policy_attachment.ebs_csi_iam_role_policy_attach
}

output "ebs_csi_iam_policy_arn" {
  value = aws_iam_policy.ebs_csi_iam_policy.arn
}

# EBS CSI Helm Release Outputs
output "ebs_csi_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value = helm_release.ebs_csi_driver.metadata
}

output "ebs_csi_driver_id" {
  description = "Id of the deployed release."
  value = helm_release.ebs_csi_driver.id
}
