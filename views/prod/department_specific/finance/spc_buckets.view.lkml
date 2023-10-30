view: spc_buckets {
  view_label:"Buckets"
  derived_table: {
    explore_source: base {
      bind_all_filters: yes
      column: parent_order_uid { field: transactions.parent_order_uid }
      column: spc_gross_sales { field: transactions.spc_gross_sales }
      column: spc_net_sales { field: transactions.spc_net_sales }
    }
  }

  dimension: parent_order_uid {
    hidden: yes
    sql: ${TABLE}.parent_order_uid ;;
  }

  dimension: spc_net_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.spc_net_sales ;;
  }

  dimension: spc_gross_sales {
    hidden: yes
    type: number
    sql: ${TABLE}.spc_gross_sales ;;
  }

  dimension: spend_per_customer_buckets {
    label: "Spend Per Customer(Net Sales, Over/Under £100)"
    type: tier
    tiers: [0,100]
    style: integer
    sql: ${spc_net_sales} ;;
  }

  dimension: spend_per_customer_buckets_gross {
    label: "Spend Per Customer(Gross Sales, Over/Under £100)"
    type: tier
    tiers: [0,100]
    style: integer
    sql: ${spc_gross_sales} ;;
  }
}
