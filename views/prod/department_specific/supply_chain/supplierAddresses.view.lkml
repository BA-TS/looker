view: supplierAddresses {
  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from `toolstation-data-storage.locations.supplierAddresses`;;
    datagroup_trigger: ts_weekly_datagroup
  }

  dimension: prim_key {
    sql: ${TABLE}.prim_key ;;
    type: string
    hidden: yes
    primary_key: yes
  }

  dimension: supplierUID {
    sql: ${TABLE}.supplierUID ;;
    type: string
    hidden: yes
  }

  dimension: addressUID {
    sql: ${TABLE}.addressUID ;;
    type: string
    hidden: yes
  }

  dimension: addressStartDate {
    sql: extract (date from ${TABLE}.addressStartDate) ;;
    type: date
    hidden: yes
  }

  dimension: addressEndDate {
    sql: extract (date from ${TABLE}.addressEndDate) ;;
    type: date
    hidden: yes
  }

  dimension: postcode {
    label: "Supplier Postcode"
    sql: ${TABLE}.postcode ;;
    type: string
  }

  dimension: country {
    label: "Supplier Country"
    sql: ${TABLE}.country ;;
    type: string
  }
}
