
view: supplier_funding_attribution {

  sql_table_name: `toolstation-data-storage.looker_custom_tables.supplier_funding_attribution`
    ;;

  dimension: product_code {
    group_label: "Product"
    label: "Product Code"
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: product_description {
    group_label: "Product"
    label: "Product Description"
    type: string
    sql: ${TABLE}.productDescription ;;
  }

  dimension: product_department {
    group_label: "Product"
    label: "Product Department"
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: product_subdepartment {
    group_label: "Product"
    label: "Product Subdepartment"
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: supplier_name {
    group_label: "Product"
    label: "Supplier Name"
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: total_units {
    type: number
    sql: ${TABLE}.totalUnits ;;
    hidden: yes
  }

  measure: total_total_units {
    type: sum
    sql: ${total_units} ;;
  }

  dimension_group: transaction {
    type: time
    timeframes: [
      raw,
      date,
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transactionDate ;;
  }

}
