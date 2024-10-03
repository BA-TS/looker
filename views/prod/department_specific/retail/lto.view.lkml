include: "/views/**/scorecard_branch_dev.view"

view: lto {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_Retention_LTO`;;
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
      sql: ${TABLE}.Shop_code ;;
      hidden: yes
    }

    dimension: lto {
      label: "LTO"
      type: string
      sql: ${TABLE}.lto ;;
      value_format_name: percent_1
    }
  }
