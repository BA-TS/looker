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

  dimension: customerUID {
    type: string
    sql: ${TABLE}.customerUID ;;
  }

  dimension: addressUID {
    type: string
    sql: ${TABLE}.addressUID ;;
  }

  dimension: addressStartDate {
    type: date
    sql: ${TABLE}.addressStartDate ;;
  }

  dimension: addressEndDate {
    type: date
    sql: ${TABLE}.addressEndDate ;;
  }

  dimension: addressType {
    type: string
    sql: ${TABLE}.addressType ;;
  }

  dimension: postcode {
    type: string
    sql: ${TABLE}.postcode ;;
  }
}
