include: "/views/**/transactions.view"
include: "/views/**/retail/**.view"
include: "/views/**/rm_visits.view"
include: "/views/**/training.view"

view: scorecard_branch_dev_ytd25 {

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

  dimension: P_K {
    type: number
    sql: ${TABLE}.P_K;;
    hidden: yes
    primary_key: yes
  }

  measure: siteUID_count {
    # required_access_grants: [lz_only]
    type: count_distinct
    sql: ${siteUID} ;;
    label: "Number of Sites"
    group_label: "Measures"
  }



  dimension: ltoPercent_dim {group_label: "Measures" label: "LTO %" type:number value_format_name:percent_2 sql:${TABLE}.ltoPercent;;hidden:yes}
  dimension: trainingAvailable_dim {group_label: "Measures" label: "Training Available" type:number value_format_name:decimal_1 sql:${TABLE}.trainingAvailable;;hidden:yes}
  dimension: trainingCompleted_dim {group_label: "Measures" label: "Training Completed" type:number value_format_name:decimal_1 sql:${TABLE}.trainingCompleted;;hidden:yes}
  dimension: trainingPercentCompleted_dim {group_label: "Measures" label: "Training % Completed" type:number value_format_name:decimal_1 sql:${TABLE}.trainingPercentCompleted;;hidden:yes}
  dimension: holidayMonthEntitlement_dim {group_label: "Measures" label: "Holiday Month Entitlement" type:number value_format_name:decimal_1 sql:${TABLE}.holidayMonthEntitlement;;hidden:yes}
  dimension: holidayTaken_dim {group_label: "Measures" label: "Holiday Taken" type:number value_format_name:decimal_1 sql:${TABLE}.holidayTaken;;hidden:yes}
  dimension: holidayTakenPercent_dim {group_label: "Measures" label: "Holiday Taken %" type:number value_format_name:decimal_1 sql:${TABLE}.holidayTakenPercent;;hidden:yes}
  dimension: apprenticeship_dim {group_label: "Measures" label: "Apprenticeship" type:number value_format_name:decimal_2 sql:${TABLE}.apprenticeship;;hidden:yes}
  dimension: safetyCompliance_dim {group_label: "Measures" label: "Safety Compliance" type:number value_format_name:decimal_1 sql:${TABLE}.safetyCompliance;;hidden:yes}
  dimension: processCompPercent_dim {group_label: "Measures" label: "Process Comp %" type:number value_format_name:percent_2 sql:${TABLE}.processCompPercent;;hidden:yes}
  dimension: orders_dim {group_label: "Measures" label: "Orders" type:number value_format_name:decimal_1 sql:${TABLE}.orders;;hidden:yes}
  dimension: shrinkage_dim {group_label: "Measures" label: "Shrinkage" type:number value_format_name:decimal_1 sql:${TABLE}.shrinkage;;hidden:yes}
  dimension: shrinkagePercent_dim {group_label: "Measures" label: "Shrinkage %" type:number value_format_name:percent_2 sql:${TABLE}.shrinkagePercent;;hidden:yes}
  dimension: NPS_dim {group_label: "Measures" label: "NPS" type:number value_format_name:decimal_1 sql:${TABLE}.NPS;;hidden:yes}
  dimension: anonOrders_dim {group_label: "Measures" label: "Anon Orders" type:number value_format_name:decimal_1 sql:${TABLE}.anonOrders;;hidden:yes}
  dimension: totalOrders_dim {group_label: "Measures" label: "Total Orders" type:number value_format_name:decimal_1 sql:${TABLE}.totalOrders;;hidden:yes}
  dimension: anonPercent_dim {group_label: "Measures" label: "Anon %" type:number value_format_name:percent_2 sql:${TABLE}.anonPercent;;hidden:yes}
  dimension: anonBandingL_dim {group_label: "Measures" label: "Anon Banding L" type:number value_format_name:decimal_1 sql:${TABLE}.anonBandingL;;hidden:yes}
  dimension: anonBandingM_dim {group_label: "Measures" label: "Anon Banding M" type:number value_format_name:decimal_1 sql:${TABLE}.anonBandingM;;hidden:yes}
  dimension: anonBandingU_dim {group_label: "Measures" label: "Anon Banding U" type:number value_format_name:decimal_1 sql:${TABLE}.anonBandingU;;hidden:yes}
  dimension: tyFrequency_dim {group_label: "Measures" label: "Ty Frequency" type:number value_format_name:decimal_1 sql:${TABLE}.tyFrequency;;hidden:yes}
  dimension: pyFrequency_dim {group_label: "Measures" label: "Py Frequency" type:number value_format_name:decimal_1 sql:${TABLE}.pyFrequency;;hidden:yes}
  dimension: yoyFrequency_dim {group_label: "Measures" label: "YOY Frequency" type:number value_format_name:percent_2 sql:${TABLE}.yoyFrequency;;hidden:yes}
  dimension: netSales_dim {group_label: "Measures" label: "Net Sales" type:number value_format_name:gbp_0 sql:${TABLE}.netSales;;hidden:yes}
  dimension: pyUnits_dim {group_label: "Measures" label: "Py Units" type:number value_format_name:decimal_1 sql:${TABLE}.pyUnits;;hidden:yes}
  dimension: unitsExCC_dim {group_label: "Measures"  type:number value_format_name:decimal_1 sql:${TABLE}.unitsExCC;;hidden:yes}
  dimension: ordersExCC_dim {group_label: "Measures"  type:number value_format_name:decimal_1 sql:${TABLE}.ordersExCC;;hidden:yes}
  dimension: pyUnitsExCC_dim {group_label: "Measures"  type:number value_format_name:decimal_1 sql:${TABLE}.pyUnitsExCC;;hidden:yes}
  dimension: pyOrdersExCC_dim {group_label: "Measures"  type:number value_format_name:decimal_1 sql:${TABLE}.pyOrdersExCC;;hidden:yes}
  dimension: tyTradeSales_dim {group_label: "Measures" label: "Ty Trade Sales" type:number value_format_name:gbp_0 sql:${TABLE}.tyTradeSales;;hidden:yes}
  dimension: pyTradeSales_dim {group_label: "Measures" label: "Py Trade Sales" type:number value_format_name:gbp_0 sql:${TABLE}.pyTradeSales;;hidden:yes}
  dimension: yoyTradeSales_dim {group_label: "Measures" label: "YOY Trade Sales" type:number value_format_name:gbp_0 sql:${TABLE}.yoyTradeSales;;hidden:yes}
  dimension: yoyUPT_dim {group_label: "Measures" label: "YOY UPT" type:number value_format_name:decimal_1 sql:${TABLE}.yoyUPT;;hidden:yes}
  dimension: tySales_dim {group_label: "Measures" label: "Ty Sales" type:number value_format_name:gbp_0 sql:${TABLE}.tySales;;hidden:yes}
  dimension: tyOrders_dim {group_label: "Measures" label: "Ty Orders" type:number value_format_name:decimal_1 sql:${TABLE}.tyOrders;;hidden:yes}
  dimension: tyAOV_dim {group_label: "Measures" label: "Ty AOV" type:number value_format_name:gbp sql:${TABLE}.tyAOV;;hidden:yes}
  dimension: pySales_dim {group_label: "Measures" label: "Py Sales" type:number value_format_name:gbp_0 sql:${TABLE}.pySales;;hidden:yes}
  dimension: pyOrders_dim {group_label: "Measures" label: "Py Orders" type:number value_format_name:decimal_1 sql:${TABLE}.pyOrders;;hidden:yes}
  dimension: actual_hours_dim {group_label: "Measures" label: "Actual Hours" type:number value_format_name:decimal_1 sql:${TABLE}.actual_hours;;hidden:yes}
  dimension: aop_hours_dim {group_label: "Measures" label: "AOP Hours" type:number value_format_name:decimal_1 sql:${TABLE}.aop_hours;;hidden:yes}
  dimension: hoursVsAOP_dim {group_label: "Measures" label: "Hours Vs AOP" type:number value_format_name:decimal_1 sql:${TABLE}.hoursVsAOP;;hidden:yes}
  dimension: labourBudgetPercent_dim {group_label: "Measures" label: "Labour Budget %" type:number value_format_name:percent_2 sql:${TABLE}.labourBudgetPercent;;hidden:yes}
  dimension: contributionVsBudget_dim {group_label: "Measures" label: "Contribution vs Budget" type:number value_format_name:decimal_1 sql:${TABLE}.contributionVsBudget;;hidden:yes}
  dimension: AOP_dim {group_label: "Measures" label: "AOP" type:number value_format_name:gbp_0 sql:${TABLE}.AOP;;hidden:yes}
  dimension: vsAOP_dim {group_label: "Measures" label: "vs AOP" type:number value_format_name:decimal_1 sql:${TABLE}.vsAOP;;hidden:yes}
  dimension: EbitLTY_dim {group_label: "Measures" label: "EbitL Ty" type:number value_format_name:gbp_0 sql:${TABLE}.EbitLTY;;hidden:yes}
  dimension: EbitLLY_dim {group_label: "Measures" label: "EbitL Ly" type:number value_format_name:gbp_0 sql:${TABLE}.EbitLLY;;hidden:yes}
  dimension: tyEBIT_dim {group_label: "Measures" label: "Ty EBIT" type:number value_format_name:gbp_0 sql:${TABLE}.tyEBIT;;hidden:yes}
  dimension: pyEBIT_dim {group_label: "Measures" label: "Py EBIT" type:number value_format_name:gbp_0 sql:${TABLE}.pyEBIT;;hidden:yes}
  dimension: tsClubSales_dim {group_label: "Measures" label: "TS Club Sales" type:number value_format_name:decimal_1 sql:${TABLE}.tsClubSales;;hidden:yes}
  dimension: tsClubSalesPercent_dim {group_label: "Scores" label: "TS Club Sales %" type:number value_format_name:decimal_1 sql:${TABLE}.tsClubSalesPercent;;hidden:yes}
  dimension: ltoScore_dim {group_label: "Scores" label: "LTO Score" type:number value_format_name:decimal_1 sql:${TABLE}.ltoScore;;hidden:yes}
  dimension: trainingScore_dim {group_label: "Scores" label: "Training Score" type:number value_format_name:decimal_1 sql:${TABLE}.trainingScore;;hidden:yes}
  dimension: holidayScore_dim {group_label: "Scores" label: "Holiday Score" type:number value_format_name:decimal_1 sql:${TABLE}.holidayScore;;hidden:yes}
  dimension: apprenticeshipScore_dim {group_label: "Scores" label: "Apprenticeship Score" type:number value_format_name:decimal_1 sql:${TABLE}.apprenticeshipScore;;hidden:yes}
  dimension: safetyComplianceScore_dim {group_label: "Scores" label: "Safety Compliance Score" type:number value_format_name:decimal_1 sql:${TABLE}.safetyComplianceScore;;hidden:yes}
  dimension: processCompScore_dim {group_label: "Scores" label: "Process Compliance Score" type:number value_format_name:decimal_1 sql:${TABLE}.processCompScore;;hidden:yes}
  dimension: shrinkageScore_dim {group_label: "Scores" label: "Shrinkage Score" type:number value_format_name:decimal_1 sql:${TABLE}.shrinkageScore;;hidden:yes}
  dimension: npsScore_dim {group_label: "Scores" label: "NPS Score" type:number value_format_name:decimal_1 sql:${TABLE}.npsScore;;hidden:yes}
  dimension: anonScore_dim {group_label: "Scores" label: "Anon Score" type:number value_format_name:decimal_1 sql:${TABLE}.anonScore;;hidden:yes}
  dimension: yoyFrequencyScore_dim {group_label: "Scores" label: "YOY Frequency Score" type:number value_format_name:decimal_1 sql:${TABLE}.yoyFrequencyScore;;hidden:yes}
  dimension: yoyTradeSalesScore_dim {group_label: "Scores" label: "YOY Trade Sales Score" type:number value_format_name:decimal_1 sql:${TABLE}.yoyTradeSalesScore;;hidden:yes}
  dimension: unitsPerTransactionScore_dim {group_label: "Scores" label: "UPT Score" type:number value_format_name:decimal_1 sql:${TABLE}.unitsPerTransactionScore;;hidden:yes}
  dimension: labourBudgetScore_dim {group_label: "Scores" label: "Labour Budget Score" type:number value_format_name:decimal_1 sql:${TABLE}.labourBudgetScore;;hidden:yes}
  dimension: tsClubScore_dim {group_label: "Scores" label: "TS Club Score" type:number value_format_name:decimal_1 sql:${TABLE}.tsClubScore;;hidden:yes}
  dimension: contributionVsBudgetScore_dim {group_label: "Ranking" label: "Contribution vs Budget Score" type:number value_format_name:decimal_1 sql:${TABLE}.contributionVsBudgetScore;;hidden:yes}
  dimension: pillarTotalColleague_dim {group_label: "Ranking" label: "Pillar Total Colleague" type:number value_format_name:decimal_1 sql:${TABLE}.pillarTotalColleague;;hidden:yes}
  dimension: pillarTotalSimplicityEfficiency_dim {group_label: "Ranking" label: "Pillar Total Simplicity Efficiency" type:number value_format_name:decimal_1 sql:${TABLE}.pillarTotalSimplicityEfficiency;;hidden:yes}
  dimension: pillarTotalCust_dim {group_label: "Ranking" label: "Pillar Total Customer" type:number value_format_name:decimal_1 sql:${TABLE}.pillarTotalCust;;hidden:yes}
  dimension: pillarTotalOverall_dim {group_label: "Ranking" label: "Pillar Total Overall" type:number value_format_name:decimal_1 sql:${TABLE}.pillarTotalOverall;;hidden:yes}
  dimension: pillarRankColleague_dim {group_label: "Ranking" label: "Pillar Rank Colleague" type:number value_format_name:decimal_0 sql:${TABLE}.pillarRankColleague;;hidden:yes}
  dimension: pillarRankSimplicityEfficiency_dim {group_label: "Ranking" label: "Pillar Rank Simplicity Efficiency" type:number value_format_name:decimal_0 sql:${TABLE}.pillarRankSimplicityEfficiency;;hidden:yes}
  dimension: pillarRankCust_dim {group_label: "Ranking" label: "Pillar Rank Customer" type:number value_format_name:decimal_0 sql:${TABLE}.pillarRankCust;;hidden:yes}
  dimension: overallRank_dim {group_label: "Ranking" label: "Overall Rank" type:number value_format_name:decimal_1 sql:${TABLE}.overallRank;;hidden:yes}
  dimension: ColleagueRag_dim {group_label: "Ranking" label: "Colleague Rag" type:number value_format_name:decimal_0 sql:${TABLE}.ColleagueRag;;hidden:yes}
  dimension: SimplicityEfficiencyRag_dim {group_label: "Ranking" label: "Simplicity Efficiency Rag" type:number value_format_name:decimal_0 sql:${TABLE}.SimplicityEfficiencyRag;;hidden:yes}
  dimension: CustRag_dim {group_label: "Ranking" label: "Customer Rag" type:number value_format_name:decimal_0 sql:${TABLE}.CustRag;;hidden:yes}
  dimension: OverallRag_dim {group_label: "Ranking" label: "Overall Rag" type:number value_format_name:decimal_0 sql:${TABLE}.OverallRag;;hidden:yes}

  measure: ltoPercent {group_label: "Measures" label: "LTO %" type: average value_format_name:percent_2 sql:${ltoPercent_dim};;}
  measure: trainingAvailable {group_label: "Measures" label: "Training Available" type: average value_format_name:decimal_1 sql:${trainingAvailable_dim};;}
  measure: trainingCompleted {group_label: "Measures" label: "Training Completed" type: average value_format_name:decimal_1 sql:${trainingCompleted_dim};;}
  measure: trainingPercentCompleted {group_label: "Measures" label: "Training Completed % " type: average value_format_name:percent_2 sql:${trainingPercentCompleted_dim};;}
  measure: holidayMonthEntitlement {group_label: "Measures" label: "Holiday Month Entitlement" type: average value_format_name:decimal_1 sql:${holidayMonthEntitlement_dim};;}
  measure: holidayTaken {group_label: "Measures" label: "Holiday Taken" type: average value_format_name:decimal_1 sql:${holidayTaken_dim};;}
  measure: holidayTakenPercent {group_label: "Measures" label: "Holiday Taken %" type: average value_format_name:percent_2 sql:${holidayTakenPercent_dim};;}
  measure: apprenticeship {group_label: "Measures" label: "Number of Apprenticeship" type: average value_format_name:decimal_2 sql:${apprenticeship_dim};;}
  measure: safetyCompliance {group_label: "Measures" label: "Safety Compliance" type: average value_format_name:percent_2 sql:${safetyCompliance_dim};;}
  measure: processCompPercent {group_label: "Measures" label: "Process Compliance %" type: average value_format_name:percent_2 sql:${processCompPercent_dim};;}
  measure: orders {group_label: "Measures" label: "Orders" type: average value_format_name:decimal_1 sql:${orders_dim};;}
  measure: shrinkage {group_label: "Measures" label: "Shrinkage" type: average value_format_name:decimal_1 sql:${shrinkage_dim};;}
  measure: shrinkagePercent {group_label: "Measures" label: "Shrinkage %" type: average value_format_name:percent_2 sql:${shrinkagePercent_dim};;}
  measure: NPS {group_label: "Measures" label: "NPS" type: average value_format_name:decimal_1 sql:${NPS_dim};;}
  measure: anonOrders {group_label: "Measures" label: "Anon Orders" type: average value_format_name:decimal_1 sql:${anonOrders_dim};;}
  measure: totalOrders {group_label: "Measures" label: "Total Orders" type: average value_format_name:decimal_1 sql:${totalOrders_dim};;}
  measure: anonPercent {group_label: "Measures" label: "Anonymous %" type: average value_format_name:percent_2 sql:${anonPercent_dim};;}
  measure: anonBandingL {group_label: "Measures" label: "Anon Banding L" type: average value_format_name:decimal_1 sql:${anonBandingL_dim};;}
  measure: anonBandingM {group_label: "Measures" label: "Anon Banding M" type: average value_format_name:decimal_1 sql:${anonBandingM_dim};;}
  measure: anonBandingU {group_label: "Measures" label: "Anon Banding U" type: average value_format_name:decimal_1 sql:${anonBandingU_dim};;}
  measure: tyFrequency {group_label: "Measures" label: "Ty Frequency" type: average value_format_name:decimal_1 sql:${tyFrequency_dim};;}
  measure: pyFrequency {group_label: "Measures" label: "Py Frequency" type: average value_format_name:decimal_1 sql:${pyFrequency_dim};;}
  measure: yoyFrequency {group_label: "Measures" label: "Frequency" type: average value_format_name:percent_2 sql:${yoyFrequency_dim};;}
  measure: netSales {group_label: "Measures" label: "Net Sales" type: average value_format_name:gbp_0 sql:${netSales_dim};;}
  measure: pyUnits {group_label: "Measures" label: "Py Units" type: average value_format_name:decimal_1 sql:${pyUnits_dim};;}
  measure: unitsExCC {group_label: "Measures"  type: average value_format_name:decimal_1 sql:${unitsExCC_dim};;}
  measure: ordersExCC {group_label: "Measures"  type: average value_format_name:decimal_1 sql:${ordersExCC_dim};;}
  measure: pyUnitsExCC {group_label: "Measures"  type: average value_format_name:decimal_1 sql:${pyUnitsExCC_dim};;}
  measure: pyOrdersExCC {group_label: "Measures"  type: average value_format_name:decimal_1 sql:${pyOrdersExCC_dim};;}
  measure: tyTradeSales {group_label: "Measures" label: "Ty Trade Sales" type: average value_format_name:gbp_0 sql:${tyTradeSales_dim};;}
  measure: pyTradeSales {group_label: "Measures" label: "Py Trade Sales" type: average value_format_name:gbp_0 sql:${pyTradeSales_dim};;}
  measure: yoyTradeSales {group_label: "Measures" label: "Trade Sales YOY " type: average value_format_name:percent_2 sql:${yoyTradeSales_dim};;}
  measure: yoyUPT {group_label: "Measures" label: "UPT" type: average value_format_name:percent_2 sql:${yoyUPT_dim};;}
  measure: tySales {group_label: "Measures" label: "Ty Sales" type: average value_format_name:gbp_0 sql:${tySales_dim};;}
  measure: tyOrders {group_label: "Measures" label: "Ty Orders" type: average value_format_name:decimal_1 sql:${tyOrders_dim};;}
  measure: tyAOV {group_label: "Measures" label: "Ty AOV" type: average value_format_name:gbp sql:${tyAOV_dim};;}
  measure: pySales {group_label: "Measures" label: "Py Sales" type: average value_format_name:gbp_0 sql:${pySales_dim};;}
  measure: pyOrders {group_label: "Measures" label: "Py Orders" type: average value_format_name:decimal_1 sql:${pyOrders_dim};;}
  measure: actual_hours {group_label: "Measures" label: "Actual Hours" type: average value_format_name:decimal_1 sql:${actual_hours_dim};;}
  measure: aop_hours {group_label: "Measures" label: "AOP Hours" type: average value_format_name:decimal_1 sql:${aop_hours_dim};;}
  measure: hoursVsAOP {group_label: "Measures" label: "Hours Vs AOP" type: average value_format_name:decimal_1 sql:${hoursVsAOP_dim};;}
  measure: labourBudgetPercent {group_label: "Measures" label: "Labour Hour vs Budget %" type: average value_format_name:percent_2 sql:${labourBudgetPercent_dim};;}
  measure: contributionVsBudget {group_label: "Measures" label: "Contribution vs Budget" type: average value_format_name:percent_2 sql:${contributionVsBudget_dim};;}
  measure: AOP {group_label: "Measures" label: "AOP" type: average value_format_name:gbp_0 sql:${AOP_dim};;}
  measure: vsAOP {group_label: "Measures" label: "vs AOP" type: average value_format_name:decimal_1 sql:${vsAOP_dim};;}
  measure: EbitLTY {group_label: "Measures" label: "EbitL Ty" type: average value_format_name:gbp_0 sql:${EbitLTY_dim};;}
  measure: EbitLLY {group_label: "Measures" label: "EbitL Ly" type: average value_format_name:gbp_0 sql:${EbitLLY_dim};;}
  measure: tyEBIT {group_label: "Measures" label: "Ty EBIT" type: average value_format_name:gbp_0 sql:${tyEBIT_dim};;}
  measure: pyEBIT {group_label: "Measures" label: "Py EBIT" type: average value_format_name:gbp_0 sql:${pyEBIT_dim};;}
  measure: tsClubSales {group_label: "Measures" label: "TS Club Sales" type: average value_format_name:gbp sql:${tsClubSales_dim};;}
  measure: tsClubSalesPercent {group_label: "Scores" label: "TS Club Sales %" type: average value_format_name:percent_2 sql:${tsClubSalesPercent_dim};;}
  measure: ltoScore {group_label: "Scores" label: "LTO Score" type: average value_format_name:decimal_1 sql:${ltoScore_dim};;}
  measure: trainingScore {group_label: "Scores" label: "Training Score" type: average value_format_name:decimal_1 sql:${trainingScore_dim};;}
  measure: holidayScore {group_label: "Scores" label: "Holiday Score" type: average value_format_name:decimal_1 sql:${holidayScore_dim};;}
  measure: apprenticeshipScore {group_label: "Scores" label: "Apprenticeship Score" type: average value_format_name:decimal_1 sql:${apprenticeshipScore_dim};;}
  measure: safetyComplianceScore {group_label: "Scores" label: "Safety Compliance Score" type: average value_format_name:decimal_1 sql:${safetyComplianceScore_dim};;}
  measure: processCompScore {group_label: "Scores" label: "Process Compliance Score" type: average value_format_name:decimal_1 sql:${processCompScore_dim};;}
  measure: shrinkageScore {group_label: "Scores" label: "Shrinkage Score" type: average value_format_name:decimal_1 sql:${shrinkageScore_dim};;}
  measure: npsScore {group_label: "Scores" label: "NPS Score" type: average value_format_name:decimal_1 sql:${npsScore_dim};;}
  measure: anonScore {group_label: "Scores" label: "Anon Score" type: average value_format_name:decimal_1 sql:${anonScore_dim};;}
  measure: yoyFrequencyScore {group_label: "Scores" label: "YOY Frequency Score" type: average value_format_name:decimal_1 sql:${yoyFrequencyScore_dim};;}
  measure: yoyTradeSalesScore {group_label: "Scores" label: "YOY Trade Sales Score" type: average value_format_name:decimal_1 sql:${yoyTradeSalesScore_dim};;}
  measure: unitsPerTransactionScore {group_label: "Scores" label: "UPT Score" type: average value_format_name:decimal_1 sql:${unitsPerTransactionScore_dim};;}
  measure: labourBudgetScore {group_label: "Scores" label: "Labour Budget Score" type: average value_format_name:decimal_1 sql:${labourBudgetScore_dim};;}
  measure: tsClubScore {group_label: "Scores" label: "TS Club Score" type: average value_format_name:decimal_1 sql:${tsClubScore_dim};;}
  measure: contributionVsBudgetScore {group_label: "Ranking" label: "Contribution vs Budget Score" type: average value_format_name:decimal_1 sql:${contributionVsBudgetScore_dim};;}
  measure: pillarTotalColleague {group_label: "Ranking" label: "Pillar Total Colleague" type: average value_format_name:decimal_1 sql:${pillarTotalColleague_dim};;}
  measure: pillarTotalSimplicityEfficiency {group_label: "Ranking" label: "Pillar Total Simplicity Efficiency" type: average value_format_name:decimal_1 sql:${pillarTotalSimplicityEfficiency_dim};;}
  measure: pillarTotalCust {group_label: "Ranking" label: "Pillar Total Customer" type: average value_format_name:decimal_1 sql:${pillarTotalCust_dim};;}
  measure: pillarTotalOverall {group_label: "Ranking" label: "Pillar Total Overall" type: average value_format_name:decimal_1 sql:${pillarTotalOverall_dim};;}
  measure: pillarRankColleague {group_label: "Ranking" label: "Pillar Rank Colleague" type: average value_format_name:decimal_0 sql:${pillarRankColleague_dim};;}
  measure: pillarRankSimplicityEfficiency {group_label: "Ranking" label: "Pillar Rank Simplicity Efficiency" type: average value_format_name:decimal_0 sql:${pillarRankSimplicityEfficiency_dim};;}
  measure: pillarRankCust {group_label: "Ranking" label: "Pillar Rank Customer" type: average value_format_name:decimal_0 sql:${pillarRankCust_dim};;}
  measure: overallRank {group_label: "Ranking" label: "Overall Rank" type: average value_format_name:decimal_1 sql:${overallRank_dim};;}
  measure: ColleagueRag {group_label: "Ranking" label: "Colleague Rag" type: average value_format_name:decimal_0 sql:${ColleagueRag_dim};;}
  measure: SimplicityEfficiencyRag {group_label: "Ranking" label: "Simplicity Efficiency Rag" type: average value_format_name:decimal_0 sql:${SimplicityEfficiencyRag_dim};;}
  measure: CustRag {group_label: "Ranking" label: "Customer Rag" type: average value_format_name:decimal_0 sql:${CustRag_dim};;}
  measure: OverallRag {group_label: "Ranking" label: "Overall Rag" type: average value_format_name:decimal_0 sql:${OverallRag_dim};;}

  measure: ty_EBIT_net_sales  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "EBIT/Net Sales TY%"
    value_format_name: percent_2
    type: number
    sql: safe_divide(${tyEBIT},${netSales})  ;;
  }

  measure: py_EBIT_net_sales  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "EBIT/Net Sales PY%"
    value_format_name: percent_2
    type: number
    sql: safe_divide(${pyEBIT},${pySales})  ;;
  }

  measure: vs_PY_EBIT  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "vs EBIT PY"
    type: number
    sql: ${tyEBIT} - ${pyEBIT}  ;;
    value_format_name: gbp_0
  }

  measure: var_PY_Net_Sales  {
    type: number
    view_label: "P&L"
    group_label: "EBIT"
    sql: ${netSales} - ${pySales}  ;;
    value_format_name: gbp_0
  }

  measure: var_PY_Sales_Percent  {
    type: number
    view_label: "P&L"
    group_label: "EBIT"
    sql: safe_divide(${var_PY_Net_Sales},${netSales})  ;;
    value_format_name: percent_2
  }

  # # --Tiers---------------------------
 dimension: ltoPercent_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${ltoPercent_dim};;}

  dimension: trainingAvailable_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${trainingAvailable_dim};;}
  dimension: trainingCompleted_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${trainingCompleted_dim};;}
  dimension: trainingPercentCompleted_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${trainingPercentCompleted_dim};;}
  dimension: holidayMonthEntitlement_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${holidayMonthEntitlement_dim};;}
  dimension: holidayTaken_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${holidayTaken_dim};;}
  dimension: holidayTakenPercent_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${holidayTakenPercent_dim};;}
  dimension: apprenticeship_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${apprenticeship_dim};;}
  dimension: safetyCompliance_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${safetyCompliance_dim};;}
  dimension: processCompPercent_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${processCompPercent_dim};;}
  dimension: orders_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${orders_dim};;}
  dimension: shrinkage_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${shrinkage_dim};;}
  dimension: shrinkagePercent_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${shrinkagePercent_dim};;}
  dimension: NPS_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${NPS_dim};;}
  dimension: anonOrders_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonOrders_dim};;}
  dimension: totalOrders_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${totalOrders_dim};;}
  dimension: anonPercent_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonPercent_dim};;}
  dimension: anonBandingL_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonBandingL_dim};;}
  dimension: anonBandingM_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonBandingM_dim};;}
  dimension: anonBandingU_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonBandingU_dim};;}
  dimension: tyFrequency_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyFrequency_dim};;}
  dimension: pyFrequency_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyFrequency_dim};;}
  dimension: yoyFrequency_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyFrequency_dim};;}
  dimension: netSales_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${netSales_dim};;}
  dimension: pyUnits_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyUnits_dim};;}
  dimension: unitsExCC_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${unitsExCC_dim};;}
  dimension: ordersExCC_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${ordersExCC_dim};;}
  dimension: pyUnitsExCC_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyUnitsExCC_dim};;}
  dimension: pyOrdersExCC_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyOrdersExCC_dim};;}
  dimension: tyTradeSales_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyTradeSales_dim};;}
  dimension: pyTradeSales_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyTradeSales_dim};;}
  dimension: yoyTradeSales_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyTradeSales_dim};;}
  dimension: yoyUPT_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyUPT_dim};;}
  dimension: tySales_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tySales_dim};;}
  dimension: tyOrders_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyOrders_dim};;}
  dimension: tyAOV_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyAOV_dim};;}
  dimension: pySales_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pySales_dim};;}
  dimension: pyOrders_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyOrders_dim};;}
  dimension: actual_hours_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${actual_hours_dim};;}
  dimension: aop_hours_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${aop_hours_dim};;}
  dimension: hoursVsAOP_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${hoursVsAOP_dim};;}
  dimension: labourBudgetPercent_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${labourBudgetPercent_dim};;}
  dimension: contributionVsBudget_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${contributionVsBudget_dim};;}
  dimension: AOP_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${AOP_dim};;}
  dimension: vsAOP_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${vsAOP_dim};;}
  dimension: EbitLTY_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${EbitLTY_dim};;}
  dimension: EbitLLY_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${EbitLLY_dim};;}
  dimension: tyEBIT_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyEBIT_dim};;}
  dimension: pyEBIT_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyEBIT_dim};;}
  dimension: tsClubSales_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tsClubSales_dim};;}
  dimension: tsClubSalesPercent_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tsClubSalesPercent_dim};;}
  dimension: ltoScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${ltoScore_dim};;}
  dimension: trainingScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${trainingScore_dim};;}
  dimension: holidayScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${holidayScore_dim};;}
  dimension: apprenticeshipScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${apprenticeshipScore_dim};;}
  dimension: safetyComplianceScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${safetyComplianceScore_dim};;}
  dimension: processCompScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${processCompScore_dim};;}
  dimension: shrinkageScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${shrinkageScore_dim};;}
  dimension: npsScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${npsScore_dim};;}
  dimension: anonScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonScore_dim};;}
  dimension: yoyFrequencyScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyFrequencyScore_dim};;}
  dimension: yoyTradeSalesScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyTradeSalesScore_dim};;}
  dimension: unitsPerTransactionScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${unitsPerTransactionScore_dim};;}
  dimension: labourBudgetScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${labourBudgetScore_dim};;}
  dimension: tsClubScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tsClubScore_dim};;}
  dimension: contributionVsBudgetScore_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${contributionVsBudgetScore_dim};;}
  dimension: pillarTotalColleague_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pillarTotalColleague_dim};;}
  dimension: pillarTotalSimplicityEfficiency_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pillarTotalSimplicityEfficiency_dim};;}
  dimension: pillarTotalCust_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pillarTotalCust_dim};;}
  dimension: pillarTotalOverall_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pillarTotalOverall_dim};;}
  dimension: pillarRankColleague_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pillarRankColleague_dim};;}
  dimension: pillarRankSimplicityEfficiency_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pillarRankSimplicityEfficiency_dim};;}
  dimension: pillarRankCust_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pillarRankCust_dim};;}
  dimension: overallRank_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${overallRank_dim};;}
  dimension: ColleagueRag_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${ColleagueRag_dim};;}
  dimension: SimplicityEfficiencyRag_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${SimplicityEfficiencyRag_dim};;}
  dimension: CustRag_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${CustRag_dim};;}
  dimension: OverallRag_tier {group_label:"testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${OverallRag_dim};;}

  # # --Error Flags----------------------
   dimension: ltoPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${ltoPercent_dim} is null) then 1 else 0 end;;}
  dimension: trainingAvailable_error_flag {group_label:"Error Flags" type:number sql:case when (${trainingAvailable_dim} is null) then 1 else 0 end;;}
  dimension: trainingCompleted_error_flag {group_label:"Error Flags" type:number sql:case when (${trainingCompleted_dim} is null) then 1 else 0 end;;}
  dimension: trainingPercentCompleted_error_flag {group_label:"Error Flags" type:number sql:case when (${trainingPercentCompleted_dim} is null) then 1 else 0 end;;}
  dimension: holidayMonthEntitlement_error_flag {group_label:"Error Flags" type:number sql:case when (${holidayMonthEntitlement_dim} is null) then 1 else 0 end;;}
  dimension: holidayTaken_error_flag {group_label:"Error Flags" type:number sql:case when (${holidayTaken_dim} is null) then 1 else 0 end;;}
  dimension: holidayTakenPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${holidayTakenPercent_dim} is null) then 1 else 0 end;;}
  dimension: apprenticeship_error_flag {group_label:"Error Flags" type:number sql:case when (${apprenticeship_dim} is null) then 1 else 0 end;;}
  dimension: safetyCompliance_error_flag {group_label:"Error Flags" type:number sql:case when (${safetyCompliance_dim} is null) then 1 else 0 end;;}
  dimension: processCompPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${processCompPercent_dim} is null) then 1 else 0 end;;}
  dimension: orders_error_flag {group_label:"Error Flags" type:number sql:case when (${orders_dim} is null) then 1 else 0 end;;}
  dimension: shrinkage_error_flag {group_label:"Error Flags" type:number sql:case when (${shrinkage_dim} is null) then 1 else 0 end;;}
  dimension: shrinkagePercent_error_flag {group_label:"Error Flags" type:number sql:case when (${shrinkagePercent_dim} is null) then 1 else 0 end;;}
  dimension: NPS_error_flag {group_label:"Error Flags" type:number sql:case when (${NPS_dim} is null) then 1 else 0 end;;}
  dimension: anonOrders_error_flag {group_label:"Error Flags" type:number sql:case when (${anonOrders_dim} is null) then 1 else 0 end;;}
  dimension: totalOrders_error_flag {group_label:"Error Flags" type:number sql:case when (${totalOrders_dim} is null) then 1 else 0 end;;}
  dimension: anonPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${anonPercent_dim} is null) then 1 else 0 end;;}
  dimension: tyFrequency_error_flag {group_label:"Error Flags" type:number sql:case when (${tyFrequency_dim} is null) then 1 else 0 end;;}
  dimension: pyFrequency_error_flag {group_label:"Error Flags" type:number sql:case when (${pyFrequency_dim} is null) then 1 else 0 end;;}
  dimension: yoyFrequency_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyFrequency_dim} is null) then 1 else 0 end;;}
  dimension: netSales_error_flag {group_label:"Error Flags" type:number sql:case when (${netSales_dim} is null) then 1 else 0 end;;}
  dimension: pyUnits_error_flag {group_label:"Error Flags" type:number sql:case when (${pyUnits_dim} is null) then 1 else 0 end;;}
  dimension: tyTradeSales_error_flag {group_label:"Error Flags" type:number sql:case when (${tyTradeSales_dim} is null) then 1 else 0 end;;}
  dimension: pyTradeSales_error_flag {group_label:"Error Flags" type:number sql:case when (${pyTradeSales_dim} is null) then 1 else 0 end;;}
  dimension: yoyTradeSales_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyTradeSales_dim} is null) then 1 else 0 end;;}
  dimension: yoyUPT_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyUPT_dim} is null) then 1 else 0 end;;}
  dimension: tySales_error_flag {group_label:"Error Flags" type:number sql:case when (${tySales_dim} is null) then 1 else 0 end;;}
  dimension: tyOrders_error_flag {group_label:"Error Flags" type:number sql:case when (${tyOrders_dim} is null) then 1 else 0 end;;}
  dimension: tyAOV_error_flag {group_label:"Error Flags" type:number sql:case when (${tyAOV_dim} is null) then 1 else 0 end;;}
  dimension: pySales_error_flag {group_label:"Error Flags" type:number sql:case when (${pySales_dim} is null) then 1 else 0 end;;}
  dimension: pyOrders_error_flag {group_label:"Error Flags" type:number sql:case when (${pyOrders_dim} is null) then 1 else 0 end;;}
  dimension: actual_hours_error_flag {group_label:"Error Flags" type:number sql:case when (${actual_hours_dim} is null) then 1 else 0 end;;}
  dimension: aop_hours_error_flag {group_label:"Error Flags" type:number sql:case when (${aop_hours_dim} is null) then 1 else 0 end;;}
  dimension: hoursVsAOP_error_flag {group_label:"Error Flags" type:number sql:case when (${hoursVsAOP_dim} is null) then 1 else 0 end;;}
  dimension: labourBudgetPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${labourBudgetPercent_dim} is null) then 1 else 0 end;;}
  dimension: ltoScore_error_flag {group_label:"Error Flags" type:number sql:case when (${ltoScore_dim} is null) then 1 else 0 end;;}
  dimension: trainingScore_error_flag {group_label:"Error Flags" type:number sql:case when (${trainingScore_dim} is null) then 1 else 0 end;;}
  dimension: holidayScore_error_flag {group_label:"Error Flags" type:number sql:case when (${holidayScore_dim} is null) then 1 else 0 end;;}
  dimension: apprenticeshipScore_error_flag {group_label:"Error Flags" type:number sql:case when (${apprenticeshipScore_dim} is null) then 1 else 0 end;;}
  dimension: safetyComplianceScore_error_flag {group_label:"Error Flags" type:number sql:case when (${safetyComplianceScore_dim} is null) then 1 else 0 end;;}
  dimension: processCompScore_error_flag {group_label:"Error Flags" type:number sql:case when (${processCompScore_dim} is null) then 1 else 0 end;;}
  dimension: shrinkageScore_error_flag {group_label:"Error Flags" type:number sql:case when (${shrinkageScore_dim} is null) then 1 else 0 end;;}
  dimension: npsScore_error_flag {group_label:"Error Flags" type:number sql:case when (${npsScore_dim} is null) then 1 else 0 end;;}
  dimension: anonScore_error_flag {group_label:"Error Flags" type:number sql:case when (${anonScore_dim} is null) then 1 else 0 end;;}
  dimension: yoyFrequencyScore_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyFrequencyScore_dim} is null) then 1 else 0 end;;}
  dimension: yoyTradeSalesScore_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyTradeSalesScore_dim} is null) then 1 else 0 end;;}
  dimension: unitsPerTransactionScore_error_flag {group_label:"Error Flags" type:number sql:case when (${unitsPerTransactionScore_dim} is null) then 1 else 0 end;;}
  dimension: labourBudgetScore_error_flag {group_label:"Error Flags" type:number sql:case when (${labourBudgetScore_dim} is null) then 1 else 0 end;;}
  dimension: tsClubScore_error_flag {group_label:"Error Flags" type:number sql:case when (${tsClubScore_dim} is null) then 1 else 0 end;;}
  dimension: tsClubSales_error_flag {group_label:"Error Flags" type:number sql:case when (${tsClubSales_dim} is null) then 1 else 0 end;;}
  dimension: tsClubSalesPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${tsClubSalesPercent_dim} is null) then 1 else 0 end;;}
  dimension: contributionVsBudget_error_flag {group_label:"Error Flags" type:number sql:case when (${contributionVsBudget_dim} is null) then 1 else 0 end;;}
  dimension: contributionVsBudgetScore_error_flag {group_label:"Error Flags" type:number sql:case when (${contributionVsBudgetScore_dim} is null) then 1 else 0 end;;}
  dimension: pillarTotalColleague_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarTotalColleague_dim} is null) then 1 else 0 end;;}
  dimension: pillarTotalSimplicityEfficiency_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarTotalSimplicityEfficiency_dim} is null) then 1 else 0 end;;}
  dimension: pillarTotalCust_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarTotalCust_dim} is null) then 1 else 0 end;;}
  dimension: pillarRankColleague_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarRankColleague_dim} is null) then 1 else 0 end;;}
  dimension: pillarRankSimplicityEfficiency_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarRankSimplicityEfficiency_dim} is null) then 1 else 0 end;;}
  dimension: pillarRankCust_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarRankCust_dim} is null) then 1 else 0 end;;}
  dimension: anonBandingL_error_flag {group_label:"Error Flags" type:number sql:case when (${anonBandingL_dim} is null) then 1 else 0 end;;}
  dimension: anonBandingM_error_flag {group_label:"Error Flags" type:number sql:case when (${anonBandingM_dim} is null) then 1 else 0 end;;}
  dimension: anonBandingU_error_flag {group_label:"Error Flags" type:number sql:case when (${anonBandingU_dim} is null) then 1 else 0 end;;}




}
