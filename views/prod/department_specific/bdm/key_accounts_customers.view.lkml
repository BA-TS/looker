include: "/views/**/transactions.view"

view: key_accounts_customers {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    * from `toolstation-data-storage.retailReporting.KEY_ACCOUNTS_CUSTOMERS_LIST`
    where bdm is not null;;
    datagroup_trigger: ts_daily_datagroup
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
    view_label: "BDM"
    label: "KA Name"
    type: string
    sql: ${TABLE}.bdm ;;
  }

  dimension_group: start {
    view_label: "Customers"
    group_label: "KA"
    type: time
    datatype: date
    sql: ${TABLE}.startDate ;;
    timeframes: [
      date,
      month,
      year
    ]
  }

  dimension_group: end {
    view_label: "Customers"
    group_label: "KA"
    type: time
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
    view_label: "Customers"
    group_label: "KA"
    label: "Is Key Accounts customer"
    type: yesno
    sql:${customer_uid} is not null;;
  }

  dimension: is_active {
    view_label: "Customers"
    group_label: "KA"
    type: yesno
    label: "Is Customer Account Active (KA)"
    sql: ${start_date}<current_date() and ${end_date} is null ;;
  }

  dimension: period {
    view_label: "Customers"
    group_label: "KA"
    type: string
    label: "Period - Pre vs Managed"
    sql:
    case when ${start_date}<${transactions.order_completed_date}
    then "Pre" else "Managed"
    End ;;
  }

  dimension: classification {
    view_label: "Customers"
    group_label: "KA"
    label: "KA Customer Classification"
    type: string
    sql:
    case
      when (date_diff(current_date()-1, ${start_date}, day)) > 364 then 'Existing'
      when (date_diff(${start_date}, ${transactions.order_completed_date},day)) <= 364 then 'Existing'
      when (date_diff(${start_date}, ${transactions.order_completed_date}, day)) is null then 'New'
      when (date_diff(${start_date}, ${transactions.order_completed_date}, day)) > 364 then 'New'
      else 'Time Traveler' end;;
  }

  measure: number_of_bdm {
    view_label: "Measures"
    label: "Number of BDMs (Key Accounts)"
    type: count_distinct
    sql: ${bdm};;
  }

}
