view: page_location_page_title {
  derived_table: {
    explore_source: GA4 {
      bind_all_filters: yes
      column: page_location { field:ga4.page_location}
      column: screen { field:ga4.screen}
      derived_column: P_K {
        sql: row_number() over () ;;
      }
    }
  }

  dimension: P_K {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.P_K ;;
  }

  dimension: page_location {
    type: string
    sql: ${TABLE}.page_location ;;
  }

  dimension: screen {
    type: string
    sql: ${TABLE}.screen ;;
  }

}
