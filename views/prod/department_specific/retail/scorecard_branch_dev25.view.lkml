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
  dimension: ltoPercent { type:string sql:${TABLE}.ltoPercent;;hidden:no}
  dimension: trainingAvailable { type:string sql:${TABLE}.trainingAvailable;;hidden:no}
  dimension: trainingCompleted { type:string sql:${TABLE}.trainingCompleted;;hidden:no}
  dimension: trainingPercentCompleted { type:string sql:${TABLE}.trainingPercentCompleted;;hidden:no}
  dimension: holidayQ1MonthEntitlement { type:string sql:${TABLE}.holidayQ1MonthEntitlement;;hidden:no}
  dimension: holidayQ1TakenInQuarter { type:string sql:${TABLE}.holidayQ1TakenInQuarter;;hidden:no}
  dimension: holidayQ1TakenPercent { type:string sql:${TABLE}.holidayQ1TakenPercent;;hidden:no}
  dimension: holidayQ1MonthInQuarter { type:string sql:${TABLE}.holidayQ1MonthInQuarter;;hidden:no}
  dimension: holidayQ2MonthEntitlement { type:string sql:${TABLE}.holidayQ2MonthEntitlement;;hidden:no}
  dimension: holidayQ2TakenInQuarter { type:string sql:${TABLE}.holidayQ2TakenInQuarter;;hidden:no}
  dimension: holidayQ2TakenPercent { type:string sql:${TABLE}.holidayQ2TakenPercent;;hidden:no}
  dimension: holidayQ2MonthInQuarter { type:string sql:${TABLE}.holidayQ2MonthInQuarter;;hidden:no}
  dimension: holidayQ3MonthEntitlement { type:string sql:${TABLE}.holidayQ3MonthEntitlement;;hidden:no}
  dimension: holidayQ3TakenInQuarter { type:string sql:${TABLE}.holidayQ3TakenInQuarter;;hidden:no}
  dimension: holidayQ3TakenPercent { type:string sql:${TABLE}.holidayQ3TakenPercent;;hidden:no}
  dimension: holidayQ3MonthInQuarter { type:string sql:${TABLE}.holidayQ3MonthInQuarter;;hidden:no}
  dimension: holidayQ4MonthEntitlement { type:string sql:${TABLE}.holidayQ4MonthEntitlement;;hidden:no}
  dimension: holidayQ4TakenInQuarter { type:string sql:${TABLE}.holidayQ4TakenInQuarter;;hidden:no}
  dimension: holidayQ4TakenPercent { type:string sql:${TABLE}.holidayQ4TakenPercent;;hidden:no}
  dimension: holidayQ4MonthInQuarter { type:string sql:${TABLE}.holidayQ4MonthInQuarter;;hidden:no}
  dimension: apprenticeship { type:string sql:${TABLE}.apprenticeship;;hidden:no}
  dimension: operationalCompliance { type:number sql:${TABLE}.operationalCompliance;;hidden:no}
  dimension: Comp_Actual { type:number sql:${TABLE}.Comp_Actual;;hidden:no}
  dimension: moves { type:number sql:${TABLE}.moves;;hidden:no}
  dimension: units { type:number sql:${TABLE}.units;;hidden:no}
  dimension: orders { type:number sql:${TABLE}.orders;;hidden:no}
  dimension: stockAccuracy { type:number sql:${TABLE}.stockAccuracy;;hidden:no}
  dimension: branchNPS { type:number sql:${TABLE}.branchNPS;;hidden:no}
  dimension: anonOrders { type:number sql:${TABLE}.anonOrders;;hidden:no}
  dimension: totalOrders { type:number sql:${TABLE}.totalOrders;;hidden:no}
  dimension: anonPercent { type:number sql:${TABLE}.anonPercent;;hidden:no}
  dimension: tyFrequency { type:number sql:${TABLE}.tyFrequency;;hidden:no}
  dimension: pyFrequency { type:number sql:${TABLE}.pyFrequency;;hidden:no}
  dimension: yoyFrequency { type:number sql:${TABLE}.yoyFrequency;;hidden:no}
  dimension: tradeAccountSales { type:number sql:${TABLE}.tradeAccountSales;;hidden:no}
  dimension: netSales { type:number sql:${TABLE}.netSales;;hidden:no}
  dimension: pyUnits { type:number sql:${TABLE}.pyUnits;;hidden:no}
  dimension: tradeAccountParticipation { type:number sql:${TABLE}.tradeAccountParticipation;;hidden:no}
  dimension: tyTradeSales { type:number sql:${TABLE}.tyTradeSales;;hidden:no}
  dimension: pyTradeSales { type:number sql:${TABLE}.pyTradeSales;;hidden:no}
  dimension: yoyTradeSales { type:number sql:${TABLE}.yoyTradeSales;;hidden:no}
  dimension: unitsExCC { type:number sql:${TABLE}.unitsExCC;;hidden:no}
  dimension: ordersExCC { type:number sql:${TABLE}.ordersExCC;;hidden:no}
  dimension: pyUnitsExCC { type:number sql:${TABLE}.pyUnitsExCC;;hidden:no}
  dimension: pyOrdersExCC { type:number sql:${TABLE}.pyOrdersExCC;;hidden:no}
  dimension: yoyAverageItems { type:number sql:${TABLE}.yoyAverageItems;;hidden:no}
  dimension: tyRetailTradingProfit { type:number sql:${TABLE}.tyRetailTradingProfit;;hidden:no}
  dimension: aopRetailTradingProfit { type:number sql:${TABLE}.aopRetailTradingProfit;;hidden:no}
  dimension: vsAOPRetailTradingProfit { type:number sql:${TABLE}.vsAOPRetailTradingProfit;;hidden:no}
  dimension: tySales { type:number sql:${TABLE}.tySales;;hidden:no}
  dimension: tyOrders { type:number sql:${TABLE}.tyOrders;;hidden:no}
  dimension: tyAOV { type:number sql:${TABLE}.tyAOV;;hidden:no}
  dimension: pySales { type:number sql:${TABLE}.pySales;;hidden:no}
  dimension: pyOrders { type:number sql:${TABLE}.pyOrders;;hidden:no}
  dimension: actual_hours { type:number sql:${TABLE}.actual_hours;;hidden:no}
  dimension: aop_hours { type:number sql:${TABLE}.aop_hours;;hidden:no}
  dimension: hoursVsAOP { type:number sql:${TABLE}.hoursVsAOP;;hidden:no}
  dimension: labourBudgetPercent { type:number sql:${TABLE}.labourBudgetPercent;;hidden:no}
  dimension: budget { type:number sql:${TABLE}.budget;;hidden:no}
  dimension: varBudget { type:number sql:${TABLE}.varBudget;;hidden:no}
  dimension: ltoScore { type:number sql:${TABLE}.ltoScore;;hidden:no}
  dimension: trainingScore { type:number sql:${TABLE}.trainingScore;;hidden:no}
  dimension: q1HolidayScore { type:number sql:${TABLE}.q1HolidayScore;;hidden:no}
  dimension: q2HolidayScore { type:number sql:${TABLE}.q2HolidayScore;;hidden:no}
  dimension: q3HolidayScore { type:number sql:${TABLE}.q3HolidayScore;;hidden:no}
  dimension: q4HolidayScore { type:number sql:${TABLE}.q4HolidayScore;;hidden:no}
  dimension: apprenticeshipScore { type:number sql:${TABLE}.apprenticeshipScore;;hidden:no}
  dimension: operationalComplianceScore { type:number sql:${TABLE}.operationalComplianceScore;;hidden:no}
  dimension: compScore { type:number sql:${TABLE}.compScore;;hidden:no}
  dimension: accuracyScore { type:number sql:${TABLE}.accuracyScore;;hidden:no}
  dimension: npsBranchScore { type:number sql:${TABLE}.npsBranchScore;;hidden:no}
  dimension: anonScore { type:number sql:${TABLE}.anonScore;;hidden:no}
  dimension: yoyFrequencyScore { type:number sql:${TABLE}.yoyFrequencyScore;;hidden:no}
  dimension: tradeParticipationScore { type:number sql:${TABLE}.tradeParticipationScore;;hidden:no}
  dimension: yoyTradeSalesScore { type:number sql:${TABLE}.yoyTradeSalesScore;;hidden:no}
  dimension: averageItemsScore { type:number sql:${TABLE}.averageItemsScore;;hidden:no}
  dimension: retailTradingProfitScore { type:number sql:${TABLE}.retailTradingProfitScore;;hidden:no}
  dimension: labourBudgetScore { type:number sql:${TABLE}.labourBudgetScore;;hidden:no}
  dimension: pillarTotalColleague { type:number sql:${TABLE}.pillarTotalColleague;;hidden:no}
  dimension: pillarTotalSimplicityEfficiency { type:number sql:${TABLE}.pillarTotalSimplicityEfficiency;;hidden:no}
  dimension: pillarTotalCust { type:number sql:${TABLE}.pillarTotalCust;;hidden:no}
  dimension: pillarRankColleague { type:number sql:${TABLE}.pillarRankColleague;;hidden:no}
  dimension: pillarRankSimplicityEfficiency { type:number sql:${TABLE}.pillarRankSimplicityEfficiency;;hidden:no}
  dimension: pillarRankCust { type:number sql:${TABLE}.pillarRankCust;;hidden:no}
  dimension: overallRank { type:number sql:${TABLE}.overallRank;;hidden:no}
  dimension: ColleagueRag { type:number sql:${TABLE}.ColleagueRag;;hidden:no}
  dimension: SimplicityEfficiencyRag { type:number sql:${TABLE}.SimplicityEfficiencyRag;;hidden:no}
  dimension: CustRag { type:number sql:${TABLE}.CustRag;;hidden:no}
  dimension: OverallRag { type:number sql:${TABLE}.OverallRag;;hidden:no}


# Error Flags  --------------------------------------------------------------------

}
