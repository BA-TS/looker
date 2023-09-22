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
                      ts.parentOrderUID



                    FROM
                      `toolstation-data-storage.sales.ecreboTransactions` et
                      LEFT JOIN
                      `toolstation-data-storage.sales.ecreboCoupons` ec ON  et.transaction_uuid=ec.transaction_uuid
                      JOIN
                      `toolstation-data-storage.sales.TrolleySales` ts ON et.transaction_uuid=ts.trolleyUID

                    WHERE
                      ec.campaign_id IS NOT NULL


                    )

SELECT
   ecrebo_cte.campaign_id,
   ecrebo_cte.campaign_name,
   CASE
    WHEN STRPOS(campaign_id, ' ') > 0 THEN campaign_id
    ELSE campaign_name
  END AS new_campaign_name,
    ecrebo_cte.date as date,
    ecrebo_cte.parentOrderUID,
   SUM(CASE WHEN tr.transactionLineType = 'Marketing' AND productCode IN ('00021','00027') THEN tr.netSalesValue ELSE 0 END) as code21_27Value,
   SUM(CASE WHEN tr.transactionLineType = 'Sale' THEN tr.netSalesValue ELSE 0 END) as salesLineOnlyNetSalesValue,
   SUM(tr.netSalesValue) as NetSalesValue,
   SUM(tr.marginInclFunding) as orderMarginInclFunding

FROM
  `sales.transactions` tr
  JOIN
  ecrebo_cte ON tr.parentOrderUID=ecrebo_cte.parentOrderUID



GROUP BY
  1,2,3,4,5

order by 1,2,3
 ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: ecrebo_date_filter {
    type: date
    datatype: date
    sql: ${TABLE}.date;;
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
