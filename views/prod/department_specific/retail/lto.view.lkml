include: "/views/**/scorecard_branch_dev.view"

view: lto {

  derived_table: {
    sql:
    select *,
    --concat(extract (year from current_date), right(concat(0, extract (month from current_date)-1),2)) as month,
          202412 as month,
    from `toolstation-data-storage.retailReporting.SC_LTO_BRANCH`;;
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

    dimension: lto {
      label: "LTO %"
      type: number
      sql: ${TABLE}.LTO ;;
      value_format_name: percent_1
    }


  }
