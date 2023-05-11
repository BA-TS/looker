# include: "/views/**/products.view"

view: attached_products {
  derived_table: {
    sql:
      select distinct
      parentOrderUID,
      p.productCode,
      p.productDescription
     from `toolstation-data-storage.sales.transactions` t
        inner join `toolstation-data-storage.range.products_current` p
          using(productUID);;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: parent_order_uid {
    group_label: "Single Line Transactions"
    label: "Parent Order UID Attached"
    primary_key: yes
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

  measure: attached_transactions_total {
    group_label: "Single Line Transactions"
    label: "Total number of attached transactions"
    type: count_distinct
    sql: ${parent_order_uid};;
  }
}
