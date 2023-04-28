include: "/views/**/*base*.view"

view: ecrebo {

  derived_table: {
    sql:
      (SELECT
    DATE(et.datetime) as ecreboDate,
     ec.campaign_id,
     ec.campaign_name,
     tr.parentOrderUID,
     COUNT(DISTINCT tr.parentOrderUID) as orderRedemptions,
     SUM(CASE WHEN tr.transactionLineType = 'Marketing' AND productCode IN ('00021','00027') THEN tr.netSalesValue ELSE 0 END) as code21_27Value,
     SUM(CASE WHEN tr.transactionLineType = 'Sale' THEN tr.netSalesValue ELSE 0 END) as netSalesValue,
     SUM(CASE WHEN tr.transactionLineType = 'Sale' THEN tr.quantity ELSE 0 END) as salesUnits
      FROM
      `toolstation-data-storage.data_engineering_team.ecreboTransactions` et
      LEFT JOIN
      `toolstation-data-storage.data_engineering_team.ecreboCoupons` ec ON et.transaction_uuid=ec.transaction_uuid
      JOIN
      `toolstation-data-storage.sales.TrolleySales` ts ON et.transaction_uuid=ts.trolleyUID
      JOIN
      `sales.transactions` tr ON ts.parentOrderUID=tr.parentOrderUID
      JOIN
      `ts_finance.dim_date` dd ON DATE(et.datetime)=dd.fullDate
      WHERE
      ec.campaign_id IS NOT NULL
      GROUP BY
      1,2,3,4
      );;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: ecrebo_date_filter {
    type: date
    datatype: date
    sql: ${TABLE}.ecreboDate};;
  }
  dimension: parent_order_uid {
    group_label: "Order ID"
    label: "Parent Order UID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
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
#         measure: ecrebo_marketing_vouchers {
#           label: "Ecrebo Marketing Vouchers"
#           type:  sum
#           view_label: "Measures"
#           group_label: "Marketing"
#           sql: ${code21_27Value} ;;
#           value_format_name: gbp
# }
}
