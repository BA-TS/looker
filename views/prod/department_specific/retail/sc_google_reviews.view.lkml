view: sc_google_reviews {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_GOOGLE_REVIEWS`;;

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: siteUID {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: newReviews {
    type: string
    sql: ${TABLE}.newReviews ;;
  }

  dimension: rating {
    type: string
    sql: ${TABLE}.rating ;;
  }
 }
