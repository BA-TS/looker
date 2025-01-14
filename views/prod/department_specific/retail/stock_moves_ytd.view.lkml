include: "/views/**/scorecard_branch_dev.view"

view: stock_moves_ytd {
  derived_table: {
    sql:
    select
    siteUID,
    sum(moves) as moves,
        --concat(extract (year from current_date), right(concat(0, extract (month from current_date)-1),2)) as month,
              202412 as month,
    from `toolstation-data-storage.retailReporting.SC_MOVES_VS_DELIVERED`
    where left(cast(month as string),4) = cast(extract (year from current_date) as string)
    group by all
    ;;
  }

  dimension: month {
    type: string
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: moves {
    group_label: "YTD"
    type: number
    sql: ${TABLE}.moves ;;
  }

}
