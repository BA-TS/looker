view: apprenticeship {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_APPRENTICESHIP_BRANCH`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
      label: "Month_test"
      sql: CAST(RIGHT(${TABLE}.Month,6) AS string);;
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

    dimension: Apprentices_MTH {
      label: "Apprenticeship MTH"
      type: number
      sql: ${TABLE}.Apprentices_MTH ;;
    }

    dimension: Apprentices_YTD {
      label: "Apprenticeship YTD"
      type: number
      sql: ${TABLE}.Apprentices_YTD ;;
    }



  }
