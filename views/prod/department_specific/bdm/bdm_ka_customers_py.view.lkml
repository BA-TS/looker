
view: bdm_ka_customers_py {
  derived_table: {
    sql:
    cast(format_timestamp('%Y%m', t.transactionDate) as int64)+100 as yearMonth,
    t.customerUID,
    sum(t.netSalesValue) as pySales

    FROM `toolstation-data-storage.sales.transactions` t
    INNER JOIN `toolstation-data-storage.retailReporting.BDM_KA_CUSTOMERS_LIST` bdm
    on t.customerUID = bdm.customerUID

    WHERE date(t.transactionDate) <= date_sub(current_date()-1, interval 364 day)
    and date(t.transactionDate) between date_sub(bdm.startDate, interval 364 day) and date_sub(coalesce(bdm.endDate,current_date()), interval 364 day)
    and t.productCode not in ('85699', '00053','44842')
    and isCancelled = 0

    GROUP BY ALL;;
  }

  dimension: prim_key {
    type: string
    sql: concat(${customer_uid},${month}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: py_sales {
    value_format_name: gbp
    type: number
    sql: ${TABLE}.pySales;;
    hidden: yes
  }

  dimension: month{
    type: date
    sql: ${TABLE}.yearMonth ;;
    hidden: yes
  }

  measure: total_net_sales {
    value_format_name: gbp_0
    type: sum
    sql: ${py_sales};;
  }

  measure: incremental_net_sales_old {
    value_format_name: gbp_0
    type: number
    sql: ${transactions.total_net_sales}-${total_net_sales};;
  }
}