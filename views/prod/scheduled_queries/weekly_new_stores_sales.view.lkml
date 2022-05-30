view: weekly_new_stores_sales {

  # every monday

  derived_table: {
    datagroup_trigger: ts_transactions_datagroup

    sql: with stores as (
          select

              siteUID,
              siteName,
              dateOpened,
              d.fiscalYearWeek as firstTradingWeek

              from `toolstation-data-storage.locations.sites` s
              inner join `toolstation-data-storage.ts_finance.dim_date` d
                  on date(s.dateOpened) = d.fullDate

              where
                  regionName like 'Region%'
                  or regionName like 'Closed%'
      )

      ,sales as (
      select

          s.siteUID,
          s.siteName,
          s.firstTradingWeek,
          s.dateOpened,
          d.fiscalYEarWeek salesWeek,
          row_number() over (partition by s.siteUID order by d.fiscalYearWeek) as storeRelativeSalesWeek,
          sum(t.netSalesValue) netSales

          from `toolstation-data-storage.sales.transactions` t
              inner join stores s
                  on t.siteUID = s.siteUID

              inner join `toolstation-data-storage.ts_finance.dim_date` d
                  on date(t.transactionDate) = d.fullDate
                  and d.fiscalYearWeek >= s.firstTradingWeek



          group by 1,2,3,4,5

          qualify row_number() over (partition by s.siteUID order by d.fiscalYearWeek) <= 13
      )
      SELECT * FROM
      (
        select

          siteUID,
          siteName,
          date(dateOpened) date_opened,
          sum(netSales) over (partition by siteUID) as totalSales,
          storeRelativeSalesWeek,
          netSales

          from sales
      )
      PIVOT
      (
        SUM(netSales) AS actual_sales_week
        FOR storeRelativeSalesWeek in (1,2,3,4,5,6,7,8,9,10,11,12,13)
      )

      order by 3 desc
       ;;
  }


  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.siteName ;;
  }

  dimension: date_opened {
    type: date
    datatype: date
    sql: ${TABLE}.date_opened ;;
  }

  dimension: total_sales {
    type: number
    sql: ${TABLE}.totalSales ;;
  }

  dimension: actual_sales_week_1 {
    type: number
    sql: ${TABLE}.actual_sales_week_1 ;;
  }

  dimension: actual_sales_week_2 {
    type: number
    sql: ${TABLE}.actual_sales_week_2 ;;
  }

  dimension: actual_sales_week_3 {
    type: number
    sql: ${TABLE}.actual_sales_week_3 ;;
  }

  dimension: actual_sales_week_4 {
    type: number
    sql: ${TABLE}.actual_sales_week_4 ;;
  }

  dimension: actual_sales_week_5 {
    type: number
    sql: ${TABLE}.actual_sales_week_5 ;;
  }

  dimension: actual_sales_week_6 {
    type: number
    sql: ${TABLE}.actual_sales_week_6 ;;
  }

  dimension: actual_sales_week_7 {
    type: number
    sql: ${TABLE}.actual_sales_week_7 ;;
  }

  dimension: actual_sales_week_8 {
    type: number
    sql: ${TABLE}.actual_sales_week_8 ;;
  }

  dimension: actual_sales_week_9 {
    type: number
    sql: ${TABLE}.actual_sales_week_9 ;;
  }

  dimension: actual_sales_week_10 {
    type: number
    sql: ${TABLE}.actual_sales_week_10 ;;
  }

  dimension: actual_sales_week_11 {
    type: number
    sql: ${TABLE}.actual_sales_week_11 ;;
  }

  dimension: actual_sales_week_12 {
    type: number
    sql: ${TABLE}.actual_sales_week_12 ;;
  }

  dimension: actual_sales_week_13 {
    type: number
    sql: ${TABLE}.actual_sales_week_13 ;;
  }


}
