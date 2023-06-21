# Groups
resource "okta_group" "Quote_Underwriters" {
  name = "Quote_Underwriters_${var.env}"
}

resource "okta_group" "Quote_Agents" {
  name = "Quote_Agents_${var.env}"
}

resource "okta_group" "Agents" {
  name = "Agents_${var.env}"
}

# Group Rules
resource "okta_group_rule" "Quote-Agents-Provisioning-Rule" {
  expression_value  = "user.userStatus==\"Approved\" and isMemberOfGroupName(\"Agents_${var.env}\")"
  group_assignments = ["Quote_Agents_${var.env}"]
  name              = "Quote Agents Provisioning Rule - ${var.env}"
  status            = "ACTIVE"
}

resource "okta_group_rule" "Quote-Underwriters-Provisioning-Rule" {
  expression_value  = "isMemberOfAnyGroup(\"quote_underwriter_${var.env}\")"
  group_assignments = ["Quote_Underwriters_${var.env}"]
  name              = "Quote Underwriters Provisioning Rule - ${var.env}"
  status            = "ACTIVE"
}

resource "okta_group_rule" "Assign-External-Users-Group" {
  expression_value  = "isMemberOfAnyGroup(\"Quote_Agents_${var.env}\")"
  group_assignments = ["External_Users_${var.env}"]
  name              = "Assign to External Users Group - ${var.env}"
  status            = "ACTIVE"
}