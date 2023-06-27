include: "/views/**/*.view"

explore: retail {
  view_name: google_reviews
  required_access_grants: [testing]
  label: "Retail"

  join: sites {
    view_label: "Site Information"
    type: left_outer
    relationship: many_to_one
    sql_on: ${google_reviews.siteUID}=${sites.site_uid} ;;
  }
}
