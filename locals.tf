#------------------
# CAF naming logic – DO NOT change per env
#------------------

locals {
  region_short = "ci"
  workload     = "web"

  base_name = "${local.workload}-${local.region_short}-${var.environment}"

  tags = {
    Environment = var.environment
    Workload    = local.workload
    ManagedBy   = "Terraform"
    Owner       = "Surjeet"
  }
}
