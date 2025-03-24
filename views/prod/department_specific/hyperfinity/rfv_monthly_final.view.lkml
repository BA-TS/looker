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
