# Groups
# Data sources for AD groups
data "okta_group" "quote_underwriter_prd" {
  count = var.env == "prd" ? 1 : 0
  name  = "quote_underwriter_prd"
}

# Currently used in dev and tst
data "okta_group" "quote_underwriter_tst" {
  count = var.env == "dev" || var.env == "tst" || var.env == "nonprd" ? 1 : 0
  name  = "quote_underwriter_tst"
}

# Currently used in qa and stg
data "okta_group" "quote_underwriter_qa" {
  count = var.env == "qa" || var.env == "stg" || var.env == "nonprd" ? 1 : 0
  name  = "quote_underwriter_qa"
}

# If not prod, these groups will be created. If prod, will use the existing data source for ID. 
resource "okta_group" "Quote_Underwriters" {
  description = var.env == "prd" ? "Underwriter access to quote.natl.com" : "Underwriter access to quote.natl.com ${var.env}"
  name        = var.env == "prd" ? "Quote_Underwriters" : "Quote_Underwriters_${var.env}"
}

resource "okta_group" "Quote_Agents" {
  description = var.env == "prd" ? "Grants access for agents into quote.natl.com" : "Grants access for agents into quote.natl.com ${var.env}"
  name        = var.env == "prd" ? "Quote_Agents" : "Quote_Agents_${var.env}"
}

resource "okta_group" "Agents" {
  description = var.env == "prd" ? "Agents for quote (commercial lines)" : "Agents for quote (commercial lines) ${var.env}"
  name        = var.env == "prd" ? "Agents" : "Agents_${var.env}"
}

resource "okta_group" "External-Users" {
  description = "Self-Service Registration Users"
  name        = var.env == "prd" ? "External-Users" : "External-Users-${var.env}"
}

# Group Rules
resource "okta_group_rule" "Quote-Agents-Provisioning-Rule" {
  expression_value  = var.env == "prd" ? "user.userStatus==\"Approved\" and isMemberOfGroupName(\"Agents\")" : "user.userStatus==\"Approved\" and isMemberOfGroupName(\"Agents_${var.env}\")"
  group_assignments = [okta_group.Quote_Agents.id]
  name              = var.env == "prd" ? "Quote Agent Provisioning Rule" : "Quote Agent Provisioning Rule ${var.env}"
  status            = "ACTIVE"
}

resource "okta_group_rule" "Quote-Underwriters-Provisioning-Rule" {
  expression_value = (
    var.env == "prd" ? "isMemberOfAnyGroup(\"${data.okta_group.quote_underwriter_prd[0].id}\")" : (
      var.env == "nonprd" ? "isMemberOfAnyGroup(\"${data.okta_group.quote_underwriter_tst[0].id}\")" : (
        var.env == "dev" ? "isMemberOfAnyGroup(\"${data.okta_group.quote_underwriter_tst[0].id}\")" : (
          var.env == "tst" ? "isMemberOfAnyGroup(\"${data.okta_group.quote_underwriter_tst[0].id}\")" : (
            var.env == "qa" ? "isMemberOfAnyGroup(\"${data.okta_group.quote_underwriter_qa[0].id}\")" : (
              var.env == "stg" ? "isMemberOfAnyGroup(\"${data.okta_group.quote_underwriter_qa[0].id}\")" : ""
            )
          )
        )
      )
    )
  )
  group_assignments = [okta_group.Quote_Underwriters.id]
  name              = var.env == "prd" ? "Map AD groups to Okta Quote Underwriters Group" : "Map AD groups to Okta Quote Underwriters Group ${var.env}"
  status            = "ACTIVE"
}

resource "okta_group_rule" "Assign-External-Users-Group" {
  expression_value  = "isMemberOfAnyGroup(\"${okta_group.Quote_Agents.id}\")"
  group_assignments = [okta_group.External-Users.id]
  name              = var.env == "prd" ? "Map Quote Agents to External Users Group" : "Map Quote Agents to External Users Group ${var.env}"
  status            = "ACTIVE"
}