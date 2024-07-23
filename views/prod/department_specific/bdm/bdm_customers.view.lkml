view: bdm_customers {
  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    * from `toolstation-data-storage.retailReporting.BDM_CUSTOMERS_LIST`;;
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
    label: "BDM"
    type: string
    sql: ${TABLE}.bdm ;;
  }

  dimension_group: start {
    view_label: "Customer"
    group_label: "Dates"
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
    view_label: "Customer"
    group_label: "Dates (BDM)"
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

  dimension: is_bdm_customer {
    view_label: "Customer"
    label: "Is BDM customer"
    type: yesno
    sql:${customer_uid} is not null;;
  }

  dimension: is_active {
    view_label: "Customer"
    type: yesno
    label: "Is Customer Account Active (BDM)"
    sql: ${start_date}<current_date() and ${end_date} is null ;;
  }

  measure: number_of_bdm {
    view_label: "Measures"
    label: "Number of BDMs"
    type: count_distinct
    sql: ${bdm};;
  }

}
