include: "/views/**/transactions.view"
include: "/views/**/retail/**.view"
include: "/views/**/rm_visits.view"
include: "/views/**/training.view"

view: scorecard_branch_dev_ytd25 {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_25_YTD_DATA_FINAL_DEV`;;

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
  }

  dimension: siteUID_month {
    type: string
    sql: concat(${month},${siteUID});;
    hidden: yes
    primary_key: yes
  }

  dimension: ltoPercent { type:string value_format_name:decimal_1 sql:${TABLE}.ltoPercent;;hidden:no}
  dimension: trainingAvailable { type:string value_format_name:decimal_1 sql:${TABLE}.trainingAvailable;;hidden:no}
  dimension: trainingCompleted { type:string value_format_name:decimal_1 sql:${TABLE}.trainingCompleted;;hidden:no}
  dimension: trainingPercentCompleted { type:string value_format_name:decimal_1 sql:${TABLE}.trainingPercentCompleted;;hidden:no}
  dimension: holidayMonthEntitlement { type:string value_format_name:decimal_1 sql:${TABLE}.holidayMonthEntitlement;;hidden:no}
  dimension: holidayTaken { type:string value_format_name:decimal_1 sql:${TABLE}.holidayTaken;;hidden:no}
  dimension: holidayTakenPercent { type:string value_format_name:decimal_1 sql:${TABLE}.holidayTakenPercent;;hidden:no}
  dimension: apprenticeship { type:string value_format_name:decimal_1 sql:${TABLE}.apprenticeship;;hidden:no}
  dimension: safetyCompliance { type:string value_format_name:decimal_1 sql:${TABLE}.safetyCompliance;;hidden:no}
  dimension: processCompPercent { type:string value_format_name:decimal_1 sql:${TABLE}.processCompPercent;;hidden:no}
  dimension: orders { type:string value_format_name:decimal_1 sql:${TABLE}.orders;;hidden:no}
  dimension: shrinkage { type:string value_format_name:decimal_1 sql:${TABLE}.shrinkage;;hidden:no}
  dimension: shrinkagePercent { type:string value_format_name:decimal_1 sql:${TABLE}.shrinkagePercent;;hidden:no}
  dimension: branchNPS { type:string value_format_name:decimal_1 sql:${TABLE}.branchNPS;;hidden:no}
  dimension: anonOrders { type:string value_format_name:decimal_1 sql:${TABLE}.anonOrders;;hidden:no}
  dimension: totalOrders { type:string value_format_name:decimal_1 sql:${TABLE}.totalOrders;;hidden:no}
  dimension: anonPercent { type:string value_format_name:decimal_1 sql:${TABLE}.anonPercent;;hidden:no}
  dimension: tyFrequency { type:string value_format_name:decimal_1 sql:${TABLE}.tyFrequency;;hidden:no}
  dimension: pyFrequency { type:string value_format_name:decimal_1 sql:${TABLE}.pyFrequency;;hidden:no}
  dimension: yoyFrequency { type:string value_format_name:decimal_1 sql:${TABLE}.yoyFrequency;;hidden:no}
  dimension: netSales { type:string value_format_name:decimal_1 sql:${TABLE}.netSales;;hidden:no}
  dimension: pyUnits { type:string value_format_name:decimal_1 sql:${TABLE}.pyUnits;;hidden:no}
  dimension: tyTradeSales { type:string value_format_name:decimal_1 sql:${TABLE}.tyTradeSales;;hidden:no}
  dimension: pyTradeSales { type:string value_format_name:decimal_1 sql:${TABLE}.pyTradeSales;;hidden:no}
  dimension: yoyTradeSales { type:string value_format_name:decimal_1 sql:${TABLE}.yoyTradeSales;;hidden:no}
  dimension: yoyAverageItems { type:string value_format_name:decimal_1 sql:${TABLE}.yoyAverageItems;;hidden:no}
  dimension: tySales { type:string value_format_name:decimal_1 sql:${TABLE}.tySales;;hidden:no}
  dimension: tyOrders { type:string value_format_name:decimal_1 sql:${TABLE}.tyOrders;;hidden:no}
  dimension: tyAOV { type:string value_format_name:decimal_1 sql:${TABLE}.tyAOV;;hidden:no}
  dimension: pySales { type:string value_format_name:decimal_1 sql:${TABLE}.pySales;;hidden:no}
  dimension: pyOrders { type:string value_format_name:decimal_1 sql:${TABLE}.pyOrders;;hidden:no}
  dimension: actual_hours { type:string value_format_name:decimal_1 sql:${TABLE}.actual_hours;;hidden:no}
  dimension: aop_hours { type:string value_format_name:decimal_1 sql:${TABLE}.aop_hours;;hidden:no}
  dimension: hoursVsAOP { type:string value_format_name:decimal_1 sql:${TABLE}.hoursVsAOP;;hidden:no}
  dimension: labourBudgetPercent { type:string value_format_name:decimal_1 sql:${TABLE}.labourBudgetPercent;;hidden:no}
  dimension: ltoScore { type:string value_format_name:decimal_1 sql:${TABLE}.ltoScore;;hidden:no}
  dimension: trainingScore { type:string value_format_name:decimal_1 sql:${TABLE}.trainingScore;;hidden:no}
  dimension: HolidayScore { type:string value_format_name:decimal_1 sql:${TABLE}.HolidayScore;;hidden:no}
  dimension: apprenticeshipScore { type:string value_format_name:decimal_1 sql:${TABLE}.apprenticeshipScore;;hidden:no}
  dimension: safetyComplianceScore { type:string value_format_name:decimal_1 sql:${TABLE}.safetyComplianceScore;;hidden:no}
  dimension: compScore { type:string value_format_name:decimal_1 sql:${TABLE}.compScore;;hidden:no}
  dimension: shrinkageScore { type:string value_format_name:decimal_1 sql:${TABLE}.shrinkageScore;;hidden:no}
  dimension: npsBranchScore { type:string value_format_name:decimal_1 sql:${TABLE}.npsBranchScore;;hidden:no}
  dimension: anonScore { type:string value_format_name:decimal_1 sql:${TABLE}.anonScore;;hidden:no}
  dimension: yoyFrequencyScore { type:string value_format_name:decimal_1 sql:${TABLE}.yoyFrequencyScore;;hidden:no}
  dimension: yoyTradeSalesScore { type:string value_format_name:decimal_1 sql:${TABLE}.yoyTradeSalesScore;;hidden:no}
  dimension: averageItemsScore { type:string value_format_name:decimal_1 sql:${TABLE}.averageItemsScore;;hidden:no}
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
  dimension: vsPYEBIT { type:string value_format_name:decimal_1 sql:${TABLE}.vsPYEBIT;;hidden:no}
  dimension: ebitScore { type:string value_format_name:decimal_1 sql:${TABLE}.ebitScore;;hidden:no}
  dimension: tsClubScore { type:string value_format_name:decimal_1 sql:${TABLE}.tsClubScore;;hidden:no}
  dimension: tsClubSales { type:string value_format_name:decimal_1 sql:${TABLE}.tsClubSales;;hidden:no}
  dimension: tsClubSalesPercent { type:string value_format_name:decimal_1 sql:${TABLE}.tsClubSalesPercent;;hidden:no}

}
