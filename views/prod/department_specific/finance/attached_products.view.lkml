view: attached_products {
  derived_table: {
    sql:
      select distinct
      transactionDate,
      parentOrderUID,
      p.productCode,
      p.productDescription,
      productDepartment,
      productSubdepartment,
      row_number() OVER(ORDER BY parentOrderUID) AS prim_key,
     from `toolstation-data-storage.sales.transactions` t
        inner join `toolstation-data-storage.range.products_current` p
          using(productUID)
    where  p.productCode not in ("85699","44842") ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  parameter: product_code_attachment {
    label: "Attached Products - Filter by Product Code"
    description: "Please enter the product codes"
    type: string
    # allowed_value: {
    #   label: "Yes"
    #   value: "1"
    # }
    default_value: "86627"
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
    group_label: "Single Line Transactions"
    label: "Parent Order UID Attached"
    # primary_key: yes
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension: product_code_attached {
    group_label: "Single Line Transactions"
    type: string
    sql:${TABLE}.productCode;;
}

  dimension: product_description_attached {
    group_label: "Single Line Transactions"
    type: string
    sql:${TABLE}.productDescription;;
  }

  dimension: product_department_attached {
    group_label: "Single Line Transactions"
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: product_subdepartment_attached {
    group_label: "Single Line Transactions"
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: filter_match {
    group_label: "Single Line Transactions"
    label: "Product Match"
    type: yesno
    sql: ${product_code_attached}=${products.product_code};;
  }

  dimension: filter_match2 {
    group_label: "Single Line Transactions"
    label: "Product Match"
    type: number
    sql: case when ${product_code_attached} IN (${products.product_code}) then 0 else 1 end;;
    hidden: yes
  }

  dimension: user_selected_products {
    group_label: "Single Line Transactions"
    label: "User Selected Products"
    type: string
    sql: {% parameter product_code_attachment %};;
    hidden: yes
  }

  dimension: attached_product_flag {
    group_label: "Single Line Transactions"
    label: "Attached Product (Y/N)"
    type: number
    sql: case when ${product_code_attached} IN UNNEST(SPLIT(${user_selected_products})) and ${filter_match} is false then 1 else 0 end;;
    hidden: yes
  }

  measure: attached_count {
    view_label: "Measures"
    group_label: "Single Line Transactions"
    label: "Total number of attached transactions "
    type: sum
    sql: ${attached_product_flag};;
  }

  measure: product_match_count {
    group_label: "Total number of attached products"
    type: sum
    sql: ${filter_match2};;
    hidden: yes
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
