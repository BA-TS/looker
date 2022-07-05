include: "/views/prod/customer/customer_stats.view"

explore: customer_stats {

  extends: []
  label: "Customer Stats"
  description: "Explore Toolstation customer stats by day"

  # always_filter: {
  #   filters: [
  #     isActive: "1"
  #   ]
  # }

  fields: [
    ALL_FIELDS*,
  ]}
