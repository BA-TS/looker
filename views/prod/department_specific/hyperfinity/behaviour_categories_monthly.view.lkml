view: behaviour_categories_monthly {
  derived_table: {
    sql:
      select * from `toolstation-data-storage.Hyperfinity.BEHAVIOUR_CATEGORIES_MONTHLY`
      ;;
  }

  dimension: prim_key {
    group_label:"Behaviour Categories History"
    type:string
    sql:${customerUID}||${run_date};;
    primary_key: yes
    hidden:yes
  }

  dimension: customerUID {
    group_label:"Behaviour Categories History"
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: run_date {
    group_label:"Behaviour Categories History"
    type:string
    sql:${TABLE}.RUN_DATE;;
    hidden:no
    }

  dimension: cluster_high_level {
    group_label:"Behaviour Categories History"
    type:string
    sql:${TABLE}.CLUSTER_HIGHLEVEL;;
    }

  dimension: cluster_low_level {
    group_label:"Behaviour Categories History"
    type:string
    sql:${TABLE}.CLUSTER_LOWLEVEL;;
  }

  dimension: period_code {
    group_label:"Behaviour Categories History"
    type:string
    sql:cast(${TABLE}.PERIOD_CODE as string);;
    hidden: yes
  }

  dimension: final_segment{
    group_label:"Behaviour Categories History"
    type:string
    sql:coalesce(${TABLE}.FINAL_SEGMENT,"Unknown");;
  }

  dimension: final_segment_high_level {
    group_label:"Behaviour Categories History"
    type:string
    sql:coalesce(${TABLE}.FINAL_SEGMENT_HIGHLEVEL,"Unknown");;
  }

  dimension: most_recent_run_date {
    group_label:"Behaviour Categories History"
    type:string
    sql:${TABLE}.MOST_RECENT_RUN_DATE;;
  }

  dimension: most_recent_period_code {
    group_label:"Behaviour Categories History"
    type:string
    sql:${TABLE}.MOST_RECENT_PERIOD_CODE;;
  }


  dimension: new_customer_flag {
    type:yesno
    sql:${TABLE}.NEW_CUSTOMER_FLAG;;
  }

  dimension: month_start {
    group_label:"Behaviour Categories History"
    label: "Month Start (yyyymm)"
    type:string
    sql:cast(${TABLE}.MONTH_START as string);;
    hidden:yes
  }

  dimension: month_end {
    group_label:"Behaviour Categories History"
    label: "Month End (yyyymm)"
    type:string
    sql:cast(${TABLE}.MONTH_END as string);;
    hidden:yes
  }
}
