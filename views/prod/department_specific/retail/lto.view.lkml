view: lto {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_Retention_LTO`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: siteUID {
      type: string
      view_label: "Site Information"
      label: "Site UID"
      sql: ${TABLE}.Shop_code ;;
      hidden: yes
    }

    dimension: lto {
      label: "LTO"
      type: string
      sql: ${TABLE}.lto ;;
    }
  }
