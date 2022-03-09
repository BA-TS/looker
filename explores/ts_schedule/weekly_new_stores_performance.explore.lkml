include: "/views/prod/finance/weekly_new_stores_performance.view.lkml"


explore: weekly_new_stores_performance{

  required_access_grants: [is_developer]

}
