include: "/views/**/scorecard_branch_dev.view"

view: rm_visits {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_RM_VISITS`;;
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

    dimension: score {
      label: "RM Visit"
      type: number
      sql: cast(${TABLE}.score as decimal) ;;
    }

   dimension: rm_visit_error_flag {
    type: yesno
    sql: (${score}-${scorecard_branch_dev.rm_Visit}>0) or (${scorecard_branch_dev.rm_Visit} is null) ;;
  }

  }
