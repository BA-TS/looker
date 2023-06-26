view: google_reviews {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_GOOGLE_REVIEWS`;;

  dimension: month {
    type: string
    view_label: "Date"
    label: "Year Month (yyyymm)"
    sql: ${TABLE}.month ;;
  }

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
  }

  dimension: newReviews {
    type: string
    label: "Number of Reviews"
    sql: ${TABLE}.newReviews ;;
  }

  dimension: rating {
    type: string
    description: "Rating (0-5)"
    sql: ${TABLE}.rating ;;
  }
 }
