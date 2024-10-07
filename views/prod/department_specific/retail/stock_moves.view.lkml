include: "/views/**/scorecard_branch_dev.view"

view: stock_moves {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_MOVES_VS_DELIVERED` ;;

  dimension: month {
    type: string
    view_label: "Date"
    label: "Year Month (yyyymm)"
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: moves {
    type: number
    sql: ${TABLE}.moves ;;
  }

  dimension: stock_Accuracy_error_flag {
    type: yesno
    sql: (${scorecard_branch_dev.stock_Accuracy} is null) ;;
  }

}
