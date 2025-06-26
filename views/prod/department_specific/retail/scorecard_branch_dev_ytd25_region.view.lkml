include: "/views/**/transactions.view"
include: "/views/**/retail/**.view"
include: "/views/**/rm_visits.view"
include: "/views/**/training.view"

view: scorecard_branch_dev_ytd25_region {

  derived_table: {
    sql:
      SELECT
      *,
      row_number() over () as P_K,
      FROM `toolstation-data-storage.retailReporting.SC_25_YTD_DATA_FINAL_DEV`
      ;;
    datagroup_trigger: ts_daily_datagroup
  }

  dimension: month {
    type: string
    view_label: "Date"
    label: "Year Month (yyyymm)"
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: region_number {
    type: number
    sql:case when left(${siteUID},6)= "Region" then CAST(REGEXP_EXTRACT(${siteUID}, r'(\d+)') AS INT64) else null end
      ;;
      hidden: yes
  }

  dimension: P_K {
    type: number
    sql: ${TABLE}.P_K;;
    hidden: yes
    primary_key: yes
  }

  dimension: ltoPercent {group_label: "Measures" label: "LTO %" type:number value_format_name:percent_2 sql:${TABLE}.ltoPercent;;}
  dimension: trainingAvailable {group_label: "Measures" label: "Training Available" type:number value_format_name:decimal_1 sql:${TABLE}.trainingAvailable;;}
  dimension: trainingCompleted {group_label: "Measures" label: "Training Completed" type:number value_format_name:decimal_1 sql:${TABLE}.trainingCompleted;;}
  dimension: trainingPercentCompleted {group_label: "Measures" label: "Training % Completed" type:number value_format_name:decimal_1 sql:${TABLE}.trainingPercentCompleted;;}
  dimension: holidayMonthEntitlement {group_label: "Measures" label: "Holiday Month Entitlement" type:number value_format_name:decimal_1 sql:${TABLE}.holidayMonthEntitlement;;}
  dimension: holidayTaken {group_label: "Measures" label: "Holiday Taken" type:number value_format_name:decimal_1 sql:${TABLE}.holidayTaken;;}
  dimension: holidayTakenPercent {group_label: "Measures" label: "Holiday Taken %" type:number value_format_name:decimal_1 sql:${TABLE}.holidayTakenPercent;;}
  dimension: apprenticeship {group_label: "Measures" label: "Apprenticeship" type:number value_format_name:decimal_2 sql:${TABLE}.apprenticeship;;}
  dimension: safetyCompliance {group_label: "Measures" label: "Safety Compliance" type:number value_format_name:decimal_1 sql:${TABLE}.safetyCompliance;;}
  dimension: processCompPercent {group_label: "Measures" label: "Process Comp %" type:number value_format_name:percent_2 sql:${TABLE}.processCompPercent;;}
  dimension: orders {group_label: "Measures" label: "Orders" type:number value_format_name:decimal_1 sql:${TABLE}.orders;;}
  dimension: shrinkage {group_label: "Measures" label: "Shrinkage" type:number value_format_name:decimal_1 sql:${TABLE}.shrinkage;;}
  dimension: shrinkagePercent {group_label: "Measures" label: "Shrinkage %" type:number value_format_name:percent_2 sql:${TABLE}.shrinkagePercent;;}
  dimension: NPS {group_label: "Measures" label: "NPS" type:number value_format_name:decimal_1 sql:${TABLE}.NPS;;}
  dimension: anonOrders {group_label: "Measures" label: "Anon Orders" type:number value_format_name:decimal_1 sql:${TABLE}.anonOrders;;}
  dimension: totalOrders {group_label: "Measures" label: "Total Orders" type:number value_format_name:decimal_1 sql:${TABLE}.totalOrders;;}
  dimension: anonPercent {group_label: "Measures" label: "Anon %" type:number value_format_name:percent_2 sql:${TABLE}.anonPercent;;}
  dimension: anonBandingL {group_label: "Measures" label: "Anon Banding L" type:number value_format_name:decimal_1 sql:${TABLE}.anonBandingL;;}
  dimension: anonBandingM {group_label: "Measures" label: "Anon Banding M" type:number value_format_name:decimal_1 sql:${TABLE}.anonBandingM;;}
  dimension: anonBandingU {group_label: "Measures" label: "Anon Banding U" type:number value_format_name:decimal_1 sql:${TABLE}.anonBandingU;;}
  dimension: tyFrequency {group_label: "Measures" label: "Ty Frequency" type:number value_format_name:decimal_1 sql:${TABLE}.tyFrequency;;}
  dimension: pyFrequency {group_label: "Measures" label: "Py Frequency" type:number value_format_name:decimal_1 sql:${TABLE}.pyFrequency;;}
  dimension: yoyFrequency {group_label: "Measures" label: "YOY Frequency" type:number value_format_name:percent_2 sql:${TABLE}.yoyFrequency;;}
  dimension: netSales {group_label: "Measures" label: "Net Sales" type:number value_format_name:gbp_0 sql:${TABLE}.netSales;;}
  dimension: pyUnits {group_label: "Measures" label: "Py Units" type:number value_format_name:decimal_1 sql:${TABLE}.pyUnits;;}
  dimension: unitsExCC {group_label: "Measures"  type:number value_format_name:decimal_1 sql:${TABLE}.unitsExCC;;}
  dimension: ordersExCC {group_label: "Measures"  type:number value_format_name:decimal_1 sql:${TABLE}.ordersExCC;;}
  dimension: pyUnitsExCC {group_label: "Measures"  type:number value_format_name:decimal_1 sql:${TABLE}.pyUnitsExCC;;}
  dimension: pyOrdersExCC {group_label: "Measures"  type:number value_format_name:decimal_1 sql:${TABLE}.pyOrdersExCC;;}
  dimension: tyTradeSales {group_label: "Measures" label: "Ty Trade Sales" type:number value_format_name:gbp_0 sql:${TABLE}.tyTradeSales;;}
  dimension: pyTradeSales {group_label: "Measures" label: "Py Trade Sales" type:number value_format_name:gbp_0 sql:${TABLE}.pyTradeSales;;}
  dimension: yoyTradeSales {group_label: "Measures" label: "YOY Trade Sales" type:number value_format_name:gbp_0 sql:${TABLE}.yoyTradeSales;;}
  dimension: yoyUPT {group_label: "Measures" label: "YOY UPT" type:number value_format_name:decimal_1 sql:${TABLE}.yoyUPT;;}
  dimension: tySales {group_label: "Measures" label: "Ty Sales" type:number value_format_name:gbp_0 sql:${TABLE}.tySales;;}
  dimension: tyOrders {group_label: "Measures" label: "Ty Orders" type:number value_format_name:decimal_1 sql:${TABLE}.tyOrders;;}
  dimension: tyAOV {group_label: "Measures" label: "Ty AOV" type:number value_format_name:gbp sql:${TABLE}.tyAOV;;}
  dimension: pySales {group_label: "Measures" label: "Py Sales" type:number value_format_name:gbp_0 sql:${TABLE}.pySales;;}
  dimension: pyOrders {group_label: "Measures" label: "Py Orders" type:number value_format_name:decimal_1 sql:${TABLE}.pyOrders;;}
  dimension: actual_hours {group_label: "Measures" label: "Actual Hours" type:number value_format_name:decimal_1 sql:${TABLE}.actual_hours;;}
  dimension: aop_hours {group_label: "Measures" label: "AOP Hours" type:number value_format_name:decimal_1 sql:${TABLE}.aop_hours;;}
  dimension: hoursVsAOP {group_label: "Measures" label: "Hours Vs AOP" type:number value_format_name:decimal_1 sql:${TABLE}.hoursVsAOP;;}
  dimension: labourBudgetPercent {group_label: "Measures" label: "Labour Budget %" type:number value_format_name:percent_2 sql:${TABLE}.labourBudgetPercent;;}
  dimension: contributionVsBudget {group_label: "Measures" label: "Contribution vs Budget" type:number value_format_name:decimal_1 sql:${TABLE}.contributionVsBudget;;}
  dimension: AOP {group_label: "Measures" label: "AOP" type:number value_format_name:gbp_0 sql:${TABLE}.AOP;;}
  dimension: vsAOP {group_label: "Measures" label: "vs AOP" type:number value_format_name:decimal_1 sql:${TABLE}.vsAOP;;}
  dimension: EbitLTY {group_label: "Measures" label: "EbitL Ty" type:number value_format_name:gbp_0 sql:${TABLE}.EbitLTY;;}
  dimension: EbitLLY {group_label: "Measures" label: "EbitL Ly" type:number value_format_name:gbp_0 sql:${TABLE}.EbitLLY;;}
  dimension: tyEBIT {group_label: "Measures" label: "Ty EBIT" type:number value_format_name:gbp_0 sql:${TABLE}.tyEBIT;;}
  dimension: pyEBIT {group_label: "Measures" label: "Py EBIT" type:number value_format_name:gbp_0 sql:${TABLE}.pyEBIT;;}
  dimension: tsClubSales {group_label: "Measures" label: "TS Club Sales" type:number value_format_name:decimal_1 sql:${TABLE}.tsClubSales;;}
  dimension: tsClubSalesPercent {group_label: "Scores" label: "TS Club Sales %" type:number value_format_name:decimal_1 sql:${TABLE}.tsClubSalesPercent;;}
  dimension: ltoScore {group_label: "Scores" label: "LTO Score" type:number value_format_name:decimal_1 sql:${TABLE}.ltoScore;;}
  dimension: trainingScore {group_label: "Scores" label: "Training Score" type:number value_format_name:decimal_1 sql:${TABLE}.trainingScore;;}
  dimension: holidayScore {group_label: "Scores" label: "Holiday Score" type:number value_format_name:decimal_1 sql:${TABLE}.holidayScore;;}
  dimension: apprenticeshipScore {group_label: "Scores" label: "Apprenticeship Score" type:number value_format_name:decimal_1 sql:${TABLE}.apprenticeshipScore;;}
  dimension: safetyComplianceScore {group_label: "Scores" label: "Safety Compliance Score" type:number value_format_name:decimal_1 sql:${TABLE}.safetyComplianceScore;;}
  dimension: processCompScore {group_label: "Scores" label: "Process Compliance Score" type:number value_format_name:decimal_1 sql:${TABLE}.processCompScore;;}
  dimension: shrinkageScore {group_label: "Scores" label: "Shrinkage Score" type:number value_format_name:decimal_1 sql:${TABLE}.shrinkageScore;;}
  dimension: npsScore {group_label: "Scores" label: "NPS Score" type:number value_format_name:decimal_1 sql:${TABLE}.npsScore;;}
  dimension: anonScore {group_label: "Scores" label: "Anon Score" type:number value_format_name:decimal_1 sql:${TABLE}.anonScore;;}
  dimension: yoyFrequencyScore {group_label: "Scores" label: "YOY Frequency Score" type:number value_format_name:decimal_1 sql:${TABLE}.yoyFrequencyScore;;}
  dimension: yoyTradeSalesScore {group_label: "Scores" label: "YOY Trade Sales Score" type:number value_format_name:decimal_1 sql:${TABLE}.yoyTradeSalesScore;;}
  dimension: unitsPerTransactionScore {group_label: "Scores" label: "UPT Score" type:number value_format_name:decimal_1 sql:${TABLE}.unitsPerTransactionScore;;}
  dimension: labourBudgetScore {group_label: "Scores" label: "Labour Budget Score" type:number value_format_name:decimal_1 sql:${TABLE}.labourBudgetScore;;}
  dimension: tsClubScore {group_label: "Scores" label: "TS Club Score" type:number value_format_name:decimal_1 sql:${TABLE}.tsClubScore;;}
  dimension: contributionVsBudgetScore {group_label: "Scores" label: "Contribution vs Budget Score" type:number value_format_name:decimal_1 sql:${TABLE}.contributionVsBudgetScore;;}
  dimension: pillarRankColleague {group_label: "Rank" label: "Pillar Rank Colleague" type:number value_format_name:decimal_0 sql:${TABLE}.pillarRankColleague;;}
  dimension: pillarRankSimplicityEfficiency {group_label: "Rank" label: "Pillar Rank Simplicity Efficiency" type:number value_format_name:decimal_0 sql:${TABLE}.pillarRankSimplicityEfficiency;;}
  dimension: pillarRankCust {group_label: "Rank" label: "Pillar Rank Customer" type:number value_format_name:decimal_0 sql:${TABLE}.pillarRankCust;;}
  dimension: overallRank {group_label: "Rank" label: "Overall Rank" type:number value_format_name:decimal_0 sql:${TABLE}.overallRank;;}

  dimension: ty_EBIT_net_sales  {
    view_label: "P&L"
    group_label: "EBIT Region"
    label: "EBIT/Net Sales TY%"
    value_format_name: percent_2
    type: number
    sql: safe_divide(${tyEBIT},${netSales})  ;;
  }

  dimension: py_EBIT_net_sales  {
    view_label: "P&L"
    group_label: "EBIT Region"
    label: "EBIT/Net Sales PY%"
    value_format_name: percent_2
    type: number
    sql: safe_divide(${pyEBIT},${pySales})  ;;
  }

  dimension: vs_PY_EBIT  {
    view_label: "P&L"
    group_label: "EBIT Region"
    label: "vs EBIT PY"
    type: number
    sql: ${tyEBIT} - ${pyEBIT}  ;;
    value_format_name: gbp_0
  }

  dimension: var_PY_Net_Sales  {
    type: number
    view_label: "P&L"
    group_label: "EBIT Region"
    sql: ${netSales} - ${pySales}  ;;
    value_format_name: gbp_0
  }

  dimension: var_PY_Sales_Percent  {
    type: number
    view_label: "P&L"
    group_label: "EBIT Region"
    label: "Var PY Sales %"
    sql: safe_divide(${var_PY_Net_Sales},${pySales})  ;;
    value_format_name: percent_3
  }

}
