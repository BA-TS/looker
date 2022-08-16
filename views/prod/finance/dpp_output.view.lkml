# The name of this view in Looker is "Dpp Output"
view: dpp_output {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.DPP_v2.dpp_output`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Aov" in Explore.

  measure: aov {
    type: number
    sql: ${TABLE}.AOV ;;
  }

  measure: attached_r1_attachment_rate {
    type: number
    sql: ${TABLE}.attached_r1_attachment_rate ;;
  }

  dimension: attached_r1_description {
    type: string
    sql: ${TABLE}.attached_r1_description ;;
  }

  measure: attached_r1_dpp {
    type: number
    sql: ${TABLE}.attached_r1_dpp ;;
  }

  measure: attached_r1_dpp_rate {
    type: number
    sql: ${TABLE}.attached_r1_dpp_rate ;;
  }

  measure: attached_r1_orders {
    type: number
    sql: ${TABLE}.attached_r1_orders ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_attached_r1_orders {
  #   type: sum
  #   sql: ${attached_r1_orders} ;;
  # }

  # measure: average_attached_r1_orders {
  #   type: average
  #   sql: ${attached_r1_orders} ;;
  # }

  dimension: attached_r1_sku {
    type: string
    sql: ${TABLE}.attached_r1_sku ;;
  }

  measure: attached_r2_attachment_rate {
    type: number
    sql: ${TABLE}.attached_r2_attachment_rate ;;
  }

  dimension: attached_r2_description {
    type: string
    sql: ${TABLE}.attached_r2_description ;;
  }

  measure: attached_r2_dpp {
    type: number
    sql: ${TABLE}.attached_r2_dpp ;;
  }

  measure: attached_r2_dpp_rate {
    type: number
    sql: ${TABLE}.attached_r2_dpp_rate ;;
  }

  measure: attached_r2_orders {
    type: number
    sql: ${TABLE}.attached_r2_orders ;;
  }

  dimension: attached_r2_sku {
    type: string
    sql: ${TABLE}.attached_r2_sku ;;
  }

  measure: attached_r3_attachment_rate {
    type: number
    sql: ${TABLE}.attached_r3_attachment_rate ;;
  }

  dimension: attached_r3_description {
    type: string
    sql: ${TABLE}.attached_r3_description ;;
  }

  measure: attached_r3_dpp {
    type: number
    sql: ${TABLE}.attached_r3_dpp ;;
  }

  measure: attached_r3_dpp_rate {
    type: number
    sql: ${TABLE}.attached_r3_dpp_rate ;;
  }

  measure: attached_r3_orders {
    type: number
    sql: ${TABLE}.attached_r3_orders ;;
  }

  dimension: attached_r3_sku {
    type: string
    sql: ${TABLE}.attached_r3_sku ;;
  }

  dimension: avg_gross_sale_price_per_unit {
    type: number
    sql: ${TABLE}.avgGrossSalePricePerUnit ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.endDate ;;
  }

  dimension: fit_in_cage_2 {
    type: number
    sql: ${TABLE}.fit_in_cage_2 ;;
  }

  dimension: fitin_tote {
    type: number
    sql: ${TABLE}.fitinTote ;;
  }

  dimension: heavy_flag {
    type: number
    sql: ${TABLE}.HeavyFlag ;;
  }

  dimension: labour_pallet_multiplier {
    type: number
    sql: ${TABLE}.LabourPalletMultiplier ;;
  }

  dimension: location_indicator {
    type: string
    sql: ${TABLE}.LocationIndicator ;;
  }

  dimension: measure_1 {
    type: number
    sql: ${TABLE}.measure_1 ;;
  }

  dimension: measure_2 {
    type: number
    sql: ${TABLE}.measure_2 ;;
  }

  dimension: measure_3 {
    type: number
    sql: ${TABLE}.measure_3 ;;
  }

  dimension: narrow_aisle_indicator {
    type: string
    sql: ${TABLE}.NarrowAisleIndicator ;;
  }

  measure: order_cogs {
    type: number
    sql: ${TABLE}.orderCOGS ;;
  }

  measure: order_dpp {
    type: number
    sql: ${TABLE}.orderDPP ;;
  }

  measure: order_dpprate {
    type: number
    sql: ${TABLE}.orderDPPRate ;;
  }

  measure: order_margin_inc_funding {
    type: number
    sql: ${TABLE}.orderMarginIncFunding ;;
  }

  measure: order_margin_rate {
    type: number
    sql: ${TABLE}.orderMarginRate ;;
  }

  measure: order_net_sales {
    type: number
    sql: ${TABLE}.orderNetSales ;;
  }

  measure: order_tprate {
    type: number
    sql: ${TABLE}.orderTPRate ;;
  }

  measure: order_trading_profit {
    type: number
    sql: ${TABLE}.orderTradingProfit ;;
  }

  measure: orders {
    type: number
    sql: ${TABLE}.orders ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  measure: product_cogs {
    type: number
    sql: ${TABLE}.productCOGS ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: product_description {
    type: string
    sql: ${TABLE}.productDescription ;;
  }

  measure: product_dpp {
    type: number
    sql: ${TABLE}.productDPP ;;
  }

  measure: product_dppper_unit {
    type: number
    sql: ${TABLE}.productDPPPerUnit ;;
  }

  measure: product_dpprate {
    type: number
    sql: ${TABLE}.productDPPRate ;;
  }

  measure: product_labour_cost {
    type: number
    sql: ${TABLE}.productLabourCost ;;
  }

  measure: product_labour_cost_per_unit {
    type: number
    sql: ${TABLE}.productLabourCostPerUnit ;;
  }

  measure: product_margin_inc_funding {
    type: number
    sql: ${TABLE}.productMarginIncFunding ;;
  }

  measure: product_margin_rate {
    type: number
    sql: ${TABLE}.productMarginRate ;;
  }

  measure: product_net_sales {
    type: number
    sql: ${TABLE}.productNetSales ;;
  }

  dimension: product_subdepartment {
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  measure: product_tprate {
    type: number
    sql: ${TABLE}.productTPRate ;;
  }

  measure: product_trading_profit {
    type: number
    sql: ${TABLE}.productTradingProfit ;;
  }

  measure: product_trading_profit_per_unit {
    type: number
    sql: ${TABLE}.productTradingProfitPerUnit ;;
  }

  measure: product_transport_cost {
    type: number
    sql: ${TABLE}.productTransportCost ;;
  }

  measure: product_transport_cost_per_unit {
    type: number
    sql: ${TABLE}.productTransportCostPerUnit ;;
  }

  measure: product_units_sold {
    type: number
    sql: ${TABLE}.productUnitsSold ;;
  }

  dimension: sc_cost {
    type: string
    sql: ${TABLE}.SC_cost ;;
  }

  dimension: sc_matrix {
    type: string
    sql: ${TABLE}.sc_matrix ;;
  }

  dimension: sc_size {
    type: string
    sql: ${TABLE}.sc_size ;;
  }

  dimension: sc_usage {
    type: string
    sql: ${TABLE}.SC_usage ;;
  }

  measure: slt_rate {
    type: number
    sql: ${TABLE}.slt_rate ;;
  }

  measure: slts {
    type: number
    sql: ${TABLE}.slts ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.startDate ;;
  }

  dimension: transport_type_indicator {
    type: string
    sql: ${TABLE}.TransportTypeIndicator ;;
  }

  dimension: weight_g {
    type: number
    sql: ${TABLE}.weightG ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
