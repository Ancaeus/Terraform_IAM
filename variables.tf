variable "aws_profile" {
  type    = string
  default = "eck10-build"
}

variable "aws_access_key_id" {
  type    = string
  default = ""
}

variable "aws_secret_access_key" {
  type    = string
  default = ""
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "groups" {
  type = list
  default = [
    "LinuxTeam"
  ]
}

variable "users" {
  type = map
  default = {
    "john.snow" = {
      "groups" = [
        "LinuxTeam"
      ],
      "tags" = {
      }
    }
  }
}


variable "service_accounts" {
  type = map
  default = {
    "dev_app_ci" = {
      "name" = "dev_app-ci"
      "tags" = {
        "Name" = "Dev App Service Account"
      }
    }
    "dev_infra_ci" = {
      "name" = "dev_infra-ci"
      "tags" = {
        "Name" = "Dev Infra Service Account"
      }
    }
    "prod_app_ci" = {
      "name" = "prod_app-ci"
      "tags" = {
        "Name" = "Prod App Service Account"
      }
    }
    "prod_infra_ci" = {
      "name" = "prod_infra-ci"
      "tags" = {
        "Name" = "Prod Infra Service Account"
      }
    }
  }
}

variable "policy_associations"{
  type = map
  default = {
    "dev_app_ci" = {
      "name" = "dev_app-ci"
      "tags" = {
        "Name" = "Dev App Service Account"
      }
    }
    "dev_infra_ci" = {
      "name" = "dev_infra-ci"
      "tags" = {
        "Name" = "Dev Infra Service Account"
      }
    }
    "prod_app_ci" = {
      "name" = "prod_app-ci"
      "tags" = {
        "Name" = "Prod App Service Account"
      }
    }
    "prod_infra_ci" = {
      "name" = "prod_infra-ci"
      "tags" = {
        "Name" = "Prod Infra Service Account"
      }
    }
  }
}


variable "environment" {
  type = map
  default = {
    "dev" = {
      "tags" = {
        "Name" = "dev"
      }
    },
    "prod" = {
      "tags" = {
        "Name" = "prod"
      }
    }
  }
}

variable "prod_account" {}
variable "dev_account" {}
