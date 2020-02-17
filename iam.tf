

resource "aws_iam_group" "groups" {
  count = length(var.groups)
  name  = var.groups[count.index]
}

resource "aws_iam_group_policy_attachment" "administrators" {
  group      = "LinuxTeam"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "users" {
  for_each = var.users
  name     = each.key
  tags     = each.value["tags"]
}

resource "aws_iam_user" "service_account" {
   for_each = var.service_accounts
   name     = each.key
   tags     = each.value["tags"]

}

# resource "aws_iam_user" "dev_app_ci" {
#   name = "dev_app_ci"
#   tags = {
#     "Managed_by" = "Terraform"
#     "State"      = "To be reviewed"
#   }
# }

# resource "aws_iam_user" "dev_infra_ci" {
#   name = "dev_infra_ci"
#   tags = {
#     "Managed_by" = "Terraform"
#     "State"      = "To be reviewed"
#   }
# }

# resource "aws_iam_user" "prod_app_ci" {
#   name = "prod_app_ci"
#   tags = {
#     "Managed_by" = "Terraform"
#     "State"      = "To be reviewed"
#   }
# }

# resource "aws_iam_user" "prod_infra_ci" {
#   name = "prod_infra_ci"
#   tags = {
#     "Managed_by" = "Terraform"
#     "State"      = "To be reviewed"
#   }
# }


data "template_file" "dev_app_ci_policy" {
  template = "${file("./policies/dev/app_ci_policy_doc.json")}"
  vars = {
    account = "${var.dev_account}"
  }
}

data "template_file" "prod_app_ci_policy" {
  template = "${file("./policies/prod/app_ci_policy_doc.json")}"
  vars = {
    account = "${var.prod_account}"
  }
}

data "template_file" "dev_infra_ci_policy" {
  template = "${file("./policies/dev/infra_ci_policy_doc.json")}"
  vars = {
    account = "${var.dev_account}"
  }
}

data "template_file" "prod_infra_ci_policy" {
  template = "${file("./policies/prod/infra_ci_policy_doc.json")}"
  vars = {
    account = "${var.prod_account}"
  }
}



# resource "aws_iam_policy" "dev_app_ci" {
#    name        = "dev_app_ci"
#   description = "dev app ci"
# #  count = length(var.policy_associations)
# #  users      = ["${element(keys(var.policy_assiciations), 0)}"]
#  for_each = var.policy_associations
#  policy_association     = each.key
# #    groups   = each.value["groups"]
    
#   policy      = join("", ${data.template_file} ${each.policy_association} "policy.rendered")"
# }

resource "aws_iam_policy" "dev_app_ci" {
  name        = "dev_app_ci"
  description = "dev app ci"
  policy      = "${data.template_file.dev_app_ci_policy.rendered}"
}

resource "aws_iam_policy" "dev_infra_ci" {
  name        = "dev_infra_ci"
  description = "dev app ci"
  policy      = "${data.template_file.dev_infra_ci_policy.rendered}"
}


resource "aws_iam_policy" "prod_app_ci" {
  name        = "prod_app_ci"
  description = "prod app ci"
  policy      = "${data.template_file.prod_app_ci_policy.rendered}"

}




resource "aws_iam_policy" "prod_infra_ci" {
  name        = "prod_infra_ci"
  description = "prod infra ci"
  policy      = "${data.template_file.prod_infra_ci_policy.rendered}"

}

# Find a logic for the policies.
# Fix the dependencies 




#  resource "aws_iam_user_group_membership" "user_groups" {
#    for_each = var.users
#    user     = each.key
#    groups   = each.value["groups"]
#  }

 resource "aws_iam_policy_attachment" "dev_app_ci_dependency" {
   name       = "dev_app_ci"
  #  count = length(var.service_accounts)
   users      = ["${element(keys(var.service_accounts), 0)}"]
   policy_arn = "${aws_iam_policy.dev_app_ci.arn}"

 }
resource "aws_iam_policy_attachment" "dev_infra_ci_dependency" {
  name       = "dev_infra_ci"
  users      = ["${element(keys(var.service_accounts), 1)}"]
  policy_arn = "${aws_iam_policy.dev_infra_ci.arn}"

}

resource "aws_iam_policy_attachment" "prod_app_ci_dependency" {
  name       = "prod_app_ci"
  users      = ["${element(keys(var.service_accounts), 2)}"]
  policy_arn = "${aws_iam_policy.prod_app_ci.arn}"

}
resource "aws_iam_policy_attachment" "prod_infra_ci_dependency" {
  name       = "prod_app_ci"
  users      = ["${element(keys(var.service_accounts), 3)}"]
  policy_arn = "${aws_iam_policy.prod_infra_ci.arn}"

}
