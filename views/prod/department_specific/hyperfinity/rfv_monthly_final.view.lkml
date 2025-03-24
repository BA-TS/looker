view: rfv_monthly_final {
  derived_table: {
    sql:
      select * from `toolstation-data-storage.Hyperfinity.RFV_MONTHLY_FINAL`;;
  }

  dimension: customerUID {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: trade_flag {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.TRADE_FLAG;;
  }

  dimension: n_orders {
    group_label:"Hyperfinity"
    type:number
    sql:${TABLE}.N_ORDERS;;
  }

  dimension: units {
    group_label:"Hyperfinity"
    type:number
    sql:${TABLE}.UNITS;;
  }

  dimension: net_sales {
    group_label:"Hyperfinity"
    type:number
    sql:${TABLE}.NETSALES;;
    value_format_name: gbp_0
  }

  dimension: days_since_last_order {
    group_label:"Hyperfinity"
    type:number
    sql:${TABLE}.DAYS_SINCE_LAST_ORDER;;
  }

  dimension: spend_per_order {
    group_label:"Hyperfinity"
    type:number
    sql:${TABLE}.SPEND_PER_ORDER;;
    value_format_name: gbp_0
  }

  dimension: rfv_group {
    group_label:"Hyperfinity"
    label: "RFV Group"
    type:string
    sql:${TABLE}.RFV_GROUP;;
  }

  dimension: run_date {
    group_label:"Hyperfinity"
    type:date
    sql:${TABLE}.RUN_DATE;;
    hidden:yes
  }

  dimension: period_code {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.PERIOD_CODE;;
    hidden:yes
  }

}
