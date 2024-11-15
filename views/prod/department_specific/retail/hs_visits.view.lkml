view: hs_visits {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_HS_VISITS`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
      label: "Month_test"
      sql: CAST(RIGHT(${TABLE}.month,6) AS string);;
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

    dimension: hs_visits_score {
      label: "HS Visit"
      type: number
      sql: ${TABLE}.score;;
    }
  }
