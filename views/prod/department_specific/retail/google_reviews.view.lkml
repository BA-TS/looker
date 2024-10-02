view: google_reviews {

  # sql_table_name:`toolstation-data-storage.retailReporting.SC_GOOGLE_REVIEWS`;;

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_GOOGLE_REVIEWS`;;
    # datagroup_trigger: ts_transactions_datagroup
  }


  dimension: month {
    type: string
    label: "Google_month"
    sql: CAST(${TABLE}.month AS string);;
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

  dimension: newReviews {
    type: string
    label: "Number of Reviews"
    sql: ${TABLE}.newReviews ;;
  }

  dimension: rating {
    label: "Google Rating"
    type: string
    description: "Rating"
    sql: ${TABLE}.rating ;;
  }

  measure: TotalReviews {
    type: sum
    label: "Total Number of Reviews"
    sql: ${newReviews};;
  }

  measure: AverageRating {
    type: average
    label: "Average Rating"
    sql: ${rating} ;;
  }

  measure: siteUID_count {
    type: count_distinct
    view_label: "Site Information"
    label: "Number of sites (Google Reviews)"
    sql: ${siteUID} ;;
  }
}
