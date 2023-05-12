# include: "/views/**/products.view"

view: attached_products {
  derived_table: {
    sql:
      select distinct
      parentOrderUID,
      p.productCode,
      p.productDescription,
      row_number() OVER(ORDER BY parentOrderUID) AS prim_key,
     from `toolstation-data-storage.sales.transactions` t
        inner join `toolstation-data-storage.range.products_current` p
          using(productUID);;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
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

  dimension: filter_match {
    group_label: "Single Line Transactions"
    label: "Product Match"
    type: yesno
    sql: ${product_code_attached}=${products.product_code};;
  }

  dimension: attached_product_flag {
    group_label: "Single Line Transactions"
    label: "Attached Product (Y/N)"
    type: number
    sql: case when ${product_code_attached} IN ("86627", "93763","31668" ) and ${filter_match} is false then 1 else 0 end;;
  }

  measure: attached_count {
    group_label: "Single Line Transactions"
    label: "Total number of attached transactions "
    type: sum
    sql: ${attached_product_flag};;
  }
}
