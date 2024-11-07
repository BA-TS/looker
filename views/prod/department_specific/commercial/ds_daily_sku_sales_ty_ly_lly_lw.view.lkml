view: ds_daily_sku_sales_ty_ly_lly_lw {
  derived_table: {
    sql:
      SELECT distinct row_number() over () as P_K,
      *
      FROM `toolstation-data-storage.financeReporting.DS_DAILY_SKU_SALES_TY_LY_LLY_LW` ;;
  }

  dimension: P_K {
    description: "Primary Key"
    type: string
    sql: ${TABLE}.P_K ;;
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

  dimension: clusterProductDepartment { type:string sql:${TABLE}.clusterProductDepartment;;hidden:no}
  dimension: clusterProductSubDepartment { type:string sql:${TABLE}.clusterProductSubDepartment;;hidden:no}
  dimension: clusterProductChannel { type:string sql:${TABLE}.clusterProductChannel;;hidden:no}
  dimension: DepartmentHead { type:string sql:${TABLE}.DepartmentHead;;hidden:no}
  dimension: clusterDepartmentHead { type:string sql:${TABLE}.clusterDepartmentHead;;hidden:no}
  dimension: date { type:string sql:${TABLE}.date;;hidden:yes}
  dimension: supplier { type:string sql:${TABLE}.supplier;;hidden:no}
  dimension: extranetSupplier { type:string sql:${TABLE}.extranetSupplier;;hidden:no}
  dimension: supplierPartNumber { type:string sql:${TABLE}.supplierPartNumber;;hidden:no}
  dimension: newProduct { type:string sql:${TABLE}.newProduct;;hidden:no}
  dimension: ty_grossSales { type:string sql:${TABLE}.ty.grossSales;;hidden:no}
  dimension: ty_netSales { type:string sql:${TABLE}.ty.netSales;;hidden:no}
  dimension: ty_prodMargin { type:string sql:${TABLE}.ty.prodMargin;;hidden:no}
  dimension: ty_funding { type:string sql:${TABLE}.ty.funding;;hidden:no}
  dimension: ty_grossMargin { type:string sql:${TABLE}.ty.grossMargin;;hidden:no}
  dimension: ty_units { type:string sql:${TABLE}.ty.units;;hidden:no}
  dimension: ty_orders { type:string sql:${TABLE}.ty.orders;;hidden:no}
  dimension: ty_newProductNetSales { type:string sql:${TABLE}.ty.newProductNetSales;;hidden:no}
  dimension: ty_newProductMargin { type:string sql:${TABLE}.ty.newProductMargin;;hidden:no}
  dimension: ty_tradeCreditNetSales { type:string sql:${TABLE}.ty.tradeCreditNetSales;;hidden:no}
  dimension: ty_tradeCreditMargin { type:string sql:${TABLE}.ty.tradeCreditMargin;;hidden:no}
  dimension: ty_newCustomerNetSales { type:string sql:${TABLE}.ty.newCustomerNetSales;;hidden:no}
  dimension: ty_newCustomerMargin { type:string sql:${TABLE}.ty.newCustomerMargin;;hidden:no}
  dimension: ty_promoNetSales { type:string sql:${TABLE}.ty.promoNetSales;;hidden:no}
  dimension: ty_promoGrossMargin { type:string sql:${TABLE}.ty.promoGrossMargin;;hidden:no}
  dimension: ty_isPromo { type:string sql:${TABLE}.ty.isPromo;;hidden:no}
  dimension: ty_lflNetSales { type:string sql:${TABLE}.ty.lflNetSales;;hidden:no}
  dimension: ty_lflMargin { type:string sql:${TABLE}.ty.lflMargin;;hidden:no}
  dimension: ty_lflUnits { type:string sql:${TABLE}.ty.lflUnits;;hidden:no}
  dimension: ty_BRANCHNetSales { type:string sql:${TABLE}.ty.BRANCHNetSales;;hidden:no}
  dimension: ty_WEBNetSales { type:string sql:${TABLE}.ty.WEBNetSales;;hidden:no}
  dimension: ty_CLICKNetSales { type:string sql:${TABLE}.ty.CLICKNetSales;;hidden:no}
  dimension: ty_EPOSAVNetSales { type:string sql:${TABLE}.ty.EPOSAVNetSales;;hidden:no}
  dimension: ty_EPOSERNetSales { type:string sql:${TABLE}.ty.EPOSERNetSales;;hidden:no}
  dimension: ty_CCNetSales { type:string sql:${TABLE}.ty.CCNetSales;;hidden:no}
  dimension: ty_EBAYNetSales { type:string sql:${TABLE}.ty.EBAYNetSales;;hidden:no}
  dimension: ty_DROPSHIPNetSales { type:string sql:${TABLE}.ty.DROPSHIPNetSales;;hidden:no}
  dimension: ty_BRANCHMargin { type:string sql:${TABLE}.ty.BRANCHMargin;;hidden:no}
  dimension: ty_WEBMargin { type:string sql:${TABLE}.ty.WEBMargin;;hidden:no}
  dimension: ty_CLICKMargin { type:string sql:${TABLE}.ty.CLICKMargin;;hidden:no}
  dimension: ty_EPOSAVMargin { type:string sql:${TABLE}.ty.EPOSAVMargin;;hidden:no}
  dimension: ty_EPOSERMargin { type:string sql:${TABLE}.ty.EPOSERMargin;;hidden:no}
  dimension: ty_CCMargin { type:string sql:${TABLE}.ty.CCMargin;;hidden:no}
  dimension: ty_EBAYMargin { type:string sql:${TABLE}.ty.EBAYMargin;;hidden:no}
  dimension: ty_DROPSHIPMargin { type:string sql:${TABLE}.ty.DROPSHIPMargin;;hidden:no}
  dimension: ty_netSalesBudget { type:string sql:${TABLE}.ty.netSalesBudget;;hidden:no}
  dimension: ty_marginBudget { type:string sql:${TABLE}.ty.marginBudget;;hidden:no}
  dimension: ty_netSalesRF { type:string sql:${TABLE}.ty.netSalesRF;;hidden:no}
  dimension: ty_marginRF { type:string sql:${TABLE}.ty.marginRF;;hidden:no}
  dimension: ty_TradeNetSales { type:string sql:${TABLE}.ty.TradeNetSales;;hidden:no}
  dimension: ty_TradeMargin { type:string sql:${TABLE}.ty.TradeMargin;;hidden:no}
  dimension: ty_TradeUnits { type:string sql:${TABLE}.ty.TradeUnits;;hidden:no}
  dimension: ty_TradeParticipation { type:string sql:${TABLE}.ty.TradeParticipation;;hidden:no}
  dimension: ty_DIYNetSales { type:string sql:${TABLE}.ty.DIYNetSales;;hidden:no}
  dimension: ty_DIYMargin { type:string sql:${TABLE}.ty.DIYMargin;;hidden:no}
  dimension: ty_DIYUnits { type:string sql:${TABLE}.ty.DIYUnits;;hidden:no}
  dimension: ty_DIYParticipation { type:string sql:${TABLE}.ty.DIYParticipation;;hidden:no}
  dimension: ty_OwnBrandSales { type:string sql:${TABLE}.ty.OwnBrandSales;;hidden:no}
  dimension: ty_OwnBrandMargin { type:string sql:${TABLE}.ty.OwnBrandMargin;;hidden:no}
  dimension: ty_OwnBrandUnits { type:string sql:${TABLE}.ty.OwnBrandUnits;;hidden:no}
  dimension: ty_OwnBrandTradeNetSales { type:string sql:${TABLE}.ty.OwnBrandTradeNetSales;;hidden:no}
  dimension: ty_OwnBrandTradeMargin { type:string sql:${TABLE}.ty.OwnBrandTradeMargin;;hidden:no}
  dimension: ty_OwnBrandTradeUnits { type:string sql:${TABLE}.ty.OwnBrandTradeUnits;;hidden:no}
  dimension: ty_OwnBrandTradeParticipation { type:string sql:${TABLE}.ty.OwnBrandTradeParticipation;;hidden:no}
  dimension: ty_OwnBrandDIYNetSales { type:string sql:${TABLE}.ty.OwnBrandDIYNetSales;;hidden:no}
  dimension: ty_OwnBrandDIYMargin { type:string sql:${TABLE}.ty.OwnBrandDIYMargin;;hidden:no}
  dimension: ty_OwnBrandDIYUnits { type:string sql:${TABLE}.ty.OwnBrandDIYUnits;;hidden:no}
  dimension: ty_OwnBrandDIYParticipation { type:string sql:${TABLE}.ty.OwnBrandDIYParticipation;;hidden:no}
  dimension: ly_grossSales { type:string sql:${TABLE}.ly.grossSales;;hidden:no}
  dimension: ly_netSales { type:string sql:${TABLE}.ly.netSales;;hidden:no}
  dimension: ly_prodMargin { type:string sql:${TABLE}.ly.prodMargin;;hidden:no}
  dimension: ly_funding { type:string sql:${TABLE}.ly.funding;;hidden:no}
  dimension: ly_grossMargin { type:string sql:${TABLE}.ly.grossMargin;;hidden:no}
  dimension: ly_units { type:string sql:${TABLE}.ly.units;;hidden:no}
  dimension: ly_orders { type:string sql:${TABLE}.ly.orders;;hidden:no}
  dimension: ly_newProductNetSales { type:string sql:${TABLE}.ly.newProductNetSales;;hidden:no}
  dimension: ly_newProductMargin { type:string sql:${TABLE}.ly.newProductMargin;;hidden:no}
  dimension: ly_tradeCreditNetSales { type:string sql:${TABLE}.ly.tradeCreditNetSales;;hidden:no}
  dimension: ly_tradeCreditMargin { type:string sql:${TABLE}.ly.tradeCreditMargin;;hidden:no}
  dimension: ly_newCustomerNetSales { type:string sql:${TABLE}.ly.newCustomerNetSales;;hidden:no}
  dimension: ly_newCustomerMargin { type:string sql:${TABLE}.ly.newCustomerMargin;;hidden:no}
  dimension: ly_promoNetSales { type:string sql:${TABLE}.ly.promoNetSales;;hidden:no}
  dimension: ly_promoGrossMargin { type:string sql:${TABLE}.ly.promoGrossMargin;;hidden:no}
  dimension: ly_isPromo { type:string sql:${TABLE}.ly.isPromo;;hidden:no}
  dimension: ly_lflNetSales { type:string sql:${TABLE}.ly.lflNetSales;;hidden:no}
  dimension: ly_lflMargin { type:string sql:${TABLE}.ly.lflMargin;;hidden:no}
  dimension: ly_BRANCHNetSales { type:string sql:${TABLE}.ly.BRANCHNetSales;;hidden:no}
  dimension: ly_WEBNetSales { type:string sql:${TABLE}.ly.WEBNetSales;;hidden:no}
  dimension: ly_CLICKNetSales { type:string sql:${TABLE}.ly.CLICKNetSales;;hidden:no}
  dimension: ly_EPOSAVNetSales { type:string sql:${TABLE}.ly.EPOSAVNetSales;;hidden:no}
  dimension: ly_EPOSERNetSales { type:string sql:${TABLE}.ly.EPOSERNetSales;;hidden:no}
  dimension: ly_CCNetSales { type:string sql:${TABLE}.ly.CCNetSales;;hidden:no}
  dimension: ly_EBAYNetSales { type:string sql:${TABLE}.ly.EBAYNetSales;;hidden:no}
  dimension: ly_DROPSHIPNetSales { type:string sql:${TABLE}.ly.DROPSHIPNetSales;;hidden:no}
  dimension: ly_BRANCHMargin { type:string sql:${TABLE}.ly.BRANCHMargin;;hidden:no}
  dimension: ly_WEBMargin { type:string sql:${TABLE}.ly.WEBMargin;;hidden:no}
  dimension: ly_CLICKMargin { type:string sql:${TABLE}.ly.CLICKMargin;;hidden:no}
  dimension: ly_EPOSAVMargin { type:string sql:${TABLE}.ly.EPOSAVMargin;;hidden:no}
  dimension: ly_EPOSERMargin { type:string sql:${TABLE}.ly.EPOSERMargin;;hidden:no}
  dimension: ly_CCMargin { type:string sql:${TABLE}.ly.CCMargin;;hidden:no}
  dimension: ly_EBAYMargin { type:string sql:${TABLE}.ly.EBAYMargin;;hidden:no}
  dimension: ly_DROPSHIPMargin { type:string sql:${TABLE}.ly.DROPSHIPMargin;;hidden:no}
  dimension: ly_TradeNetSales { type:string sql:${TABLE}.ly.TradeNetSales;;hidden:no}
  dimension: ly_TradeMargin { type:string sql:${TABLE}.ly.TradeMargin;;hidden:no}
  dimension: ly_TradeUnits { type:string sql:${TABLE}.ly.TradeUnits;;hidden:no}
  dimension: ly_TradeParticipation { type:string sql:${TABLE}.ly.TradeParticipation;;hidden:no}
  dimension: ly_DIYNetSales { type:string sql:${TABLE}.ly.DIYNetSales;;hidden:no}
  dimension: ly_DIYMargin { type:string sql:${TABLE}.ly.DIYMargin;;hidden:no}
  dimension: ly_DIYUnits { type:string sql:${TABLE}.ly.DIYUnits;;hidden:no}
  dimension: ly_DIYParticipation { type:string sql:${TABLE}.ly.DIYParticipation;;hidden:no}
  dimension: ly_OwnBrandSales { type:string sql:${TABLE}.ly.OwnBrandSales;;hidden:no}
  dimension: ly_OwnBrandMargin { type:string sql:${TABLE}.ly.OwnBrandMargin;;hidden:no}
  dimension: ly_OwnBrandUnits { type:string sql:${TABLE}.ly.OwnBrandUnits;;hidden:no}
  dimension: ly_OwnBrandTradeNetSales { type:string sql:${TABLE}.ly.OwnBrandTradeNetSales;;hidden:no}
  dimension: ly_OwnBrandTradeMargin { type:string sql:${TABLE}.ly.OwnBrandTradeMargin;;hidden:no}
  dimension: ly_OwnBrandTradeUnits { type:string sql:${TABLE}.ly.OwnBrandTradeUnits;;hidden:no}
  dimension: ly_OwnBrandTradeParticipation { type:string sql:${TABLE}.ly.OwnBrandTradeParticipation;;hidden:no}
  dimension: ly_OwnBrandDIYNetSales { type:string sql:${TABLE}.ly.OwnBrandDIYNetSales;;hidden:no}
  dimension: ly_OwnBrandDIYMargin { type:string sql:${TABLE}.ly.OwnBrandDIYMargin;;hidden:no}
  dimension: ly_OwnBrandDIYUnits { type:string sql:${TABLE}.ly.OwnBrandDIYUnits;;hidden:no}
  dimension: ly_OwnBrandDIYParticipation { type:string sql:${TABLE}.ly.OwnBrandDIYParticipation;;hidden:no}
  dimension: lly_grossSales { type:string sql:${TABLE}.lly.grossSales;;hidden:no}
  dimension: lly_netSales { type:string sql:${TABLE}.lly.netSales;;hidden:no}
  dimension: lly_prodMargin { type:string sql:${TABLE}.lly.prodMargin;;hidden:no}
  dimension: lly_funding { type:string sql:${TABLE}.lly.funding;;hidden:no}
  dimension: lly_grossMargin { type:string sql:${TABLE}.lly.grossMargin;;hidden:no}
  dimension: lly_units { type:string sql:${TABLE}.lly.units;;hidden:no}
  dimension: lly_newProductNetSales { type:string sql:${TABLE}.lly.newProductNetSales;;hidden:no}
  dimension: lly_newProductMargin { type:string sql:${TABLE}.lly.newProductMargin;;hidden:no}
  dimension: lly_tradeCreditNetSales { type:string sql:${TABLE}.lly.tradeCreditNetSales;;hidden:no}
  dimension: lly_tradeCreditMargin { type:string sql:${TABLE}.lly.tradeCreditMargin;;hidden:no}
  dimension: lly_newCustomerNetSales { type:string sql:${TABLE}.lly.newCustomerNetSales;;hidden:no}
  dimension: lly_newCustomerMargin { type:string sql:${TABLE}.lly.newCustomerMargin;;hidden:no}
  dimension: lly_lflNetSales { type:string sql:${TABLE}.lly.lflNetSales;;hidden:no}
  dimension: lly_lflMargin { type:string sql:${TABLE}.lly.lflMargin;;hidden:no}
  dimension: lly_TradeNetSales { type:string sql:${TABLE}.lly.TradeNetSales;;hidden:no}
  dimension: lly_TradeMargin { type:string sql:${TABLE}.lly.TradeMargin;;hidden:no}
  dimension: lly_TradeUnits { type:string sql:${TABLE}.lly.TradeUnits;;hidden:no}
  dimension: lly_TradeParticipation { type:string sql:${TABLE}.lly.TradeParticipation;;hidden:no}
  dimension: lly_DIYNetSales { type:string sql:${TABLE}.lly.DIYNetSales;;hidden:no}
  dimension: lly_DIYMargin { type:string sql:${TABLE}.lly.DIYMargin;;hidden:no}
  dimension: lly_DIYUnits { type:string sql:${TABLE}.lly.DIYUnits;;hidden:no}
  dimension: lly_DIYParticipation { type:string sql:${TABLE}.lly.DIYParticipation;;hidden:no}
  dimension: lly_OwnBrandSales { type:string sql:${TABLE}.lly.OwnBrandSales;;hidden:no}
  dimension: lly_OwnBrandMargin { type:string sql:${TABLE}.lly.OwnBrandMargin;;hidden:no}
  dimension: lly_OwnBrandUnits { type:string sql:${TABLE}.lly.OwnBrandUnits;;hidden:no}
  dimension: lly_OwnBrandTradeNetSales { type:string sql:${TABLE}.lly.OwnBrandTradeNetSales;;hidden:no}
  dimension: lly_OwnBrandTradeMargin { type:string sql:${TABLE}.lly.OwnBrandTradeMargin;;hidden:no}
  dimension: lly_OwnBrandTradeUnits { type:string sql:${TABLE}.lly.OwnBrandTradeUnits;;hidden:no}
  dimension: lly_OwnBrandTradeParticipation { type:string sql:${TABLE}.lly.OwnBrandTradeParticipation;;hidden:no}
  dimension: lly_OwnBrandDIYNetSales { type:string sql:${TABLE}.lly.OwnBrandDIYNetSales;;hidden:no}
  dimension: lly_OwnBrandDIYMargin { type:string sql:${TABLE}.lly.OwnBrandDIYMargin;;hidden:no}
  dimension: lly_OwnBrandDIYUnits { type:string sql:${TABLE}.lly.OwnBrandDIYUnits;;hidden:no}
  dimension: lly_OwnBrandDIYParticipation { type:string sql:${TABLE}.lly.OwnBrandDIYParticipation;;hidden:no}
  dimension: lw_grossSales { type:string sql:${TABLE}.lw.grossSales;;hidden:no}
  dimension: lw_netSales { type:string sql:${TABLE}.lw.netSales;;hidden:no}
  dimension: lw_prodMargin { type:string sql:${TABLE}.lw.prodMargin;;hidden:no}
  dimension: lw_funding { type:string sql:${TABLE}.lw.funding;;hidden:no}
  dimension: lw_grossMargin { type:string sql:${TABLE}.lw.grossMargin;;hidden:no}
  dimension: lw_units { type:string sql:${TABLE}.lw.units;;hidden:no}
  dimension: lw_newProductNetSales { type:string sql:${TABLE}.lw.newProductNetSales;;hidden:no}
  dimension: lw_newProductMargin { type:string sql:${TABLE}.lw.newProductMargin;;hidden:no}
  dimension: lw_tradeCreditNetSales { type:string sql:${TABLE}.lw.tradeCreditNetSales;;hidden:no}
  dimension: lw_tradeCreditMargin { type:string sql:${TABLE}.lw.tradeCreditMargin;;hidden:no}
  dimension: lw_newCustomerNetSales { type:string sql:${TABLE}.lw.newCustomerNetSales;;hidden:no}
  dimension: lw_newCustomerMargin { type:string sql:${TABLE}.lw.newCustomerMargin;;hidden:no}
  dimension: lw_lflNetSales { type:string sql:${TABLE}.lw.lflNetSales;;hidden:no}
  dimension: lw_lflMargin { type:string sql:${TABLE}.lw.lflMargin;;hidden:no}
  dimension: lw_TradeNetSales { type:string sql:${TABLE}.lw.TradeNetSales;;hidden:no}
  dimension: lw_TradeMargin { type:string sql:${TABLE}.lw.TradeMargin;;hidden:no}
  dimension: lw_TradeUnits { type:string sql:${TABLE}.lw.TradeUnits;;hidden:no}
  dimension: lw_TradeParticipation { type:string sql:${TABLE}.lw.TradeParticipation;;hidden:no}
  dimension: lw_DIYNetSales { type:string sql:${TABLE}.lw.DIYNetSales;;hidden:no}
  dimension: lw_DIYMargin { type:string sql:${TABLE}.lw.DIYMargin;;hidden:no}
  dimension: lw_DIYUnits { type:string sql:${TABLE}.lw.DIYUnits;;hidden:no}
  dimension: lw_DIYParticipation { type:string sql:${TABLE}.lw.DIYParticipation;;hidden:no}
  dimension: lw_OwnBrandSales { type:string sql:${TABLE}.lw.OwnBrandSales;;hidden:no}
  dimension: lw_OwnBrandMargin { type:string sql:${TABLE}.lw.OwnBrandMargin;;hidden:no}
  dimension: lw_OwnBrandUnits { type:string sql:${TABLE}.lw.OwnBrandUnits;;hidden:no}
  dimension: lw_OwnBrandTradeNetSales { type:string sql:${TABLE}.lw.OwnBrandTradeNetSales;;hidden:no}
  dimension: lw_OwnBrandTradeMargin { type:string sql:${TABLE}.lw.OwnBrandTradeMargin;;hidden:no}
  dimension: lw_OwnBrandTradeUnits { type:string sql:${TABLE}.lw.OwnBrandTradeUnits;;hidden:no}
  dimension: lw_OwnBrandTradeParticipation { type:string sql:${TABLE}.lw.OwnBrandTradeParticipation;;hidden:no}
  dimension: lw_OwnBrandDIYNetSales { type:string sql:${TABLE}.lw.OwnBrandDIYNetSales;;hidden:no}
  dimension: lw_OwnBrandDIYMargin { type:string sql:${TABLE}.lw.OwnBrandDIYMargin;;hidden:no}
  dimension: lw_OwnBrandDIYUnits { type:string sql:${TABLE}.lw.OwnBrandDIYUnits;;hidden:no}
  dimension: lw_OwnBrandDIYParticipation { type:string sql:${TABLE}.lw.OwnBrandDIYParticipation;;hidden:no}
  dimension: DepHead_DepartmentHead { type:string sql:${TABLE}.DepHead.DepartmentHead;;hidden:no}
  dimension: DepHead_DepartmentHeadCode { type:string sql:${TABLE}.DepHead.DepartmentHeadCode;;hidden:no}
}
