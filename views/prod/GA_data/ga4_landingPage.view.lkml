view: ga4_landingpage {

  derived_table: {
    explore_source: GA4_testy {
      bind_all_filters: yes
      column: land_PK { field: ga4_rjagdev_test.PK}
      column: land_time { field: ga4_rjagdev_test.Mintime}
      column: land_session { field: ga4_rjagdev_test.session_id}
      column: land_page { field: ga4_rjagdev_test.page_location}
      column: land_screen { field: ga4_rjagdev_test.Screen_name}
      derived_column: firstEvent {
        sql: row_number() over (partition by land_session order by land_time asc) ;;
      }
    }
  }

  dimension: land_PK {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.land_PK ;;
  }

  dimension: land_session {
    type: string
    sql: ${TABLE}.land_session ;;
  }

  dimension: land_screen {
    type: string
    sql: ${TABLE}.land_screen ;;
  }

  dimension: land_page {
    type: string
    sql: ${TABLE}.land_page ;;
  }

  dimension: firstEvent {
    type: number
    sql: ${TABLE}.firstEvent ;;
  }

}
