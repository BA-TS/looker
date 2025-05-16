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

  dimension: run_date {
    group_label:"RFV Monthly Final"
    type:date
    sql:${TABLE}.RUN_DATE;;
    hidden:yes
  }

  dimension: period_code {
    group_label:"RFV Monthly Final"
    type:string
    sql:${TABLE}.PERIOD_CODE;;
    hidden:yes
  }

  dimension: most_recent_run {
    group_label:"RFV Monthly Final"
    type:yesno
    sql:${run_date} is not null;;
    hidden: yes
  }
}
