include: "/views/**/*.view"

explore: retail {
  view_name: google_reviews
  required_access_grants: [lz_testing]
  label: "Retail"

  join: sites {
    view_label: "Site Information"
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${sites.site_uid} ;;
  }

  join: appraisals {
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${appraisals.siteUID} and ${google_reviews.month}=${appraisals.month} ;;
  }

  join: compliance_support {
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${compliance_support.siteUID} and ${google_reviews.month}=${compliance_support.month} ;;
  }

  join: paid_hours {
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${paid_hours.siteUID} and ${google_reviews.month}=${paid_hours.month} ;;
  }
}
