view: ds_daily_sku_sales_ty_ly_lly_lw {
  derived_table: {
    sql:
      SELECT
      # --distinct row_number() over () as P_K,
      *,
      FROM `toolstation-data-storage.financeReporting.DS_DAILY_SKU_SALES_TY_LY_LLY_LW`
     where dims.date between date_sub(current_date(), interval 14 day) and current_date()
      ;;
     datagroup_trigger: ts_daily_datagroup
  }

  dimension: P_K {
    description: "Primary Key"
    type: string
    sql: concat(${date_date}, ${product_code}) ;;
    primary_key: yes
    hidden: yes
  }

  dimension_group: date {
    type: time
    datatype: date
    timeframes: [date,month]
    hidden: yes
    sql: date(${TABLE}.dims.date) ;;
  }

  dimension: product_code {
    type: number
    sql: ${TABLE}.dims.productCode;;
  }

  dimension: ty_grossSales_dim { type:number sql:${TABLE}.ty.grossSales;;hidden:yes}
  dimension: ty_netSales_dim { type:number sql:${TABLE}.ty.netSales;;hidden:yes}
  dimension: ty_prodMargin_dim { type:number sql:${TABLE}.ty.prodMargin;;hidden:yes}
  dimension: ty_funding_dim { type:number sql:${TABLE}.ty.funding;;hidden:yes}
  dimension: ty_grossMargin_dim { type:number sql:${TABLE}.ty.grossMargin;;hidden:yes}
  dimension: ty_units_dim { type:number sql:${TABLE}.ty.units;;hidden:yes}
  dimension: ty_orders_dim { type:number sql:${TABLE}.ty.orders;;hidden:yes}
  dimension: ty_newProductNetSales_dim { type:number sql:${TABLE}.ty.newProductNetSales;;hidden:yes}
  dimension: ty_newProductMargin_dim { type:number sql:${TABLE}.ty.newProductMargin;;hidden:yes}
  dimension: ty_tradeCreditNetSales_dim { type:number sql:${TABLE}.ty.tradeCreditNetSales;;hidden:yes}
  dimension: ty_tradeCreditMargin_dim { type:number sql:${TABLE}.ty.tradeCreditMargin;;hidden:yes}
  dimension: ty_newCustomerNetSales_dim { type:number sql:${TABLE}.ty.newCustomerNetSales;;hidden:yes}
  dimension: ty_newCustomerMargin_dim { type:number sql:${TABLE}.ty.newCustomerMargin;;hidden:yes}
  dimension: ty_promoNetSales_dim { type:number sql:${TABLE}.ty.promoNetSales;;hidden:yes}
  dimension: ty_promoGrossMargin_dim { type:number sql:${TABLE}.ty.promoGrossMargin;;hidden:yes}
  dimension: ty_isPromo_dim { type:number sql:${TABLE}.ty.isPromo;;hidden:yes}
  dimension: ty_lflNetSales_dim { type:number sql:${TABLE}.ty.lflNetSales;;hidden:yes}
  dimension: ty_lflMargin_dim { type:number sql:${TABLE}.ty.lflMargin;;hidden:yes}
  dimension: ty_lflUnits_dim { type:number sql:${TABLE}.ty.lflUnits;;hidden:yes}
  dimension: ty_BRANCHNetSales_dim { type:number sql:${TABLE}.ty.BRANCHNetSales;;hidden:yes}
  dimension: ty_WEBNetSales_dim { type:number sql:${TABLE}.ty.WEBNetSales;;hidden:yes}
  dimension: ty_CLICKNetSales_dim { type:number sql:${TABLE}.ty.CLICKNetSales;;hidden:yes}
  dimension: ty_EPOSAVNetSales_dim { type:number sql:${TABLE}.ty.EPOSAVNetSales;;hidden:yes}
  dimension: ty_EPOSERNetSales_dim { type:number sql:${TABLE}.ty.EPOSERNetSales;;hidden:yes}
  dimension: ty_CCNetSales_dim { type:number sql:${TABLE}.ty.CCNetSales;;hidden:yes}
  dimension: ty_EBAYNetSales_dim { type:number sql:${TABLE}.ty.EBAYNetSales;;hidden:yes}
  dimension: ty_DROPSHIPNetSales_dim { type:number sql:${TABLE}.ty.DROPSHIPNetSales;;hidden:yes}
  dimension: ty_BRANCHMargin_dim { type:number sql:${TABLE}.ty.BRANCHMargin;;hidden:yes}
  dimension: ty_WEBMargin_dim { type:number sql:${TABLE}.ty.WEBMargin;;hidden:yes}
  dimension: ty_CLICKMargin_dim { type:number sql:${TABLE}.ty.CLICKMargin;;hidden:yes}
  dimension: ty_EPOSAVMargin_dim { type:number sql:${TABLE}.ty.EPOSAVMargin;;hidden:yes}
  dimension: ty_EPOSERMargin_dim { type:number sql:${TABLE}.ty.EPOSERMargin;;hidden:yes}
  dimension: ty_CCMargin_dim { type:number sql:${TABLE}.ty.CCMargin;;hidden:yes}
  dimension: ty_EBAYMargin_dim { type:number sql:${TABLE}.ty.EBAYMargin;;hidden:yes}
  dimension: ty_DROPSHIPMargin_dim { type:number sql:${TABLE}.ty.DROPSHIPMargin;;hidden:yes}
  dimension: ty_netSalesBudget_dim { type:number sql:${TABLE}.ty.netSalesBudget;;hidden:yes}
  dimension: ty_marginBudget_dim { type:number sql:${TABLE}.ty.marginBudget;;hidden:yes}
  dimension: ty_netSalesRF_dim { type:number sql:${TABLE}.ty.netSalesRF;;hidden:yes}
  dimension: ty_marginRF_dim { type:number sql:${TABLE}.ty.marginRF;;hidden:yes}
  dimension: ty_TradeNetSales_dim { type:number sql:${TABLE}.ty.TradeNetSales;;hidden:yes}
  dimension: ty_TradeMargin_dim { type:number sql:${TABLE}.ty.TradeMargin;;hidden:yes}
  dimension: ty_TradeUnits_dim { type:number sql:${TABLE}.ty.TradeUnits;;hidden:yes}
  dimension: ty_TradeParticipation_dim { type:number sql:${TABLE}.ty.TradeParticipation;;hidden:yes}
  dimension: ty_DIYNetSales_dim { type:number sql:${TABLE}.ty.DIYNetSales;;hidden:yes}
  dimension: ty_DIYMargin_dim { type:number sql:${TABLE}.ty.DIYMargin;;hidden:yes}
  dimension: ty_DIYUnits_dim { type:number sql:${TABLE}.ty.DIYUnits;;hidden:yes}
  dimension: ty_DIYParticipation_dim { type:number sql:${TABLE}.ty.DIYParticipation;;hidden:yes}
  dimension: ty_OwnBrandSales_dim { type:number sql:${TABLE}.ty.OwnBrandSales;;hidden:yes}
  dimension: ty_OwnBrandMargin_dim { type:number sql:${TABLE}.ty.OwnBrandMargin;;hidden:yes}
  dimension: ty_OwnBrandUnits_dim { type:number sql:${TABLE}.ty.OwnBrandUnits;;hidden:yes}
  dimension: ty_OwnBrandTradeNetSales_dim { type:number sql:${TABLE}.ty.OwnBrandTradeNetSales;;hidden:yes}
  dimension: ty_OwnBrandTradeMargin_dim { type:number sql:${TABLE}.ty.OwnBrandTradeMargin;;hidden:yes}
  dimension: ty_OwnBrandTradeUnits_dim { type:number sql:${TABLE}.ty.OwnBrandTradeUnits;;hidden:yes}
  dimension: ty_OwnBrandTradeParticipation_dim { type:number sql:${TABLE}.ty.OwnBrandTradeParticipation;;hidden:yes}
  dimension: ty_OwnBrandDIYNetSales_dim { type:number sql:${TABLE}.ty.OwnBrandDIYNetSales;;hidden:yes}
  dimension: ty_OwnBrandDIYMargin_dim { type:number sql:${TABLE}.ty.OwnBrandDIYMargin;;hidden:yes}
  dimension: ty_OwnBrandDIYUnits_dim { type:number sql:${TABLE}.ty.OwnBrandDIYUnits;;hidden:yes}
  dimension: ty_OwnBrandDIYParticipation_dim { type:number sql:${TABLE}.ty.OwnBrandDIYParticipation;;hidden:yes}
  dimension: ly_grossSales_dim { type:number sql:${TABLE}.ly.grossSales;;hidden:yes}
  dimension: ly_netSales_dim { type:number sql:${TABLE}.ly.netSales;;hidden:yes}
  dimension: ly_prodMargin_dim { type:number sql:${TABLE}.ly.prodMargin;;hidden:yes}
  dimension: ly_funding_dim { type:number sql:${TABLE}.ly.funding;;hidden:yes}
  dimension: ly_grossMargin_dim { type:number sql:${TABLE}.ly.grossMargin;;hidden:yes}
  dimension: ly_units_dim { type:number sql:${TABLE}.ly.units;;hidden:yes}
  dimension: ly_orders_dim { type:number sql:${TABLE}.ly.orders;;hidden:yes}
  dimension: ly_newProductNetSales_dim { type:number sql:${TABLE}.ly.newProductNetSales;;hidden:yes}
  dimension: ly_newProductMargin_dim { type:number sql:${TABLE}.ly.newProductMargin;;hidden:yes}
  dimension: ly_tradeCreditNetSales_dim { type:number sql:${TABLE}.ly.tradeCreditNetSales;;hidden:yes}
  dimension: ly_tradeCreditMargin_dim { type:number sql:${TABLE}.ly.tradeCreditMargin;;hidden:yes}
  dimension: ly_newCustomerNetSales_dim { type:number sql:${TABLE}.ly.newCustomerNetSales;;hidden:yes}
  dimension: ly_newCustomerMargin_dim { type:number sql:${TABLE}.ly.newCustomerMargin;;hidden:yes}
  dimension: ly_promoNetSales_dim { type:number sql:${TABLE}.ly.promoNetSales;;hidden:yes}
  dimension: ly_promoGrossMargin_dim { type:number sql:${TABLE}.ly.promoGrossMargin;;hidden:yes}
  dimension: ly_isPromo_dim { type:number sql:${TABLE}.ly.isPromo;;hidden:yes}
  dimension: ly_lflNetSales_dim { type:number sql:${TABLE}.ly.lflNetSales;;hidden:yes}
  dimension: ly_lflMargin_dim { type:number sql:${TABLE}.ly.lflMargin;;hidden:yes}
  dimension: ly_BRANCHNetSales_dim { type:number sql:${TABLE}.ly.BRANCHNetSales;;hidden:yes}
  dimension: ly_WEBNetSales_dim { type:number sql:${TABLE}.ly.WEBNetSales;;hidden:yes}
  dimension: ly_CLICKNetSales_dim { type:number sql:${TABLE}.ly.CLICKNetSales;;hidden:yes}
  dimension: ly_EPOSAVNetSales_dim { type:number sql:${TABLE}.ly.EPOSAVNetSales;;hidden:yes}
  dimension: ly_EPOSERNetSales_dim { type:number sql:${TABLE}.ly.EPOSERNetSales;;hidden:yes}
  dimension: ly_CCNetSales_dim { type:number sql:${TABLE}.ly.CCNetSales;;hidden:yes}
  dimension: ly_EBAYNetSales_dim { type:number sql:${TABLE}.ly.EBAYNetSales;;hidden:yes}
  dimension: ly_DROPSHIPNetSales_dim { type:number sql:${TABLE}.ly.DROPSHIPNetSales;;hidden:yes}
  dimension: ly_BRANCHMargin_dim { type:number sql:${TABLE}.ly.BRANCHMargin;;hidden:yes}
  dimension: ly_WEBMargin_dim { type:number sql:${TABLE}.ly.WEBMargin;;hidden:yes}
  dimension: ly_CLICKMargin_dim { type:number sql:${TABLE}.ly.CLICKMargin;;hidden:yes}
  dimension: ly_EPOSAVMargin_dim { type:number sql:${TABLE}.ly.EPOSAVMargin;;hidden:yes}
  dimension: ly_EPOSERMargin_dim { type:number sql:${TABLE}.ly.EPOSERMargin;;hidden:yes}
  dimension: ly_CCMargin_dim { type:number sql:${TABLE}.ly.CCMargin;;hidden:yes}
  dimension: ly_EBAYMargin_dim { type:number sql:${TABLE}.ly.EBAYMargin;;hidden:yes}
  dimension: ly_DROPSHIPMargin_dim { type:number sql:${TABLE}.ly.DROPSHIPMargin;;hidden:yes}
  dimension: ly_TradeNetSales_dim { type:number sql:${TABLE}.ly.TradeNetSales;;hidden:yes}
  dimension: ly_TradeMargin_dim { type:number sql:${TABLE}.ly.TradeMargin;;hidden:yes}
  dimension: ly_TradeUnits_dim { type:number sql:${TABLE}.ly.TradeUnits;;hidden:yes}
  dimension: ly_TradeParticipation_dim { type:number sql:${TABLE}.ly.TradeParticipation;;hidden:yes}
  dimension: ly_DIYNetSales_dim { type:number sql:${TABLE}.ly.DIYNetSales;;hidden:yes}
  dimension: ly_DIYMargin_dim { type:number sql:${TABLE}.ly.DIYMargin;;hidden:yes}
  dimension: ly_DIYUnits_dim { type:number sql:${TABLE}.ly.DIYUnits;;hidden:yes}
  dimension: ly_DIYParticipation_dim { type:number sql:${TABLE}.ly.DIYParticipation;;hidden:yes}
  dimension: ly_OwnBrandSales_dim { type:number sql:${TABLE}.ly.OwnBrandSales;;hidden:yes}
  dimension: ly_OwnBrandMargin_dim { type:number sql:${TABLE}.ly.OwnBrandMargin;;hidden:yes}
  dimension: ly_OwnBrandUnits_dim { type:number sql:${TABLE}.ly.OwnBrandUnits;;hidden:yes}
  dimension: ly_OwnBrandTradeNetSales_dim { type:number sql:${TABLE}.ly.OwnBrandTradeNetSales;;hidden:yes}
  dimension: ly_OwnBrandTradeMargin_dim { type:number sql:${TABLE}.ly.OwnBrandTradeMargin;;hidden:yes}
  dimension: ly_OwnBrandTradeUnits_dim { type:number sql:${TABLE}.ly.OwnBrandTradeUnits;;hidden:yes}
  dimension: ly_OwnBrandTradeParticipation_dim { type:number sql:${TABLE}.ly.OwnBrandTradeParticipation;;hidden:yes}
  dimension: ly_OwnBrandDIYNetSales_dim { type:number sql:${TABLE}.ly.OwnBrandDIYNetSales;;hidden:yes}
  dimension: ly_OwnBrandDIYMargin_dim { type:number sql:${TABLE}.ly.OwnBrandDIYMargin;;hidden:yes}
  dimension: ly_OwnBrandDIYUnits_dim { type:number sql:${TABLE}.ly.OwnBrandDIYUnits;;hidden:yes}
  dimension: ly_OwnBrandDIYParticipation_dim { type:number sql:${TABLE}.ly.OwnBrandDIYParticipation;;hidden:yes}
  dimension: lly_grossSales_dim { type:number sql:${TABLE}.lly.grossSales;;hidden:yes}
  dimension: lly_netSales_dim { type:number sql:${TABLE}.lly.netSales;;hidden:yes}
  dimension: lly_prodMargin_dim { type:number sql:${TABLE}.lly.prodMargin;;hidden:yes}
  dimension: lly_funding_dim { type:number sql:${TABLE}.lly.funding;;hidden:yes}
  dimension: lly_grossMargin_dim { type:number sql:${TABLE}.lly.grossMargin;;hidden:yes}
  dimension: lly_units_dim { type:number sql:${TABLE}.lly.units;;hidden:yes}
  dimension: lly_newProductNetSales_dim { type:number sql:${TABLE}.lly.newProductNetSales;;hidden:yes}
  dimension: lly_newProductMargin_dim { type:number sql:${TABLE}.lly.newProductMargin;;hidden:yes}
  dimension: lly_tradeCreditNetSales_dim { type:number sql:${TABLE}.lly.tradeCreditNetSales;;hidden:yes}
  dimension: lly_tradeCreditMargin_dim { type:number sql:${TABLE}.lly.tradeCreditMargin;;hidden:yes}
  dimension: lly_newCustomerNetSales_dim { type:number sql:${TABLE}.lly.newCustomerNetSales;;hidden:yes}
  dimension: lly_newCustomerMargin_dim { type:number sql:${TABLE}.lly.newCustomerMargin;;hidden:yes}
  dimension: lly_lflNetSales_dim { type:number sql:${TABLE}.lly.lflNetSales;;hidden:yes}
  dimension: lly_lflMargin_dim { type:number sql:${TABLE}.lly.lflMargin;;hidden:yes}
  dimension: lly_TradeNetSales_dim { type:number sql:${TABLE}.lly.TradeNetSales;;hidden:yes}
  dimension: lly_TradeMargin_dim { type:number sql:${TABLE}.lly.TradeMargin;;hidden:yes}
  dimension: lly_TradeUnits_dim { type:number sql:${TABLE}.lly.TradeUnits;;hidden:yes}
  dimension: lly_TradeParticipation_dim { type:number sql:${TABLE}.lly.TradeParticipation;;hidden:yes}
  dimension: lly_DIYNetSales_dim { type:number sql:${TABLE}.lly.DIYNetSales;;hidden:yes}
  dimension: lly_DIYMargin_dim { type:number sql:${TABLE}.lly.DIYMargin;;hidden:yes}
  dimension: lly_DIYUnits_dim { type:number sql:${TABLE}.lly.DIYUnits;;hidden:yes}
  dimension: lly_DIYParticipation_dim { type:number sql:${TABLE}.lly.DIYParticipation;;hidden:yes}
  dimension: lly_OwnBrandSales_dim { type:number sql:${TABLE}.lly.OwnBrandSales;;hidden:yes}
  dimension: lly_OwnBrandMargin_dim { type:number sql:${TABLE}.lly.OwnBrandMargin;;hidden:yes}
  dimension: lly_OwnBrandUnits_dim { type:number sql:${TABLE}.lly.OwnBrandUnits;;hidden:yes}
  dimension: lly_OwnBrandTradeNetSales_dim { type:number sql:${TABLE}.lly.OwnBrandTradeNetSales;;hidden:yes}
  dimension: lly_OwnBrandTradeMargin_dim { type:number sql:${TABLE}.lly.OwnBrandTradeMargin;;hidden:yes}
  dimension: lly_OwnBrandTradeUnits_dim { type:number sql:${TABLE}.lly.OwnBrandTradeUnits;;hidden:yes}
  dimension: lly_OwnBrandTradeParticipation_dim { type:number sql:${TABLE}.lly.OwnBrandTradeParticipation;;hidden:yes}
  dimension: lly_OwnBrandDIYNetSales_dim { type:number sql:${TABLE}.lly.OwnBrandDIYNetSales;;hidden:yes}
  dimension: lly_OwnBrandDIYMargin_dim { type:number sql:${TABLE}.lly.OwnBrandDIYMargin;;hidden:yes}
  dimension: lly_OwnBrandDIYUnits_dim { type:number sql:${TABLE}.lly.OwnBrandDIYUnits;;hidden:yes}
  dimension: lly_OwnBrandDIYParticipation_dim { type:number sql:${TABLE}.lly.OwnBrandDIYParticipation;;hidden:yes}
  dimension: lw_grossSales_dim { type:number sql:${TABLE}.lw.grossSales;;hidden:yes}
  dimension: lw_netSales_dim { type:number sql:${TABLE}.lw.netSales;;hidden:yes}
  dimension: lw_prodMargin_dim { type:number sql:${TABLE}.lw.prodMargin;;hidden:yes}
  dimension: lw_funding_dim { type:number sql:${TABLE}.lw.funding;;hidden:yes}
  dimension: lw_grossMargin_dim { type:number sql:${TABLE}.lw.grossMargin;;hidden:yes}
  dimension: lw_units_dim { type:number sql:${TABLE}.lw.units;;hidden:yes}
  dimension: lw_newProductNetSales_dim { type:number sql:${TABLE}.lw.newProductNetSales;;hidden:yes}
  dimension: lw_newProductMargin_dim { type:number sql:${TABLE}.lw.newProductMargin;;hidden:yes}
  dimension: lw_tradeCreditNetSales_dim { type:number sql:${TABLE}.lw.tradeCreditNetSales;;hidden:yes}
  dimension: lw_tradeCreditMargin_dim { type:number sql:${TABLE}.lw.tradeCreditMargin;;hidden:yes}
  dimension: lw_newCustomerNetSales_dim { type:number sql:${TABLE}.lw.newCustomerNetSales;;hidden:yes}
  dimension: lw_newCustomerMargin_dim { type:number sql:${TABLE}.lw.newCustomerMargin;;hidden:yes}
  dimension: lw_lflNetSales_dim { type:number sql:${TABLE}.lw.lflNetSales;;hidden:yes}
  dimension: lw_lflMargin_dim { type:number sql:${TABLE}.lw.lflMargin;;hidden:yes}
  dimension: lw_TradeNetSales_dim { type:number sql:${TABLE}.lw.TradeNetSales;;hidden:yes}
  dimension: lw_TradeMargin_dim { type:number sql:${TABLE}.lw.TradeMargin;;hidden:yes}
  dimension: lw_TradeUnits_dim { type:number sql:${TABLE}.lw.TradeUnits;;hidden:yes}
  dimension: lw_TradeParticipation_dim { type:number sql:${TABLE}.lw.TradeParticipation;;hidden:yes}
  dimension: lw_DIYNetSales_dim { type:number sql:${TABLE}.lw.DIYNetSales;;hidden:yes}
  dimension: lw_DIYMargin_dim { type:number sql:${TABLE}.lw.DIYMargin;;hidden:yes}
  dimension: lw_DIYUnits_dim { type:number sql:${TABLE}.lw.DIYUnits;;hidden:yes}
  dimension: lw_DIYParticipation_dim { type:number sql:${TABLE}.lw.DIYParticipation;;hidden:yes}
  dimension: lw_OwnBrandSales_dim { type:number sql:${TABLE}.lw.OwnBrandSales;;hidden:yes}
  dimension: lw_OwnBrandMargin_dim { type:number sql:${TABLE}.lw.OwnBrandMargin;;hidden:yes}
  dimension: lw_OwnBrandUnits_dim { type:number sql:${TABLE}.lw.OwnBrandUnits;;hidden:yes}
  dimension: lw_OwnBrandTradeNetSales_dim { type:number sql:${TABLE}.lw.OwnBrandTradeNetSales;;hidden:yes}
  dimension: lw_OwnBrandTradeMargin_dim { type:number sql:${TABLE}.lw.OwnBrandTradeMargin;;hidden:yes}
  dimension: lw_OwnBrandTradeUnits_dim { type:number sql:${TABLE}.lw.OwnBrandTradeUnits;;hidden:yes}
  dimension: lw_OwnBrandTradeParticipation_dim { type:number sql:${TABLE}.lw.OwnBrandTradeParticipation;;hidden:yes}
  dimension: lw_OwnBrandDIYNetSales_dim { type:number sql:${TABLE}.lw.OwnBrandDIYNetSales;;hidden:yes}
  dimension: lw_OwnBrandDIYMargin_dim { type:number sql:${TABLE}.lw.OwnBrandDIYMargin;;hidden:yes}
  dimension: lw_OwnBrandDIYUnits_dim { type:number sql:${TABLE}.lw.OwnBrandDIYUnits;;hidden:yes}
  dimension: lw_OwnBrandDIYParticipation_dim { type:number sql:${TABLE}.lw.OwnBrandDIYParticipation;;hidden:yes}
  dimension: DepHead_DepartmentHead_dim { type:string sql:${TABLE}.DepHead.DepartmentHead;;hidden:no}
  dimension: DepHead_DepartmentHeadCode_dim { type:string sql:${TABLE}.DepHead.DepartmentHeadCode;;hidden:no}


  measure: ty_grossSales { type:sum sql:${ty_grossSales_dim};;}
  measure: ty_netSales { type:sum sql:${ty_netSales_dim};;}
  measure: ty_prodMargin { type:sum sql:${ty_prodMargin_dim};;}
  measure: ty_funding { type:sum sql:${ty_funding_dim};;}
  measure: ty_grossMargin { type:sum sql:${ty_grossMargin_dim};;}
  measure: ty_units { type:sum sql:${ty_units_dim};;}
  measure: ty_orders { type:sum sql:${ty_orders_dim};;}
  measure: ty_newProductNetSales { type:sum sql:${ty_newProductNetSales_dim};;}
  measure: ty_newProductMargin { type:sum sql:${ty_newProductMargin_dim};;}
  measure: ty_tradeCreditNetSales { type:sum sql:${ty_tradeCreditNetSales_dim};;}
  measure: ty_tradeCreditMargin { type:sum sql:${ty_tradeCreditMargin_dim};;}
  measure: ty_newCustomerNetSales { type:sum sql:${ty_newCustomerNetSales_dim};;}
  measure: ty_newCustomerMargin { type:sum sql:${ty_newCustomerMargin_dim};;}
  measure: ty_promoNetSales { type:sum sql:${ty_promoNetSales_dim};;}
  measure: ty_promoGrossMargin { type:sum sql:${ty_promoGrossMargin_dim};;}
  measure: ty_isPromo { type:sum sql:${ty_isPromo_dim};;}
  measure: ty_lflNetSales { type:sum sql:${ty_lflNetSales_dim};;}
  measure: ty_lflMargin { type:sum sql:${ty_lflMargin_dim};;}
  measure: ty_lflUnits { type:sum sql:${ty_lflUnits_dim};;}
  measure: ty_BRANCHNetSales { type:sum sql:${ty_BRANCHNetSales_dim};;}
  measure: ty_WEBNetSales { type:sum sql:${ty_WEBNetSales_dim};;}
  measure: ty_CLICKNetSales { type:sum sql:${ty_CLICKNetSales_dim};;}
  measure: ty_EPOSAVNetSales { type:sum sql:${ty_EPOSAVNetSales_dim};;}
  measure: ty_EPOSERNetSales { type:sum sql:${ty_EPOSERNetSales_dim};;}
  measure: ty_CCNetSales { type:sum sql:${ty_CCNetSales_dim};;}
  measure: ty_EBAYNetSales { type:sum sql:${ty_EBAYNetSales_dim};;}
  measure: ty_DROPSHIPNetSales { type:sum sql:${ty_DROPSHIPNetSales_dim};;}
  measure: ty_BRANCHMargin { type:sum sql:${ty_BRANCHMargin_dim};;}
  measure: ty_WEBMargin { type:sum sql:${ty_WEBMargin_dim};;}
  measure: ty_CLICKMargin { type:sum sql:${ty_CLICKMargin_dim};;}
  measure: ty_EPOSAVMargin { type:sum sql:${ty_EPOSAVMargin_dim};;}
  measure: ty_EPOSERMargin { type:sum sql:${ty_EPOSERMargin_dim};;}
  measure: ty_CCMargin { type:sum sql:${ty_CCMargin_dim};;}
  measure: ty_EBAYMargin { type:sum sql:${ty_EBAYMargin_dim};;}
  measure: ty_DROPSHIPMargin { type:sum sql:${ty_DROPSHIPMargin_dim};;}
  measure: ty_netSalesBudget { type:sum sql:${ty_netSalesBudget_dim};;}
  measure: ty_marginBudget { type:sum sql:${ty_marginBudget_dim};;}
  measure: ty_netSalesRF { type:sum sql:${ty_netSalesRF_dim};;}
  measure: ty_marginRF { type:sum sql:${ty_marginRF_dim};;}
  measure: ty_TradeNetSales { type:sum sql:${ty_TradeNetSales_dim};;}
  measure: ty_TradeMargin { type:sum sql:${ty_TradeMargin_dim};;}
  measure: ty_TradeUnits { type:sum sql:${ty_TradeUnits_dim};;}
  measure: ty_TradeParticipation { type:sum sql:${ty_TradeParticipation_dim};;}
  measure: ty_DIYNetSales { type:sum sql:${ty_DIYNetSales_dim};;}
  measure: ty_DIYMargin { type:sum sql:${ty_DIYMargin_dim};;}
  measure: ty_DIYUnits { type:sum sql:${ty_DIYUnits_dim};;}
  measure: ty_DIYParticipation { type:sum sql:${ty_DIYParticipation_dim};;}
  measure: ty_OwnBrandSales { type:sum sql:${ty_OwnBrandSales_dim};;}
  measure: ty_OwnBrandMargin { type:sum sql:${ty_OwnBrandMargin_dim};;}
  measure: ty_OwnBrandUnits { type:sum sql:${ty_OwnBrandUnits_dim};;}
  measure: ty_OwnBrandTradeNetSales { type:sum sql:${ty_OwnBrandTradeNetSales_dim};;}
  measure: ty_OwnBrandTradeMargin { type:sum sql:${ty_OwnBrandTradeMargin_dim};;}
  measure: ty_OwnBrandTradeUnits { type:sum sql:${ty_OwnBrandTradeUnits_dim};;}
  measure: ty_OwnBrandTradeParticipation { type:sum sql:${ty_OwnBrandTradeParticipation_dim};;}
  measure: ty_OwnBrandDIYNetSales { type:sum sql:${ty_OwnBrandDIYNetSales_dim};;}
  measure: ty_OwnBrandDIYMargin { type:sum sql:${ty_OwnBrandDIYMargin_dim};;}
  measure: ty_OwnBrandDIYUnits { type:sum sql:${ty_OwnBrandDIYUnits_dim};;}
  measure: ty_OwnBrandDIYParticipation { type:sum sql:${ty_OwnBrandDIYParticipation_dim};;}
  measure: ly_grossSales { type:sum sql:${ly_grossSales_dim};;}
  measure: ly_netSales { type:sum sql:${ly_netSales_dim};;}
  measure: ly_prodMargin { type:sum sql:${ly_prodMargin_dim};;}
  measure: ly_funding { type:sum sql:${ly_funding_dim};;}
  measure: ly_grossMargin { type:sum sql:${ly_grossMargin_dim};;}
  measure: ly_units { type:sum sql:${ly_units_dim};;}
  measure: ly_orders { type:sum sql:${ly_orders_dim};;}
  measure: ly_newProductNetSales { type:sum sql:${ly_newProductNetSales_dim};;}
  measure: ly_newProductMargin { type:sum sql:${ly_newProductMargin_dim};;}
  measure: ly_tradeCreditNetSales { type:sum sql:${ly_tradeCreditNetSales_dim};;}
  measure: ly_tradeCreditMargin { type:sum sql:${ly_tradeCreditMargin_dim};;}
  measure: ly_newCustomerNetSales { type:sum sql:${ly_newCustomerNetSales_dim};;}
  measure: ly_newCustomerMargin { type:sum sql:${ly_newCustomerMargin_dim};;}
  measure: ly_promoNetSales { type:sum sql:${ly_promoNetSales_dim};;}
  measure: ly_promoGrossMargin { type:sum sql:${ly_promoGrossMargin_dim};;}
  measure: ly_isPromo { type:sum sql:${ly_isPromo_dim};;}
  measure: ly_lflNetSales { type:sum sql:${ly_lflNetSales_dim};;}
  measure: ly_lflMargin { type:sum sql:${ly_lflMargin_dim};;}
  measure: ly_BRANCHNetSales { type:sum sql:${ly_BRANCHNetSales_dim};;}
  measure: ly_WEBNetSales { type:sum sql:${ly_WEBNetSales_dim};;}
  measure: ly_CLICKNetSales { type:sum sql:${ly_CLICKNetSales_dim};;}
  measure: ly_EPOSAVNetSales { type:sum sql:${ly_EPOSAVNetSales_dim};;}
  measure: ly_EPOSERNetSales { type:sum sql:${ly_EPOSERNetSales_dim};;}
  measure: ly_CCNetSales { type:sum sql:${ly_CCNetSales_dim};;}
  measure: ly_EBAYNetSales { type:sum sql:${ly_EBAYNetSales_dim};;}
  measure: ly_DROPSHIPNetSales { type:sum sql:${ly_DROPSHIPNetSales_dim};;}
  measure: ly_BRANCHMargin { type:sum sql:${ly_BRANCHMargin_dim};;}
  measure: ly_WEBMargin { type:sum sql:${ly_WEBMargin_dim};;}
  measure: ly_CLICKMargin { type:sum sql:${ly_CLICKMargin_dim};;}
  measure: ly_EPOSAVMargin { type:sum sql:${ly_EPOSAVMargin_dim};;}
  measure: ly_EPOSERMargin { type:sum sql:${ly_EPOSERMargin_dim};;}
  measure: ly_CCMargin { type:sum sql:${ly_CCMargin_dim};;}
  measure: ly_EBAYMargin { type:sum sql:${ly_EBAYMargin_dim};;}
  measure: ly_DROPSHIPMargin { type:sum sql:${ly_DROPSHIPMargin_dim};;}
  measure: ly_TradeNetSales { type:sum sql:${ly_TradeNetSales_dim};;}
  measure: ly_TradeMargin { type:sum sql:${ly_TradeMargin_dim};;}
  measure: ly_TradeUnits { type:sum sql:${ly_TradeUnits_dim};;}
  measure: ly_TradeParticipation { type:sum sql:${ly_TradeParticipation_dim};;}
  measure: ly_DIYNetSales { type:sum sql:${ly_DIYNetSales_dim};;}
  measure: ly_DIYMargin { type:sum sql:${ly_DIYMargin_dim};;}
  measure: ly_DIYUnits { type:sum sql:${ly_DIYUnits_dim};;}
  measure: ly_DIYParticipation { type:sum sql:${ly_DIYParticipation_dim};;}
  measure: ly_OwnBrandSales { type:sum sql:${ly_OwnBrandSales_dim};;}
  measure: ly_OwnBrandMargin { type:sum sql:${ly_OwnBrandMargin_dim};;}
  measure: ly_OwnBrandUnits { type:sum sql:${ly_OwnBrandUnits_dim};;}
  measure: ly_OwnBrandTradeNetSales { type:sum sql:${ly_OwnBrandTradeNetSales_dim};;}
  measure: ly_OwnBrandTradeMargin { type:sum sql:${ly_OwnBrandTradeMargin_dim};;}
  measure: ly_OwnBrandTradeUnits { type:sum sql:${ly_OwnBrandTradeUnits_dim};;}
  measure: ly_OwnBrandTradeParticipation { type:sum sql:${ly_OwnBrandTradeParticipation_dim};;}
  measure: ly_OwnBrandDIYNetSales { type:sum sql:${ly_OwnBrandDIYNetSales_dim};;}
  measure: ly_OwnBrandDIYMargin { type:sum sql:${ly_OwnBrandDIYMargin_dim};;}
  measure: ly_OwnBrandDIYUnits { type:sum sql:${ly_OwnBrandDIYUnits_dim};;}
  measure: ly_OwnBrandDIYParticipation { type:sum sql:${ly_OwnBrandDIYParticipation_dim};;}
  measure: lly_grossSales { type:sum sql:${lly_grossSales_dim};;}
  measure: lly_netSales { type:sum sql:${lly_netSales_dim};;}
  measure: lly_prodMargin { type:sum sql:${lly_prodMargin_dim};;}
  measure: lly_funding { type:sum sql:${lly_funding_dim};;}
  measure: lly_grossMargin { type:sum sql:${lly_grossMargin_dim};;}
  measure: lly_units { type:sum sql:${lly_units_dim};;}
  measure: lly_newProductNetSales { type:sum sql:${lly_newProductNetSales_dim};;}
  measure: lly_newProductMargin { type:sum sql:${lly_newProductMargin_dim};;}
  measure: lly_tradeCreditNetSales { type:sum sql:${lly_tradeCreditNetSales_dim};;}
  measure: lly_tradeCreditMargin { type:sum sql:${lly_tradeCreditMargin_dim};;}
  measure: lly_newCustomerNetSales { type:sum sql:${lly_newCustomerNetSales_dim};;}
  measure: lly_newCustomerMargin { type:sum sql:${lly_newCustomerMargin_dim};;}
  measure: lly_lflNetSales { type:sum sql:${lly_lflNetSales_dim};;}
  measure: lly_lflMargin { type:sum sql:${lly_lflMargin_dim};;}
  measure: lly_TradeNetSales { type:sum sql:${lly_TradeNetSales_dim};;}
  measure: lly_TradeMargin { type:sum sql:${lly_TradeMargin_dim};;}
  measure: lly_TradeUnits { type:sum sql:${lly_TradeUnits_dim};;}
  measure: lly_TradeParticipation { type:sum sql:${lly_TradeParticipation_dim};;}
  measure: lly_DIYNetSales { type:sum sql:${lly_DIYNetSales_dim};;}
  measure: lly_DIYMargin { type:sum sql:${lly_DIYMargin_dim};;}
  measure: lly_DIYUnits { type:sum sql:${lly_DIYUnits_dim};;}
  measure: lly_DIYParticipation { type:sum sql:${lly_DIYParticipation_dim};;}
  measure: lly_OwnBrandSales { type:sum sql:${lly_OwnBrandSales_dim};;}
  measure: lly_OwnBrandMargin { type:sum sql:${lly_OwnBrandMargin_dim};;}
  measure: lly_OwnBrandUnits { type:sum sql:${lly_OwnBrandUnits_dim};;}
  measure: lly_OwnBrandTradeNetSales { type:sum sql:${lly_OwnBrandTradeNetSales_dim};;}
  measure: lly_OwnBrandTradeMargin { type:sum sql:${lly_OwnBrandTradeMargin_dim};;}
  measure: lly_OwnBrandTradeUnits { type:sum sql:${lly_OwnBrandTradeUnits_dim};;}
  measure: lly_OwnBrandTradeParticipation { type:sum sql:${lly_OwnBrandTradeParticipation_dim};;}
  measure: lly_OwnBrandDIYNetSales { type:sum sql:${lly_OwnBrandDIYNetSales_dim};;}
  measure: lly_OwnBrandDIYMargin { type:sum sql:${lly_OwnBrandDIYMargin_dim};;}
  measure: lly_OwnBrandDIYUnits { type:sum sql:${lly_OwnBrandDIYUnits_dim};;}
  measure: lly_OwnBrandDIYParticipation { type:sum sql:${lly_OwnBrandDIYParticipation_dim};;}
  measure: lw_grossSales { type:sum sql:${lw_grossSales_dim};;}
  measure: lw_netSales { type:sum sql:${lw_netSales_dim};;}
  measure: lw_prodMargin { type:sum sql:${lw_prodMargin_dim};;}
  measure: lw_funding { type:sum sql:${lw_funding_dim};;}
  measure: lw_grossMargin { type:sum sql:${lw_grossMargin_dim};;}
  measure: lw_units { type:sum sql:${lw_units_dim};;}
  measure: lw_newProductNetSales { type:sum sql:${lw_newProductNetSales_dim};;}
  measure: lw_newProductMargin { type:sum sql:${lw_newProductMargin_dim};;}
  measure: lw_tradeCreditNetSales { type:sum sql:${lw_tradeCreditNetSales_dim};;}
  measure: lw_tradeCreditMargin { type:sum sql:${lw_tradeCreditMargin_dim};;}
  measure: lw_newCustomerNetSales { type:sum sql:${lw_newCustomerNetSales_dim};;}
  measure: lw_newCustomerMargin { type:sum sql:${lw_newCustomerMargin_dim};;}
  measure: lw_lflNetSales { type:sum sql:${lw_lflNetSales_dim};;}
  measure: lw_lflMargin { type:sum sql:${lw_lflMargin_dim};;}
  measure: lw_TradeNetSales { type:sum sql:${lw_TradeNetSales_dim};;}
  measure: lw_TradeMargin { type:sum sql:${lw_TradeMargin_dim};;}
  measure: lw_TradeUnits { type:sum sql:${lw_TradeUnits_dim};;}
  measure: lw_TradeParticipation { type:sum sql:${lw_TradeParticipation_dim};;}
  measure: lw_DIYNetSales { type:sum sql:${lw_DIYNetSales_dim};;}
  measure: lw_DIYMargin { type:sum sql:${lw_DIYMargin_dim};;}
  measure: lw_DIYUnits { type:sum sql:${lw_DIYUnits_dim};;}
  measure: lw_DIYParticipation { type:sum sql:${lw_DIYParticipation_dim};;}
  measure: lw_OwnBrandSales { type:sum sql:${lw_OwnBrandSales_dim};;}
  measure: lw_OwnBrandMargin { type:sum sql:${lw_OwnBrandMargin_dim};;}
  measure: lw_OwnBrandUnits { type:sum sql:${lw_OwnBrandUnits_dim};;}
  measure: lw_OwnBrandTradeNetSales { type:sum sql:${lw_OwnBrandTradeNetSales_dim};;}
  measure: lw_OwnBrandTradeMargin { type:sum sql:${lw_OwnBrandTradeMargin_dim};;}
  measure: lw_OwnBrandTradeUnits { type:sum sql:${lw_OwnBrandTradeUnits_dim};;}
  measure: lw_OwnBrandTradeParticipation { type:sum sql:${lw_OwnBrandTradeParticipation_dim};;}
  measure: lw_OwnBrandDIYNetSales { type:sum sql:${lw_OwnBrandDIYNetSales_dim};;}
  measure: lw_OwnBrandDIYMargin { type:sum sql:${lw_OwnBrandDIYMargin_dim};;}
  measure: lw_OwnBrandDIYUnits { type:sum sql:${lw_OwnBrandDIYUnits_dim};;}
  measure: lw_OwnBrandDIYParticipation { type:sum sql:${lw_OwnBrandDIYParticipation_dim};;}
  measure: DepHead_DepartmentHead { type:sum sql:${DepHead_DepartmentHead_dim};;}
  measure: DepHead_DepartmentHeadCode { type:sum sql:${DepHead_DepartmentHeadCode_dim};;}

  # ------------------------------------
  # measure: net_sales_YOY { type:number sql:${ty_netSales}-${ly_netSales};;}


}
