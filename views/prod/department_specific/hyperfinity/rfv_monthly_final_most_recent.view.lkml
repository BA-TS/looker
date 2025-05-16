view: rfv_monthly_final_most_recent {
  derived_table: {
    sql:
      with most_recent_run as (
        select UCU_UID,max(RUN_DATE) as RUN_DATE
        from`toolstation-data-storage.Hyperfinity.RFV_MONTHLY_FINAL`
        group by all
      )

      select h.*
      from `toolstation-data-storage.Hyperfinity.RFV_MONTHLY_FINAL` h
      inner join most_recent_run r
      on h.UCU_UID = r.UCU_UID
      and h.RUN_DATE = r.RUN_DATE;;
  }

  dimension: prim_key {
    group_label:"RFV Monthly Final"
    type:string
    sql:${customerUID}||${run_date};;
    primary_key: yes
    hidden:yes
  }

  dimension: customerUID {
    group_label:"RFV Monthly Final"
    type:string
    sql:${TABLE}.UCU_UID;;
    hidden:yes
  }

  dimension: rfv_group {
    group_label:"RFV Monthly Final"
    label: "RFV Group"
    type:string
    sql:${TABLE}.RFV_GROUP;;
  }

  dimension: run_date {
    group_label:"RFV Monthly Final"
    type:date
    sql:${TABLE}.RUN_DATE;;
    hidden:no
  }

  dimension: period_code {
    group_label:"RFV Monthly Final"
    type:string
    sql:${TABLE}.PERIOD_CODE;;
    hidden:yes
  }

  dimension: month_start {
    group_label:"RFV Monthly Final"
    label: "Month Start (yyyymm)"
    type:string
    sql:cast(${TABLE}.MONTH_START as string);;
    hidden:yes
  }

  dimension: month_end {
    group_label:"RFV Monthly Final"
    label: "Month End (yyyymm)"
    type:string
    sql:cast(${TABLE}.MONTH_END as string);;
    hidden:yes
  }

}
