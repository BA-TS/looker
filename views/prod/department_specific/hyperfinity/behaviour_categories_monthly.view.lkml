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

  dimension: RUN_DATE {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.RUN_DATE;;
    hidden:no
    }

  dimension: CLUSTER_HIGH_LEVEL {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.CLUSTER_HIGHLEVEL;;
    hidden:no
    }

  dimension: CLUSTER_LOW_LEVEL {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.CLUSTER_LOWLEVEL;;
    hidden:no
  }

  dimension: PERIOD_CODE {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.PERIOD_CODE;;
    hidden:no
  }

  dimension: FINAL_SEGMENT {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.FINAL_SEGMENT;;
    hidden:no
  }

  dimension: FINAL_SEGMENT_HIGH_LEVEL {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.FINAL_SEGMENT_HIGHLEVEL;;
    hidden:no
  }

  dimension: MOST_RECENT_RUN_DATE {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.MOST_RECENT_RUN_DATE;;
    hidden:no
  }

  dimension: MOST_RECENT_PERIOD_CODE {
    group_label:"Hyperfinity"
    type:string
    sql:${TABLE}.MOST_RECENT_PERIOD_CODE;;
  }

}
