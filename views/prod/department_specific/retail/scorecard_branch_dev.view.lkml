include: "/views/**/transactions.view"
include: "/views/**/retail/**.view"
include: "/views/**/rm_visits.view"

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
    label: "Site UID (Scorecard Testing, incl Region/Division)"
    sql: ${TABLE}.siteUID ;;
    # hidden: yes
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
    value_format_name: percent_1
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
    value_format_name: percent_1
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
    value_format_name: percent_1
  }

  dimension: apprenticeship  {
    label: "Apprenticeship (SC)"
    type: number
    sql: ${TABLE}.apprenticeship   ;;
  }

  dimension: operational_Compliance  {
    label: "Operational Compliance Completed %(SC)"
    type: number
    sql: ${TABLE}.operationalCompliance ;;
    value_format_name: percent_1
  }

  dimension: hs_Visit  {
    label: "HS Visit (SC)"
    type: number
    sql: ${TABLE}.hsVisit  ;;
  }

  dimension: rm_Visit  {
    label: "RM Visit (SC)"
    type: number
    sql: cast(${TABLE}.rmVisit as decimal)  ;;
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
    value_format_name: percent_1
  }


  dimension: nps  {
    label: "NPS (SC)"
    type: number
    sql: ${TABLE}.branchNPS  ;;
    value_format_name: decimal_0
  }

  dimension: valued  {
    label: "Valued (SC)"
    type: number
    sql: ${TABLE}.branchValued  ;;
    value_format_name: decimal_2
  }

  dimension: trade_nps  {
    label: "NPS Trade (SC)"
    type: number
    sql: ${TABLE}.branchTradeNPS  ;;
    value_format_name: decimal_0
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
    value_format_name: percent_1
  }

  dimension: ty_Frequency {
    label: "TY Frequency (SC)"
    type: number
    sql: ${TABLE}.tyFrequency  ;;
    value_format_name: decimal_2
  }

  dimension: py_Frequency {
    label: "PY Frequency (SC)"
    type: number
    sql: ${TABLE}.pyFrequency  ;;
    value_format_name: decimal_2
  }

  dimension: yoy_Frequency {
    label: "YOY Frequency (SC)"
    type: number
    sql: ${TABLE}.yoyFrequency  ;;
    value_format_name: percent_1
  }

  dimension: customer_Retention  {
    label: "Customer Retention % (SC)"
    type: number
    sql: ${TABLE}.customerRetention  ;;
    value_format_name: percent_1
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
    value_format_name: percent_1
  }

  dimension: ty_Trade_Sales  {
    label: "TY Trade Sales (SC)"
    type: number
    sql: ${TABLE}.tyTradeSales  ;;
    value_format_name: decimal_0
  }

  dimension: py_Trade_Sales  {
    label: "PY Trade Sales (SC)"
    type: number
    sql: ${TABLE}.pyTradeSales  ;;
    value_format_name: decimal_0
  }

  dimension: yoy_Trade_Sales  {
    label: "YoY Trade Sales (SC)"
    type: number
    sql: ${TABLE}.yoyTradeSales  ;;
    value_format_name: percent_1
  }

  dimension: ty_trade_ACS  {
    label: "TY Trade ACS (SC)"
    type: number
    sql: ${TABLE}.tyTradeACS  ;;
    value_format_name: decimal_1
  }

  dimension: py_trade_ACS  {
    label: "PY Trade ACS (SC)"
    type: number
    sql: ${TABLE}.pyTradeACS  ;;
    value_format_name: decimal_1
  }

  dimension: yoy_trade_ACS  {
    label: "YOY Trade ACS (SC)"
    type: number
    sql: ${TABLE}.yoyTradeACS  ;;
    value_format_name: percent_1
  }

  dimension: TY_Orders  {
    type: number
    sql: ${TABLE}.tyOrders  ;;
  }

  dimension: TY_AOV  {
    type: number
    sql: ${TABLE}.tyAOV  ;;
    value_format_name: decimal_2
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
    value_format_name: decimal_2
  }

  dimension: target_AOV  {
    type: number
    sql: ${TABLE}.targetAOV  ;;
    value_format_name: decimal_1
  }

  dimension: vs_Target_AOV  {
    label: "AOV v Target (SC)"
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format_name: percent_1
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
    value_format_name: percent_1
  }


  dimension: labour_T3_Percent  {
    label: "Labour T3% (SC)"
    type: number
    sql: ${TABLE}.labourT3Percent  ;;
    value_format_name: percent_1
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
    value_format_name: percent_1
  }

  dimension: Avg_Selling_Price_Improv  {
    label: "Avg Selling Price Improvement (SC)"
    type: number
    sql: ${TABLE}.AvgSellingPriceImprov  ;;
    value_format_name: percent_1
  }

  dimension: Loyalty_spend_increase  {
    label: "Loyalty Spend Increase (SC)"
    type: number
    sql: ${TABLE}.Loyalty_spend_increase  ;;
    value_format_name: percent_1
  }

  dimension: ty_retail_trading_profit  {
    label: "TY Trading Profit (SC)"
    type: number
    sql: ${TABLE}.tyRetailTradingProfit  ;;
    value_format_name: decimal_0
  }

  dimension: aop_retail_trading_profit  {
    label: "AOP Trading Profit (SC)"
    type: number
    sql: ${TABLE}.aopRetailTradingProfit  ;;
    value_format_name: decimal_0
  }

  dimension: vs_AOP_retail_trading_profit  {
    label: "Trading Profit vs AOP (SC)"
    type: number
    sql: ${TABLE}.vsAOPRetailTradingProfit  ;;
    value_format_name: percent_1
  }

  dimension: yoy_average_items  {
    label: "YOY Average Items (SC)"
    type: number
    sql: ${TABLE}.yoyAverageItems  ;;
    value_format_name: percent_1
  }

  dimension: holiday_Q1_Month_Entitlement  {
    label: "Holiday Entitlement Q1 (SC)"
    type: number
    sql: ${TABLE}.holidayQ1MonthEntitlement  ;;
  }

  dimension: holiday_Q1_Taken_In_Quarter  {
    label: "Holiday Taken Q1 (SC)"
    type: number
    sql: ${TABLE}.holidayQ1TakenInQuarter ;;
  }

  dimension: holiday_Q1_Taken_Percent  {
    label: "Holiday Taken% Q1 (SC)"
    type: number
    sql: ${TABLE}.holidayQ1TakenPercent  ;;
    value_format_name: percent_1
  }

  dimension: holiday_Q2_Month_Entitlement  {
    label: "Holiday Entitlement Q2 (SC)"
    type: number
    sql: ${TABLE}.holidayQ2MonthEntitlement  ;;
  }

  dimension: holiday_Q2_Taken_In_Quarter  {
    label: "Holiday Taken Q2 (SC)"
    type: number
    sql: ${TABLE}.holidayQ2TakenInQuarter ;;
  }

  dimension: holiday_Q2_Taken_Percent  {
    label: "Holiday Taken% Q2 (SC)"
    type: number
    sql: ${TABLE}.holidayQ2TakenPercent  ;;
    value_format_name: percent_1
  }

  dimension: holiday_Q3_Month_Entitlement  {
    label: "Holiday Entitlement Q3 (SC)"
    type: number
    sql: ${TABLE}.holidayQ3MonthEntitlement  ;;
  }

  dimension: holiday_Q3_Taken_In_Quarter  {
    label: "Holiday Taken Q3 (SC)"
    type: number
    sql: ${TABLE}.holidayQ3TakenInQuarter ;;
  }

  dimension: holiday_Q3_Taken_Percent  {
    label: "Holiday Taken% Q3 (SC)"
    type: number
    sql: ${TABLE}.holidayQ3TakenPercent  ;;
    value_format_name: percent_1
  }

  dimension: holiday_Q4_Month_Entitlement  {
    label: "Holiday Entitlement Q4 (SC)"
    type: number
    sql: ${TABLE}.holidayQ4MonthEntitlement  ;;
  }

  dimension: holiday_Q4_Taken_In_Quarter  {
    label: "Holiday Taken Q4 (SC)"
    type: number
    sql: ${TABLE}.holidayQ4TakenInQuarter ;;
  }

  dimension: holiday_Q4_Taken_Percent  {
    label: "Holiday Taken% Q4 (SC)"
    type: number
    sql: ${TABLE}.holidayQ4TakenPercent  ;;
    value_format_name: percent_1
  }

