view: lcm_history {
  sql_table_name: `toolstation-data-storage.pricing.lcmHistory`;;

  dimension: product_uid {
    label: "Product UID"
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  dimension: product_code {
    label: "Product Code"
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension_group: full {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.fullDate ;;
  }

  dimension: supplier_uid {
    label: "Supplier UID"
    type: string
    sql: ${TABLE}.supplierUID ;;
    hidden: yes
  }

  dimension: unit_cost_gbp {
    label: "Unit Cost (GBP)"
    type: number
    sql: ${TABLE}.unitCostGBP ;;
    hidden: yes
  }

  measure: max_unit_cost {
    label: "Unit Cost (GBP)"
    description: "Max price of unit cost price in a period."
    type: max
    sql: ${unit_cost_gbp} ;;
  }
}
