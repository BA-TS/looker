view: trade_customers {
  view_label: "Customers"
  sql_table_name: `toolstation-data-storage.ts_marketing.CRM_DBS_Trade_Type_Master`
    ;;

  dimension: customer_number {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.Customer_Number ;;
  }

  dimension_group: load {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Load_Date ;;
    hidden: yes
  }

  dimension: trade_segment {
    type: string
    group_label: "Flags"
    sql: ${TABLE}.Trade_Flag ;;
  }

  dimension: trade_type {
    type: string
    group_label: "Flags"
    sql: ${TABLE}.Trade_Type ;;
  }

}
