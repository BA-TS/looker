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

  dimension: headcount_sum_12m   {
    type: number
    sql: ${TABLE}.headcount_sum_12m  ;;
    value_format: "0.00"
  }

  dimension: lto_Percent   {
    type: number
    sql: ${TABLE}.ltoPercent  ;;
    value_format: "0.00"
  }

  dimension: training_Available   {
    type: number
    sql: ${TABLE}.trainingAvailable  ;;
    value_format: "0.00"
  }

  dimension: training_Completed   {
    type: number
    sql: ${TABLE}.trainingCompleted ;;
    value_format: "0.00"
  }

  dimension: training_Percent_Completed  {
    type: number
    sql: ${TABLE}.trainingPercentCompleted  ;;
    value_format: "0.00"
  }

  dimension: appraisals   {
    type: number
    sql: ${TABLE}.appraisals  ;;
    value_format: "0.00"
  }

  dimension: colleagues   {
    type: number
    sql: ${TABLE}.colleagues  ;;
    value_format: "0.00"
  }

  dimension: appraisal_Percent  {
    type: number
    sql: ${TABLE}.appraisalPercent  ;;
    value_format: "0.00"
  }

  dimension: apprenticeship  {
    type: number
    sql: ${TABLE}.apprenticeship   ;;
    value_format: "0.00"
  }

  dimension: operational_Compliance  {
    type: number
    sql: ${TABLE}.operationalCompliance ;;
    value_format: "0.00"
  }

  dimension: hs_Visit  {
    type: number
    sql: ${TABLE}.hsVisit  ;;
    value_format: "0.00"
  }

  dimension: rm_Visit  {
    type: number
    sql: ${TABLE}. rmVisit  ;;
    value_format: "0.00"
  }

  dimension: Comp_Actual  {
    type: number
    sql: ${TABLE}.Comp_Actual  ;;
    value_format: "0.00"
  }

  dimension: moves  {
    type: number
    sql: ${TABLE}.moves  ;;
    value_format: "0.00"
  }

  dimension: units  {
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
    type: number
    sql: ${TABLE}.stockAccuracy  ;;
    value_format: "0.00"
  }

  dimension: branch_NPS  {
    type: number
    sql: ${TABLE}.branchNPS  ;;
    value_format: "0.00"
  }

  dimension: branch_Valued  {
    type: number
    sql: ${TABLE}.branchValued  ;;
    value_format: "0.00"
  }

  dimension: total_Valued  {
    type: number
    sql: ${TABLE}.totalValued  ;;
    value_format: "0.00"
  }

  dimension: rating  {
    type: number
    sql: ${TABLE}.rating  ;;
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
    type: number
    sql: ${TABLE}.anonPercent  ;;
    value_format: "0.00"
  }

  dimension: yoy_Frequency {
    type: number
    sql: ${TABLE}.yoyFrequency  ;;
    value_format: "0.00"
  }

  dimension: customer_Retention  {
    type: number
    sql: ${TABLE}.customerRetention  ;;
    value_format: "0.00"
  }

  dimension: trade_Account_Sales  {
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
    type: number
    sql: ${TABLE}.pyUnits  ;;
    value_format: "0.00"
  }

  dimension: trade_Account_Participation  {
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
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: aop_hours  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: hoursVsAOP  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: lyActualHours  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: labourT1T2Percent  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: labourT3Percent  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: tyEBIT  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: pyEBIT  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format: "0.00"
  }

  dimension: vsPYEBIT  {
    type: number
    sql: ${TABLE}.vsPYEBIT  ;;
    value_format: "0.00"
  }

  dimension: prophixSales  {
    type: number
    sql: ${TABLE}.prophixSales  ;;
    value_format: "0.00"
  }

  dimension: budget  {
    type: number
    sql: ${TABLE}.budget  ;;
    value_format: "0.00"
  }

  dimension: varBudget  {
    type: number
    sql: ${TABLE}.varBudget  ;;
    value_format: "0.00"
  }

  dimension: pyProphixSales  {
    type: number
    sql: ${TABLE}.pyProphixSales  ;;
    value_format: "0.00"
  }

  dimension: varPYNetSales  {
    type: number
    sql: ${TABLE}.varPYNetSales  ;;
    value_format: "0.00"
  }

  dimension: varPYSalesPercent  {
    type: number
    sql: ${TABLE}.varPYSalesPercent  ;;
    value_format: "0.00"
  }

  dimension: AvgSellingPriceImprov  {
    type: number
    sql: ${TABLE}.AvgSellingPriceImprov  ;;
    value_format: "0.00"
  }

  dimension: Loyalty_spend_increase  {
    type: number
    sql: ${TABLE}.Loyalty_spend_increase  ;;
    value_format: "0.00"
  }



}