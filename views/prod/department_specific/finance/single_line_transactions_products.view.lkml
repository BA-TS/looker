view: single_line_transactions_products {
  derived_table: {
    sql:
      select distinct
      parentOrderUID,
      case when  count(distinct case when p.productCode > '10000' and lower(p.productDepartment) not in ('uncatalogued') then p.productCode else null end) over (partition by t.parentOrderUID) = 1 then true else false end single_line_transaction_flag
      from `toolstation-data-storage.sales.transactions` t
        inner join `toolstation-data-storage.range.products_current` p
          using(productUID)
      where p.productCode IN ('86627','93763','31668')
    ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: parent_order_uid {
    group_label: "Single Line Transactions"
    hidden:  yes
    primary_key: yes
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  # dimension: selected_product {
  #   group_label: "Single Line Transactions"
  #   hidden:  yes
  #   type: string
  #   sql: 1 ;;
  # }

}
