view: operational_compliance {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_OPERATIONAL_COMPLIANCE_BRANCH`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
      label: "Month_test"
      sql: CAST(RIGHT(${TABLE}.Month,6) AS string);;
      hidden: yes
    }

    dimension: siteUID {
      type: string
      sql: ${TABLE}.siteUID ;;
      hidden: yes
    }

    dimension: siteUID_month {
      type: string
      sql: concat(${month},${siteUID}) ;;
      hidden: yes
      primary_key: yes
    }

    dimension: tasks {
      group_label: "Monthly"
      label: "Tasks"
      type: number
      sql: ${TABLE}.Tasks ;;
    }

   dimension: overdue {
    group_label: "Monthly"
    label: "Overdue"
    type: number
    sql: ${TABLE}.Overdue ;;
   }

  dimension: percentage_complete {
    group_label: "Monthly"
    label: "Completed %"
    type: number
    sql: ${TABLE}.OperationalCompliance_MTH ;;
  }

  dimension: tasks_YTD {
    group_label: "Monthly"
    label: "Tasks"
    type: number
    sql: ${TABLE}.Tasks_YTD ;;
  }

  dimension: overdue_YTD {
    group_label: "Monthly"
    label: "Overdue"
    type: number
    sql: ${TABLE}.Overdue_YTD ;;
  }

  dimension: percentage_complete_YTD {
    group_label: "Monthly"
    label: "Complete % YTD"
    type: number
    sql: ${TABLE}.OperationalCompliance_YTD ;;
  }

}
