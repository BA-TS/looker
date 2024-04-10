view: ga4_landingpage {

  sql_table_name: `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` ;;

  dimension: land_PK {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${TABLE}.P_K) ;;
  }


  dimension: land_session {
    description: "session_id"
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  #dimension: land_screen {
    #type: string
    #sql: ${TABLE}.Screen_name ;;
  #}

  dimension: land_page {
    type: string
    sql: first_value(${TABLE}.page_location) over (partition by ${TABLE}.session_id order by ${TABLE}.minTime asc) ;;
  }

  dimension: land_screen {
    type: number
    sql: first_value(${TABLE}.Screen_name) over (partition by ${TABLE}.session_id order by ${TABLE}.minTime asc) ;;
  }


}
