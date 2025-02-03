include: "/views/**/scorecard_branch_dev.view"

view: google_reviews {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.retailReporting.SC_GOOGLE_REVIEWS`;;
    # datagroup_trigger: ts_transactions_datagroup
  }

  dimension: month {
    type: string
    label: "Month_test"
    sql: CAST(${TABLE}.month AS string);;
    required_access_grants: [lz_testing]
    hidden: yes
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

  # dimension: google_rating_error_flag {
  #   type: number
  #   sql:
  #   case when
  #   ${rating}<>${scorecard_branch_dev.rating} then 1
  #   when (${scorecard_branch_dev.rating} is null) then 2
  #   else 0
  #   end;;
  # }

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

}
