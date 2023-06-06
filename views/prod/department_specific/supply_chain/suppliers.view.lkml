view: suppliers {
  sql_table_name: `toolstation-data-storage.range.suppliers`;;
  drill_fields: [supplier_uid]

  dimension: supplier_uid {
    label: "Supplier UID"
    primary_key: yes
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.supplierUID ;;
  }

  dimension: advertising_contribution {
    type: number
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.advertisingContribution ;;
  }

  dimension: master_supplier_name {
    type: string
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.masterSupplierName ;;
  }

  dimension: master_supplier_uid {
    type: number
    value_format_name: id
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.masterSupplierUID ;;
  }

  dimension: mcp {
    label: "MCP"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.mcp ;;
  }

  dimension: mcp_type {
    label: "MCP Type"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.mcpType ;;
  }

  dimension: supplier_name {
    type: string
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.supplierName ;;
  }

  dimension: supplier_planner {
    label: "SC Planner"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.supplierPlanner ;;
  }

  dimension: supplier_contact {
    group_label: "Contact Details"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.supplierContact ;;
  }

  dimension: supplier_email {
    group_label: "Contact Details"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.supplierEmail ;;
  }

  dimension: supplier_fax {
    group_label: "Contact Details"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.supplierFax ;;
  }

  dimension: supplier_telephone {
    group_label: "Contact Details"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.supplierTelephone ;;
  }

  dimension: supplier_website {
    group_label: "Contact Details"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.supplierWebsite ;;
  }

  dimension: rebate_max {
    group_label: "Rebates"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.rebateMax ;;
  }

  dimension: rebate_min {
    group_label: "Rebates"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.rebateMin ;;
  }

  dimension: rebate_percentage {
    group_label: "Rebates"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.rebatePercentage ;;
  }

  dimension: is_active {
    group_label: "Flags"
    type: number
    sql: ${TABLE}.isActive ;;
  }

  dimension: is_do_not_use {
    group_label: "Flags"
    type: number
    sql: ${TABLE}.isDoNotUse ;;
  }

  dimension: payment_terms {
    type: number
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.paymentTerms ;;
  }

  dimension: sage_supplier_code {
    type: string
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.sageSupplierCode ;;
  }

  dimension: settlement_discount_days {
    type: number
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.settlementDiscountDays ;;
  }

  dimension: settlement_discount_percentage {
    type: number
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.settlementDiscountPercentage ;;
  }

  dimension: account_credit_limit {
    type: number
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.accountCreditLimit ;;
  }

  dimension: account_held {
    type: number
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.accountHeld ;;
  }

  dimension: account_number {
    type: string
    required_access_grants: [can_use_supplier_information]
    sql: ${TABLE}.accountNumber ;;
  }

  dimension: non_returns_agreement {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.nonReturnsAgreement ;;
  }

  dimension: non_returns_agreement_percentage {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.nonReturnsAgreementPercentage ;;
  }

  dimension: order_type {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.orderType ;;
  }

  dimension: autogen_max_order_lines {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.autogenMaxOrderLines ;;
  }

  dimension: autogen_min_order_value {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.autogenMinOrderValue ;;
  }

  dimension: autogen_safety_net_value {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.autogenSafetyNetValue ;;
  }

  dimension: lead_time {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.leadTime ;;
  }

  dimension: preferred_reorder_day {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: string
    sql: ${TABLE}.preferredReorderDay ;;
  }

  dimension: reorder_frequency {
    group_label: "Supply Chain"
    required_access_grants: [can_use_supplier_information]
    type: number
    sql: ${TABLE}.reorderFrequency ;;
  }
}
