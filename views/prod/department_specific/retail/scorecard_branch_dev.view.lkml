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
    value_format: "0.00"
  }

  dimension: lto_Percent_sc   {
    label: "LTO % (SC)"
    type: number
    sql: ${TABLE}.ltoPercent  ;;
    value_format: "0.00"
  }

  dimension: training_Available   {
    label: "Training Available (SC)"
    type: number
    sql: ${TABLE}.trainingAvailable  ;;
    value_format: "0.00"
  }

  dimension: training_Completed   {
    label: "Training Completed (SC)"
    type: number
    sql: ${TABLE}.trainingCompleted ;;
    value_format: "0.00"
  }

  dimension: training_Percent_Completed  {
    label: "Training Completed % (SC)"
    type: number
    sql: ${TABLE}.trainingPercentCompleted  ;;
    value_format: "0.00"
  }

  dimension: appraisals   {
    label: "Appraisals (SC)"
    type: number
    sql: ${TABLE}.appraisals  ;;
    value_format: "0.00"
  }

  dimension: colleagues   {
    label: "Colleagues (SC)"
    type: number
    sql: ${TABLE}.colleagues  ;;
    value_format: "0.00"
  }

  dimension: appraisal_Percent  {
    label: "Appraisal % (SC)"
    type: number
    sql: ${TABLE}.appraisalPercent  ;;
    value_format: "0.00"
  }

  dimension: apprenticeship  {
    label: "Apprenticeship (SC)"
    type: number
    sql: ${TABLE}.apprenticeship   ;;
    value_format: "0.00"
  }

  dimension: operational_Compliance  {
    label: "Operational Compliance (SC)"
    type: number
    sql: ${TABLE}.operationalCompliance ;;
    value_format: "0.00"
  }

  dimension: hs_Visit  {
    label: "HS Visit (SC)"
    type: number
    sql: ${TABLE}.hsVisit  ;;
    value_format: "0.00"
  }

  dimension: rm_Visit  {
    label: "RM Visit (SC)"
    type: number
    sql: ${TABLE}. rmVisit  ;;
    value_format: "0.00"
  }

  dimension: Comp_Actual  {
    label: "Compliance Actual (SC)"
    type: number
    sql: ${TABLE}.Comp_Actual  ;;
    value_format: "0.00"
  }

  measure: Comp_Actual_sum  {
    type: sum
    label: "Compliance Sum"
    sql:${Comp_Actual}  ;;
    value_format: "0.00"
  }

  measure: Comp_Actual_avg  {
    type: number
    label: "Compliance Average"
    sql:safe_divide(${Comp_Actual_sum},${siteUID_count});;
    value_format: "0.00"
  }

  dimension: moves  {
    label: "Moves (SC)"
    type: number
    sql: ${TABLE}.moves  ;;
    value_format: "0.00"
  }

  dimension: units  {
    label: "Units (SC)"
    type: number
    sql: ${TABLE}.units  ;;
    value_format: "0.00"
  }

  dimension: orders  {
    type: number
    sql: ${TABLE}.orders  ;;
    value_format: "0.00"
  }

  dimension: stock_Accuracy  {
    label: "Stock Accuracy (SC)"
    type: number
    sql: ${TABLE}.stockAccuracy  ;;
    value_format: "0.00"
  }

  dimension: branch_NPS  {
    label: "Branch NPS (SC)"
    type: number
    sql: ${TABLE}.branchNPS  ;;
    value_format: "0.00"
  }

  dimension: branch_Valued  {
    label: "Branch Valued (SC)"
    type: number
    sql: ${TABLE}.branchValued  ;;
    value_format: "0.00"
  }

  dimension: branchTradeNPS  {
    label: "Branch Trade NPS (SC)"
    type: number
    sql: ${TABLE}.branchTradeNPS  ;;
    value_format: "0.00"
  }

  dimension: rating  {
    type: number
    label: "Google Rating (SC)"
    sql: ${TABLE}.rating  ;;
    value_format: "0.00"
  }

  measure: rating_sum  {
    type: sum
    label: "Google Rating Sum"
    sql:${rating}  ;;
    value_format: "0.00"
  }

  measure: rating_avg  {
    type: number
    label: "Google Rating Average"
    sql:safe_divide(${rating_sum},${siteUID_count});;
    value_format: "0.00"
  }

  dimension: anon_Orders  {
    type: number
    sql: ${TABLE}.anonOrders  ;;
    value_format: "0.00"
  }

  dimension: total_Orders  {
    type: number
    sql: ${TABLE}.totalOrders  ;;
    value_format: "0.00"
  }

  dimension: EbitL_TY  {
    type: number
    sql: ${TABLE}.EbitLTY  ;;
    value_format: "0.00"
  }

  dimension: EbitL_LY  {
    type: number
    sql: ${TABLE}.EbitLLY  ;;
    value_format: "0.00"
  }

  dimension: anon_Percent  {
    label: "Annon % (SC)"
    type: number
    sql: ${TABLE}.anonPercent  ;;
    value_format: "0.00"
  }

  dimension: yoy_Frequency {
    label: "YOY Frequency (SC)"
    type: number
    sql: ${TABLE}.yoyFrequency  ;;
    value_format: "0.00"
  }

  dimension: customer_Retention  {
    label: "Customer Retention % (SC)"
    type: number
    sql: ${TABLE}.customerRetention  ;;
    value_format: "0.00"
  }

  dimension: trade_Account_Sales  {
    label: "Trade Account Sales (SC)"
    type: number
    sql: ${TABLE}.tradeAccountSales  ;;
    value_format: "0.00"
  }

  dimension: net_Sales  {
    type: number
    sql: ${TABLE}.netSales  ;;
    value_format: "0.00"
  }

  dimension: py_Units  {
    label: "PY Units (SC)"
    type: number
    sql: ${TABLE}.pyUnits  ;;
    value_format: "0.00"
  }

  dimension: trade_Account_Participation  {
    label: "Trade Account Participation (SC)"
    type: number
    sql: ${TABLE}.tradeAccountParticipation  ;;
    value_format: "0.00"
  }

  dimension: ty_Trade_Sales  {
    type: number
    sql: ${TABLE}.tyTradeSales  ;;
    value_format: "0.00"
  }

  dimension: TY_Orders  {
    type: number
    sql: ${TABLE}.tyOrders  ;;
    value_format: "0.00"
  }

  dimension: TY_AOV  {
    type: number
    sql: ${TABLE}.tyAOV  ;;
    value_format: "0.00"
  }

  dimension: py_Sales  {
    type: number
    sql: ${TABLE}.pySales  ;;
    value_format: "0.00"
  }

  dimension: py_Orders  {
    type: number
    sql: ${TABLE}.pyOrders  ;;
    value_format: "0.00"
  }

  dimension: py_AOV  {
    type: number
    sql: ${TABLE}.pyAOV  ;;
    value_format: "0.00"
  }

  dimension: target_AOV  {
    type: number
    sql: ${TABLE}.targetAOV  ;;
    value_format: "0.00"
  }

  dimension: vs_Target_AOV  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: actual_hours  {
    label: "AOP Hours (SC)"
    type: number
    sql: ${TABLE}.actual_hours  ;;
    value_format: "0.00"
  }

  dimension: aop_hours  {
    label: "AOP Hours (SC)"
    type: number
    sql: ${TABLE}.aop_hours  ;;
    value_format: "0.00"
  }

  dimension: hours_Vs_AOP  {
    label: "Hours vs AOP (SC)"
    type: number
    sql: ${TABLE}.hoursVsAOP  ;;
    value_format: "0.00"
  }

  dimension: ly_Actual_Hours  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: labour_T1T2_Percent  {
    label: "Labour T1T2% (SC)"
    type: number
    sql: ${TABLE}.labourT1T2Percent  ;;
    value_format: "0.00"
  }

  dimension: labour_T3_Percent  {
    label: "Labour T3% (SC)"
    type: number
    sql: ${TABLE}.labourT3Percent  ;;
    value_format: "0.00"
  }

  dimension: ty_EBIT  {
    type: number
    sql: ${TABLE}.tyEBIT  ;;
    value_format: "0.00"
  }

  dimension: py_EBIT  {
    type: number
    sql: ${TABLE}.tyEBIT  ;;
    value_format: "0.00"
  }

  dimension: vs_PY_EBIT  {
    type: number
    sql: ${TABLE}.vsPYEBIT  ;;
    value_format: "0.00"
  }

  dimension: prophix_Sales  {
    type: number
    sql: ${TABLE}.prophixSales  ;;
    value_format: "0.00"
  }

  dimension: budget  {
    type: number
    sql: ${TABLE}.budget  ;;
    value_format: "0.00"
  }

  dimension: var_Budget  {
    type: number
    sql: ${TABLE}.varBudget  ;;
    value_format: "0.00"
  }

  dimension: py_Prophix_Sales  {
    type: number
    sql: ${TABLE}.pyProphixSales  ;;
    value_format: "0.00"
  }

  dimension: var_PY_Net_Sales  {
    type: number
    sql: ${TABLE}.varPYNetSales  ;;
    value_format: "0.00"
  }

  dimension: var_PY_Sales_Percent  {
    type: number
    sql: ${TABLE}.varPYSalesPercent  ;;
    value_format: "0.00"
  }

  dimension: Avg_Selling_Price_Improv  {
    type: number
    sql: ${TABLE}.AvgSellingPriceImprov  ;;
    value_format: "0.00"
  }

  dimension: Loyalty_spend_increase  {
    label: "Loyalty Spend Increase (SC)"
    type: number
    sql: ${TABLE}.Loyalty_spend_increase  ;;
    value_format: "0.00"
  }
}
