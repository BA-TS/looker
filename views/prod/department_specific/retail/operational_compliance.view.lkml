view: operational_compliance {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_OPERATIONAL_COMPLIANCE_BRANCH`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
      label: "Month_test"
      sql: CAST(${TABLE}.Month AS string);;
      required_access_grants: [lz_testing]
      hidden: yes
    }

    dimension: siteUID {
      type: string
      view_label: "Site Information"
      label: "Site UID"
      sql: ${TABLE}.siteUID ;;
      hidden: yes
    }

    dimension: siteUID_month {
      type: string
      view_label: "Site Information"
      sql: concat(${month},${siteUID}) ;;
      hidden: yes
      primary_key: yes
    }

    dimension: tasks {
      label: "Tasks"
      type: number
      sql: ${TABLE}.Tasks ;;
    }

   dimension: overdue {
    label: "Overdue"
    type: number
    sql: ${TABLE}.Overdue ;;
   }

  dimension: percentage_complete {
    label: "Operational Compliance Completed %"
    type: number
    sql: ${TABLE}.OperationalCompliance_MTH ;;
  }

  dimension: tasks_YTD {
    label: "Tasks YTD"
    type: number
    sql: ${TABLE}.Tasks_YTD ;;
  }

  dimension: overdue_YTD {
    label: "Overdue YTD"
    type: number
    sql: ${TABLE}.Overdue_YTD ;;
  }

  dimension: percentage_complete_YTD {
    label: "Complete % YTD"
    type: number
    sql: ${TABLE}.OperationalCompliance_YTD ;;
  }

  dimension: operational_compliance_error_flag {
    type: yesno
    sql: (${percentage_complete}!=${scorecard_branch_dev.operational_Compliance}) or (${scorecard_branch_dev.operational_Compliance} is null) ;;
  }
}
