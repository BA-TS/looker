include: "/views/**/scorecard_branch_dev.view"

view: rm_visits {

  derived_table: {
    sql:
      with base as (
       select siteUID, max(month) as month
       from
       `toolstation-data-storage.retailReporting.SC_RM_VISITS`
       group by all

      )

      select s.siteUID,
      s.month as last_visit_month,
      s.score,
      concat(extract (year from current_date), right(concat(0, extract (month from current_date)-1),2)) as month,
      from
      `toolstation-data-storage.retailReporting.SC_RM_VISITS` s
      left join base b
      on s.siteUID = b.siteUID and s.month = b.month
      order by 2 desc
    ;;
    # datagroup_trigger: ts_transactions_datagroup
    }

    dimension: month {
      type: string
      label: "Month test"
      sql: CAST(${TABLE}.month AS string);;
      required_access_grants: [lz_testing]
      # hidden: yes
    }

  dimension: last_visit_month {
    type: string
    sql: CAST(${TABLE}.last_visit_month AS string);;
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