view: ga4_landingpage {

  sql_table_name: `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` ;;

  dimension: land_PK {
    primary_key: yes
    hidden: yes
    type: string
    sql: sql: concat(${TABLE}.P_K,coalesce("NONE"),coalesce(${itemid},"NONE"), coalesce(${land_Mintime},"NONE")) ;;
  }

  dimension: land_Mintime {
    hidden: yes
    type: string
    sql: cast(${TABLE}.minTime as string) ;;
  }

  dimension: land_session {
    description: "session_id"
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: land_screen {
    type: string
    sql: ${TABLE}.Screen_name ;;
  }

  dimension: land_page {
    type: string
    sql: ${TABLE}.page_location ;;
  }

  dimension: firstEvent {
    type: number
    sql: row_number() over (partition by ${land_session} order by ${land_Mintime} asc ) ;;
  }

  dimension: itemid {
    type: string
    hidden: yes
    sql: case when ${TABLE}.item_id in ('44842') then 'null' else ${TABLE}.item_id end;;
  }

}
