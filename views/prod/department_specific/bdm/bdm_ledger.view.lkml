view: bdm_ledger {
  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from `toolstation-data-storage.retailReporting.BDM_LEDGER`;;
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
    group_label: "BDM"
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: credit_limit {
    group_label: "BDM"
    type: number
    sql: ${TABLE}.creditLimit ;;
  }
 }
