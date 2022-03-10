

include: "/views/prod/finance/weekly_new_stores_sales.view.lkml"


explore: weekly_new_stores_sales{

  required_access_grants: [is_developer]

}
