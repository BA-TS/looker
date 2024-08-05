view: attached_products {
  derived_table: {
    sql:
      select distinct
      transactionDate,
      parentOrderUID,
      p.productCode,
      p.productDescription,
      pd.packDescription,
      productDepartment,
      productSubdepartment,
      row_number() OVER(ORDER BY parentOrderUID) AS prim_key,
      sum(marginInclFunding) as marginInclFunding,
      sum(netSalesValue) as netSalesValue,
     from `toolstation-data-storage.sales.transactions` t
        inner join `toolstation-data-storage.range.products_current` p
          using(productUID)
        inner join `toolstation-data-storage.range.productDimensions` pd
          using (productUID)
    where  p.productCode not in ("85699","44842","00053") and p.productCode > "10000"
    group by 1, 2, 3, 4, 5, 6, 7
    ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  parameter: product_code_attachment {
    group_label: "Attached 1"
    label: "Attached Products - Filter by Product Code"
    description: "Please enter the product codes"
    type: string
    # allowed_value: {
    #   label: "Yes"
    #   value: "1"
    # }
    default_value: "86627"
    hidden: yes
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }

  dimension_group: transaction {
    label: "Transaction"
    type: time
    timeframes: [
      raw,
      date
    ]
    sql: ${TABLE}.transactionDate ;;
    hidden: yes
  }

  dimension: parent_order_uid {
    group_label: "Attached 1"
    label: "Parent Order UID Attached"
    # primary_key: yes
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension: product_code_attached {
    group_label: "Attached 1"
    type: string
    sql:${TABLE}.productCode;;
}

  dimension: product_description_attached {
    group_label: "Attached 1"
    type: string
    sql:${TABLE}.productDescription;;
  }

  dimension: pack_description_attached {
    group_label: "Attached 1"
    type: string
    sql:${TABLE}.packDescription;;
  }

  dimension: marginInclFunding_attached {
    group_label: "Attached 1"
    label: "Margin (Incl Funding) Attached Product"
    type: number
    sql:${TABLE}.marginInclFunding;;
  }

  dimension: netSalesValue {
    group_label: "Attached 1"
    label: "Net Sales Attached Product"
    type: number
    sql:${TABLE}.netSalesValue;;
  }

  dimension: product_department_attached {
    group_label: "Attached 1"
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: product_subdepartment_attached {
    group_label: "Attached 1"
    label: "Product Sub Department Attached"
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: filter_match {
    group_label: "Attached 1"
    label: "Product Match"
    type: yesno
    sql: ${product_code_attached}=${products.product_code};;
  }

  dimension: department_match {
    group_label: "Attached 1"
    type: yesno
    sql: ${product_department_attached}=${transactions.product_department};;
  }

  dimension: subdepartment_match {
    group_label: "Attached 1"
    type: yesno
    sql: ${product_subdepartment_attached}=${products.subdepartment};;
  }

  dimension: filter_match2 {
    group_label: "Attached 1"
    label: "Product Match"
    type: number
    sql: case when ${product_code_attached} IN (${products.product_code}) then 0 else 1 end;;
    hidden: yes
  }

  dimension: user_selected_products {
    group_label: "Attached 1"
    label: "User Selected Products"
    type: string
    sql: {% parameter product_code_attachment %};;
    hidden: yes
  }

  dimension: attached_product_flag {
    group_label: "Attached 1"
    label: "Attached Product (Y/N)"
    type: number
    sql: case when ${product_code_attached} IN UNNEST(SPLIT(${user_selected_products})) and ${filter_match} is false then 1 else 0 end;;
    hidden: yes
  }

  measure: attached_count {
    group_label: "Attached 1"
    view_label: "Measures"
    label: "Total number of attached transactions "
    type: sum
    sql: ${attached_product_flag};;
  }

  measure: product_match_count {
    group_label: "Attached 1"
    label: "Total number of attached products"
    type: sum
    sql: ${filter_match2};;
    hidden: yes
  }

  measure: total_marginInclFunding_attached {
    group_label: "Attached 1"
    label: "Margin (Incl Funding) Attached Product"
    type: sum
    sql:${marginInclFunding_attached};;
    value_format_name: gbp
  }

  measure: total_netSalesValue {
    group_label: "Attached 1"
    label: "Net Sales Attached Product"
    type: sum
    sql:${netSalesValue};;
    value_format_name: gbp
  }

  measure: total_margin_rate_incl_funding {
    group_label: "Attached 1"
    label: "Margin Rate (Incl Funding) Attached Product"
    type: number
    sql: COALESCE(safe_divide(cast(${total_marginInclFunding_attached} as numeric),cast(${total_netSalesValue} as numeric)),null);;
    # COALESCE(SAFE_DIVIDE(${total_margin_incl_funding}, ${total_net_sales}),null) ;;
    value_format: "0.00%;(0.00%)"
  }

  # measure: product_count {
  #   group_label: "Single Line Transactions"
  #   label: "Total number of attached transactions "
  #   type: sum
  #   sql: ${product_code_attached};;
  # }

  # measure: attachment_rate_product_filter{
  #   group_label: "Single Line Transactions"
  #   type: number
  #   sql: ${attached_count}/${product_count}
  # }
}
