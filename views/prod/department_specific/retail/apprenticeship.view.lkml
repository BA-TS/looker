view: apprenticeship {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_APPRENTICESHIP_BRANCH`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
      sql: CAST(RIGHT(${TABLE}.Month,6) AS string);;
      required_access_grants: [lz_testing]
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

    dimension: Apprentices_MTH {
      group_label: "Monthly"
      label: "Apprenticeship"
      type: number
      sql: ${TABLE}.Apprentices_MTH ;;
    }

    dimension: Apprentices_YTD {
      group_label: "YTD"
      label: "Apprenticeship"
      type: number
      sql: ${TABLE}.Apprentices_YTD ;;
    }



  }
