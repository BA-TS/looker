view: suppliers {
  sql_table_name: `toolstation-data-storage.range.suppliers`
    ;;
  drill_fields: [supplier_uid]

  dimension: supplier_uid {
    primary_key: yes
    type: string
    sql: ${TABLE}.supplierUID ;;
  }

  dimension: account_credit_limit {
    type: number
    sql: ${TABLE}.accountCreditLimit ;;
  }

  dimension: account_held {
    type: number
    sql: ${TABLE}.accountHeld ;;
  }

  dimension: account_number {
    type: string
    sql: ${TABLE}.accountNumber ;;
  }

  dimension: advertising_contribution {
    type: number
    sql: ${TABLE}.advertisingContribution ;;
  }

  dimension: autogen_max_order_lines {
    type: number
    sql: ${TABLE}.autogenMaxOrderLines ;;
  }

  dimension: autogen_min_order_value {
    type: number
    sql: ${TABLE}.autogenMinOrderValue ;;
  }

  dimension: autogen_safety_net_value {
    type: number
    sql: ${TABLE}.autogenSafetyNetValue ;;
  }

  dimension: is_active {
    type: number
    sql: ${TABLE}.isActive ;;
  }

  dimension: is_do_not_use {
    type: number
    sql: ${TABLE}.isDoNotUse ;;
  }

  dimension: lead_time {
    type: number
    sql: ${TABLE}.leadTime ;;
  }

  dimension: master_supplier_name {
    type: string
    sql: ${TABLE}.masterSupplierName ;;
  }

  dimension: master_supplier_uid {
    type: number
    value_format_name: id
    sql: ${TABLE}.masterSupplierUID ;;
  }

  dimension: mcp {
    type: number
    sql: ${TABLE}.mcp ;;
  }

  dimension: mcp_type {
    type: string
    sql: ${TABLE}.mcpType ;;
  }

  dimension: non_returns_agreement {
    type: number
    sql: ${TABLE}.nonReturnsAgreement ;;
  }

  dimension: non_returns_agreement_percentage {
    type: number
    sql: ${TABLE}.nonReturnsAgreementPercentage ;;
  }

  dimension: order_type {
    type: string
    sql: ${TABLE}.orderType ;;
  }

  dimension: payment_terms {
    type: number
    sql: ${TABLE}.paymentTerms ;;
  }

  dimension: preferred_reorder_day {
    type: string
    sql: ${TABLE}.preferredReorderDay ;;
  }

  dimension: rebate_max {
    type: number
    sql: ${TABLE}.rebateMax ;;
  }

  dimension: rebate_min {
    type: number
    sql: ${TABLE}.rebateMin ;;
  }

  dimension: rebate_percentage {
    type: number
    sql: ${TABLE}.rebatePercentage ;;
  }

  dimension: reorder_frequency {
    type: number
    sql: ${TABLE}.reorderFrequency ;;
  }

  dimension: sage_supplier_code {
    type: string
    sql: ${TABLE}.sageSupplierCode ;;
  }

  dimension: settlement_discount_days {
    type: number
    sql: ${TABLE}.settlementDiscountDays ;;
  }

  dimension: settlement_discount_percentage {
    type: number
    sql: ${TABLE}.settlementDiscountPercentage ;;
  }

  dimension: supplier_contact {
    type: string
    sql: ${TABLE}.supplierContact ;;
  }

  dimension: supplier_email {
    type: string
    sql: ${TABLE}.supplierEmail ;;
  }

  dimension: supplier_fax {
    type: string
    sql: ${TABLE}.supplierFax ;;
  }

  dimension: supplier_name {
    type: string
    sql: ${TABLE}.supplierName ;;
  }

  dimension: supplier_planner {
    type: string
    sql: ${TABLE}.supplierPlanner ;;
  }

  dimension: supplier_telephone {
    type: string
    sql: ${TABLE}.supplierTelephone ;;
  }

  dimension: supplier_website {
    type: string
    sql: ${TABLE}.supplierWebsite ;;
  }

}
