view: ga4_landingpage {

  sql_table_name: `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` ;;

  dimension: land_PK {
    primary_key: yes
    hidden: yes
    type: string
    sql: row_number() over () ;;
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

  measure: land_page {
    type: string
    sql: min_by(${TABLE}.Screen_name, ${TABLE}.minTime);;
  }

  #dimension: land_screen {
    #type: number
    #sql: first_value(${TABLE}.Screen_name) over (partition by ${TABLE}.session_id order by ${TABLE}.minTime asc) ;;
  #}


}
