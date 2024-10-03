view: operational_compliance {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_GOOGLE_REVIEWS`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
      label: "Month_test"
      sql: CAST(${TABLE}.month AS string);;
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

    dimension: number_of_task {
      group_label: "Operational Compliance"
      label: "OC - Number of tasks"
      type: string
      sql: ${TABLE}.number_of_task ;;
    }

   dimension: overdue {
    group_label: "Operational Compliance"
    label: "OC - Overdue"
    type: string
    sql: ${TABLE}.overdue ;;
   }

  dimension: percentage_complete {
    group_label: "Operational Compliance"
    label: "OC - % Complete"
    type: string
    sql: ${TABLE}.percentage_complete ;;
  }
}
