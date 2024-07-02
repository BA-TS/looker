view: bdm_customers {
  required_access_grants: [can_use_customer_information_trade]
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
    type: time
    datatype: date
    sql: ${TABLE}.startDate ;;
  }

  dimension_group: end {
    type: time
    datatype: date
    sql: ${TABLE}.endDate;;
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customerName ;;
    hidden: yes
  }

  dimension: is_bdm_customer {
    label: "Is BDM customer"
    type: yesno
    sql:${customer_uid} is not null;;
  }

  dimension: is_active {
    type: yesno
    sql: ${start_date}<current_date() ;;
  }

}
