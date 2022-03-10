include: "/views/prod/finance/monthly_pendingOrders.view.lkml"


explore: monthly_pendingOrders{

  required_access_grants: [is_developer]

}
