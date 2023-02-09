view: app_web_data {

  derived_table: {
    sql: SELECT
        distinct customerUID as CustomerID
        parentOrderUID as OrderID,
        date(transactionDate) as TransactionDate
        fiscalYearWeek,
        Case
        when t.userUID like 'APP' then 'App Trolley'
        when t.userUID like 'WWW' then 'Web Trolley'
        end as App_Web,
        sum(netsalePrice) as NetSalePrice,
        sum(quantity) as Quantity,
        sum(netSalesValue) as NetSaleValue,
        sum(marginInclFunding) as Margin

        where date_diff(current_date (),date(t.transactionDate), day) <= 15
        and transactionLineType = "Sale"
        and productCode not in ('85699','00053')
        and isCancelled = 0
        and (userUID  = 'APP' or userUID  = 'WWW')
        group by 2,3
        ;;

        #datagroup_trigger:app_web_datagroup
        #partition_keys: ["transactiondate"]
        #cluster_keys: ["CUSTOMERUID"]
        }
        dimension: CustomerID {
        description: "customers for the last week"
        type: string
        sql:  ${TABLE}.customerUID ;;
      }

      dimension: OrderID {
        description: "transaction ID"
        type:string
        sql: ${TABLE}.PARENTORDERUID ;;
      }

      dimension_group: transactiondate  {
        description: "transactiondate"
        type: time
        timeframes: [raw,date]
        sql: ${TABLE}.transactiondate ;;
      }

      dimension: fiscalYearWeek {
        description: "Year-week of transaction"
        type:  string
        sql:  ${TABLE}.fiscalYearWeek ;;
      }

      dimension: App_web {
        description: "If user used App or Web"
        type:  string
        sql:  ${TABLE}.App_web ;;
      }

      dimension: NetSalePrice {
        description: "Total price of transcation"
        type: number
        sql: ${TABLE}.NetSalePrice ;;
      }

      dimension: Quantity {
        description: "Total products in order"
        type:  number
        sql:  ${TABLE}.Quantity ;;
      }

      dimension: NetSaleValue {
        description: "Total value of order"
        type: number
        sql: ${TABLE}.NetSaleValue ;;
      }

      dimension: Margin {
        description: "Margin of order"
        type: number
        sql: ${TABLE}.Margin ;;
      }
  }
