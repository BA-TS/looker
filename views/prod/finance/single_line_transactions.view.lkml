view: single_line_transactions {
  derived_table: {
    sql:
      select distinct
      parentOrderUID,
      case when  count(distinct case when p.productCode > '10000' and lower(p.productDepartment) not in ('uncatalogued') then p.productCode else null end) over (partition by t.parentOrderUID) = 1 then true else false end single_line_transaction_flag
      from `toolstation-data-storage.sales.transactions` t
        inner join `toolstation-data-storage.range.products_current` p
          using(productUID)
      ;;
    datagroup_trigger: toolstation_transactions_datagroup
  }

  dimension: parent_order_uid {
    hidden:  yes
    primary_key: yes
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }
  dimension: single_line_transaction_flag {
    view_label: "Transactions"
    group_label: "Flags"
    label: "Single Line"
    description: "Yes/No whether the transaction contained only one product line."
    type: yesno
    sql: ${TABLE}.single_line_transaction_flag ;;
  }
  measure: single_line_transactions {
    type: sum
    sql: CASE WHEN ${single_line_transaction_flag} = true THEN 1 ELSE 0 END ;;
    hidden: yes
  }

}
