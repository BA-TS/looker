view: supplieraddresses {
  derived_table: {
    sql:
    select * from `toolstation-data-storage.locations.supplierAddresses`;;
    datagroup_trigger: ts_weekly_datagroup
  }

  dimension: supplierUID {
    sql: ${TABLE}.supplierUID ;;
    type: string
  }

  dimension: addressUID {
    sql: ${TABLE}.addressUID ;;
    type: string
  }

  dimension: addressStartDate {
    sql: extract (date from ${TABLE}.addressStartDate) ;;
    type: date
  }

  dimension: addressEndDate {
    sql: extract (date from ${TABLE}.addressEndDate) ;;
    type: date
  }

  dimension: postcode {
    sql: ${TABLE}.postcode ;;
    type: string
  }

  dimension: country {
    sql: ${TABLE}.country ;;
    type: string
  }
}
