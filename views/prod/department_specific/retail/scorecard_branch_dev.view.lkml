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
  }

  dimension: ltoPercent   {
    type: number
    sql: ${TABLE}.ltoPercent  ;;
  }

  dimension: trainingAvailable   {
    type: number
    sql: ${TABLE}.trainingAvailable  ;;
  }

  dimension: trainingCompleted   {
    type: number
    sql: ${TABLE}.trainingCompleted ;;
  }

  dimension: trainingPercentCompleted  {
    type: number
    sql: ${TABLE}.trainingPercentCompleted  ;;
  }

  dimension: appraisals   {
    type: number
    sql: ${TABLE}.appraisals  ;;
  }

  dimension: colleagues   {
    type: number
    sql: ${TABLE}.colleagues  ;;
  }

  dimension: appraisalPercent  {
    type: number
    sql: ${TABLE}.appraisalPercent  ;;
  }

  dimension: apprenticeship  {
    type: number
    sql: ${TABLE}.apprenticeship   ;;
  }

  dimension: operationalCompliance  {
    type: number
    sql: ${TABLE}.operationalCompliance ;;
  }

  dimension: hsVisit  {
    type: number
    sql: ${TABLE}.hsVisit  ;;
  }

  dimension: rmVisit  {
    type: number
    sql: ${TABLE}. rmVisit  ;;
  }

  dimension: Comp_Actual  {
    type: number
    sql: ${TABLE}.Comp_Actual  ;;
  }

  dimension: moves  {
    type: number
    sql: ${TABLE}.moves  ;;
  }

  dimension: units  {
    type: number
    sql: ${TABLE}.units  ;;
  }

  dimension: orders  {
    type: number
    sql: ${TABLE}.orders  ;;
  }

  dimension: stockAccuracy  {
    type: number
    sql: ${TABLE}.stockAccuracy  ;;
  }

  dimension: branchNPS  {
    type: number
    sql: ${TABLE}.branchNPS  ;;
  }

  dimension: branchValued  {
    type: number
    sql: ${TABLE}.branchValued  ;;
  }

  dimension: totalValued  {
    type: number
    sql: ${TABLE}.totalValued  ;;
  }

  dimension: rating  {
    type: number
    sql: ${TABLE}.rating  ;;
  }

  dimension: anonOrders  {
    type: number
    sql: ${TABLE}.anonOrders  ;;
  }

  dimension: totalOrders  {
    type: number
    sql: ${TABLE}.totalOrders  ;;
  }

}
