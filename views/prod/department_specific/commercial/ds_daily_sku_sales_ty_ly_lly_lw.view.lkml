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
    hidden: yes
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
  dimension: DepHead_DepartmentHead_dim { type:string sql:${TABLE}.DepHead.DepartmentHead;;hidden:yes}
  dimension: DepHead_DepartmentHeadCode_dim { type:string sql:${TABLE}.DepHead.DepartmentHeadCode;;hidden:yes}

  measure: ty_grossSales {group_label:"TY" type: sum sql:${ty_grossSales_dim};;value_format_name: decimal_1}
  measure: ty_netSales {group_label:"TY" type: sum sql:${ty_netSales_dim};;value_format_name: decimal_1}
  measure: ty_prodMargin {group_label:"TY" type: sum sql:${ty_prodMargin_dim};;value_format_name: decimal_1}
  measure: ty_funding {group_label:"TY" type: sum sql:${ty_funding_dim};;value_format_name: decimal_1}
  measure: ty_grossMargin {group_label:"TY" type: sum sql:${ty_grossMargin_dim};;value_format_name: decimal_1}
  measure: ty_units {group_label:"TY" type: sum sql:${ty_units_dim};;value_format_name: decimal_1}
  measure: ty_orders {group_label:"TY" type: sum sql:${ty_orders_dim};;value_format_name: decimal_1}
  measure: ty_newProductNetSales {group_label:"TY" type: sum sql:${ty_newProductNetSales_dim};;value_format_name: decimal_1}
  measure: ty_newProductMargin {group_label:"TY" type: sum sql:${ty_newProductMargin_dim};;value_format_name: decimal_1}
  measure: ty_tradeCreditNetSales {group_label:"TY" type: sum sql:${ty_tradeCreditNetSales_dim};;value_format_name: decimal_1}
  measure: ty_tradeCreditMargin {group_label:"TY" type: sum sql:${ty_tradeCreditMargin_dim};;value_format_name: decimal_1}
  measure: ty_newCustomerNetSales {group_label:"TY" type: sum sql:${ty_newCustomerNetSales_dim};;value_format_name: decimal_1}
  measure: ty_newCustomerMargin {group_label:"TY" type: sum sql:${ty_newCustomerMargin_dim};;value_format_name: decimal_1}
  measure: ty_promoNetSales {group_label:"TY" type: sum sql:${ty_promoNetSales_dim};;value_format_name: decimal_1}
  measure: ty_promoGrossMargin {group_label:"TY" type: sum sql:${ty_promoGrossMargin_dim};;value_format_name: decimal_1}
  measure: ty_isPromo {group_label:"TY" type: sum sql:${ty_isPromo_dim};;value_format_name: decimal_1}
  measure: ty_lflNetSales {group_label:"TY" type: sum sql:${ty_lflNetSales_dim};;value_format_name: decimal_1}
  measure: ty_lflMargin {group_label:"TY" type: sum sql:${ty_lflMargin_dim};;value_format_name: decimal_1}
  measure: ty_lflUnits {group_label:"TY" type: sum sql:${ty_lflUnits_dim};;value_format_name: decimal_1}
  measure: ty_BRANCHNetSales {group_label:"TY" type: sum sql:${ty_BRANCHNetSales_dim};;value_format_name: decimal_1}
  measure: ty_WEBNetSales {group_label:"TY" type: sum sql:${ty_WEBNetSales_dim};;value_format_name: decimal_1}
  measure: ty_CLICKNetSales {group_label:"TY" type: sum sql:${ty_CLICKNetSales_dim};;value_format_name: decimal_1}
  measure: ty_EPOSAVNetSales {group_label:"TY" type: sum sql:${ty_EPOSAVNetSales_dim};;value_format_name: decimal_1}
  measure: ty_EPOSERNetSales {group_label:"TY" type: sum sql:${ty_EPOSERNetSales_dim};;value_format_name: decimal_1}
  measure: ty_CCNetSales {group_label:"TY" type: sum sql:${ty_CCNetSales_dim};;value_format_name: decimal_1}
  measure: ty_EBAYNetSales {group_label:"TY" type: sum sql:${ty_EBAYNetSales_dim};;value_format_name: decimal_1}
  measure: ty_DROPSHIPNetSales {group_label:"TY" type: sum sql:${ty_DROPSHIPNetSales_dim};;value_format_name: decimal_1}
  measure: ty_BRANCHMargin {group_label:"TY" type: sum sql:${ty_BRANCHMargin_dim};;value_format_name: decimal_1}
  measure: ty_WEBMargin {group_label:"TY" type: sum sql:${ty_WEBMargin_dim};;value_format_name: decimal_1}
  measure: ty_CLICKMargin {group_label:"TY" type: sum sql:${ty_CLICKMargin_dim};;value_format_name: decimal_1}
  measure: ty_EPOSAVMargin {group_label:"TY" type: sum sql:${ty_EPOSAVMargin_dim};;value_format_name: decimal_1}
  measure: ty_EPOSERMargin {group_label:"TY" type: sum sql:${ty_EPOSERMargin_dim};;value_format_name: decimal_1}
  measure: ty_CCMargin {group_label:"TY" type: sum sql:${ty_CCMargin_dim};;value_format_name: decimal_1}
  measure: ty_EBAYMargin {group_label:"TY" type: sum sql:${ty_EBAYMargin_dim};;value_format_name: decimal_1}
  measure: ty_DROPSHIPMargin {group_label:"TY" type: sum sql:${ty_DROPSHIPMargin_dim};;value_format_name: decimal_1}
  measure: ty_netSalesBudget {group_label:"TY" type: sum sql:${ty_netSalesBudget_dim};;value_format_name: decimal_1}
  measure: ty_marginBudget {group_label:"TY" type: sum sql:${ty_marginBudget_dim};;value_format_name: decimal_1}
  measure: ty_netSalesRF {group_label:"TY" type: sum sql:${ty_netSalesRF_dim};;value_format_name: decimal_1}
  measure: ty_marginRF {group_label:"TY" type: sum sql:${ty_marginRF_dim};;value_format_name: decimal_1}
  measure: ty_TradeNetSales {group_label:"TY" type: sum sql:${ty_TradeNetSales_dim};;value_format_name: decimal_1}
  measure: ty_TradeMargin {group_label:"TY" type: sum sql:${ty_TradeMargin_dim};;value_format_name: decimal_1}
  measure: ty_TradeUnits {group_label:"TY" type: sum sql:${ty_TradeUnits_dim};;value_format_name: decimal_1}
  measure: ty_TradeParticipation {group_label:"TY" type: sum sql:${ty_TradeParticipation_dim};;value_format_name: decimal_1}
  measure: ty_DIYNetSales {group_label:"TY" type: sum sql:${ty_DIYNetSales_dim};;value_format_name: decimal_1}
  measure: ty_DIYMargin {group_label:"TY" type: sum sql:${ty_DIYMargin_dim};;value_format_name: decimal_1}
  measure: ty_DIYUnits {group_label:"TY" type: sum sql:${ty_DIYUnits_dim};;value_format_name: decimal_1}
  measure: ty_DIYParticipation {group_label:"TY" type: sum sql:${ty_DIYParticipation_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandSales {group_label:"TY" type: sum sql:${ty_OwnBrandSales_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandMargin {group_label:"TY" type: sum sql:${ty_OwnBrandMargin_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandUnits {group_label:"TY" type: sum sql:${ty_OwnBrandUnits_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandTradeNetSales {group_label:"TY" type: sum sql:${ty_OwnBrandTradeNetSales_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandTradeMargin {group_label:"TY" type: sum sql:${ty_OwnBrandTradeMargin_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandTradeUnits {group_label:"TY" type: sum sql:${ty_OwnBrandTradeUnits_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandTradeParticipation {group_label:"TY" type: sum sql:${ty_OwnBrandTradeParticipation_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandDIYNetSales {group_label:"TY" type: sum sql:${ty_OwnBrandDIYNetSales_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandDIYMargin {group_label:"TY" type: sum sql:${ty_OwnBrandDIYMargin_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandDIYUnits {group_label:"TY" type: sum sql:${ty_OwnBrandDIYUnits_dim};;value_format_name: decimal_1}
  measure: ty_OwnBrandDIYParticipation {group_label:"TY" type: sum sql:${ty_OwnBrandDIYParticipation_dim};;value_format_name: decimal_1}
  measure: ly_grossSales {group_label:"LY" type: sum sql:${ly_grossSales_dim};;value_format_name: decimal_1}
  measure: ly_netSales {group_label:"LY" type: sum sql:${ly_netSales_dim};;value_format_name: decimal_1}
  measure: ly_prodMargin {group_label:"LY" type: sum sql:${ly_prodMargin_dim};;value_format_name: decimal_1}
  measure: ly_funding {group_label:"LY" type: sum sql:${ly_funding_dim};;value_format_name: decimal_1}
  measure: ly_grossMargin {group_label:"LY" type: sum sql:${ly_grossMargin_dim};;value_format_name: decimal_1}
  measure: ly_units {group_label:"LY" type: sum sql:${ly_units_dim};;value_format_name: decimal_1}
  measure: ly_orders {group_label:"LY" type: sum sql:${ly_orders_dim};;value_format_name: decimal_1}
  measure: ly_newProductNetSales {group_label:"LY" type: sum sql:${ly_newProductNetSales_dim};;value_format_name: decimal_1}
  measure: ly_newProductMargin {group_label:"LY" type: sum sql:${ly_newProductMargin_dim};;value_format_name: decimal_1}
  measure: ly_tradeCreditNetSales {group_label:"LY" type: sum sql:${ly_tradeCreditNetSales_dim};;value_format_name: decimal_1}
  measure: ly_tradeCreditMargin {group_label:"LY" type: sum sql:${ly_tradeCreditMargin_dim};;value_format_name: decimal_1}
  measure: ly_newCustomerNetSales {group_label:"LY" type: sum sql:${ly_newCustomerNetSales_dim};;value_format_name: decimal_1}
  measure: ly_newCustomerMargin {group_label:"LY" type: sum sql:${ly_newCustomerMargin_dim};;value_format_name: decimal_1}
  measure: ly_promoNetSales {group_label:"LY" type: sum sql:${ly_promoNetSales_dim};;value_format_name: decimal_1}
  measure: ly_promoGrossMargin {group_label:"LY" type: sum sql:${ly_promoGrossMargin_dim};;value_format_name: decimal_1}
  measure: ly_isPromo {group_label:"LY" type: sum sql:${ly_isPromo_dim};;value_format_name: decimal_1}
  measure: ly_lflNetSales {group_label:"LY" type: sum sql:${ly_lflNetSales_dim};;value_format_name: decimal_1}
  measure: ly_lflMargin {group_label:"LY" type: sum sql:${ly_lflMargin_dim};;value_format_name: decimal_1}
  measure: ly_BRANCHNetSales {group_label:"LY" type: sum sql:${ly_BRANCHNetSales_dim};;value_format_name: decimal_1}
  measure: ly_WEBNetSales {group_label:"LY" type: sum sql:${ly_WEBNetSales_dim};;value_format_name: decimal_1}
  measure: ly_CLICKNetSales {group_label:"LY" type: sum sql:${ly_CLICKNetSales_dim};;value_format_name: decimal_1}
  measure: ly_EPOSAVNetSales {group_label:"LY" type: sum sql:${ly_EPOSAVNetSales_dim};;value_format_name: decimal_1}
  measure: ly_EPOSERNetSales {group_label:"LY" type: sum sql:${ly_EPOSERNetSales_dim};;value_format_name: decimal_1}
  measure: ly_CCNetSales {group_label:"LY" type: sum sql:${ly_CCNetSales_dim};;value_format_name: decimal_1}
  measure: ly_EBAYNetSales {group_label:"LY" type: sum sql:${ly_EBAYNetSales_dim};;value_format_name: decimal_1}
  measure: ly_DROPSHIPNetSales {group_label:"LY" type: sum sql:${ly_DROPSHIPNetSales_dim};;value_format_name: decimal_1}
  measure: ly_BRANCHMargin {group_label:"LY" type: sum sql:${ly_BRANCHMargin_dim};;value_format_name: decimal_1}
  measure: ly_WEBMargin {group_label:"LY" type: sum sql:${ly_WEBMargin_dim};;value_format_name: decimal_1}
  measure: ly_CLICKMargin {group_label:"LY" type: sum sql:${ly_CLICKMargin_dim};;value_format_name: decimal_1}
  measure: ly_EPOSAVMargin {group_label:"LY" type: sum sql:${ly_EPOSAVMargin_dim};;value_format_name: decimal_1}
  measure: ly_EPOSERMargin {group_label:"LY" type: sum sql:${ly_EPOSERMargin_dim};;value_format_name: decimal_1}
  measure: ly_CCMargin {group_label:"LY" type: sum sql:${ly_CCMargin_dim};;value_format_name: decimal_1}
  measure: ly_EBAYMargin {group_label:"LY" type: sum sql:${ly_EBAYMargin_dim};;value_format_name: decimal_1}
  measure: ly_DROPSHIPMargin {group_label:"LY" type: sum sql:${ly_DROPSHIPMargin_dim};;value_format_name: decimal_1}
  measure: ly_TradeNetSales {group_label:"LY" type: sum sql:${ly_TradeNetSales_dim};;value_format_name: decimal_1}
  measure: ly_TradeMargin {group_label:"LY" type: sum sql:${ly_TradeMargin_dim};;value_format_name: decimal_1}
  measure: ly_TradeUnits {group_label:"LY" type: sum sql:${ly_TradeUnits_dim};;value_format_name: decimal_1}
  measure: ly_TradeParticipation {group_label:"LY" type: sum sql:${ly_TradeParticipation_dim};;value_format_name: decimal_1}
  measure: ly_DIYNetSales {group_label:"LY" type: sum sql:${ly_DIYNetSales_dim};;value_format_name: decimal_1}
  measure: ly_DIYMargin {group_label:"LY" type: sum sql:${ly_DIYMargin_dim};;value_format_name: decimal_1}
  measure: ly_DIYUnits {group_label:"LY" type: sum sql:${ly_DIYUnits_dim};;value_format_name: decimal_1}
  measure: ly_DIYParticipation {group_label:"LY" type: sum sql:${ly_DIYParticipation_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandSales {group_label:"LY" type: sum sql:${ly_OwnBrandSales_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandMargin {group_label:"LY" type: sum sql:${ly_OwnBrandMargin_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandUnits {group_label:"LY" type: sum sql:${ly_OwnBrandUnits_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandTradeNetSales {group_label:"LY" type: sum sql:${ly_OwnBrandTradeNetSales_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandTradeMargin {group_label:"LY" type: sum sql:${ly_OwnBrandTradeMargin_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandTradeUnits {group_label:"LY" type: sum sql:${ly_OwnBrandTradeUnits_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandTradeParticipation {group_label:"LY" type: sum sql:${ly_OwnBrandTradeParticipation_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandDIYNetSales {group_label:"LY" type: sum sql:${ly_OwnBrandDIYNetSales_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandDIYMargin {group_label:"LY" type: sum sql:${ly_OwnBrandDIYMargin_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandDIYUnits {group_label:"LY" type: sum sql:${ly_OwnBrandDIYUnits_dim};;value_format_name: decimal_1}
  measure: ly_OwnBrandDIYParticipation {group_label:"LY" type: sum sql:${ly_OwnBrandDIYParticipation_dim};;value_format_name: decimal_1}
  measure: lly_grossSales {group_label:"LLY" type: sum sql:${lly_grossSales_dim};;value_format_name: decimal_1}
  measure: lly_netSales {group_label:"LLY" type: sum sql:${lly_netSales_dim};;value_format_name: decimal_1}
  measure: lly_prodMargin {group_label:"LLY" type: sum sql:${lly_prodMargin_dim};;value_format_name: decimal_1}
  measure: lly_funding {group_label:"LLY" type: sum sql:${lly_funding_dim};;value_format_name: decimal_1}
  measure: lly_grossMargin {group_label:"LLY" type: sum sql:${lly_grossMargin_dim};;value_format_name: decimal_1}
  measure: lly_units {group_label:"LLY" type: sum sql:${lly_units_dim};;value_format_name: decimal_1}
  measure: lly_newProductNetSales {group_label:"LLY" type: sum sql:${lly_newProductNetSales_dim};;value_format_name: decimal_1}
  measure: lly_newProductMargin {group_label:"LLY" type: sum sql:${lly_newProductMargin_dim};;value_format_name: decimal_1}
  measure: lly_tradeCreditNetSales {group_label:"LLY" type: sum sql:${lly_tradeCreditNetSales_dim};;value_format_name: decimal_1}
  measure: lly_tradeCreditMargin {group_label:"LLY" type: sum sql:${lly_tradeCreditMargin_dim};;value_format_name: decimal_1}
  measure: lly_newCustomerNetSales {group_label:"LLY" type: sum sql:${lly_newCustomerNetSales_dim};;value_format_name: decimal_1}
  measure: lly_newCustomerMargin {group_label:"LLY" type: sum sql:${lly_newCustomerMargin_dim};;value_format_name: decimal_1}
  measure: lly_lflNetSales {group_label:"LLY" type: sum sql:${lly_lflNetSales_dim};;value_format_name: decimal_1}
  measure: lly_lflMargin {group_label:"LLY" type: sum sql:${lly_lflMargin_dim};;value_format_name: decimal_1}
  measure: lly_TradeNetSales {group_label:"LLY" type: sum sql:${lly_TradeNetSales_dim};;value_format_name: decimal_1}
  measure: lly_TradeMargin {group_label:"LLY" type: sum sql:${lly_TradeMargin_dim};;value_format_name: decimal_1}
  measure: lly_TradeUnits {group_label:"LLY" type: sum sql:${lly_TradeUnits_dim};;value_format_name: decimal_1}
  measure: lly_TradeParticipation {group_label:"LLY" type: sum sql:${lly_TradeParticipation_dim};;value_format_name: decimal_1}
  measure: lly_DIYNetSales {group_label:"LLY" type: sum sql:${lly_DIYNetSales_dim};;value_format_name: decimal_1}
  measure: lly_DIYMargin {group_label:"LLY" type: sum sql:${lly_DIYMargin_dim};;value_format_name: decimal_1}
  measure: lly_DIYUnits {group_label:"LLY" type: sum sql:${lly_DIYUnits_dim};;value_format_name: decimal_1}
  measure: lly_DIYParticipation {group_label:"LLY" type: sum sql:${lly_DIYParticipation_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandSales {group_label:"LLY" type: sum sql:${lly_OwnBrandSales_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandMargin {group_label:"LLY" type: sum sql:${lly_OwnBrandMargin_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandUnits {group_label:"LLY" type: sum sql:${lly_OwnBrandUnits_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandTradeNetSales {group_label:"LLY" type: sum sql:${lly_OwnBrandTradeNetSales_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandTradeMargin {group_label:"LLY" type: sum sql:${lly_OwnBrandTradeMargin_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandTradeUnits {group_label:"LLY" type: sum sql:${lly_OwnBrandTradeUnits_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandTradeParticipation {group_label:"LLY" type: sum sql:${lly_OwnBrandTradeParticipation_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandDIYNetSales {group_label:"LLY" type: sum sql:${lly_OwnBrandDIYNetSales_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandDIYMargin {group_label:"LLY" type: sum sql:${lly_OwnBrandDIYMargin_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandDIYUnits {group_label:"LLY" type: sum sql:${lly_OwnBrandDIYUnits_dim};;value_format_name: decimal_1}
  measure: lly_OwnBrandDIYParticipation {group_label:"LLY" type: sum sql:${lly_OwnBrandDIYParticipation_dim};;value_format_name: decimal_1}
  measure: lw_grossSales {group_label:"LW" type: sum sql:${lw_grossSales_dim};;value_format_name: decimal_1}
  measure: lw_netSales {group_label:"LW" type: sum sql:${lw_netSales_dim};;value_format_name: decimal_1}
  measure: lw_prodMargin {group_label:"LW" type: sum sql:${lw_prodMargin_dim};;value_format_name: decimal_1}
  measure: lw_funding {group_label:"LW" type: sum sql:${lw_funding_dim};;value_format_name: decimal_1}
  measure: lw_grossMargin {group_label:"LW" type: sum sql:${lw_grossMargin_dim};;value_format_name: decimal_1}
  measure: lw_units {group_label:"LW" type: sum sql:${lw_units_dim};;value_format_name: decimal_1}
  measure: lw_newProductNetSales {group_label:"LW" type: sum sql:${lw_newProductNetSales_dim};;value_format_name: decimal_1}
  measure: lw_newProductMargin {group_label:"LW" type: sum sql:${lw_newProductMargin_dim};;value_format_name: decimal_1}
  measure: lw_tradeCreditNetSales {group_label:"LW" type: sum sql:${lw_tradeCreditNetSales_dim};;value_format_name: decimal_1}
  measure: lw_tradeCreditMargin {group_label:"LW" type: sum sql:${lw_tradeCreditMargin_dim};;value_format_name: decimal_1}
  measure: lw_newCustomerNetSales {group_label:"LW" type: sum sql:${lw_newCustomerNetSales_dim};;value_format_name: decimal_1}
  measure: lw_newCustomerMargin {group_label:"LW" type: sum sql:${lw_newCustomerMargin_dim};;value_format_name: decimal_1}
  measure: lw_lflNetSales {group_label:"LW" type: sum sql:${lw_lflNetSales_dim};;value_format_name: decimal_1}
  measure: lw_lflMargin {group_label:"LW" type: sum sql:${lw_lflMargin_dim};;value_format_name: decimal_1}
  measure: lw_TradeNetSales {group_label:"LW" type: sum sql:${lw_TradeNetSales_dim};;value_format_name: decimal_1}
  measure: lw_TradeMargin {group_label:"LW" type: sum sql:${lw_TradeMargin_dim};;value_format_name: decimal_1}
  measure: lw_TradeUnits {group_label:"LW" type: sum sql:${lw_TradeUnits_dim};;value_format_name: decimal_1}
  measure: lw_TradeParticipation {group_label:"LW" type: sum sql:${lw_TradeParticipation_dim};;value_format_name: decimal_1}
  measure: lw_DIYNetSales {group_label:"LW" type: sum sql:${lw_DIYNetSales_dim};;value_format_name: decimal_1}
  measure: lw_DIYMargin {group_label:"LW" type: sum sql:${lw_DIYMargin_dim};;value_format_name: decimal_1}
  measure: lw_DIYUnits {group_label:"LW" type: sum sql:${lw_DIYUnits_dim};;value_format_name: decimal_1}
  measure: lw_DIYParticipation {group_label:"LW" type: sum sql:${lw_DIYParticipation_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandSales {group_label:"LW" type: sum sql:${lw_OwnBrandSales_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandMargin {group_label:"LW" type: sum sql:${lw_OwnBrandMargin_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandUnits {group_label:"LW" type: sum sql:${lw_OwnBrandUnits_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandTradeNetSales {group_label:"LW" type: sum sql:${lw_OwnBrandTradeNetSales_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandTradeMargin {group_label:"LW" type: sum sql:${lw_OwnBrandTradeMargin_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandTradeUnits {group_label:"LW" type: sum sql:${lw_OwnBrandTradeUnits_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandTradeParticipation {group_label:"LW" type: sum sql:${lw_OwnBrandTradeParticipation_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandDIYNetSales {group_label:"LW" type: sum sql:${lw_OwnBrandDIYNetSales_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandDIYMargin {group_label:"LW" type: sum sql:${lw_OwnBrandDIYMargin_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandDIYUnits {group_label:"LW" type: sum sql:${lw_OwnBrandDIYUnits_dim};;value_format_name: decimal_1}
  measure: lw_OwnBrandDIYParticipation {group_label:"LW" type: sum sql:${lw_OwnBrandDIYParticipation_dim};;value_format_name: decimal_1}


  # YOY------------------------------------

measure: YOY_grossSales {group_label:"YOY" type:number sql:${ty_grossSales}-${ly_grossSales};;value_format_name: decimal_1}

measure: YOY_netSales {group_label:"YOY" type:number sql:${ty_netSales}-${ly_netSales};;value_format_name: decimal_1}
measure: YOY_prodMargin {group_label:"YOY" type:number sql:${ty_prodMargin}-${ly_prodMargin};;value_format_name: decimal_1}
measure: YOY_funding {group_label:"YOY" type:number sql:${ty_funding}-${ly_funding};;value_format_name: decimal_1}
measure: YOY_grossMargin {group_label:"YOY" type:number sql:${ty_grossMargin}-${ly_grossMargin};;value_format_name: decimal_1}
measure: YOY_units {group_label:"YOY" type:number sql:${ty_units}-${ly_units};;value_format_name: decimal_1}
measure: YOY_orders {group_label:"YOY" type:number sql:${ty_orders}-${ly_orders};;value_format_name: decimal_1}
measure: YOY_newProductNetSales {group_label:"YOY" type:number sql:${ty_newProductNetSales}-${ly_newProductNetSales};;value_format_name: decimal_1}
measure: YOY_newProductMargin {group_label:"YOY" type:number sql:${ty_newProductMargin}-${ly_newProductMargin};;value_format_name: decimal_1}
measure: YOY_tradeCreditNetSales {group_label:"YOY" type:number sql:${ty_tradeCreditNetSales}-${ly_tradeCreditNetSales};;value_format_name: decimal_1}
measure: YOY_tradeCreditMargin {group_label:"YOY" type:number sql:${ty_tradeCreditMargin}-${ly_tradeCreditMargin};;value_format_name: decimal_1}
measure: YOY_newCustomerNetSales {group_label:"YOY" type:number sql:${ty_newCustomerNetSales}-${ly_newCustomerNetSales};;value_format_name: decimal_1}
measure: YOY_newCustomerMargin {group_label:"YOY" type:number sql:${ty_newCustomerMargin}-${ly_newCustomerMargin};;value_format_name: decimal_1}
measure: YOY_promoNetSales {group_label:"YOY" type:number sql:${ty_promoNetSales}-${ly_promoNetSales};;value_format_name: decimal_1}
measure: YOY_promoGrossMargin {group_label:"YOY" type:number sql:${ty_promoGrossMargin}-${ly_promoGrossMargin};;value_format_name: decimal_1}
measure: YOY_isPromo {group_label:"YOY" type:number sql:${ty_isPromo}-${ly_isPromo};;value_format_name: decimal_1}
measure: YOY_lflNetSales {group_label:"YOY" type:number sql:${ty_lflNetSales}-${ly_lflNetSales};;value_format_name: decimal_1}
measure: YOY_lflMargin {group_label:"YOY" type:number sql:${ty_lflMargin}-${ly_lflMargin};;value_format_name: decimal_1}
measure: YOY_BRANCHNetSales {group_label:"YOY" type:number sql:${ty_BRANCHNetSales}-${ly_BRANCHNetSales};;value_format_name: decimal_1}
measure: YOY_WEBNetSales {group_label:"YOY" type:number sql:${ty_WEBNetSales}-${ly_WEBNetSales};;value_format_name: decimal_1}
measure: YOY_CLICKNetSales {group_label:"YOY" type:number sql:${ty_CLICKNetSales}-${ly_CLICKNetSales};;value_format_name: decimal_1}
measure: YOY_EPOSAVNetSales {group_label:"YOY" type:number sql:${ty_EPOSAVNetSales}-${ly_EPOSAVNetSales};;value_format_name: decimal_1}
measure: YOY_EPOSERNetSales {group_label:"YOY" type:number sql:${ty_EPOSERNetSales}-${ly_EPOSERNetSales};;value_format_name: decimal_1}
measure: YOY_CCNetSales {group_label:"YOY" type:number sql:${ty_CCNetSales}-${ly_CCNetSales};;value_format_name: decimal_1}
measure: YOY_EBAYNetSales {group_label:"YOY" type:number sql:${ty_EBAYNetSales}-${ly_EBAYNetSales};;value_format_name: decimal_1}
measure: YOY_DROPSHIPNetSales {group_label:"YOY" type:number sql:${ty_DROPSHIPNetSales}-${ly_DROPSHIPNetSales};;value_format_name: decimal_1}
measure: YOY_BRANCHMargin {group_label:"YOY" type:number sql:${ty_BRANCHMargin}-${ly_BRANCHMargin};;value_format_name: decimal_1}
measure: YOY_WEBMargin {group_label:"YOY" type:number sql:${ty_WEBMargin}-${ly_WEBMargin};;value_format_name: decimal_1}
measure: YOY_CLICKMargin {group_label:"YOY" type:number sql:${ty_CLICKMargin}-${ly_CLICKMargin};;value_format_name: decimal_1}
measure: YOY_EPOSAVMargin {group_label:"YOY" type:number sql:${ty_EPOSAVMargin}-${ly_EPOSAVMargin};;value_format_name: decimal_1}
measure: YOY_EPOSERMargin {group_label:"YOY" type:number sql:${ty_EPOSERMargin}-${ly_EPOSERMargin};;value_format_name: decimal_1}
measure: YOY_CCMargin {group_label:"YOY" type:number sql:${ty_CCMargin}-${ly_CCMargin};;value_format_name: decimal_1}
measure: YOY_EBAYMargin {group_label:"YOY" type:number sql:${ty_EBAYMargin}-${ly_EBAYMargin};;value_format_name: decimal_1}
measure: YOY_DROPSHIPMargin {group_label:"YOY" type:number sql:${ty_DROPSHIPMargin}-${ly_DROPSHIPMargin};;value_format_name: decimal_1}
measure: YOY_TradeNetSales {group_label:"YOY" type:number sql:${ty_TradeNetSales}-${ly_TradeNetSales};;value_format_name: decimal_1}
measure: YOY_TradeMargin {group_label:"YOY" type:number sql:${ty_TradeMargin}-${ly_TradeMargin};;value_format_name: decimal_1}
measure: YOY_TradeUnits {group_label:"YOY" type:number sql:${ty_TradeUnits}-${ly_TradeUnits};;value_format_name: decimal_1}
measure: YOY_TradeParticipation {group_label:"YOY" type:number sql:${ty_TradeParticipation}-${ly_TradeParticipation};;value_format_name: decimal_1}
measure: YOY_DIYNetSales {group_label:"YOY" type:number sql:${ty_DIYNetSales}-${ly_DIYNetSales};;value_format_name: decimal_1}
measure: YOY_DIYMargin {group_label:"YOY" type:number sql:${ty_DIYMargin}-${ly_DIYMargin};;value_format_name: decimal_1}
measure: YOY_DIYUnits {group_label:"YOY" type:number sql:${ty_DIYUnits}-${ly_DIYUnits};;value_format_name: decimal_1}
measure: YOY_DIYParticipation {group_label:"YOY" type:number sql:${ty_DIYParticipation}-${ly_DIYParticipation};;value_format_name: decimal_1}
measure: YOY_OwnBrandSales {group_label:"YOY" type:number sql:${ty_OwnBrandSales}-${ly_OwnBrandSales};;value_format_name: decimal_1}
measure: YOY_OwnBrandMargin {group_label:"YOY" type:number sql:${ty_OwnBrandMargin}-${ly_OwnBrandMargin};;value_format_name: decimal_1}
measure: YOY_OwnBrandUnits {group_label:"YOY" type:number sql:${ty_OwnBrandUnits}-${ly_OwnBrandUnits};;value_format_name: decimal_1}
measure: YOY_OwnBrandTradeNetSales {group_label:"YOY" type:number sql:${ty_OwnBrandTradeNetSales}-${ly_OwnBrandTradeNetSales};;value_format_name: decimal_1}
measure: YOY_OwnBrandTradeMargin {group_label:"YOY" type:number sql:${ty_OwnBrandTradeMargin}-${ly_OwnBrandTradeMargin};;value_format_name: decimal_1}
measure: YOY_OwnBrandTradeUnits {group_label:"YOY" type:number sql:${ty_OwnBrandTradeUnits}-${ly_OwnBrandTradeUnits};;value_format_name: decimal_1}
measure: YOY_OwnBrandTradeParticipation {group_label:"YOY" type:number sql:${ty_OwnBrandTradeParticipation}-${ly_OwnBrandTradeParticipation};;value_format_name: decimal_1}
measure: YOY_OwnBrandDIYNetSales {group_label:"YOY" type:number sql:${ty_OwnBrandDIYNetSales}-${ly_OwnBrandDIYNetSales};;value_format_name: decimal_1}
measure: YOY_OwnBrandDIYMargin {group_label:"YOY" type:number sql:${ty_OwnBrandDIYMargin}-${ly_OwnBrandDIYMargin};;value_format_name: decimal_1}
measure: YOY_OwnBrandDIYUnits {group_label:"YOY" type:number sql:${ty_OwnBrandDIYUnits}-${ly_OwnBrandDIYUnits};;value_format_name: decimal_1}
measure: YOY_OwnBrandDIYParticipation {group_label:"YOY" type:number sql:${ty_OwnBrandDIYParticipation}-${ly_OwnBrandDIYParticipation};;value_format_name: decimal_1}
measure: 2YOY_grossSales {group_label:"2YOY" type:number sql:${ty_grossSales}-${lly_grossSales};;value_format_name: decimal_1}
measure: 2YOY_netSales {group_label:"2YOY" type:number sql:${ty_netSales}-${lly_netSales};;value_format_name: decimal_1}
measure: 2YOY_prodMargin {group_label:"2YOY" type:number sql:${ty_prodMargin}-${lly_prodMargin};;value_format_name: decimal_1}
measure: 2YOY_funding {group_label:"2YOY" type:number sql:${ty_funding}-${lly_funding};;value_format_name: decimal_1}
measure: 2YOY_grossMargin {group_label:"2YOY" type:number sql:${ty_grossMargin}-${lly_grossMargin};;value_format_name: decimal_1}
measure: 2YOY_units {group_label:"2YOY" type:number sql:${ty_units}-${lly_units};;value_format_name: decimal_1}
measure: 2YOY_newProductNetSales {group_label:"2YOY" type:number sql:${ty_newProductNetSales}-${lly_newProductNetSales};;value_format_name: decimal_1}
measure: 2YOY_newProductMargin {group_label:"2YOY" type:number sql:${ty_newProductMargin}-${lly_newProductMargin};;value_format_name: decimal_1}
measure: 2YOY_tradeCreditNetSales {group_label:"2YOY" type:number sql:${ty_tradeCreditNetSales}-${lly_tradeCreditNetSales};;value_format_name: decimal_1}
measure: 2YOY_tradeCreditMargin {group_label:"2YOY" type:number sql:${ty_tradeCreditMargin}-${lly_tradeCreditMargin};;value_format_name: decimal_1}
measure: 2YOY_newCustomerNetSales {group_label:"2YOY" type:number sql:${ty_newCustomerNetSales}-${lly_newCustomerNetSales};;value_format_name: decimal_1}
measure: 2YOY_newCustomerMargin {group_label:"2YOY" type:number sql:${ty_newCustomerMargin}-${lly_newCustomerMargin};;value_format_name: decimal_1}
measure: 2YOY_lflNetSales {group_label:"2YOY" type:number sql:${ty_lflNetSales}-${lly_lflNetSales};;value_format_name: decimal_1}
measure: 2YOY_lflMargin {group_label:"2YOY" type:number sql:${ty_lflMargin}-${lly_lflMargin};;value_format_name: decimal_1}
measure: 2YOY_TradeNetSales {group_label:"2YOY" type:number sql:${ty_TradeNetSales}-${lly_TradeNetSales};;value_format_name: decimal_1}
measure: 2YOY_TradeMargin {group_label:"2YOY" type:number sql:${ty_TradeMargin}-${lly_TradeMargin};;value_format_name: decimal_1}
measure: 2YOY_TradeUnits {group_label:"2YOY" type:number sql:${ty_TradeUnits}-${lly_TradeUnits};;value_format_name: decimal_1}
measure: 2YOY_TradeParticipation {group_label:"2YOY" type:number sql:${ty_TradeParticipation}-${lly_TradeParticipation};;value_format_name: decimal_1}
measure: 2YOY_DIYNetSales {group_label:"2YOY" type:number sql:${ty_DIYNetSales}-${lly_DIYNetSales};;value_format_name: decimal_1}
measure: 2YOY_DIYMargin {group_label:"2YOY" type:number sql:${ty_DIYMargin}-${lly_DIYMargin};;value_format_name: decimal_1}
measure: 2YOY_DIYUnits {group_label:"2YOY" type:number sql:${ty_DIYUnits}-${lly_DIYUnits};;value_format_name: decimal_1}
measure: 2YOY_DIYParticipation {group_label:"2YOY" type:number sql:${ty_DIYParticipation}-${lly_DIYParticipation};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandSales {group_label:"2YOY" type:number sql:${ty_OwnBrandSales}-${lly_OwnBrandSales};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandMargin {group_label:"2YOY" type:number sql:${ty_OwnBrandMargin}-${lly_OwnBrandMargin};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandUnits {group_label:"2YOY" type:number sql:${ty_OwnBrandUnits}-${lly_OwnBrandUnits};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandTradeNetSales {group_label:"2YOY" type:number sql:${ty_OwnBrandTradeNetSales}-${lly_OwnBrandTradeNetSales};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandTradeMargin {group_label:"2YOY" type:number sql:${ty_OwnBrandTradeMargin}-${lly_OwnBrandTradeMargin};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandTradeUnits {group_label:"2YOY" type:number sql:${ty_OwnBrandTradeUnits}-${lly_OwnBrandTradeUnits};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandTradeParticipation {group_label:"2YOY" type:number sql:${ty_OwnBrandTradeParticipation}-${lly_OwnBrandTradeParticipation};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandDIYNetSales {group_label:"2YOY" type:number sql:${ty_OwnBrandDIYNetSales}-${lly_OwnBrandDIYNetSales};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandDIYMargin {group_label:"2YOY" type:number sql:${ty_OwnBrandDIYMargin}-${lly_OwnBrandDIYMargin};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandDIYUnits {group_label:"2YOY" type:number sql:${ty_OwnBrandDIYUnits}-${lly_OwnBrandDIYUnits};;value_format_name: decimal_1}
measure: 2YOY_OwnBrandDIYParticipation {group_label:"2YOY" type:number sql:${ty_OwnBrandDIYParticipation}-${lly_OwnBrandDIYParticipation};;value_format_name: decimal_1}
measure: LW_grossSales {group_label:"LW" type:number sql:${ty_grossSales}-${lw_grossSales};;value_format_name: decimal_1}
measure: LW_netSales {group_label:"LW" type:number sql:${ty_netSales}-${lw_netSales};;value_format_name: decimal_1}
measure: LW_prodMargin {group_label:"LW" type:number sql:${ty_prodMargin}-${lw_prodMargin};;value_format_name: decimal_1}
measure: LW_funding {group_label:"LW" type:number sql:${ty_funding}-${lw_funding};;value_format_name: decimal_1}
measure: LW_grossMargin {group_label:"LW" type:number sql:${ty_grossMargin}-${lw_grossMargin};;value_format_name: decimal_1}
measure: LW_units {group_label:"LW" type:number sql:${ty_units}-${lw_units};;value_format_name: decimal_1}
measure: LW_newProductNetSales {group_label:"LW" type:number sql:${ty_newProductNetSales}-${lw_newProductNetSales};;value_format_name: decimal_1}
measure: LW_newProductMargin {group_label:"LW" type:number sql:${ty_newProductMargin}-${lw_newProductMargin};;value_format_name: decimal_1}
measure: LW_tradeCreditNetSales {group_label:"LW" type:number sql:${ty_tradeCreditNetSales}-${lw_tradeCreditNetSales};;value_format_name: decimal_1}
measure: LW_tradeCreditMargin {group_label:"LW" type:number sql:${ty_tradeCreditMargin}-${lw_tradeCreditMargin};;value_format_name: decimal_1}
measure: LW_newCustomerNetSales {group_label:"LW" type:number sql:${ty_newCustomerNetSales}-${lw_newCustomerNetSales};;value_format_name: decimal_1}
measure: LW_newCustomerMargin {group_label:"LW" type:number sql:${ty_newCustomerMargin}-${lw_newCustomerMargin};;value_format_name: decimal_1}
measure: LW_lflNetSales {group_label:"LW" type:number sql:${ty_lflNetSales}-${lw_lflNetSales};;value_format_name: decimal_1}
measure: LW_lflMargin {group_label:"LW" type:number sql:${ty_lflMargin}-${lw_lflMargin};;value_format_name: decimal_1}
measure: LW_TradeNetSales {group_label:"LW" type:number sql:${ty_TradeNetSales}-${lw_TradeNetSales};;value_format_name: decimal_1}
measure: LW_TradeMargin {group_label:"LW" type:number sql:${ty_TradeMargin}-${lw_TradeMargin};;value_format_name: decimal_1}
measure: LW_TradeUnits {group_label:"LW" type:number sql:${ty_TradeUnits}-${lw_TradeUnits};;value_format_name: decimal_1}
measure: LW_TradeParticipation {group_label:"LW" type:number sql:${ty_TradeParticipation}-${lw_TradeParticipation};;value_format_name: decimal_1}
measure: LW_DIYNetSales {group_label:"LW" type:number sql:${ty_DIYNetSales}-${lw_DIYNetSales};;value_format_name: decimal_1}
measure: LW_DIYMargin {group_label:"LW" type:number sql:${ty_DIYMargin}-${lw_DIYMargin};;value_format_name: decimal_1}
measure: LW_DIYUnits {group_label:"LW" type:number sql:${ty_DIYUnits}-${lw_DIYUnits};;value_format_name: decimal_1}
measure: LW_DIYParticipation {group_label:"LW" type:number sql:${ty_DIYParticipation}-${lw_DIYParticipation};;value_format_name: decimal_1}
measure: LW_OwnBrandSales {group_label:"LW" type:number sql:${ty_OwnBrandSales}-${lw_OwnBrandSales};;value_format_name: decimal_1}
measure: LW_OwnBrandMargin {group_label:"LW" type:number sql:${ty_OwnBrandMargin}-${lw_OwnBrandMargin};;value_format_name: decimal_1}
measure: LW_OwnBrandUnits {group_label:"LW" type:number sql:${ty_OwnBrandUnits}-${lw_OwnBrandUnits};;value_format_name: decimal_1}
measure: LW_OwnBrandTradeNetSales {group_label:"LW" type:number sql:${ty_OwnBrandTradeNetSales}-${lw_OwnBrandTradeNetSales};;value_format_name: decimal_1}
measure: LW_OwnBrandTradeMargin {group_label:"LW" type:number sql:${ty_OwnBrandTradeMargin}-${lw_OwnBrandTradeMargin};;value_format_name: decimal_1}
measure: LW_OwnBrandTradeUnits {group_label:"LW" type:number sql:${ty_OwnBrandTradeUnits}-${lw_OwnBrandTradeUnits};;value_format_name: decimal_1}
measure: LW_OwnBrandTradeParticipation {group_label:"LW" type:number sql:${ty_OwnBrandTradeParticipation}-${lw_OwnBrandTradeParticipation};;value_format_name: decimal_1}
measure: LW_OwnBrandDIYNetSales {group_label:"LW" type:number sql:${ty_OwnBrandDIYNetSales}-${lw_OwnBrandDIYNetSales};;value_format_name: decimal_1}
measure: LW_OwnBrandDIYMargin {group_label:"LW" type:number sql:${ty_OwnBrandDIYMargin}-${lw_OwnBrandDIYMargin};;value_format_name: decimal_1}
measure: LW_OwnBrandDIYUnits {group_label:"LW" type:number sql:${ty_OwnBrandDIYUnits}-${lw_OwnBrandDIYUnits};;value_format_name: decimal_1}
measure: LW_OwnBrandDIYParticipation {group_label:"LW" type:number sql:${ty_OwnBrandDIYParticipation}-${lw_OwnBrandDIYParticipation};;value_format_name: decimal_1}


  # YOY %------------------------------------
 measure: YOY_percent_grossSales {group_label:"YOY%" type:number sql:safe_divide(${ty_grossSales}-${ly_grossSales},${ly_grossSales});;value_format_name: percent_1}

  measure: YOY_percent_netSales {group_label:"YOY%" type:number sql:safe_divide(${ty_netSales}-${ly_netSales},${ly_netSales});;value_format_name: percent_1}
  measure: YOY_percent_prodMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_prodMargin}-${ly_prodMargin},${ly_prodMargin});;value_format_name: percent_1}
  measure: YOY_percent_funding {group_label:"YOY%" type:number sql:safe_divide(${ty_funding}-${ly_funding},${ly_funding});;value_format_name: percent_1}
  measure: YOY_percent_grossMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_grossMargin}-${ly_grossMargin},${ly_grossMargin});;value_format_name: percent_1}
  measure: YOY_percent_units {group_label:"YOY%" type:number sql:safe_divide(${ty_units}-${ly_units},${ly_units});;value_format_name: percent_1}
  measure: YOY_percent_orders {group_label:"YOY%" type:number sql:safe_divide(${ty_orders}-${ly_orders},${ly_orders});;value_format_name: percent_1}
  measure: YOY_percent_newProductNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_newProductNetSales}-${ly_newProductNetSales},${ly_newProductNetSales});;value_format_name: percent_1}
  measure: YOY_percent_newProductMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_newProductMargin}-${ly_newProductMargin},${ly_newProductMargin});;value_format_name: percent_1}
  measure: YOY_percent_tradeCreditNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_tradeCreditNetSales}-${ly_tradeCreditNetSales},${ly_tradeCreditNetSales});;value_format_name: percent_1}
  measure: YOY_percent_tradeCreditMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_tradeCreditMargin}-${ly_tradeCreditMargin},${ly_tradeCreditMargin});;value_format_name: percent_1}
  measure: YOY_percent_newCustomerNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_newCustomerNetSales}-${ly_newCustomerNetSales},${ly_newCustomerNetSales});;value_format_name: percent_1}
  measure: YOY_percent_newCustomerMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_newCustomerMargin}-${ly_newCustomerMargin},${ly_newCustomerMargin});;value_format_name: percent_1}
  measure: YOY_percent_promoNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_promoNetSales}-${ly_promoNetSales},${ly_promoNetSales});;value_format_name: percent_1}
  measure: YOY_percent_promoGrossMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_promoGrossMargin}-${ly_promoGrossMargin},${ly_promoGrossMargin});;value_format_name: percent_1}
  measure: YOY_percent_isPromo {group_label:"YOY%" type:number sql:safe_divide(${ty_isPromo}-${ly_isPromo},${ly_isPromo});;value_format_name: percent_1}
  measure: YOY_percent_lflNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_lflNetSales}-${ly_lflNetSales},${ly_lflNetSales});;value_format_name: percent_1}
  measure: YOY_percent_lflMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_lflMargin}-${ly_lflMargin},${ly_lflMargin});;value_format_name: percent_1}
  measure: YOY_percent_BRANCHNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_BRANCHNetSales}-${ly_BRANCHNetSales},${ly_BRANCHNetSales});;value_format_name: percent_1}
  measure: YOY_percent_WEBNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_WEBNetSales}-${ly_WEBNetSales},${ly_WEBNetSales});;value_format_name: percent_1}
  measure: YOY_percent_CLICKNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_CLICKNetSales}-${ly_CLICKNetSales},${ly_CLICKNetSales});;value_format_name: percent_1}
  measure: YOY_percent_EPOSAVNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_EPOSAVNetSales}-${ly_EPOSAVNetSales},${ly_EPOSAVNetSales});;value_format_name: percent_1}
  measure: YOY_percent_EPOSERNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_EPOSERNetSales}-${ly_EPOSERNetSales},${ly_EPOSERNetSales});;value_format_name: percent_1}
  measure: YOY_percent_CCNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_CCNetSales}-${ly_CCNetSales},${ly_CCNetSales});;value_format_name: percent_1}
  measure: YOY_percent_EBAYNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_EBAYNetSales}-${ly_EBAYNetSales},${ly_EBAYNetSales});;value_format_name: percent_1}
  measure: YOY_percent_DROPSHIPNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_DROPSHIPNetSales}-${ly_DROPSHIPNetSales},${ly_DROPSHIPNetSales});;value_format_name: percent_1}
  measure: YOY_percent_BRANCHMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_BRANCHMargin}-${ly_BRANCHMargin},${ly_BRANCHMargin});;value_format_name: percent_1}
  measure: YOY_percent_WEBMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_WEBMargin}-${ly_WEBMargin},${ly_WEBMargin});;value_format_name: percent_1}
  measure: YOY_percent_CLICKMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_CLICKMargin}-${ly_CLICKMargin},${ly_CLICKMargin});;value_format_name: percent_1}
  measure: YOY_percent_EPOSAVMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_EPOSAVMargin}-${ly_EPOSAVMargin},${ly_EPOSAVMargin});;value_format_name: percent_1}
  measure: YOY_percent_EPOSERMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_EPOSERMargin}-${ly_EPOSERMargin},${ly_EPOSERMargin});;value_format_name: percent_1}
  measure: YOY_percent_CCMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_CCMargin}-${ly_CCMargin},${ly_CCMargin});;value_format_name: percent_1}
  measure: YOY_percent_EBAYMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_EBAYMargin}-${ly_EBAYMargin},${ly_EBAYMargin});;value_format_name: percent_1}
  measure: YOY_percent_DROPSHIPMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_DROPSHIPMargin}-${ly_DROPSHIPMargin},${ly_DROPSHIPMargin});;value_format_name: percent_1}
  measure: YOY_percent_TradeNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_TradeNetSales}-${ly_TradeNetSales},${ly_TradeNetSales});;value_format_name: percent_1}
  measure: YOY_percent_TradeMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_TradeMargin}-${ly_TradeMargin},${ly_TradeMargin});;value_format_name: percent_1}
  measure: YOY_percent_TradeUnits {group_label:"YOY%" type:number sql:safe_divide(${ty_TradeUnits}-${ly_TradeUnits},${ly_TradeUnits});;value_format_name: percent_1}
  measure: YOY_percent_TradeParticipation {group_label:"YOY%" type:number sql:safe_divide(${ty_TradeParticipation}-${ly_TradeParticipation},${ly_TradeParticipation});;value_format_name: percent_1}
  measure: YOY_percent_DIYNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_DIYNetSales}-${ly_DIYNetSales},${ly_DIYNetSales});;value_format_name: percent_1}
  measure: YOY_percent_DIYMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_DIYMargin}-${ly_DIYMargin},${ly_DIYMargin});;value_format_name: percent_1}
  measure: YOY_percent_DIYUnits {group_label:"YOY%" type:number sql:safe_divide(${ty_DIYUnits}-${ly_DIYUnits},${ly_DIYUnits});;value_format_name: percent_1}
  measure: YOY_percent_DIYParticipation {group_label:"YOY%" type:number sql:safe_divide(${ty_DIYParticipation}-${ly_DIYParticipation},${ly_DIYParticipation});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandSales {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandSales}-${ly_OwnBrandSales},${ly_OwnBrandSales});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandMargin}-${ly_OwnBrandMargin},${ly_OwnBrandMargin});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandUnits {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandUnits}-${ly_OwnBrandUnits},${ly_OwnBrandUnits});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandTradeNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandTradeNetSales}-${ly_OwnBrandTradeNetSales},${ly_OwnBrandTradeNetSales});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandTradeMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandTradeMargin}-${ly_OwnBrandTradeMargin},${ly_OwnBrandTradeMargin});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandTradeUnits {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandTradeUnits}-${ly_OwnBrandTradeUnits},${ly_OwnBrandTradeUnits});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandTradeParticipation {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandTradeParticipation}-${ly_OwnBrandTradeParticipation},${ly_OwnBrandTradeParticipation});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandDIYNetSales {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandDIYNetSales}-${ly_OwnBrandDIYNetSales},${ly_OwnBrandDIYNetSales});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandDIYMargin {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandDIYMargin}-${ly_OwnBrandDIYMargin},${ly_OwnBrandDIYMargin});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandDIYUnits {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandDIYUnits}-${ly_OwnBrandDIYUnits},${ly_OwnBrandDIYUnits});;value_format_name: percent_1}
  measure: YOY_percent_OwnBrandDIYParticipation {group_label:"YOY%" type:number sql:safe_divide(${ty_OwnBrandDIYParticipation}-${ly_OwnBrandDIYParticipation},${ly_OwnBrandDIYParticipation});;value_format_name: percent_1}
  measure: 2YOY_percent_grossSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_grossSales}-${lly_grossSales},${lly_grossSales});;value_format_name: percent_1}
  measure: 2YOY_percent_netSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_netSales}-${lly_netSales},${lly_netSales});;value_format_name: percent_1}
  measure: 2YOY_percent_prodMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_prodMargin}-${lly_prodMargin},${lly_prodMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_funding {group_label:"2YOY%" type:number sql:safe_divide(${ty_funding}-${lly_funding},${lly_funding});;value_format_name: percent_1}
  measure: 2YOY_percent_grossMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_grossMargin}-${lly_grossMargin},${lly_grossMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_units {group_label:"2YOY%" type:number sql:safe_divide(${ty_units}-${lly_units},${lly_units});;value_format_name: percent_1}
  measure: 2YOY_percent_newProductNetSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_newProductNetSales}-${lly_newProductNetSales},${lly_newProductNetSales});;value_format_name: percent_1}
  measure: 2YOY_percent_newProductMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_newProductMargin}-${lly_newProductMargin},${lly_newProductMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_tradeCreditNetSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_tradeCreditNetSales}-${lly_tradeCreditNetSales},${lly_tradeCreditNetSales});;value_format_name: percent_1}
  measure: 2YOY_percent_tradeCreditMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_tradeCreditMargin}-${lly_tradeCreditMargin},${lly_tradeCreditMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_newCustomerNetSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_newCustomerNetSales}-${lly_newCustomerNetSales},${lly_newCustomerNetSales});;value_format_name: percent_1}
  measure: 2YOY_percent_newCustomerMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_newCustomerMargin}-${lly_newCustomerMargin},${lly_newCustomerMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_lflNetSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_lflNetSales}-${lly_lflNetSales},${lly_lflNetSales});;value_format_name: percent_1}
  measure: 2YOY_percent_lflMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_lflMargin}-${lly_lflMargin},${lly_lflMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_TradeNetSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_TradeNetSales}-${lly_TradeNetSales},${lly_TradeNetSales});;value_format_name: percent_1}
  measure: 2YOY_percent_TradeMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_TradeMargin}-${lly_TradeMargin},${lly_TradeMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_TradeUnits {group_label:"2YOY%" type:number sql:safe_divide(${ty_TradeUnits}-${lly_TradeUnits},${lly_TradeUnits});;value_format_name: percent_1}
  measure: 2YOY_percent_TradeParticipation {group_label:"2YOY%" type:number sql:safe_divide(${ty_TradeParticipation}-${lly_TradeParticipation},${lly_TradeParticipation});;value_format_name: percent_1}
  measure: 2YOY_percent_DIYNetSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_DIYNetSales}-${lly_DIYNetSales},${lly_DIYNetSales});;value_format_name: percent_1}
  measure: 2YOY_percent_DIYMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_DIYMargin}-${lly_DIYMargin},${lly_DIYMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_DIYUnits {group_label:"2YOY%" type:number sql:safe_divide(${ty_DIYUnits}-${lly_DIYUnits},${lly_DIYUnits});;value_format_name: percent_1}
  measure: 2YOY_percent_DIYParticipation {group_label:"2YOY%" type:number sql:safe_divide(${ty_DIYParticipation}-${lly_DIYParticipation},${lly_DIYParticipation});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandSales}-${lly_OwnBrandSales},${lly_OwnBrandSales});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandMargin}-${lly_OwnBrandMargin},${lly_OwnBrandMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandUnits {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandUnits}-${lly_OwnBrandUnits},${lly_OwnBrandUnits});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandTradeNetSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandTradeNetSales}-${lly_OwnBrandTradeNetSales},${lly_OwnBrandTradeNetSales});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandTradeMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandTradeMargin}-${lly_OwnBrandTradeMargin},${lly_OwnBrandTradeMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandTradeUnits {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandTradeUnits}-${lly_OwnBrandTradeUnits},${lly_OwnBrandTradeUnits});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandTradeParticipation {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandTradeParticipation}-${lly_OwnBrandTradeParticipation},${lly_OwnBrandTradeParticipation});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandDIYNetSales {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandDIYNetSales}-${lly_OwnBrandDIYNetSales},${lly_OwnBrandDIYNetSales});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandDIYMargin {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandDIYMargin}-${lly_OwnBrandDIYMargin},${lly_OwnBrandDIYMargin});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandDIYUnits {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandDIYUnits}-${lly_OwnBrandDIYUnits},${lly_OwnBrandDIYUnits});;value_format_name: percent_1}
  measure: 2YOY_percent_OwnBrandDIYParticipation {group_label:"2YOY%" type:number sql:safe_divide(${ty_OwnBrandDIYParticipation}-${lly_OwnBrandDIYParticipation},${lly_OwnBrandDIYParticipation});;value_format_name: percent_1}
  measure: LW_percent_grossSales {group_label:"LW%" type:number sql:safe_divide(${ty_grossSales}-${lw_grossSales},${lw_grossSales});;value_format_name: percent_1}
  measure: LW_percent_netSales {group_label:"LW%" type:number sql:safe_divide(${ty_netSales}-${lw_netSales},${lw_netSales});;value_format_name: percent_1}
  measure: LW_percent_prodMargin {group_label:"LW%" type:number sql:safe_divide(${ty_prodMargin}-${lw_prodMargin},${lw_prodMargin});;value_format_name: percent_1}
  measure: LW_percent_funding {group_label:"LW%" type:number sql:safe_divide(${ty_funding}-${lw_funding},${lw_funding});;value_format_name: percent_1}
  measure: LW_percent_grossMargin {group_label:"LW%" type:number sql:safe_divide(${ty_grossMargin}-${lw_grossMargin},${lw_grossMargin});;value_format_name: percent_1}
  measure: LW_percent_units {group_label:"LW%" type:number sql:safe_divide(${ty_units}-${lw_units},${lw_units});;value_format_name: percent_1}
  measure: LW_percent_newProductNetSales {group_label:"LW%" type:number sql:safe_divide(${ty_newProductNetSales}-${lw_newProductNetSales},${lw_newProductNetSales});;value_format_name: percent_1}
  measure: LW_percent_newProductMargin {group_label:"LW%" type:number sql:safe_divide(${ty_newProductMargin}-${lw_newProductMargin},${lw_newProductMargin});;value_format_name: percent_1}
  measure: LW_percent_tradeCreditNetSales {group_label:"LW%" type:number sql:safe_divide(${ty_tradeCreditNetSales}-${lw_tradeCreditNetSales},${lw_tradeCreditNetSales});;value_format_name: percent_1}
  measure: LW_percent_tradeCreditMargin {group_label:"LW%" type:number sql:safe_divide(${ty_tradeCreditMargin}-${lw_tradeCreditMargin},${lw_tradeCreditMargin});;value_format_name: percent_1}
  measure: LW_percent_newCustomerNetSales {group_label:"LW%" type:number sql:safe_divide(${ty_newCustomerNetSales}-${lw_newCustomerNetSales},${lw_newCustomerNetSales});;value_format_name: percent_1}
  measure: LW_percent_newCustomerMargin {group_label:"LW%" type:number sql:safe_divide(${ty_newCustomerMargin}-${lw_newCustomerMargin},${lw_newCustomerMargin});;value_format_name: percent_1}
  measure: LW_percent_lflNetSales {group_label:"LW%" type:number sql:safe_divide(${ty_lflNetSales}-${lw_lflNetSales},${lw_lflNetSales});;value_format_name: percent_1}
  measure: LW_percent_lflMargin {group_label:"LW%" type:number sql:safe_divide(${ty_lflMargin}-${lw_lflMargin},${lw_lflMargin});;value_format_name: percent_1}
  measure: LW_percent_TradeNetSales {group_label:"LW%" type:number sql:safe_divide(${ty_TradeNetSales}-${lw_TradeNetSales},${lw_TradeNetSales});;value_format_name: percent_1}
  measure: LW_percent_TradeMargin {group_label:"LW%" type:number sql:safe_divide(${ty_TradeMargin}-${lw_TradeMargin},${lw_TradeMargin});;value_format_name: percent_1}
  measure: LW_percent_TradeUnits {group_label:"LW%" type:number sql:safe_divide(${ty_TradeUnits}-${lw_TradeUnits},${lw_TradeUnits});;value_format_name: percent_1}
  measure: LW_percent_TradeParticipation {group_label:"LW%" type:number sql:safe_divide(${ty_TradeParticipation}-${lw_TradeParticipation},${lw_TradeParticipation});;value_format_name: percent_1}
  measure: LW_percent_DIYNetSales {group_label:"LW%" type:number sql:safe_divide(${ty_DIYNetSales}-${lw_DIYNetSales},${lw_DIYNetSales});;value_format_name: percent_1}
  measure: LW_percent_DIYMargin {group_label:"LW%" type:number sql:safe_divide(${ty_DIYMargin}-${lw_DIYMargin},${lw_DIYMargin});;value_format_name: percent_1}
  measure: LW_percent_DIYUnits {group_label:"LW%" type:number sql:safe_divide(${ty_DIYUnits}-${lw_DIYUnits},${lw_DIYUnits});;value_format_name: percent_1}
  measure: LW_percent_DIYParticipation {group_label:"LW%" type:number sql:safe_divide(${ty_DIYParticipation}-${lw_DIYParticipation},${lw_DIYParticipation});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandSales {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandSales}-${lw_OwnBrandSales},${lw_OwnBrandSales});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandMargin {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandMargin}-${lw_OwnBrandMargin},${lw_OwnBrandMargin});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandUnits {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandUnits}-${lw_OwnBrandUnits},${lw_OwnBrandUnits});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandTradeNetSales {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandTradeNetSales}-${lw_OwnBrandTradeNetSales},${lw_OwnBrandTradeNetSales});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandTradeMargin {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandTradeMargin}-${lw_OwnBrandTradeMargin},${lw_OwnBrandTradeMargin});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandTradeUnits {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandTradeUnits}-${lw_OwnBrandTradeUnits},${lw_OwnBrandTradeUnits});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandTradeParticipation {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandTradeParticipation}-${lw_OwnBrandTradeParticipation},${lw_OwnBrandTradeParticipation});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandDIYNetSales {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandDIYNetSales}-${lw_OwnBrandDIYNetSales},${lw_OwnBrandDIYNetSales});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandDIYMargin {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandDIYMargin}-${lw_OwnBrandDIYMargin},${lw_OwnBrandDIYMargin});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandDIYUnits {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandDIYUnits}-${lw_OwnBrandDIYUnits},${lw_OwnBrandDIYUnits});;value_format_name: percent_1}
  measure: LW_percent_OwnBrandDIYParticipation {group_label:"LW%" type:number sql:safe_divide(${ty_OwnBrandDIYParticipation}-${lw_OwnBrandDIYParticipation},${lw_OwnBrandDIYParticipation});;value_format_name: percent_1}
}
