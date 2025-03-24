view: behaviour_categories_monthly {
  derived_table: {
    sql:
      select * from `toolstation-data-storage.Hyperfinity.BEHAVIOUR_CATEGORIES_MONTHLY`
      ;;
  }

  dimension: prim_key {
    group_label:"RFV Monthly Final"
    type:string
    sql:concatenate(${customerUID},${run_date};;
    primary_key: yes
    hidden:yes
  }

  dimension: customerUID {
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: run_date {
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:${TABLE}.RUN_DATE;;
    hidden:no
    }

  dimension: cluster_high_level {
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:${TABLE}.CLUSTER_HIGHLEVEL;;
    hidden:yes
    }

  dimension: cluster_low_level {
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:${TABLE}.CLUSTER_LOWLEVEL;;
    hidden:yes
  }

  dimension: period_code {
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:${TABLE}.PERIOD_CODE;;
    hidden:no
  }

  dimension: final_segment{
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:coalesce(${TABLE}.FINAL_SEGMENT,"Unknown");;
    hidden:no
  }

  dimension: final_segment_high_level {
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:coalesce(${TABLE}.FINAL_SEGMENT_HIGHLEVEL,"Unknown");;
    hidden:no
  }

  dimension: most_recent_run_date {
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:${TABLE}.MOST_RECENT_RUN_DATE;;
    hidden:no
  }

  dimension: most_recent_period_code {
    group_label:"Behaviour Categories Monthly"
    type:string
    sql:${TABLE}.MOST_RECENT_PERIOD_CODE;;
  }

}
