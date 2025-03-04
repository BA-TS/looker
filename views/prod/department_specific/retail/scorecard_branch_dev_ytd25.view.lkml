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
    # hidden: yes
  }

  measure: siteUID_count {
    type: count_distinct
    sql: ${siteUID} ;;
    label: "Number of Sites"
  }

  dimension: siteUID_month {
    type: string
    sql: concat(${month},${siteUID});;
    hidden: yes
    primary_key: yes
  }

  dimension: ltoPercent { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.ltoPercent;;hidden:no}
  dimension: trainingAvailable { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.trainingAvailable;;hidden:no}
  dimension: trainingCompleted { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.trainingCompleted;;hidden:no}
  dimension: trainingPercentCompleted { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.trainingPercentCompleted;;hidden:no}
  dimension: holidayMonthEntitlement { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.holidayMonthEntitlement;;hidden:no}
  dimension: holidayTaken { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.holidayTaken;;hidden:no}
  dimension: holidayTakenPercent { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.holidayTakenPercent;;hidden:no}
  dimension: apprenticeship { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.apprenticeship;;hidden:no}
  dimension: safetyCompliance { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.safetyCompliance;;hidden:no}
  dimension: processCompPercent { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.processCompPercent;;hidden:no}
  dimension: orders { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.orders;;hidden:no}
  dimension: shrinkage { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.shrinkage;;hidden:no}
  dimension: shrinkagePercent { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.shrinkagePercent;;hidden:no}
  dimension: NPS { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.NPS;;hidden:no}
  dimension: anonOrders { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.anonOrders;;hidden:no}
  dimension: totalOrders { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.totalOrders;;hidden:no}
  dimension: anonPercent { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.anonPercent;;hidden:no}
  dimension: anonBandingL { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.anonBandingL;;hidden:no}
  dimension: anonBandingM { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.anonBandingM;;hidden:no}
  dimension: anonBandingU { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.anonBandingU;;hidden:no}
  dimension: anonPercentVsTarget { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.anonPercentVsTarget;;hidden:no}
  dimension: tyFrequency { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.tyFrequency;;hidden:no}
  dimension: pyFrequency { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pyFrequency;;hidden:no}
  dimension: yoyFrequency { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.yoyFrequency;;hidden:no}
  dimension: netSales { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.netSales;;hidden:no}
  dimension: pyUnits { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pyUnits;;hidden:no}
  dimension: unitsExCC { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.unitsExCC;;hidden:no}
  dimension: ordersExCC { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.ordersExCC;;hidden:no}
  dimension: pyUnitsExCC { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pyUnitsExCC;;hidden:no}
  dimension: pyOrdersExCC { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pyOrdersExCC;;hidden:no}
  dimension: tyTradeSales { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.tyTradeSales;;hidden:no}
  dimension: pyTradeSales { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pyTradeSales;;hidden:no}
  dimension: yoyTradeSales { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.yoyTradeSales;;hidden:no}
  dimension: yoyUPT { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.yoyUPT;;hidden:no}
  dimension: tySales { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.tySales;;hidden:no}
  dimension: tyOrders { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.tyOrders;;hidden:no}
  dimension: tyAOV { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.tyAOV;;hidden:no}
  dimension: pySales { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pySales;;hidden:no}
  dimension: pyOrders { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pyOrders;;hidden:no}
  dimension: actual_hours { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.actual_hours;;hidden:no}
  dimension: aop_hours { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.aop_hours;;hidden:no}
  dimension: hoursVsAOP { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.hoursVsAOP;;hidden:no}
  dimension: labourBudgetPercent { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.labourBudgetPercent;;hidden:no}
  dimension: contributionVsBudget { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.contributionVsBudget;;hidden:no}
  dimension: AOP { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.AOP;;hidden:no}
  dimension: vsAOP { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.vsAOP;;hidden:no}
  dimension: tyEBIT { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.tyEBIT;;hidden:no}
  dimension: pyEBIT { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pyEBIT;;hidden:no}
  dimension: tsClubSales { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.tsClubSales;;hidden:no}
  dimension: tsClubSalesPercent { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.tsClubSalesPercent;;hidden:no}
  dimension: ltoScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.ltoScore;;hidden:no}
  dimension: trainingScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.trainingScore;;hidden:no}
  dimension: holidayScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.holidayScore;;hidden:no}
  dimension: apprenticeshipScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.apprenticeshipScore;;hidden:no}
  dimension: safetyComplianceScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.safetyComplianceScore;;hidden:no}
  dimension: processCompScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.processCompScore;;hidden:no}
  dimension: shrinkageScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.shrinkageScore;;hidden:no}
  dimension: npsScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.npsScore;;hidden:no}
  dimension: anonScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.anonScore;;hidden:no}
  dimension: yoyFrequencyScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.yoyFrequencyScore;;hidden:no}
  dimension: yoyTradeSalesScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.yoyTradeSalesScore;;hidden:no}
  dimension: unitsPerTransactionScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.unitsPerTransactionScore;;hidden:no}
  dimension: labourBudgetScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.labourBudgetScore;;hidden:no}
  dimension: tsClubScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.tsClubScore;;hidden:no}
  dimension: contributionVsBudgetScore { group_label: "Scores" type:number value_format_name:decimal_3 sql:${TABLE}.contributionVsBudgetScore;;hidden:no}
  dimension: pillarTotalColleague { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pillarTotalColleague;;hidden:no}
  dimension: pillarTotalSimplicityEfficiency { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pillarTotalSimplicityEfficiency;;hidden:no}
  dimension: pillarTotalCust { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pillarTotalCust;;hidden:no}
  dimension: pillarTotalOverall { group_label: "Measures" type:number value_format_name:decimal_3 sql:${TABLE}.pillarTotalOverall;;hidden:no}
  dimension: pillarRankColleague { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.pillarRankColleague;;hidden:no}
  dimension: pillarRankSimplicityEfficiency { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.pillarRankSimplicityEfficiency;;hidden:no}
  dimension: pillarRankCust { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.pillarRankCust;;hidden:no}
  dimension: overallRank { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.overallRank;;hidden:no}
  dimension: ColleagueRag { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.ColleagueRag;;hidden:no}
  dimension: SimplicityEfficiencyRag { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.SimplicityEfficiencyRag;;hidden:no}
  dimension: CustRag { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.CustRag;;hidden:no}
  dimension: OverallRag { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.OverallRag;;hidden:no}
  dimension: pillarRankColleagueNew { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.pillarRankColleagueNew;;hidden:no}
  dimension: pillarRankSimplicityEfficiencyNew { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.pillarRankSimplicityEfficiencyNew;;hidden:no}
  dimension: pillarRankCustNew { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.pillarRankCustNew;;hidden:no}
  dimension: overallRankNew { group_label: "Ranking" type:number value_format_name:decimal_3 sql:${TABLE}.overallRankNew;;hidden:no}

  dimension: ltoPercent_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${ltoPercent};;}
  dimension: trainingAvailable_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${trainingAvailable};;}
  dimension: trainingCompleted_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${trainingCompleted};;}
  dimension: trainingPercentCompleted_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${trainingPercentCompleted};;}
  dimension: holidayMonthEntitlement_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${holidayMonthEntitlement};;}
  dimension: holidayTaken_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${holidayTaken};;}
  dimension: holidayTakenPercent_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${holidayTakenPercent};;}
  dimension: apprenticeship_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${apprenticeship};;}
  dimension: safetyCompliance_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${safetyCompliance};;}
  dimension: processCompPercent_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${processCompPercent};;}
  dimension: orders_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${orders};;}
  dimension: shrinkage_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${shrinkage};;}
  dimension: shrinkagePercent_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${shrinkagePercent};;}
  dimension: NPS_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${NPS};;}
  dimension: anonOrders_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonOrders};;}
  dimension: totalOrders_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${totalOrders};;}
  dimension: anonPercent_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonPercent};;}
  dimension: tyFrequency_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyFrequency};;}
  dimension: pyFrequency_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyFrequency};;}
  dimension: yoyFrequency_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyFrequency};;}
  dimension: netSales_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${netSales};;}
  dimension: pyUnits_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyUnits};;}
  dimension: tyTradeSales_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyTradeSales};;}
  dimension: pyTradeSales_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyTradeSales};;}
  dimension: yoyTradeSales_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyTradeSales};;}
  dimension: yoyUPT_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyUPT};;}
  dimension: tySales_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tySales};;}
  dimension: tyOrders_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyOrders};;}
  dimension: tyAOV_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tyAOV};;}
  dimension: pySales_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pySales};;}
  dimension: pyOrders_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${pyOrders};;}
  dimension: actual_hours_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${actual_hours};;}
  dimension: aop_hours_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${aop_hours};;}
  dimension: hoursVsAOP_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${hoursVsAOP};;}
  dimension: labourBudgetPercent_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${labourBudgetPercent};;}
  dimension: ltoScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${ltoScore};;}
  dimension: trainingScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${trainingScore};;}
  dimension: holidayScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${holidayScore};;}
  dimension: apprenticeshipScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${apprenticeshipScore};;}
  dimension: safetyComplianceScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${safetyComplianceScore};;}
  dimension: processCompScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${processCompScore};;}
  dimension: shrinkageScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${shrinkageScore};;}
  dimension: npsScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${npsScore};;}
  dimension: anonScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${anonScore};;}
  dimension: yoyFrequencyScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyFrequencyScore};;}
  dimension: yoyTradeSalesScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${yoyTradeSalesScore};;}
  dimension: unitsPerTransactionScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${unitsPerTransactionScore};;}
  dimension: labourBudgetScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${labourBudgetScore};;}
  dimension: pillarTotalColleague_tier {group_label:"Testing" type:tier tiers:[0,10,20,30,40,50] sql:${pillarTotalColleague};;}
  dimension: pillarTotalSimplicityEfficiency_tier {group_label:"Testing" type:tier tiers:[0,10,20,30,40,50]  sql:${pillarTotalSimplicityEfficiency};;}
  dimension: pillarTotalCust_tier {group_label:"Testing" type:tier tiers:[0,10,20,30,40,50]  sql:${pillarTotalCust};;}
  dimension: pillarRankColleague_tier {group_label:"Testing" type:tier tiers:[0,100,200,300,400,500,600] sql:${pillarRankColleague};;}
  dimension: pillarRankSimplicityEfficiency_tier {group_label:"Testing" type:tier tiers:[0,100,200,300,400,500,600] sql:${pillarRankSimplicityEfficiency};;}
  dimension: pillarRankCust_tier {group_label:"Testing" type:tier tiers:[0,100,200,300,400,500,600] sql:${pillarRankCust};;}
  dimension: overallRank_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${overallRank};;}
  dimension: ColleagueRag_tier {group_label:"Testing" type:tier tiers:[0,1,2,3] sql:${ColleagueRag};;}
  dimension: SimplicityEfficiencyRag_tier {group_label:"Testing" type:tier tiers:[0,1,2,3] sql:${SimplicityEfficiencyRag};;}
  dimension: CustRag_tier {group_label:"Testing" type:tier tiers:[0,1,2,3] sql:${CustRag};;}
  dimension: OverallRag_tier {group_label:"Testing" type:tier tiers:[0,1,2,3] sql:${OverallRag};;}
  dimension: contributionVsBudget_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${contributionVsBudget};;}
  dimension: contributionVsBudgetScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${contributionVsBudgetScore};;}
  dimension: tsClubScore_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tsClubScore};;}
  dimension: tsClubSales_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tsClubSales};;}
  dimension: tsClubSalesPercent_tier {group_label:"Testing" type:tier tiers:[0,1,2, 4,6,8,10] sql:${tsClubSalesPercent};;}


  # --Error Flags----------------------
  dimension: ltoPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${ltoPercent} is null) then 1 else 0 end;;}
  dimension: trainingAvailable_error_flag {group_label:"Error Flags" type:number sql:case when (${trainingAvailable} is null) then 1 else 0 end;;}
  dimension: trainingCompleted_error_flag {group_label:"Error Flags" type:number sql:case when (${trainingCompleted} is null) then 1 else 0 end;;}
  dimension: trainingPercentCompleted_error_flag {group_label:"Error Flags" type:number sql:case when (${trainingPercentCompleted} is null) then 1 else 0 end;;}
  dimension: holidayMonthEntitlement_error_flag {group_label:"Error Flags" type:number sql:case when (${holidayMonthEntitlement} is null) then 1 else 0 end;;}
  dimension: holidayTaken_error_flag {group_label:"Error Flags" type:number sql:case when (${holidayTaken} is null) then 1 else 0 end;;}
  dimension: holidayTakenPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${holidayTakenPercent} is null) then 1 else 0 end;;}
  dimension: apprenticeship_error_flag {group_label:"Error Flags" type:number sql:case when (${apprenticeship} is null) then 1 else 0 end;;}
  dimension: safetyCompliance_error_flag {group_label:"Error Flags" type:number sql:case when (${safetyCompliance} is null) then 1 else 0 end;;}
  dimension: processCompPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${processCompPercent} is null) then 1 else 0 end;;}
  dimension: orders_error_flag {group_label:"Error Flags" type:number sql:case when (${orders} is null) then 1 else 0 end;;}
  dimension: shrinkage_error_flag {group_label:"Error Flags" type:number sql:case when (${shrinkage} is null) then 1 else 0 end;;}
  dimension: shrinkagePercent_error_flag {group_label:"Error Flags" type:number sql:case when (${shrinkagePercent} is null) then 1 else 0 end;;}
  dimension: NPS_error_flag {group_label:"Error Flags" type:number sql:case when (${NPS} is null) then 1 else 0 end;;}
  dimension: anonOrders_error_flag {group_label:"Error Flags" type:number sql:case when (${anonOrders} is null) then 1 else 0 end;;}
  dimension: totalOrders_error_flag {group_label:"Error Flags" type:number sql:case when (${totalOrders} is null) then 1 else 0 end;;}
  dimension: anonPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${anonPercent} is null) then 1 else 0 end;;}
  dimension: tyFrequency_error_flag {group_label:"Error Flags" type:number sql:case when (${tyFrequency} is null) then 1 else 0 end;;}
  dimension: pyFrequency_error_flag {group_label:"Error Flags" type:number sql:case when (${pyFrequency} is null) then 1 else 0 end;;}
  dimension: yoyFrequency_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyFrequency} is null) then 1 else 0 end;;}
  dimension: netSales_error_flag {group_label:"Error Flags" type:number sql:case when (${netSales} is null) then 1 else 0 end;;}
  dimension: pyUnits_error_flag {group_label:"Error Flags" type:number sql:case when (${pyUnits} is null) then 1 else 0 end;;}
  dimension: tyTradeSales_error_flag {group_label:"Error Flags" type:number sql:case when (${tyTradeSales} is null) then 1 else 0 end;;}
  dimension: pyTradeSales_error_flag {group_label:"Error Flags" type:number sql:case when (${pyTradeSales} is null) then 1 else 0 end;;}
  dimension: yoyTradeSales_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyTradeSales} is null) then 1 else 0 end;;}
  dimension: yoyUPT_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyUPT} is null) then 1 else 0 end;;}
  dimension: tySales_error_flag {group_label:"Error Flags" type:number sql:case when (${tySales} is null) then 1 else 0 end;;}
  dimension: tyOrders_error_flag {group_label:"Error Flags" type:number sql:case when (${tyOrders} is null) then 1 else 0 end;;}
  dimension: tyAOV_error_flag {group_label:"Error Flags" type:number sql:case when (${tyAOV} is null) then 1 else 0 end;;}
  dimension: pySales_error_flag {group_label:"Error Flags" type:number sql:case when (${pySales} is null) then 1 else 0 end;;}
  dimension: pyOrders_error_flag {group_label:"Error Flags" type:number sql:case when (${pyOrders} is null) then 1 else 0 end;;}
  dimension: actual_hours_error_flag {group_label:"Error Flags" type:number sql:case when (${actual_hours} is null) then 1 else 0 end;;}
  dimension: aop_hours_error_flag {group_label:"Error Flags" type:number sql:case when (${aop_hours} is null) then 1 else 0 end;;}
  dimension: hoursVsAOP_error_flag {group_label:"Error Flags" type:number sql:case when (${hoursVsAOP} is null) then 1 else 0 end;;}
  dimension: labourBudgetPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${labourBudgetPercent} is null) then 1 else 0 end;;}
  dimension: ltoScore_error_flag {group_label:"Error Flags" type:number sql:case when (${ltoScore} is null) then 1 else 0 end;;}
  dimension: trainingScore_error_flag {group_label:"Error Flags" type:number sql:case when (${trainingScore} is null) then 1 else 0 end;;}
  dimension: holidayScore_error_flag {group_label:"Error Flags" type:number sql:case when (${holidayScore} is null) then 1 else 0 end;;}
  dimension: apprenticeshipScore_error_flag {group_label:"Error Flags" type:number sql:case when (${apprenticeshipScore} is null) then 1 else 0 end;;}
  dimension: safetyComplianceScore_error_flag {group_label:"Error Flags" type:number sql:case when (${safetyComplianceScore} is null) then 1 else 0 end;;}
  dimension: processCompScore_error_flag {group_label:"Error Flags" type:number sql:case when (${processCompScore} is null) then 1 else 0 end;;}
  dimension: shrinkageScore_error_flag {group_label:"Error Flags" type:number sql:case when (${shrinkageScore} is null) then 1 else 0 end;;}
  dimension: npsScore_error_flag {group_label:"Error Flags" type:number sql:case when (${npsScore} is null) then 1 else 0 end;;}
  dimension: anonScore_error_flag {group_label:"Error Flags" type:number sql:case when (${anonScore} is null) then 1 else 0 end;;}
  dimension: yoyFrequencyScore_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyFrequencyScore} is null) then 1 else 0 end;;}
  dimension: yoyTradeSalesScore_error_flag {group_label:"Error Flags" type:number sql:case when (${yoyTradeSalesScore} is null) then 1 else 0 end;;}
  dimension: unitsPerTransactionScore_error_flag {group_label:"Error Flags" type:number sql:case when (${unitsPerTransactionScore} is null) then 1 else 0 end;;}
  dimension: labourBudgetScore_error_flag {group_label:"Error Flags" type:number sql:case when (${labourBudgetScore} is null) then 1 else 0 end;;}
  dimension: tsClubScore_error_flag {group_label:"Error Flags" type:number sql:case when (${tsClubScore} is null) then 1 else 0 end;;}
  dimension: tsClubSales_error_flag {group_label:"Error Flags" type:number sql:case when (${tsClubSales} is null) then 1 else 0 end;;}
  dimension: tsClubSalesPercent_error_flag {group_label:"Error Flags" type:number sql:case when (${tsClubSalesPercent} is null) then 1 else 0 end;;}
  dimension: contributionVsBudget_error_flag {group_label:"Error Flags" type:number sql:case when (${contributionVsBudget} is null) then 1 else 0 end;;}
  dimension: contributionVsBudgetScore_error_flag {group_label:"Error Flags" type:number sql:case when (${contributionVsBudgetScore} is null) then 1 else 0 end;;}
  dimension: pillarTotalColleague_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarTotalColleague} is null) then 1 else 0 end;;}
  dimension: pillarTotalSimplicityEfficiency_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarTotalSimplicityEfficiency} is null) then 1 else 0 end;;}
  dimension: pillarTotalCust_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarTotalCust} is null) then 1 else 0 end;;}
  dimension: pillarRankColleague_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarRankColleague} is null) then 1 else 0 end;;}
  dimension: pillarRankSimplicityEfficiency_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarRankSimplicityEfficiency} is null) then 1 else 0 end;;}
  dimension: pillarRankCust_error_flag {group_label:"Error Flags" type:number sql:case when (${pillarRankCust} is null) then 1 else 0 end;;}
  dimension: anonBandingL_error_flag {group_label:"Error Flags" type:number sql:case when (${anonBandingL} is null) then 1 else 0 end;;}
  dimension: anonBandingM_error_flag {group_label:"Error Flags" type:number sql:case when (${anonBandingM} is null) then 1 else 0 end;;}
  dimension: anonBandingU_error_flag {group_label:"Error Flags" type:number sql:case when (${anonBandingU} is null) then 1 else 0 end;;}
  dimension: anonPercentVsTarget_error_flag {group_label:"Error Flags" type:number sql:case when (${anonPercentVsTarget} is null) then 1 else 0 end;;}

  dimension: ty_EBIT_net_sales  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "EBIT/Net Sales TY%"
    value_format_name: percent_1
    type: number
    sql: safe_divide(${tyEBIT},${netSales})  ;;
  }


  dimension: py_EBIT_net_sales  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "EBIT/Net Sales PY%"
    value_format_name: percent_1
    type: number
    sql: safe_divide(${pyEBIT},${pySales})  ;;
  }

  dimension: vs_PY_EBIT  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "vs EBIT PY"
    type: number
    sql: ${tyEBIT} - ${pyEBIT}  ;;
    value_format_name: gbp_0
  }


}