# Error Flags  --------------------------------------------------------------------
  dimension: stock_accuracy_error_flag {
    type: number
    sql: case when
    (${stock_Accuracy} is null) then 1
     when abs(coalesce(${stock_moves.moves},0)-coalesce(${moves},0))>0 then 2
      else 0 end;;
  }

  dimension: labour_T1T2_error_flag  {
    type: number
    sql: case when
    ${sites.Is_consistent_branch} = true and ${sites.labourTier} != "Tier 3" and ${labour_T1T2_Percent} is null then 1 else 0 end;;
  }

  dimension: trade_Account_Participation_error_flag  {
    type: number
    sql: case when ${trade_Account_Participation} is null then 1 else 0 end;;
  }

  # dimension: rm_Visit_error_flag {
  #   type: number
  #   sql: case when
  #     case when
  #   (${rm_visits.score}!=${rm_Visit}) then 1
  #     --when ${rm_Visit} is null then 2
  #     --when ${rm_visits.score} is null then 4
  #     else  5
  #     end;;
  # }

  dimension: yoy_Trade_Sales_error_flag  {
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${yoy_Trade_Sales} is null then 1 else 0 end;;
  }

  dimension: yoy_Frequency_error_flag {
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${yoy_Frequency} is null then 1 else 0 end;;
  }

  dimension: vs_AOP_retail_trading_profit_error_flag  {
    label: "Trading Profit vs AOP Error Flag(SC)"
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${vs_AOP_retail_trading_profit} is null  then 1 else 0 end;;
  }

  dimension: vs_Target_AOV_error_flag  {
    type: number
    sql: case when  ${sites.Is_consistent_branch} = true and ${vs_Target_AOV} is null  then 1 else 0 end;;
  }

  dimension: yoy_trade_ACS_error_flag  {
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${yoy_trade_ACS} is null then 1 else 0 end;;
  }


  dimension: yoy_average_items_error_flag  {
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${yoy_average_items} is null  then 1 else 0 end;;
  }

  dimension: labour_T3_error_flag  {
    type: number
    sql: case when
    ${sites.Is_consistent_branch} = true and ${sites.labourTier} = "Tier 3" and ${labour_T3_Percent} is null then 1 else 0 end;;
  }

  dimension: lto_error_flag {
    type: number
    sql: case when (${lto_Percent_sc} is null) then 1
         when abs(coalesce(${lto.lto},0)-coalesce(${lto_Percent_sc},0))>0 then 2
         else 0 end;;
  }

  dimension: operational_compliance_error_flag {
    type: number
    sql: case when (${operational_Compliance} is null) then 1
         when abs(coalesce(${operational_compliance.percentage_complete},0)-coalesce(${operational_Compliance},0))>0 then 2
         else 0 end;;
  }

  dimension: holiday_Q1_error_flag {
    type: number
    sql: case when (${holiday_Q1_Taken_Percent} is null) then 1 else 0 end;;
  }

  dimension: holiday_Q2_error_flag {
    type: number
    sql: case when
    (${holiday_Q2_Taken_Percent} is null) then 1 else 0 end;;
  }

  dimension: holiday_Q3_error_flag {
    type: number
    sql: case when (${holiday_Q3_Taken_Percent} is null) then 1 else 0 end;;
  }

  dimension: holiday_Q4_error_flag {
    type: number
    sql: case when (${holiday_Q4_Taken_Percent} is null) then 1 else 0 end;;
  }


  dimension: training_error_flag {
    type: number
    sql:
    case when (${training_Percent_Completed} is null) then 1
          when abs(coalesce(${training.completed_percent},0)-coalesce(${training_Percent_Completed},0))>0 then 2
          else 0
          end
          ;;
  }

  dimension: appraisals_error_flag {
    type: number
    sql: case when (${appraisal_Percent} is null) then 1
         when abs(coalesce(${appraisal_Percent},0)-coalesce(${appraisals.appraisal_percent},0))>0 then 2
         else 0
         end;;
  }

    dimension: rm_visit_error_flag {
    type: number
    sql:
    case when (${rm_Visit} is null) then 1
    when abs(coalesce(${rm_visits.score},0)-coalesce(${rm_Visit},0))>0 then 2
    else 0
    end;;
  }

  dimension: google_rating_error_flag {
    type: number
    sql:
    case when (${rating} is null) then 1
    when abs(coalesce(${google_reviews.rating},0)-coalesce(${rating},0))>0 then 2
    else 0
    end;;
  }

  dimension: nps_error_flag {
    type: number
    sql:
    case when (${nps} is null) then 1
    when abs(coalesce( ${customer_experience.nps},0)-coalesce(${nps},0))>0 then 2
    else 0
    end;;
  }

  dimension: valued_error_flag {
    type: number
    sql:
    case when (${valued} is null) then 1
    when abs(coalesce( ${customer_experience.valued},0)-coalesce(${valued},0))>0 then 2
    else 0
    end;;
  }

  dimension: nps_trade_error_flag {
    type: number
    sql: case when (${trade_nps} is null) then 1
    when abs(coalesce( ${customer_experience_trade.nps},0)-coalesce(${trade_nps},0))>0 then 2
    else 0 end;;
  }

  dimension: compliance_support_error_flag {
    type: number
    sql: case when (${Comp_Actual} is null) then 1 else 0 end;;
  }

}
