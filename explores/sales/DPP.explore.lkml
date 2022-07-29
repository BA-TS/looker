include: "/views/prod/finance/dpp_output.view"

explore: dpp_output {

  extends: []
  label: "DPP"
  description: "Explore Toolstation DPP"

  # always_filter: {
  #   filters: [
  #     isActive: "1"
  #   ]
  # }

  fields: [
    ALL_FIELDS*,
  ]}
