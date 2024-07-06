view: key_accounts_customers {
  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    * from `toolstation-data-storage.retailReporting.KEY_ACCOUNTS_CUSTOMERS_LIST`;;
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: bdm {
    group_label: "Key Accounts"
    label: "BDM"
    type: string
    sql: ${TABLE}.bdm ;;
  }

  dimension_group: start {
    type: time
    group_label: "Dates"
    datatype: date
    sql: ${TABLE}.startDate ;;
    timeframes: [
      date,
      month,
      year
    ]
  }

  dimension_group: end {
    type: time
    group_label: "Dates"
    datatype: date
    sql: ${TABLE}.endDate;;
    timeframes: [
      date,
      month,
      year
    ]
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customerName ;;
    hidden: yes
  }

  dimension: is_key_accounts_customer {
    group_label: "Key Accounts"
    label: "Is Key Accounts customer"
    type: yesno
    sql:${customer_uid} is not null;;
  }

  dimension: is_active {
    group_label: "Key Accounts"
    type: yesno
    label: "Is Customer Account Active"
    sql: ${start_date}<current_date() and ${end_date} is null ;;
  }

  measure: number_of_bdm {
    group_label: "Key Accounts"
    label: "Number of BDMs"
    type: count_distinct
    sql: ${bdm};;
  }

}
