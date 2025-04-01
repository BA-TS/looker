include: "/views/**/scorecard_branch_dev.view"

view: training {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_TRAINING`;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
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

    dimension: available {
      type: number
      label: "Training Available"
      sql: ${TABLE}.available ;;
    }

    dimension: completed {
      type: number
      label: "Training Completed"
      sql: ${TABLE}.completed ;;
    }

  dimension: completed_percent{
    type: number
    label: "Training Completed %"
    sql: safe_divide(${completed},${available}) ;;
    value_format_name: percent_1
  }

  # dimension: training_error_flag {
  #   type: yesno
  #   sql: (${completed_percent}!=${scorecard_branch_dev.training_Percent_Completed}) or (${scorecard_branch_dev.training_Percent_Completed} is null) ;;
  # }

  }
