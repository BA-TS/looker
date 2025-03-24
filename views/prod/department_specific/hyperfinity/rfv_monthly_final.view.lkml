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

  dimension: rfv_group_number {
    group_label:"RFV Monthly Final History"
    label: "RFV Group Number"
    type:number
    sql:
      case when ${rfv_group} ="High Freq High Val" Then 1
      when ${rfv_group} ="High Freq Low Val" Then 2
      when ${rfv_group} ="Mid Freq High Val" Then 3
      when ${rfv_group} ="Mid Freq Low Val" Then 4
      when ${rfv_group} ="Low Freq High Val" Then 5
      when ${rfv_group} ="Low Freq Low Val" Then 6
      when ${rfv_group} ="Single Shoppers" Then 7
      when ${rfv_group} ="Inactive" Then 8
      when ${rfv_group} ="Lapsed/Dormant" Then 9
      when ${rfv_group} ="New" Then 10
      else null end
    ;;
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
