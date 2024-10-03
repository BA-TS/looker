view: scorecard_branch_dev {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_24_MONTHLY_DATA_DEV`;;


  dimension: month {
    type: string
    view_label: "Date"
    label: "Year Month (yyyymm)"
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  measure: siteUID_count {
    type: count_distinct
    view_label: "Site Information"
    label: "Number of Sites"
    sql: ${siteUID} ;;
  }

  dimension: siteUID_month {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: concat(${month},${siteUID});;
    hidden: yes
    primary_key: yes
  }

  dimension: headcount_sum_12m   {
    label: "LTO Headcount (SC)"
    type: number
    sql: ${TABLE}.headcount_sum_12m  ;;
  }

  dimension: lto_Percent_sc   {
    label: "LTO % (SC)"
    type: number
    sql: ${TABLE}.ltoPercent  ;;
  }

  dimension: training_Available   {
    label: "Training Available (SC)"
    type: number
    sql: ${TABLE}.trainingAvailable  ;;
  }

  dimension: training_Completed   {
    label: "Training Completed (SC)"
    type: number
    sql: ${TABLE}.trainingCompleted ;;
  }

  dimension: training_Percent_Completed  {
    label: "Training Completed % (SC)"
    type: number
    sql: ${TABLE}.trainingPercentCompleted  ;;
  }

  dimension: appraisals   {
    label: "Appraisals (SC)"
    type: number
    sql: ${TABLE}.appraisals  ;;
  }

  dimension: colleagues   {
    label: "Colleagues (SC)"
    type: number
    sql: ${TABLE}.colleagues  ;;
  }

  dimension: appraisal_Percent  {
    label: "Appraisal % (SC)"
    type: number
    sql: ${TABLE}.appraisalPercent  ;;
  }

  dimension: apprenticeship  {
    label: "Apprenticeship (SC)"
    type: number
    sql: ${TABLE}.apprenticeship   ;;
  }

  dimension: operational_Compliance  {
    label: "Operational Compliance (SC)"
    type: number
    sql: ${TABLE}.operationalCompliance ;;
  }

  dimension: hs_Visit  {
    label: "HS Visit (SC)"
    type: number
    sql: ${TABLE}.hsVisit  ;;
  }

  dimension: rm_Visit  {
    label: "RM Visit (SC)"
    type: number
    sql: ${TABLE}. rmVisit  ;;
  }

  dimension: Comp_Actual  {
    label: "Compliance Actual (SC)"
    type: number
    sql: ${TABLE}.Comp_Actual  ;;
  }

  measure: Comp_Actual_sum  {
    type: sum
    label: "Compliance Sum"
    sql:${Comp_Actual}  ;;
  }

  measure: Comp_Actual_avg  {
    type: number
    label: "Compliance Average"
    sql:safe_divide(${Comp_Actual_sum},${siteUID_count});;
  }

  dimension: moves  {
    label: "Moves (SC)"
    type: number
    sql: ${TABLE}.moves  ;;
  }

  dimension: units  {
    label: "Units (SC)"
    type: number
    sql: ${TABLE}.units  ;;
  }

  dimension: orders  {
    type: number
    sql: ${TABLE}.orders  ;;
  }

  dimension: stock_Accuracy  {
    label: "Stock Accuracy (SC)"
    type: number
    sql: ${TABLE}.stockAccuracy  ;;
  }

  dimension: branch_NPS  {
    label: "Branch NPS (SC)"
    type: number
    sql: ${TABLE}.branchNPS  ;;
  }

  dimension: branch_Valued  {
    label: "Branch Valued (SC)"
    type: number
    sql: ${TABLE}.branchValued  ;;
  }

  dimension: branchTradeNPS  {
    label: "Branch Trade NPS (SC)"
    type: number
    sql: ${TABLE}.branchTradeNPS  ;;
  }

  dimension: rating  {
    type: number
    label: "Google Rating (SC)"
    sql: ${TABLE}.rating  ;;
  }

  measure: rating_sum  {
    type: sum
    label: "Google Rating Sum"
    sql:${rating}  ;;
  }

  measure: rating_avg  {
    type: number
    label: "Google Rating Average"
    sql:safe_divide(${rating_sum},${siteUID_count});;
  }

  dimension: anon_Orders  {
    type: number
    sql: ${TABLE}.anonOrders  ;;
  }

  dimension: total_Orders  {
    type: number
    sql: ${TABLE}.totalOrders  ;;
  }

  dimension: EbitL_TY  {
    type: number
    sql: ${TABLE}.EbitLTY  ;;
  }

  dimension: EbitL_LY  {
    type: number
    sql: ${TABLE}.EbitLLY  ;;
  }

  dimension: anon_Percent  {
    label: "Annon % (SC)"
    type: number
    sql: ${TABLE}.anonPercent  ;;
  }

  dimension: yoy_Frequency {
    label: "YOY Frequency (SC)"
    type: number
    sql: ${TABLE}.yoyFrequency  ;;
  }

  dimension: customer_Retention  {
    label: "Customer Retention % (SC)"
    type: number
    sql: ${TABLE}.customerRetention  ;;
  }

  dimension: trade_Account_Sales  {
    label: "Trade Account Sales (SC)"
    type: number
    sql: ${TABLE}.tradeAccountSales  ;;
  }

  dimension: net_Sales  {
    type: number
    sql: ${TABLE}.netSales  ;;
  }

  dimension: py_Units  {
    label: "PY Units (SC)"
    type: number
    sql: ${TABLE}.pyUnits  ;;
  }

  dimension: trade_Account_Participation  {
    label: "Trade Account Participation (SC)"
    type: number
    sql: ${TABLE}.tradeAccountParticipation  ;;
  }

  dimension: ty_Trade_Sales  {
    label: "TY Trade Sales (SC)"
    type: number
    sql: ${TABLE}.tyTradeSales  ;;
  }

  dimension: TY_Orders  {
    type: number
    sql: ${TABLE}.tyOrders  ;;
  }

  dimension: TY_AOV  {
    type: number
    sql: ${TABLE}.tyAOV  ;;
  }

  dimension: py_Sales  {
    type: number
    sql: ${TABLE}.pySales  ;;
  }

  dimension: py_Orders  {
    type: number
    sql: ${TABLE}.pyOrders  ;;
  }

  dimension: py_AOV  {
    type: number
    sql: ${TABLE}.pyAOV  ;;
  }

  dimension: target_AOV  {
    type: number
    sql: ${TABLE}.targetAOV  ;;
  }

  dimension: vs_Target_AOV  {
    label: "AOV v Target (SC)"
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
  }

  dimension: actual_hours  {
    label: "AOP Hours (SC)"
    type: number
    sql: ${TABLE}.actual_hours  ;;
  }

  dimension: aop_hours  {
    label: "AOP Hours (SC)"
    type: number
    sql: ${TABLE}.aop_hours  ;;
  }

  dimension: hours_Vs_AOP  {
    label: "Hours vs AOP (SC)"
    type: number
    sql: ${TABLE}.hoursVsAOP  ;;
  }

  dimension: ly_Actual_Hours  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
  }

  dimension: labour_T1T2_Percent  {
    label: "Labour T1T2% (SC)"
    type: number
    sql: ${TABLE}.labourT1T2Percent  ;;
  }

  dimension: labour_T3_Percent  {
    label: "Labour T3% (SC)"
    type: number
    sql: ${TABLE}.labourT3Percent  ;;
  }

  dimension: ty_EBIT  {
    type: number
    sql: ${TABLE}.tyEBIT  ;;
  }

  dimension: py_EBIT  {
    type: number
    sql: ${TABLE}.tyEBIT  ;;
  }

  dimension: vs_PY_EBIT  {
    type: number
    sql: ${TABLE}.vsPYEBIT  ;;
  }

  dimension: prophix_Sales  {
    type: number
    sql: ${TABLE}.prophixSales  ;;
  }

  dimension: budget  {
    type: number
    sql: ${TABLE}.budget  ;;
  }

  dimension: var_Budget  {
    type: number
    sql: ${TABLE}.varBudget  ;;
  }

  dimension: py_Prophix_Sales  {
    type: number
    sql: ${TABLE}.pyProphixSales  ;;
  }

  dimension: var_PY_Net_Sales  {
    type: number
    sql: ${TABLE}.varPYNetSales  ;;
  }

  dimension: var_PY_Sales_Percent  {
    type: number
    sql: ${TABLE}.varPYSalesPercent  ;;
  }

  dimension: Avg_Selling_Price_Improv  {
    label: "Avg Selling Price Improvement (SC)"
    type: number
    sql: ${TABLE}.AvgSellingPriceImprov  ;;
  }

  dimension: Loyalty_spend_increase  {
    label: "Loyalty Spend Increase (SC)"
    type: number
    sql: ${TABLE}.Loyalty_spend_increase  ;;
  }

  dimension: ty_retail_trading_profit  {
    label: "TY Trading Profit (SC)"
    type: number
    sql: ${TABLE}.tyRetailTradingProfit  ;;
  }

  dimension: aop_retail_trading_profit  {
    label: "AOP Trading Profit (SC)"
    type: number
    sql: ${TABLE}.aopRetailTradingProfit  ;;
  }

  dimension: vs_AOP_retail_trading_profit  {
    label: "vs AOP Trading Profit (SC)"
    type: number
    sql: ${TABLE}.vsAOPRetailTradingProfit  ;;
  }

  dimension: yoy_average_items  {
    label: "YOY Average Items (SC)"
    type: number
    sql: ${TABLE}.yoyAverageItems  ;;
  }

  dimension: holiday_Q1_Month_Entitlement  {
    type: number
    sql: ${TABLE}.holidayQ1MonthEntitlement  ;;
  }

  dimension: holiday_Q1_Taken_In_Quarter  {
    label: "Holiday Taken Q1"
    type: number
    sql: ${TABLE}.holidayQ1TakenInQuarter ;;
  }

  dimension: holiday_Q1_Taken_Percent  {
    label: "Holiday Taken Q1 %"
    type: number
    sql: ${TABLE}.holidayQ1TakenPercent  ;;
  }

  dimension: holiday_Q2_Month_Entitlement  {
    type: number
    sql: ${TABLE}.holidayQ2MonthEntitlement  ;;
  }

  dimension: holiday_Q2_Taken_In_Quarter  {
    label: "Holiday Taken Q2"
    type: number
    sql: ${TABLE}.holidayQ2TakenInQuarter ;;
  }

  dimension: holiday_Q2_Taken_Percent  {
    label: "Holiday Taken Q2 %"
    type: number
    sql: ${TABLE}.holidayQ2TakenPercent  ;;
  }

  dimension: holiday_Q3_Month_Entitlement  {
    type: number
    sql: ${TABLE}.holidayQ3MonthEntitlement  ;;
  }

  dimension: holiday_Q3_Taken_In_Quarter  {
    label: "Holiday Taken Q3"
    type: number
    sql: ${TABLE}.holidayQ3TakenInQuarter ;;
  }

  dimension: holiday_Q3_Taken_Percent  {
    label: "Holiday Taken Q3 %"
    type: number
    sql: ${TABLE}.holidayQ3TakenPercent  ;;
  }

  dimension: holiday_Q4_Month_Entitlement  {
    type: number
    sql: ${TABLE}.holidayQ4MonthEntitlement  ;;
  }

  dimension: holiday_Q4_Taken_In_Quarter  {
    label: "Holiday Taken Q4"
    type: number
    sql: ${TABLE}.holidayQ4TakenInQuarter ;;
  }

  dimension: holiday_Q4_Taken_Percent  {
    label: "Holiday Taken Q4 %"
    type: number
    sql: ${TABLE}.holidayQ4TakenPercent  ;;
  }






}
