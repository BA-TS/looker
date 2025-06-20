include: "/views/**/calendar.view"
include: "/views/**/base.view"

view: behaviour_categories_monthly_most_recent_all {
  derived_table: {
    sql:

        select max(RUN_DATE) as RUN_DATE
        from `toolstation-data-storage.Hyperfinity.BEHAVIOUR_CATEGORIES_MONTHLY`
        group by all
      ;;
  }

  dimension: run_date {
    type:string
    sql:${TABLE}.RUN_DATE;;
    hidden:yes
  }

  dimension: is_latest_run_all{
    label: "Is Latest Run"
    type:yesno
    sql:${run_date} is not null;;
  }

  dimension: hyperfinity_latest{
    type:yesno
    sql:${is_latest_run_all} is not null and ${calendar_completed_date.previous_fiscal_week} is not null;;
  }

}
