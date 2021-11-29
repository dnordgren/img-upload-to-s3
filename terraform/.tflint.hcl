config {
  module     = false
  force      = false
}

plugin "aws" {
  enabled = true
  version = "0.7.2"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"

  # Disable deep_check by default as it requires AWS credentials, which
  # pose a security risk and overhead to manage with GitHub Actions CI.
  # Engineers can feel free to enable as it makes sense for their teams.
  deep_check = false
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_deprecated_index" {
  enabled = true
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_module_pinned_source" {
  enabled = true
}
