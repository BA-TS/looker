view: test_dgtl_ds_contibution {
  derived_table: {
    sql: SELECT * FROM `toolstation-data-storage.digitalreporting.DGTL_DS_Contribution`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fiscal_year_week {
    type: number
    sql: ${TABLE}.fiscalYearWeek ;;
  }

  dimension: fin_fyw {
    type: number
    sql: ${TABLE}.finFYW ;;
  }

  dimension: digital_net_revenue {
    type: number
    sql: ${TABLE}.digitalNetRevenue ;;
  }

  dimension: business_net_revenue {
    type: number
    sql: ${TABLE}.businessNetRevenue ;;
  }

  dimension: contribution {
    type: number
    sql: ${TABLE}.contribution ;;
  }

  set: detail {
    fields: [fiscal_year_week, fin_fyw, digital_net_revenue, business_net_revenue, contribution]
  }
}
