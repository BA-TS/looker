view: single_line_transactions {
  derived_table: {
    sql:
      SELECT DISTINCT parentOrderUID,
      case when  count(distinct case when p.productCode >= '10000' and lower(p.productDepartment) not in ('uncatalogued') then p.productCode else null end) over (partition by parentOrderUID) = 1 then true else false end single_line_transaction_flag,
      count(distinct case when p.productCode >= '10000' and lower(p.productDepartment) not in ('uncatalogued') then p.productCode else null end) over (partition by parentOrderUID) as attached_product_count,
      row_number() OVER(ORDER BY parentOrderUID) AS prim_key,
 from

(select distinct
parentOrderUID,
productUID
from `toolstation-data-storage.sales.transactions`
union distinct
select distinct
parentOrderUID,
productUID
from `toolstation-data-storage.sales.transactions_incomplete`)

inner join `toolstation-data-storage.range.products_current` p
          using(productUID);;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }

  dimension: parent_order_uid {
    hidden:  yes
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension: single_line_transaction_flag {
    view_label: "{% if _explore._name == 'digital_reporting' %}
        Digital Transactions
        {% elsif _explore._name == 'GA4_testy' %}
        GA4
        {% else %}
        Transactions
        {% endif %}"
    #view_label: "Transactions"
    group_label: "{% if _explore._name == 'GA4_testy' %}
        Transactional
        {% else %}
        Flags
        {% endif %}"
    label: "Single Line Transaction"
    description: "Yes/No whether the transaction contained only one product line."
    type: yesno
    sql: ${TABLE}.single_line_transaction_flag ;;
  }

  dimension: attached_product_count {
    label: "Number of Attached Products"
    view_label: "Products"
    type: number
    sql: ${TABLE}.attached_product_count ;;
  }

  dimension: attached_product_count_tier {
    label: "Number of Attached Products Tier"
    view_label: "Products"
    type: tier
    style: integer
    tiers: [0,1,2,3,4]
    sql: ${attached_product_count} ;;
  }

  measure: single_line_transactions_total {
    view_label: "Measures"
    group_label: "Single Line Transactions"
    type: count_distinct
    value_format: "#,##0;(#,##0)"
    sql: CASE WHEN ${single_line_transaction_flag} = true THEN ${parent_order_uid}  ELSE NULL END;;
  }

  measure: non_single_line_transactions_total {
    view_label: "Measures"
    group_label: "Single Line Transactions"
    type: count_distinct
    value_format: "#,##0;(#,##0)"
    sql: CASE WHEN ${single_line_transaction_flag} = false THEN ${parent_order_uid}  ELSE NULL END;;
    hidden: yes
  }

  measure: single_line_percent {
    view_label: "Measures"
    group_label: "Single Line Transactions"
    label: "Single Line Transactions %"
    description: "Single line transactions as a percentage of total transactions (Single Line + Non-single Line)"
    type: number
    sql: ${single_line_transactions_total}/NULLIF((${single_line_transactions_total}+${non_single_line_transactions_total}),0);;
    value_format: "0.0%"
  }

  measure: attachment_rate_percent {
    view_label: "Measures"
    group_label: "Single Line Transactions"
    label: "Attachment Rate %"
    description: "Attachment rate as a percentage of total transactions (Single Line + Non-single Line)"
    type: number
    sql: 1-${single_line_transactions_total}/NULLIF((${single_line_transactions_total}+${non_single_line_transactions_total}),0);;
    value_format: "0.0%"
  }
}
