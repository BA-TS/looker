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

  dimension: ltoPercent { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.ltoPercent;;hidden:no}
  dimension: trainingAvailable { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.trainingAvailable;;hidden:no}
  dimension: trainingCompleted { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.trainingCompleted;;hidden:no}
  dimension: trainingPercentCompleted { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.trainingPercentCompleted;;hidden:no}
  dimension: holidayMonthEntitlement { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.holidayMonthEntitlement;;hidden:no}
  dimension: holidayTaken { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.holidayTaken;;hidden:no}
  dimension: holidayTakenPercent { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.holidayTakenPercent;;hidden:no}
  dimension: apprenticeship { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.apprenticeship;;hidden:no}
  dimension: safetyCompliance { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.safetyCompliance;;hidden:no}
  dimension: processCompPercent { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.processCompPercent;;hidden:no}
  dimension: orders { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.orders;;hidden:no}
  dimension: shrinkage { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.shrinkage;;hidden:no}
  dimension: shrinkagePercent { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.shrinkagePercent;;hidden:no}
  dimension: NPS { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.NPS;;hidden:no}
  dimension: anonOrders { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.anonOrders;;hidden:no}
  dimension: totalOrders { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.totalOrders;;hidden:no}
  dimension: anonPercent { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.anonPercent;;hidden:no}
  dimension: tyFrequency { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.tyFrequency;;hidden:no}
  dimension: pyFrequency { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.pyFrequency;;hidden:no}
  dimension: yoyFrequency { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.yoyFrequency;;hidden:no}
  dimension: netSales { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.netSales;;hidden:no}
  dimension: pyUnits { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.pyUnits;;hidden:no}
  dimension: tyTradeSales { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.tyTradeSales;;hidden:no}
  dimension: pyTradeSales { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.pyTradeSales;;hidden:no}
  dimension: yoyTradeSales { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.yoyTradeSales;;hidden:no}
  dimension: yoyUPT { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.yoyUPT;;hidden:no}
  dimension: tySales { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.tySales;;hidden:no}
  dimension: tyOrders { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.tyOrders;;hidden:no}
  dimension: tyAOV { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.tyAOV;;hidden:no}
  dimension: pySales { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.pySales;;hidden:no}
  dimension: pyOrders { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.pyOrders;;hidden:no}
  dimension: actual_hours { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.actual_hours;;hidden:no}
  dimension: aop_hours { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.aop_hours;;hidden:no}
  dimension: hoursVsAOP { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.hoursVsAOP;;hidden:no}
  dimension: labourBudgetPercent { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.labourBudgetPercent;;hidden:no}
  dimension: ltoScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.ltoScore;;hidden:no}
  dimension: trainingScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.trainingScore;;hidden:no}
  dimension: holidayScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.holidayScore;;hidden:no}
  dimension: apprenticeshipScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.apprenticeshipScore;;hidden:no}
  dimension: safetyComplianceScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.safetyComplianceScore;;hidden:no}
  dimension: processCompScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.processCompScore;;hidden:no}
  dimension: shrinkageScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.shrinkageScore;;hidden:no}
  dimension: npsScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.npsScore;;hidden:no}
  dimension: anonScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.anonScore;;hidden:no}
  dimension: yoyFrequencyScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.yoyFrequencyScore;;hidden:no}
  dimension: yoyTradeSalesScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.yoyTradeSalesScore;;hidden:no}
  dimension: unitsPerTransactionScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.unitsPerTransactionScore;;hidden:no}
  dimension: labourBudgetScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.labourBudgetScore;;hidden:no}
  dimension: pillarTotalColleague { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.pillarTotalColleague;;hidden:no}
  dimension: pillarTotalSimplicityEfficiency { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.pillarTotalSimplicityEfficiency;;hidden:no}
  dimension: pillarTotalCust { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.pillarTotalCust;;hidden:no}
  dimension: pillarRankColleague { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.pillarRankColleague;;hidden:no}
  dimension: pillarRankSimplicityEfficiency { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.pillarRankSimplicityEfficiency;;hidden:no}
  dimension: pillarRankCust { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.pillarRankCust;;hidden:no}
  dimension: overallRank { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.overallRank;;hidden:no}
  dimension: ColleagueRag { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.ColleagueRag;;hidden:no}
  dimension: SimplicityEfficiencyRag { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.SimplicityEfficiencyRag;;hidden:no}
  dimension: CustRag { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.CustRag;;hidden:no}
  dimension: OverallRag { group_label: "Ranking" type:string value_format_name:decimal_1 sql:${TABLE}.OverallRag;;hidden:no}
  dimension: contributionVsBudget { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.contributionVsBudget;;hidden:no}
  dimension: contributionVsBudgetScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.contributionVsBudgetScore;;hidden:no}
  dimension: tsClubScore { group_label: "Scores" type:string value_format_name:decimal_1 sql:${TABLE}.tsClubScore;;hidden:no}
  dimension: tsClubSales { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.tsClubSales;;hidden:no}
  dimension: tsClubSalesPercent { group_label: "Measures" type:string value_format_name:decimal_1 sql:${TABLE}.tsClubSalesPercent;;hidden:no}

}
