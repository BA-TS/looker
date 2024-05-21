include: "/views/**/supplier_funding_model.view"
include: "/views/**/calendar.view"

explore: supplier_funding_model {
  label: "Supplier Funding Model "
  required_access_grants: [can_use_supplier_information]

  join: calendar_completed_date{
    from:  calendar
    view_label: "Date"
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${supplier_funding_model.date_date}=${calendar_completed_date.date} ;;
  }

}
