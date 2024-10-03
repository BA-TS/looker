
include: "/views/**/scorecard_branch_dev.view"

view: paid_hours {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_Paid_Hours`;;

  dimension: month {
    type: string
    view_label: "Date"
    label: "Year Month (yyyymm)"
    sql: ${TABLE}.month ;;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.Shop_code ;;
    hidden: yes
  }

  dimension: Actual_Hours {
    type: string
    sql: ${TABLE}.Actual_Hours ;;
  }

  dimension: AOP_Hours {
    type: string
    sql: ${TABLE}.AOP_Hours ;;
  }

  dimension: Overtime_Hours {
    type: string
    sql: ${TABLE}.Overtime_Hours ;;
  }

  dimension: Worked_Hours {
    type: string
    sql: ${TABLE}.Worked_Hours ;;
  }

  dimension: AOP_Worked_Hours {
    type: string
    sql: ${TABLE}.AOP_Worked_Hours ;;
  }
}
