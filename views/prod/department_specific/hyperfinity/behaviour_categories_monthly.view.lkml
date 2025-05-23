include: "/views/**/behaviour_categories_monthly_most_recent.view"

view: behaviour_categories_monthly {
  derived_table: {
    sql:
      select * from `toolstation-data-storage.Hyperfinity.BEHAVIOUR_CATEGORIES_MONTHLY`
      ;;
  }

  dimension: prim_key {
    type:string
    sql:${customerUID}||${run_date};;
    primary_key: yes
    hidden:yes
  }

  dimension: customerUID {
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: run_date {
    type:string
    sql:${TABLE}.RUN_DATE;;
    }

  dimension: cluster_high_level {
    group_label:"Behaviour Categories"
    type:string
    # sql:coalesce(${TABLE}.CLUSTER_HIGHLEVEL,"Unknown");;
    sql:${TABLE}.CLUSTER_HIGHLEVEL;;
    }

  dimension: cluster_low_level {
    group_label:"Behaviour Categories"
    type:string
    sql:coalesce(${TABLE}.CLUSTER_LOWLEVEL,"Unknown");;
  }

  dimension: final_segment{
    group_label:"Behaviour Categories"
    type:string
    sql:coalesce(${TABLE}.FINAL_SEGMENT,"Unknown");;
    hidden: yes
  }

  dimension: final_segment_high_level {
    group_label:"Behaviour Categories"
    type:string
    sql:coalesce(${TABLE}.FINAL_SEGMENT_HIGHLEVEL,"Unknown");;
  }

  dimension: is_lastest_run {
    type: yesno
    sql:${run_date}=${behaviour_categories_monthly_most_recent.run_date};;
  }

  # dimension: most_recent_run_date {
  #   group_label:"Behaviour Categories"
  #   type:string
  #   sql:${TABLE}.MOST_RECENT_RUN_DATE;;
  #   hidden: yes
  # }

  # dimension: is_most_recent_period_code {
  #   group_label:"Behaviour Categories"
  #   type:string
  #   sql:${TABLE}.MOST_RECENT_PERIOD_CODE;;
  #   hidden: yes
  # }

  dimension: new_customer_flag {
    type:yesno
    sql:${TABLE}.NEW_CUSTOMER_FLAG;;
  }

  dimension: month_start {
    label: "Month Start (yyyymm)"
    type:string
    sql:cast(${TABLE}.MONTH_START as string);;
  }

  dimension: month_end {
    label: "Month End (yyyymm)"
    type:string
    sql:cast(${TABLE}.MONTH_END as string);;
  }

  dimension: period_code {
    type:string
    sql:cast(${TABLE}.PERIOD_CODE as string);;
  }

  dimension: has_a_run{
    type:yesno
    sql:${period_code} is not null;;
  }

  measure: latest_period_code {
    type:max
    sql:${period_code};;
    value_format: "0"
  }

  # measure: most_recent_month_start {
  #   type:max
  #   sql:${month_start};;
  #   value_format: "0"
  # }

}
