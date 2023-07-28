view: trade_customers {
  view_label: "Customers"
  sql_table_name: `toolstation-data-storage.customer.dbs_trade_customers`;;
  #fields_hidden_by_default: yes
  required_access_grants: [can_use_customer_information]

  dimension: customer_uid {
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

  dimension: trade_flag {
    type: string
    group_label: "Flags"
    hidden: yes
    sql: ${TABLE}.Trade_Flag ;;
  }

  dimension: trade_type {
    type: string
    group_label: "Flags"
    sql: ${TABLE}.Trade_Type ;;
  }
}
