include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Development"

explore: sites {
  required_access_grants: [is_developer]
}
