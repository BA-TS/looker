view: ds_daily_sku_sales_ty_ly_lly_lw_monthlyback {

  derived_table: {
    sql:
      SELECT distinct row_number() over () as P_K,
      *
      FROM `toolstation-data-storage.financeReporting.DS_DAILY_SKU_SALES_TY_LY_LLY_LW_MonthlyBack`
      where dims.date between date_sub(current_date(), interval 14 day) and current_date();;
      datagroup_trigger: ts_daily_datagroup
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

  }
