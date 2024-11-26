view: change_hours {

  derived_table: {
    sql:
    SELECT
    *
    FROM
   `toolstation-data-storage.retailReporting.change_hours`
    ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.site_uid ;;
    hidden: yes
    primary_key: yes
  }

  dimension: change_hours {
    type: string
    sql: ${TABLE}.change_hours;;
  }

}
