include: "/views/**/*.view"

explore: customers {

  extends: []
  label: "Customer"
  description: "Explore Toolstation customer data."

  required_access_grants: [can_use_customers]

}
