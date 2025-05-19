view: rfv_monthly_final {
  derived_table: {
    sql:
      select * from `toolstation-data-storage.Hyperfinity.RFV_MONTHLY_FINAL`;;
  }

  dimension: prim_key {
    type:string
    sql:${customerUID}||${run_date};;
    primary_key: yes
    hidden:yes
  }

  dimension: customerUID {
    label: "RFV customer UID test"
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: rfv_group {
    group_label:"RFV Monthly Final"
    label: "RFV Group"
    type:string
    sql:coalesce(${TABLE}.RFV_GROUP,"New");;
  }

  dimension: rfv_group_number {
    group_label:"RFV Monthly Final"
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

  dimension: loyalty_segment {
    group_label:"RFV Monthly Final"
    type: string
    sql:
    case when ${rfv_group} ="High Freq High Val" then "Frequent High Spender"
    when ${rfv_group} ="High Freq High Val" then "Frequent High Spender"
    when ${rfv_group} ="High Freq Low Val" then "Frequent Low Spender"
    when ${rfv_group} ="Mid Freq High Val" then "Regular High Spender"
    when ${rfv_group} ="Mid Freq Low Val" then "Regular Low Spender"
    when ${rfv_group} ="Low Freq High Val" then "Infrequent High Spender"
    when ${rfv_group} ="Low Freq Low Val" then "Infrequent Low Spender"
    when ${rfv_group} ="Single Shoppers" then "Single Shoppers"
    when ${rfv_group} ="New" then "New"
    when ${rfv_group} ="Inactive" then "Reactivated (Prev Lapsed/Inactive/Dormant)"
    else "Unknown"
    end
    ;;
  }

  dimension: loyalty_segment_number{
    group_label:"RFV Monthly Final"
    type: string
    sql:
    case when ${loyalty_segment} = "Frequent High Spender" then "1"
    when ${loyalty_segment} ="Frequent Low Spender" then "2"
    when ${loyalty_segment} ="Regular High Spender" then "3"
    when ${loyalty_segment} ="Regular Low Spender" then "4"
    when ${loyalty_segment} ="Infrequent High Spender" then "5"
    when ${loyalty_segment} ="Infrequent Low Spender" then "6"
    when ${loyalty_segment} ="Single Shoppers" then "7"
    when ${loyalty_segment} ="New" then "8"
    when ${loyalty_segment} ="Reactivated (Prev Lapsed/Inactive/Dormant)" then "9"
    else "Unknown"
    end
    ;;
  }

  dimension: run_date {
    group_label:"RFV Monthly Final"
    type:date
    sql:${TABLE}.RUN_DATE;;
    hidden:yes
  }

  dimension: period_code {
    type:string
    sql:cast(${TABLE}.PERIOD_CODE as string);;
    hidden: yes
  }

  dimension: month_start {
    label: "Month Start (yyyymm)"
    type:string
    sql:cast(${TABLE}.MONTH_START as string);;
    hidden: yes
  }

  dimension: month_end {
    label: "Month End (yyyymm)"
    type:string
    sql:cast(${TABLE}.MONTH_END as string);;
    hidden: yes
  }

}
