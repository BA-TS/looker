include: "/views/**/scorecard_branch_dev.view"

view: stock_moves {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_MOVES_VS_DELIVERED` ;;

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
    group_label: "Monthly"
    type: number
    sql: ${TABLE}.moves ;;
  }

}
