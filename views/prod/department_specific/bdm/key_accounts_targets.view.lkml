view: key_accounts_targets {

  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from `toolstation-data-storage.retailReporting.KEY_ACCOUNTS_TARGETS`;;
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: bdm {
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: month {
    type: string
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
  }

  dimension: net_new {
    group_label: "KA"
    type: number
    sql: ${TABLE}.netNew ;;
  }

  dimension: existing_incremental {
    group_label: "KA"
    type: number
    sql: ${TABLE}.existingIncremental ;;
  }

  dimension: overall {
    group_label: "KA"
    type: number
    sql: ${TABLE}.overall ;;
  }
}
