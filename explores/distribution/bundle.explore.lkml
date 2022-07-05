include: "/views/prod/supply_chain/bundle_orders_detail.view"

explore: bundle_orders_detail {

  extends: []
  label: "Bundles"
  description: "Explore Toolstation bundles."

  # always_filter: {
  #   filters: [
  #     isActive: "1"
  #   ]
  # }

  fields: [
    ALL_FIELDS*,
  ]}
