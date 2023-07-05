# Groups
resource "okta_group" "Quote_Underwriters" {
  name = var.env == "prd" ? "Quote_Underwriters" : "Quote_Underwriters_${var.env}"
}

resource "okta_group" "Quote_Agents" {
  name = var.env == "prd" ? "Quote_Agents" : "Quote_Agents_${var.env}"
}

resource "okta_group" "Agents" {
  name = var.env == "prd" ? "Agents" : "Agents_${var.env}"
}

# Group Rules
resource "okta_group_rule" "Quote-Agents-Provisioning-Rule" {
  expression_value  = var.env == "prd" ? "user.userStatus==\"Approved\" and isMemberOfGroupName(\"Agents\")" : "user.userStatus==\"Approved\" and isMemberOfGroupName(\"Agents_${var.env}\")"
  group_assignments = var.env == "prd" ? ["Quote_Agents"] : ["Quote_Agents_${var.env}"]
  name              = var.env == "prd" ? "Quote Agents Provisioning Rule" : "Quote Agents Provisioning Rule - ${var.env}"
  status            = "ACTIVE"
}

resource "okta_group_rule" "Quote-Underwriters-Provisioning-Rule" {
  expression_value  = var.env == "prd" ? "isMemberOfAnyGroup(\"quote_underwriter\")" : "isMemberOfAnyGroup(\"quote_underwriter_${var.env}\")"
  group_assignments = var.env == "prd" ? ["Quote_Underwriters_${var.env}"] : ["Quote_Underwriters_${var.env}"]
  name              = var.env == "prd" ? "Quote Underwriters Provisioning Rule" : "Quote Underwriters Provisioning Rule - ${var.env}"
  status            = "ACTIVE"
}

resource "okta_group_rule" "Assign-External-Users-Group" {
  expression_value  = var.env == "prd" ? "isMemberOfAnyGroup(\"Quote_Agents\")" : "isMemberOfAnyGroup(\"Quote_Agents_${var.env}\")"
  group_assignments = var.env == "prd" ? ["External_Users"] : ["External_Users_${var.env}"]
  name              = var.env == "prd" ? "Assign to External Users Group" : "Assign to External Users Group - ${var.env}"
  status            = "ACTIVE"
}