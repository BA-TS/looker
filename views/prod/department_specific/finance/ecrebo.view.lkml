include: "/views/**/*base*.view"

view: ecrebo {

  derived_table: {
    sql:
            WITH ecrebo_cte as (

                    SELECT DISTINCT
                      DATE(et.datetime) as date,
                      ec.campaign_id,
                      ec.campaign_name,
                      et.transaction_uuid,
                      et.receipt_id,
                      #ts1.parentOrderUID,
                      #OrderID,
                      coalesce(ts1.parentOrderUID,OrderID) as ParentOrderUID



                    FROM
                      `toolstation-data-storage.sales.ecreboTransactions` et
                      JOIN
                      `toolstation-data-storage.sales.ecreboCoupons` ec ON  et.transaction_uuid=ec.transaction_uuid
                      left JOIN
                      `toolstation-data-storage.sales.TrolleySales` ts1 ON et.transaction_uuid = ts1.trolleyUID
                       left join (
                  select distinct ParentOrderUID as OrderID from `toolstation-data-storage.sales.transactions`
                       union distinct
                       select distinct ParentOrderUID as OrderID from `toolstation-data-storage.sales.transactions_incomplete`) on regexp_extract(et.receipt_id,"^.{0,11}") = OrderID
                    WHERE
                      ec.campaign_id IS NOT NULL and ec.issuance_redemption = 'r'


                    ),

    tr as (select distinct date(transactionDate) as TransactionDate, date(PlacedDate) as PlacedDate,
    parentOrderUID,productCode,transactionLineType,NetSalesValue, marginInclFunding
    from `toolstation-data-storage.sales.transactions`
    union distinct
    select distinct date(transactionDate) as TransactionDate, date(PlacedDate) as PlacedDate,
    parentOrderUID,productCode,transactionLineType,NetSalesValue, marginInclFunding
    from `toolstation-data-storage.sales.transactions_incomplete`)

SELECT
   ecrebo_cte.campaign_id,
   ecrebo_cte.campaign_name,
   CASE
    WHEN STRPOS(campaign_id, ' ') > 0 THEN campaign_id
    ELSE campaign_name
  END AS new_campaign_name,
   TransactionDate,
  PlacedDate,
    ecrebo_cte.parentOrderUID,
   SUM(CASE WHEN tr.transactionLineType = 'Marketing' AND productCode IN ('00021','00027') THEN tr.netSalesValue ELSE 0 END) as code21_27Value,
   SUM(CASE WHEN tr.transactionLineType = 'Sale' THEN tr.netSalesValue ELSE 0 END) as salesLineOnlyNetSalesValue,
   SUM(tr.netSalesValue) as NetSalesValue,
   SUM(tr.marginInclFunding) as orderMarginInclFunding

FROM
   tr
  JOIN
  ecrebo_cte ON tr.parentOrderUID=ecrebo_cte.parentOrderUID



GROUP BY
  1,2,3,4,5,6

 ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: ecrebo_date_filter {
    type: date
    datatype: date
    sql: ${TABLE}.PlacedDate;;
    hidden:  yes
  }

  dimension: TransactionDate {
    type: date
    datatype: date
    sql: ${TABLE}.TransactionDate;;
    hidden:  yes
  }

  dimension: parent_order_uid {
    group_label: "Order ID"
    label: "Parent Order UID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
    hidden:  yes
  }

  dimension: campaign_id {
    group_label: "Campaign"
    label: "Campaign ID"
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    group_label: "Campaign"
    label: "Campaign Name"
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign {
    group_label: "Campaign"
    label: "Campaign"
    type: string
    sql: ${TABLE}.new_campaign_name ;;
  }
#         measure: ecrebo_marketing_vouchers {
#           label: "Ecrebo Marketing Vouchers"
#           type:  sum
#           view_label: "Measures"
#           group_label: "Marketing"
#           sql: ${code21_27Value} ;;
#           value_format_name: gbp
# }
}
