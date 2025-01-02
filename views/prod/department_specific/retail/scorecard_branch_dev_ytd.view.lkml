include: "/views/**/transactions.view"
include: "/views/**/retail/**.view"
include: "/views/**/rm_visits.view"
include: "/views/**/training.view"

view: scorecard_branch_dev_ytd {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_24_YTD_DATA_FINAL_DEV`;;


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

  dimension: headcount_sum_12m   {
    label: "LTO Headcount YTD (SC)"
    type: number
    sql: ${TABLE}.headcount_sum_12m  ;;
  }

  dimension: lto_Percent_sc   {
    label: "LTO % YTD (SC)"
    type: number
    sql: ${TABLE}.ltoPercent  ;;
    value_format_name: percent_1
  }

  dimension: training_Available   {
    label: "Training Available YTD (SC)"
    type: number
    sql: ${TABLE}.trainingAvailable  ;;
  }

  dimension: training_Completed   {
    label: "Training Completed YTD (SC)"
    type: number
    sql: ${TABLE}.trainingCompleted ;;
  }

  dimension: training_Percent_Completed  {
    label: "Training Completed % YTD (SC)"
    type: number
    sql: ${TABLE}.trainingPercentCompleted  ;;
    value_format_name: percent_1
  }

  # dimension: appraisals   {
  #   label: "Appraisals YTD (SC)"
  #   type: number
  #   sql: ${TABLE}.appraisals  ;;
  # }

  dimension: colleagues   {
    label: "Colleagues YTD (SC)"
    type: number
    sql: ${TABLE}.colleagues  ;;
  }

  dimension: appraisal_Percent  {
    label: "Appraisal % YTD (SC)"
    type: number
    sql: ${TABLE}.appraisalPercent  ;;
    value_format_name: percent_1
  }

  dimension: apprenticeship  {
    label: "Apprenticeship YTD (SC)"
    type: number
    sql: ${TABLE}.apprenticeship   ;;
  }

  dimension: operational_Compliance  {
    label: "Operational Compliance Completed %YTD (SC)"
    type: number
    sql: ${TABLE}.operationalCompliance ;;
    value_format_name: percent_1
  }

  dimension: hs_Visit  {
    label: "HS Visit YTD (SC)"
    type: number
    sql: ${TABLE}.hsVisit  ;;
  }

  dimension: rm_Visit  {
    label: "RM Visit YTD (SC)"
    type: number
    sql: cast(${TABLE}.rmVisit as decimal)  ;;
  }

  dimension: Comp_Actual  {
    label: "Compliance Actual YTD (SC)"
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
    value_format_name: decimal_1
  }

  dimension: moves  {
    label: "Moves YTD (SC)"
    type: number
    sql: ${TABLE}.moves  ;;
  }

  dimension: units  {
    label: "Units YTD (SC)"
    type: number
    sql: ${TABLE}.units  ;;
  }

  dimension: orders  {
    type: number
    sql: ${TABLE}.orders  ;;
  }

  dimension: stock_Accuracy  {
    label: "Stock Accuracy YTD (SC)"
    type: number
    sql: ${TABLE}.stockAccuracy  ;;
    value_format_name: percent_1
  }


  dimension: nps  {
    label: "NPS YTD (SC)"
    type: number
    sql: ${TABLE}.branchNPS  ;;
    value_format_name: decimal_0
  }

  dimension: valued  {
    label: "Valued YTD (SC)"
    type: number
    sql: ${TABLE}.branchValued  ;;
    value_format_name: decimal_2
  }

  dimension: trade_nps  {
    label: "NPS Trade YTD (SC)"
    type: number
    sql: ${TABLE}.branchTradeNPS  ;;
    value_format_name: decimal_0
  }

  dimension: rating  {
    type: number
    label: "Google Rating YTD (SC)"
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
    value_format_name: decimal_1
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
    view_label: "P&L"
    label: "Direct Salary Total YTD TY"
    group_label: "Direct Salary Total"
    type: number
    sql: ${TABLE}.EbitLTY  ;;
    value_format_name: gbp_0
  }

  dimension: EbitL_LY  {
    view_label: "P&L"
    group_label: "Direct Salary Total"
    label: "Direct Salary Total YTD PY"
    type: number
    sql: ${TABLE}.EbitLLY  ;;
    value_format_name: gbp_0
  }

  dimension: anon_Percent  {
    label: "Annon % YTD (SC)"
    type: number
    sql: ${TABLE}.anonPercent  ;;
    value_format_name: percent_1
  }

  dimension: ty_Frequency {
    label: "TY Frequency YTD (SC)"
    type: number
    sql: ${TABLE}.tyFrequency  ;;
    value_format_name: decimal_2
  }

  dimension: py_Frequency {
    label: "PY Frequency YTD (SC)"
    type: number
    sql: ${TABLE}.pyFrequency  ;;
    value_format_name: decimal_2
  }

  dimension: yoy_Frequency {
    label: "YOY Frequency YTD (SC)"
    type: number
    sql: ${TABLE}.yoyFrequency  ;;
    value_format_name: percent_1
  }

  dimension: customer_Retention  {
    label: "Customer Retention % YTD (SC)"
    type: number
    sql: ${TABLE}.customerRetention  ;;
    value_format_name: percent_1
  }

  dimension: trade_Account_Sales  {
    label: "Trade Account Sales YTD (SC)"
    type: number
    sql: ${TABLE}.tradeAccountSales  ;;
    value_format_name: gbp_0
  }

  dimension: net_Sales  {
    type: number
    sql: ${TABLE}.netSales  ;;
    value_format_name: gbp_0
  }

  dimension: py_Units  {
    label: "PY Units YTD (SC)"
    type: number
    sql: ${TABLE}.pyUnits  ;;
  }

  dimension: trade_Account_Participation  {
    label: "Trade Account Participation YTD (SC)"
    type: number
    sql: ${TABLE}.tradeAccountParticipation  ;;
    value_format_name: percent_1
  }

  dimension: ty_Trade_Sales  {
    label: "TY Trade Sales YTD (SC)"
    type: number
    sql: ${TABLE}.tyTradeSales  ;;
    value_format_name: decimal_0
  }

  dimension: py_Trade_Sales  {
    label: "PY Trade Sales YTD (SC)"
    type: number
    sql: ${TABLE}.pyTradeSales  ;;
    value_format_name: decimal_0
  }

  dimension: yoy_Trade_Sales  {
    label: "YoY Trade Sales YTD (SC)"
    type: number
    sql: ${TABLE}.yoyTradeSales  ;;
    value_format_name: percent_1
  }

  dimension: ty_trade_ACS  {
    label: "TY Trade ACS YTD (SC)"
    type: number
    sql: ${TABLE}.tyTradeACS  ;;
    value_format_name: decimal_1
  }

  dimension: py_trade_ACS  {
    label: "PY Trade ACS YTD (SC)"
    type: number
    sql: ${TABLE}.pyTradeACS  ;;
    value_format_name: decimal_1
  }

  dimension: yoy_trade_ACS  {
    label: "YOY Trade ACS YTD (SC)"
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
    value_format_name: gbp_0
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
    label: "AOV v Target YTD (SC)"
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
    value_format_name: percent_1
  }

  dimension: actual_hours  {
    label: "AOP Hours YTD (SC)"
    type: number
    sql: ${TABLE}.actual_hours  ;;
  }

  dimension: aop_hours  {
    label: "AOP Hours YTD (SC)"
    type: number
    sql: ${TABLE}.aop_hours  ;;
  }

  dimension: hours_Vs_AOP  {
    label: "Hours vs AOP YTD (SC)"
    type: number
    sql: ${TABLE}.hoursVsAOP  ;;
  }

  dimension: ly_Actual_Hours  {
    type: number
    sql: ${TABLE}.vsTargetAOV  ;;
  }

  dimension: labour_T1T2_Percent  {
    label: "Labour T1T2% YTD (SC)"
    type: number
    sql: ${TABLE}.labourT1T2Percent  ;;
    value_format_name: percent_1
  }


  dimension: labour_T3_Percent  {
    label: "Labour T3% YTD (SC)"
    type: number
    sql: ${TABLE}.labourT3Percent  ;;
    value_format_name: percent_1
  }

  dimension: ty_EBIT  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "EBIT TY"
    value_format_name: gbp_0
    type: number
    sql: ${TABLE}.tyEBIT  ;;
  }

  dimension: ty_EBIT_net_sales  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "EBIT/Net Sales TY%"
    value_format_name: percent_1
    type: number
    sql: safe_divide(${ty_EBIT},${net_Sales})  ;;
  }

  dimension: py_EBIT  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "EBIT PY"
    value_format_name: gbp_0
    type: number
    sql: ${TABLE}.pyEBIT  ;;
  }

  dimension: py_EBIT_net_sales  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "EBIT/Net Sales PY%"
    value_format_name: percent_1
    type: number
    sql: safe_divide(${py_EBIT},${py_Sales})  ;;
  }

  dimension: vs_PY_EBIT  {
    view_label: "P&L"
    group_label: "EBIT"
    label: "vs EBIT PY"
    type: number
    sql: ${ty_EBIT} - ${py_EBIT}  ;;
    value_format_name: gbp_0
  }

  dimension: prophix_Sales  {
    type: number
    sql: ${TABLE}.prophixSales  ;;
    value_format_name: gbp_0
  }

  dimension: budget  {
    type: number
    sql: ${TABLE}.budget  ;;
    value_format_name: gbp_0
  }

  dimension: var_Budget  {
    type: number
    sql: ${TABLE}.varBudget  ;;
    value_format_name: gbp_0
  }

  dimension: py_Prophix_Sales  {
    type: number
    sql: ${TABLE}.pyProphixSales  ;;
    value_format_name: gbp_0
  }

  dimension: var_PY_Net_Sales  {
    type: number
    sql: ${TABLE}.varPYNetSales  ;;
    value_format_name: gbp_0
  }

  dimension: var_PY_Sales_Percent  {
    type: number
    sql: ${TABLE}.varPYSalesPercent  ;;
    value_format_name: percent_1
  }

  dimension: Avg_Selling_Price_Improv  {
    label: "Avg Selling Price Improvement YTD (SC)"
    type: number
    sql: ${TABLE}.AvgSellingPriceImprov  ;;
    value_format_name: percent_1
  }

  dimension: Loyalty_spend_increase  {
    label: "Loyalty Spend Increase YTD (SC)"
    type: number
    sql: ${TABLE}.Loyalty_spend_increase  ;;
    value_format_name: percent_1
  }

  dimension: ty_retail_trading_profit  {
    label: "TY Trading Profit YTD (SC)"
    type: number
    sql: ${TABLE}.tyRetailTradingProfit  ;;
    value_format_name: decimal_0
  }

  dimension: aop_retail_trading_profit  {
    label: "AOP Trading Profit YTD (SC)"
    type: number
    sql: ${TABLE}.aopRetailTradingProfit  ;;
    value_format_name: decimal_0
  }

  dimension: vs_AOP_retail_trading_profit  {
    label: "Trading Profit vs AOP YTD (SC)"
    type: number
    sql: ${TABLE}.vsAOPRetailTradingProfit  ;;
    value_format_name: percent_1
  }

  dimension: yoy_average_items  {
    label: "YOY Average Items YTD (SC)"
    type: number
    sql: ${TABLE}.yoyAverageItems  ;;
    value_format_name: percent_1
  }

  dimension: holiday_Q1_Month_Entitlement  {
    group_label: "Holiday"
    label: "Holiday Entitlement Q1 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ1MonthEntitlement  ;;
  }

  dimension: holiday_Q1_Taken_In_Quarter  {
    group_label: "Holiday"
    label: "Holiday Taken Q1 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ1TakenInQuarter ;;
  }

  dimension: holiday_Q1_Taken_Percent  {
    group_label: "Holiday"
    label: "Holiday Taken% Q1 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ1TakenPercent  ;;
    value_format_name: percent_1
  }

  dimension: holiday_Q2_Month_Entitlement  {
    group_label: "Holiday"
    label: "Holiday Entitlement Q2 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ2MonthEntitlement  ;;
  }

  dimension: holiday_Q2_Taken_In_Quarter  {
    group_label: "Holiday"
    label: "Holiday Taken Q2 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ2TakenInQuarter ;;
  }

  dimension: holiday_Q2_Taken_Percent  {
    group_label: "Holiday"
    label: "Holiday Taken% Q2 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ2TakenPercent  ;;
    value_format_name: percent_1
  }

  dimension: holiday_Q3_Month_Entitlement  {
    group_label: "Holiday"
    label: "Holiday Entitlement Q3 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ3MonthEntitlement  ;;
  }

  dimension: holiday_Q3_Taken_In_Quarter  {
    group_label: "Holiday"
    label: "Holiday Taken Q3 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ3TakenInQuarter ;;
  }

  dimension: holiday_Q3_Taken_Percent  {
    group_label: "Holiday"
    label: "Holiday Taken% Q3 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ3TakenPercent  ;;
    value_format_name: percent_1
  }

  dimension: holiday_Q4_Month_Entitlement  {
    group_label: "Holiday"
    label: "Holiday Entitlement Q4 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ4MonthEntitlement  ;;
  }

  dimension: holiday_Q4_Taken_In_Quarter  {
    group_label: "Holiday"
    label: "Holiday Taken Q4 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ4TakenInQuarter ;;
  }

  dimension: holiday_Q4_Taken_Percent  {
    group_label: "Holiday"
    label: "Holiday Taken% Q4 YTD (SC)"
    type: number
    sql: ${TABLE}.holidayQ4TakenPercent  ;;
    value_format_name: percent_1
  }

  dimension: rank_people  {
    group_label: "Rank YTD"
    label: "Rank People YTD"
    type: number
    sql: ${TABLE}.pillarRankPeople ;;
    value_format_name: decimal_0
  }

  dimension: rank_operational_standards  {
    group_label: "Rank YTD"
    label: "Rank Operational Standards YTD"
    type: number
    sql: ${TABLE}.pillarRankOps ;;
    value_format_name: decimal_0
  }

  dimension: rank_customer  {
    group_label: "Rank YTD"
    label: "Rank Customer YTD"
    type: number
    sql: ${TABLE}.pillarRankCust ;;
    value_format_name: decimal_0
  }

  dimension: rank_trade  {
    group_label: "Rank YTD"
    label: "Rank Trade YTD"
    type: number
    sql: ${TABLE}.pillarRankTrade ;;
    value_format_name: decimal_0
  }

  dimension: rank_finance  {
    group_label: "Rank YTD"
    label: "Rank Finance YTD"
    type: number
    sql: ${TABLE}.pillarRankFin ;;
    value_format_name: decimal_0
  }

# Error Flags  --------------------------------------------------------------------
  dimension: stock_accuracy_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when
          (${stock_Accuracy} is null) then 1
           when abs(coalesce(${stock_moves_ytd.moves},0)-coalesce(${moves},0))>0 then 2
            else 0 end;;
  }

  dimension: labour_T1T2_error_flag  {
    group_label: "Error Flag"
    type: number
    sql: case when
      ${sites.Is_consistent_branch} = true and ${sites.labourTier} != "Tier 3" and ${labour_T1T2_Percent} is null then 1 else 0 end;;
  }

  dimension: trade_Account_Participation_error_flag  {
    group_label: "Error Flag"
    type: number
    sql: case when ${trade_Account_Participation} is null then 1 else 0 end;;
  }


  # dimension: rm_Visit_error_flag {
  # group_label: "Error Flag"
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
    group_label: "Error Flag"
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${yoy_Trade_Sales} is null then 1 else 0 end;;
  }

  dimension: yoy_Frequency_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${yoy_Frequency} is null then 1 else 0 end;;
  }

  dimension: vs_AOP_retail_trading_profit_error_flag  {
    group_label: "Error Flag"
    label: "Trading Profit vs AOP Error Flag(SC)"
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${vs_AOP_retail_trading_profit} is null  then 1 else 0 end;;
  }

  dimension: vs_Target_AOV_error_flag  {
    group_label: "Error Flag"
    type: number
    sql: case when  ${sites.Is_consistent_branch} = true and ${vs_Target_AOV} is null  then 1 else 0 end;;
  }

  dimension: yoy_trade_ACS_error_flag  {
    group_label: "Error Flag"
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${yoy_trade_ACS} is null then 1 else 0 end;;
  }


  dimension: yoy_average_items_error_flag  {
    group_label: "Error Flag"
    type: number
    sql: case when ${sites.Is_consistent_branch} = true and ${yoy_average_items} is null  then 1 else 0 end;;
  }

  dimension: labour_T3_error_flag  {
    group_label: "Error Flag"
    type: number
    sql: case when
      ${sites.Is_consistent_branch} = true and ${sites.labourTier} = "Tier 3" and ${labour_T3_Percent} is null then 1 else 0 end;;
  }


  dimension: lto_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when (${lto_Percent_sc} is null) then 1
         when abs(coalesce(${lto.lto},0)-coalesce(${lto_Percent_sc},0))>0 then 2
         else 0 end;;
  }

  dimension: operational_compliance_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when (${operational_Compliance} is null) then 1
         when abs(coalesce(${operational_compliance.percentage_complete_YTD},0)-coalesce(${operational_Compliance},0))>0 then 2
         else 0 end;;
  }

  dimension: holiday_Q1_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when (${holiday_Q1_Taken_Percent} is null) then 1 else 0 end;;
  }

  dimension: holiday_Q2_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when
      (${holiday_Q2_Taken_Percent} is null) then 1 else 0 end;;
  }

  dimension: holiday_Q3_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when (${holiday_Q3_Taken_Percent} is null) then 1 else 0 end;;
  }

  dimension: holiday_Q4_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when (${holiday_Q4_Taken_Percent} is null) then 1 else 0 end;;
  }

  dimension: training_error_flag {
    group_label: "Error Flag"
    type: number
    sql:
    case when (${training_Percent_Completed} is null) then 1
        --  when abs(coalesce(${training.completed_percent},0)-coalesce(${training_Percent_Completed},0))>0 then 2
          else 0
          end
          ;;
  }

  dimension: appraisals_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when (${appraisal_Percent} is null) then 1
         when abs(coalesce(${appraisal_Percent},0)-coalesce(${appraisals_ytd.appraisal_percent},0))>0 then 2
         else 0
         end;;
  }

    dimension: rm_visit_error_flag {
      group_label: "Error Flag"
      type: number
      sql:
          case when (${rm_Visit} is null) then 1
          when abs(coalesce(${rm_visits.score},0)-coalesce(${rm_Visit},0))>0 then 2
          else 0
          end;;
    }

    dimension: google_rating_error_flag {
      group_label: "Error Flag"
      type: number
      sql:
          case when (${rating} is null) then 1
          when abs(coalesce(${google_reviews.rating},0)-coalesce(${rating},0))>0 then 2
          else 0
          end;;
    }

    dimension: nps_error_flag {
      group_label: "Error Flag"
      type: number
      sql:
          case when (${nps} is null) then 1
          when abs(coalesce( ${customer_experience.nps},0)-coalesce(${nps},0))>0 then 2
          else 0
          end;;
    }

  dimension: valued_error_flag {
    group_label: "Error Flag"
    type: number
    sql:
    case when (${valued} is null) then 1
    when abs(coalesce( ${customer_experience.valued},0)-coalesce(${valued},0))>0 then 2
    else 0
    end;;
  }

    dimension: nps_trade_error_flag {
      group_label: "Error Flag"
      type: number
      sql: case when (${trade_nps} is null) then 1
            when abs(coalesce( ${customer_experience_trade.nps},0)-coalesce(${trade_nps},0))>0 then 2
            else 0 end;;
    }

  dimension: compliance_support_error_flag {
    group_label: "Error Flag"
    type: number
    sql: case when (${Comp_Actual} is null) then 1 else 0 end;;
  }

  dimension: apprenticeship_error_flag  {
    group_label: "Error Flag"
    type: number
    sql: case when (${apprenticeship} is null) then 1 else 0 end ;;
  }

  dimension: hs_visit_error_flag  {
    group_label: "Error Flag"
    type: number
    sql: case when (${hs_Visit} is null) then 1 else 0 end ;;
  }

}
