view: operational_compliance {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_OPERATIONAL_COMPLIANCE`;;
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
      sql: ${TABLE}.UID ;;
      hidden: yes
    }

    dimension: siteUID_month {
      type: string
      view_label: "Site Information"
      sql: concat(${month},${siteUID}) ;;
      hidden: yes
      primary_key: yes
    }

    dimension: number_of_task {
      label: "OC - Number of tasks"
      type: number
      sql: ${TABLE}.Number_of_task ;;
    }

   dimension: overdue {
    label: "OC - Overdue"
    type: number
    sql: ${TABLE}.Overdue ;;
   }

  dimension: percentage_complete {
    label: "OC - % Complete"
    type: number
    sql: ${TABLE}.Percentage_complete ;;
  }
}
