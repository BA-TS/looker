view: lto {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_Retention_LTO`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
      label: "Month test"
      sql: CAST(${TABLE}.month AS string);;
      required_access_grants: [lz_testing]
      # hidden: yes
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

    dimension: lto {
      type: string
      sql: ${TABLE}.lto ;;
    }
  }
