view: behaviour_categories_monthly {
  derived_table: {
    sql:
      select * from `toolstation-data-storage.Hyperfinity.BEHAVIOUR_CATEGORIES_MONTHLY`
      ;;
  }

  dimension: customerUID {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: run_date {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.RUN_DATE;;
    hidden:no
    }

  dimension: cluster_high_level {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.CLUSTER_HIGHLEVEL;;
    hidden:no
    }

  dimension: cluster_low_level {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.CLUSTER_LOWLEVEL;;
    hidden:no
  }

  dimension: period_code {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.PERIOD_CODE;;
    hidden:no
  }

  dimension: final_segment{
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.FINAL_SEGMENT;;
    hidden:no
  }

  dimension: final_segment_high_level {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.FINAL_SEGMENT_HIGHLEVEL;;
    hidden:no
  }

  dimension: most_recent_run_date {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.MOST_RECENT_RUN_DATE;;
    hidden:no
  }

  dimension: most_recent_period_code {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.MOST_RECENT_PERIOD_CODE;;
  }

}
