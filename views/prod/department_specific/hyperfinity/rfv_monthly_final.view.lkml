view: rfv_monthly_final {
  derived_table: {
    sql:
      select * from `toolstation-data-storage.Hyperfinity.RFV_MONTHLY_FINAL`;;
  }

  dimension: prim_key {
    group_label:"RFV Monthly Final History"
    type:string
    sql:${customerUID}||${run_date};;
    primary_key: yes
    hidden:yes
  }

  dimension: customerUID {
    group_label:"RFV Monthly Final History"
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: trade_flag {
    group_label:"RFV Monthly Final History"
    type:string
    sql:${TABLE}.TRADE_FLAG;;
    hidden: yes
  }

  dimension: n_orders {
    group_label:"RFV Monthly Final History"
    type:number
    sql:${TABLE}.N_ORDERS;;
    hidden: yes
  }

  dimension: units {
    group_label:"RFV Monthly Final History"
    type:number
    sql:${TABLE}.UNITS;;
    hidden: yes
  }

  dimension: net_sales {
    group_label:"RFV Monthly Final History"
    type:number
    sql:${TABLE}.NETSALES;;
    value_format_name: gbp_0
    hidden: yes
  }

  dimension: days_since_last_order {
    group_label:"RFV Monthly Final History"
    type:number
    sql:${TABLE}.DAYS_SINCE_LAST_ORDER;;
    hidden: yes
  }

  dimension: spend_per_order {
    group_label:"RFV Monthly Final History"
    type:number
    sql:${TABLE}.SPEND_PER_ORDER;;
    value_format_name: gbp_0
    hidden: yes
  }

  dimension: rfv_group {
    group_label:"RFV Monthly Final History"
    label: "RFV Group"
    type:string
    sql:${TABLE}.RFV_GROUP;;
  }

  dimension: run_date {
    group_label:"RFV Monthly Final History"
    type:date
    sql:${TABLE}.RUN_DATE;;
    hidden:no
  }

  dimension: period_code {
    group_label:"RFV Monthly Final History"
    type:string
    sql:${TABLE}.PERIOD_CODE;;
    hidden:no
  }

}
