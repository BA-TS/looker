view: behaviour_categories_monthly_most_recent {
  derived_table: {
    sql:
      with most_recent_run as (
        select UCU_UID,max(RUN_DATE) as RUN_DATE
        from `toolstation-data-storage.Hyperfinity.BEHAVIOUR_CATEGORIES_MONTHLY`
        group by all
      )

      select distinct h.*
      from `toolstation-data-storage.Hyperfinity.BEHAVIOUR_CATEGORIES_MONTHLY` h
      inner join most_recent_run r
      on h.UCU_UID = r.UCU_UID
      and h.RUN_DATE = r.RUN_DATE
      ;;
  }

  dimension: prim_key {
    group_label:"Behaviour Categories"
    type:string
    sql:${customerUID}||${run_date};;
    primary_key: yes
    hidden:yes
  }

  dimension: customerUID {
    group_label:"Behaviour Categories"
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: run_date {
    group_label:"Behaviour Categories"
    type:string
    sql:${TABLE}.RUN_DATE;;
    hidden:no
  }

  dimension: cluster_high_level {
    group_label:"Behaviour Categories"
    type:string
    sql:${TABLE}.CLUSTER_HIGHLEVEL;;
  }

  dimension: cluster_low_level {
    group_label:"Behaviour Categories"
    type:string
    sql:${TABLE}.CLUSTER_LOWLEVEL;;
  }

  dimension: period_code {
    group_label:"Behaviour Categories"
    type:string
    sql:${TABLE}.PERIOD_CODE;;
  }

  dimension: final_segment{
    group_label:"Behaviour Categories"
    type:string
    sql:coalesce(${TABLE}.FINAL_SEGMENT,"Unknown");;
  }

  dimension: final_segment_high_level {
    group_label:"Behaviour Categories"
    type:string
    sql:coalesce(${TABLE}.FINAL_SEGMENT_HIGHLEVEL,"Unknown");;
  }

  dimension: most_recent_run_date {
    group_label:"Behaviour Categories"
    type:string
    sql:${TABLE}.MOST_RECENT_RUN_DATE;;
    hidden: yes
  }

  dimension: most_recent_period_code {
    group_label:"Behaviour Categories"
    type:string
    sql:${TABLE}.MOST_RECENT_PERIOD_CODE;;
    hidden: yes
  }

}
