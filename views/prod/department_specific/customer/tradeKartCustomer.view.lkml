view: tradekartcustomer {

derived_table: {
  sql: select distinct customerUID
  from `toolstation-data-storage.crm_reporting.TradeKartCustomerUID_copy`
  ;;
}

dimension: customerUID {
  type: string
  sql: ${TABLE}.customerUID ;;
  hidden: yes
}

dimension: trade_kart_customers {
  type: yesno
  sql: ${customerUID} is not null ;;
}

}
