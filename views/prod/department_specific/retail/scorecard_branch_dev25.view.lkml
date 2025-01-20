include: "/views/**/transactions.view"
include: "/views/**/retail/**.view"

view: scorecard_branch_dev25 {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_25_MONTHLY_DATA_DEV`;;


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

  measure: siteUID_count {
    type: count_distinct
    sql: ${siteUID} ;;
    hidden: yes
  }

  dimension: siteUID_month {
    type: string
    sql: concat(${month},${siteUID});;
    hidden: yes
    primary_key: yes
  }

# Scores  --------------------------------------------------------------------
  dimension: ltoPercent { type:string value_format_name:decimal_1 sql:${TABLE}.ltoPercent;;hidden:no}
  dimension: trainingAvailable { type:string value_format_name:decimal_1 sql:${TABLE}.trainingAvailable;;hidden:no}
  dimension: trainingCompleted { type:string value_format_name:decimal_1 sql:${TABLE}.trainingCompleted;;hidden:no}
  dimension: trainingPercentCompleted { type:string value_format_name:decimal_1 sql:${TABLE}.trainingPercentCompleted;;hidden:no}
  dimension: holidayQ1MonthEntitlement { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ1MonthEntitlement;;hidden:no}
  dimension: holidayQ1TakenInQuarter { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ1TakenInQuarter;;hidden:no}
  dimension: holidayQ1TakenPercent { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ1TakenPercent;;hidden:no}
  dimension: holidayQ1MonthInQuarter { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ1MonthInQuarter;;hidden:no}
  dimension: holidayQ2MonthEntitlement { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ2MonthEntitlement;;hidden:no}
  dimension: holidayQ2TakenInQuarter { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ2TakenInQuarter;;hidden:no}
  dimension: holidayQ2TakenPercent { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ2TakenPercent;;hidden:no}
  dimension: holidayQ2MonthInQuarter { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ2MonthInQuarter;;hidden:no}
  dimension: holidayQ3MonthEntitlement { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ3MonthEntitlement;;hidden:no}
  dimension: holidayQ3TakenInQuarter { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ3TakenInQuarter;;hidden:no}
  dimension: holidayQ3TakenPercent { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ3TakenPercent;;hidden:no}
  dimension: holidayQ3MonthInQuarter { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ3MonthInQuarter;;hidden:no}
  dimension: holidayQ4MonthEntitlement { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ4MonthEntitlement;;hidden:no}
  dimension: holidayQ4TakenInQuarter { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ4TakenInQuarter;;hidden:no}
  dimension: holidayQ4TakenPercent { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ4TakenPercent;;hidden:no}
  dimension: holidayQ4MonthInQuarter { type:string value_format_name:decimal_1 sql:${TABLE}.holidayQ4MonthInQuarter;;hidden:no}
  dimension: apprenticeship { type:string value_format_name:decimal_1 sql:${TABLE}.apprenticeship;;hidden:no}
  dimension: operationalCompliance { type:string value_format_name:decimal_1 sql:${TABLE}.operationalCompliance;;hidden:no}
  dimension: Comp_Actual { type:string value_format_name:decimal_1 sql:${TABLE}.Comp_Actual;;hidden:no}
  dimension: moves { type:string value_format_name:decimal_1 sql:${TABLE}.moves;;hidden:no}
  dimension: units { type:string value_format_name:decimal_1 sql:${TABLE}.units;;hidden:no}
  dimension: orders { type:string value_format_name:decimal_1 sql:${TABLE}.orders;;hidden:no}
  dimension: stockAccuracy { type:string value_format_name:decimal_1 sql:${TABLE}.stockAccuracy;;hidden:no}
  dimension: branchNPS { type:string value_format_name:decimal_1 sql:${TABLE}.branchNPS;;hidden:no}
  dimension: anonOrders { type:string value_format_name:decimal_1 sql:${TABLE}.anonOrders;;hidden:no}
  dimension: totalOrders { type:string value_format_name:decimal_1 sql:${TABLE}.totalOrders;;hidden:no}
  dimension: anonPercent { type:string value_format_name:decimal_1 sql:${TABLE}.anonPercent;;hidden:no}
  dimension: tyFrequency { type:string value_format_name:decimal_1 sql:${TABLE}.tyFrequency;;hidden:no}
  dimension: pyFrequency { type:string value_format_name:decimal_1 sql:${TABLE}.pyFrequency;;hidden:no}
  dimension: yoyFrequency { type:string value_format_name:decimal_1 sql:${TABLE}.yoyFrequency;;hidden:no}
  dimension: tradeAccountSales { type:string value_format_name:decimal_1 sql:${TABLE}.tradeAccountSales;;hidden:no}
  dimension: netSales { type:string value_format_name:decimal_1 sql:${TABLE}.netSales;;hidden:no}
  dimension: pyUnits { type:string value_format_name:decimal_1 sql:${TABLE}.pyUnits;;hidden:no}
  dimension: tradeAccountParticipation { type:string value_format_name:decimal_1 sql:${TABLE}.tradeAccountParticipation;;hidden:no}
  dimension: tyTradeSales { type:string value_format_name:decimal_1 sql:${TABLE}.tyTradeSales;;hidden:no}
  dimension: pyTradeSales { type:string value_format_name:decimal_1 sql:${TABLE}.pyTradeSales;;hidden:no}
  dimension: yoyTradeSales { type:string value_format_name:decimal_1 sql:${TABLE}.yoyTradeSales;;hidden:no}
  dimension: unitsExCC { type:string value_format_name:decimal_1 sql:${TABLE}.unitsExCC;;hidden:no}
  dimension: ordersExCC { type:string value_format_name:decimal_1 sql:${TABLE}.ordersExCC;;hidden:no}
  dimension: pyUnitsExCC { type:string value_format_name:decimal_1 sql:${TABLE}.pyUnitsExCC;;hidden:no}
  dimension: pyOrdersExCC { type:string value_format_name:decimal_1 sql:${TABLE}.pyOrdersExCC;;hidden:no}
  dimension: yoyAverageItems { type:string value_format_name:decimal_1 sql:${TABLE}.yoyAverageItems;;hidden:no}
  dimension: tyRetailTradingProfit { type:string value_format_name:decimal_1 sql:${TABLE}.tyRetailTradingProfit;;hidden:no}
  dimension: aopRetailTradingProfit { type:string value_format_name:decimal_1 sql:${TABLE}.aopRetailTradingProfit;;hidden:no}
  dimension: vsAOPRetailTradingProfit { type:string value_format_name:decimal_1 sql:${TABLE}.vsAOPRetailTradingProfit;;hidden:no}
  dimension: tySales { type:string value_format_name:decimal_1 sql:${TABLE}.tySales;;hidden:no}
  dimension: tyOrders { type:string value_format_name:decimal_1 sql:${TABLE}.tyOrders;;hidden:no}
  dimension: tyAOV { type:string value_format_name:decimal_1 sql:${TABLE}.tyAOV;;hidden:no}
  dimension: pySales { type:string value_format_name:decimal_1 sql:${TABLE}.pySales;;hidden:no}
  dimension: pyOrders { type:string value_format_name:decimal_1 sql:${TABLE}.pyOrders;;hidden:no}
  dimension: actual_hours { type:string value_format_name:decimal_1 sql:${TABLE}.actual_hours;;hidden:no}
  dimension: aop_hours { type:string value_format_name:decimal_1 sql:${TABLE}.aop_hours;;hidden:no}
  dimension: hoursVsAOP { type:string value_format_name:decimal_1 sql:${TABLE}.hoursVsAOP;;hidden:no}
  dimension: labourBudgetPercent { type:string value_format_name:decimal_1 sql:${TABLE}.labourBudgetPercent;;hidden:no}
  dimension: budget { type:string value_format_name:decimal_1 sql:${TABLE}.budget;;hidden:no}
  dimension: varBudget { type:string value_format_name:decimal_1 sql:${TABLE}.varBudget;;hidden:no}
  dimension: ltoScore { type:string value_format_name:decimal_1 sql:${TABLE}.ltoScore;;hidden:no}
  dimension: trainingScore { type:string value_format_name:decimal_1 sql:${TABLE}.trainingScore;;hidden:no}
  dimension: q1HolidayScore { type:string value_format_name:decimal_1 sql:${TABLE}.q1HolidayScore;;hidden:no}
  dimension: q2HolidayScore { type:string value_format_name:decimal_1 sql:${TABLE}.q2HolidayScore;;hidden:no}
  dimension: q3HolidayScore { type:string value_format_name:decimal_1 sql:${TABLE}.q3HolidayScore;;hidden:no}
  dimension: q4HolidayScore { type:string value_format_name:decimal_1 sql:${TABLE}.q4HolidayScore;;hidden:no}
  dimension: apprenticeshipScore { type:string value_format_name:decimal_1 sql:${TABLE}.apprenticeshipScore;;hidden:no}
  dimension: operationalComplianceScore { type:string value_format_name:decimal_1 sql:${TABLE}.operationalComplianceScore;;hidden:no}
  dimension: compScore { type:string value_format_name:decimal_1 sql:${TABLE}.compScore;;hidden:no}
  dimension: accuracyScore { type:string value_format_name:decimal_1 sql:${TABLE}.accuracyScore;;hidden:no}
  dimension: npsBranchScore { type:string value_format_name:decimal_1 sql:${TABLE}.npsBranchScore;;hidden:no}
  dimension: anonScore { type:string value_format_name:decimal_1 sql:${TABLE}.anonScore;;hidden:no}
  dimension: yoyFrequencyScore { type:string value_format_name:decimal_1 sql:${TABLE}.yoyFrequencyScore;;hidden:no}
  dimension: tradeParticipationScore { type:string value_format_name:decimal_1 sql:${TABLE}.tradeParticipationScore;;hidden:no}
  dimension: yoyTradeSalesScore { type:string value_format_name:decimal_1 sql:${TABLE}.yoyTradeSalesScore;;hidden:no}
  dimension: averageItemsScore { type:string value_format_name:decimal_1 sql:${TABLE}.averageItemsScore;;hidden:no}
  dimension: retailTradingProfitScore { type:string value_format_name:decimal_1 sql:${TABLE}.retailTradingProfitScore;;hidden:no}
  dimension: labourBudgetScore { type:string value_format_name:decimal_1 sql:${TABLE}.labourBudgetScore;;hidden:no}
  dimension: pillarTotalColleague { type:string value_format_name:decimal_1 sql:${TABLE}.pillarTotalColleague;;hidden:no}
  dimension: pillarTotalSimplicityEfficiency { type:string value_format_name:decimal_1 sql:${TABLE}.pillarTotalSimplicityEfficiency;;hidden:no}
  dimension: pillarTotalCust { type:string value_format_name:decimal_1 sql:${TABLE}.pillarTotalCust;;hidden:no}
  dimension: pillarRankColleague { type:string value_format_name:decimal_1 sql:${TABLE}.pillarRankColleague;;hidden:no}
  dimension: pillarRankSimplicityEfficiency { type:string value_format_name:decimal_1 sql:${TABLE}.pillarRankSimplicityEfficiency;;hidden:no}
  dimension: pillarRankCust { type:string value_format_name:decimal_1 sql:${TABLE}.pillarRankCust;;hidden:no}
  dimension: overallRank { type:string value_format_name:decimal_1 sql:${TABLE}.overallRank;;hidden:no}
  dimension: ColleagueRag { type:string value_format_name:decimal_1 sql:${TABLE}.ColleagueRag;;hidden:no}
  dimension: SimplicityEfficiencyRag { type:string value_format_name:decimal_1 sql:${TABLE}.SimplicityEfficiencyRag;;hidden:no}
  dimension: CustRag { type:string value_format_name:decimal_1 sql:${TABLE}.CustRag;;hidden:no}
  dimension: OverallRag { type:string value_format_name:decimal_1 sql:${TABLE}.OverallRag;;hidden:no}


# Error Flags  --------------------------------------------------------------------

}
