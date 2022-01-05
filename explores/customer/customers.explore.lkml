# include: "/views/**/*.view"
include: "/views/prod/customer/*.view"
include: "/views/prod/department_specific/crm/trade_customers.view"

explore: customers {

  label: "Customer"
  description: "Explore Toolstation customer data."

  # required_access_grants: [can_use_customers]

  join: trade_customers {
    view_label: "Budget"
    type: left_outer
    relationship: one_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_number};;
  }

}
