view: product_first_sale_date {
  derived_table: {
    sql:
      select
        productCode,
        min(date(transactionDate)) first_sale_date

        from `toolstation-data-storage.sales.transactions`

        group by 1;;
    datagroup_trigger: toolstation_transactions_datagroup
  }

  dimension: product_code {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: first_sale_date {
    view_label: "Products"
    group_label: "Product Details"
    label: "First Sale Date"
    type: date
    datatype: date
    sql: ${TABLE}.first_sale_date ;;
  }
}
