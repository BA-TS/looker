view: addresses {
  derived_table: {
    sql: select distinct *, row_number() over () as P_K from
       `toolstation-data-storage.locations.addresses` ;;
    # datagroup_trigger: ts_daily_datagroup
  }

  dimension: P_K {
    type: number
    sql: ${TABLE}.P_K ;;
    hidden: yes
    primary_key: yes
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: address_uid {
    type: string
    sql: ${TABLE}.addressUID ;;
    hidden: yes
  }

  dimension: address_start_date {
    group_label: "Order Delivery/Collection Address"
    type: date
    sql: ${TABLE}.addressStartDate ;;
  }

  dimension: address_end_date {
    group_label: "Order Delivery/Collection Address"
    type: date
    sql: ${TABLE}.addressEndDate ;;
  }

  dimension: address_type {
    group_label: "Order Delivery/Collection Address"
    type: string
    sql: ${TABLE}.addressType ;;
  }

  dimension: postcode {
    required_access_grants: [is_finance]
    group_label: "Order Delivery/Collection Address"
    type: string
    sql: ${TABLE}.postcode ;;
  }
}
