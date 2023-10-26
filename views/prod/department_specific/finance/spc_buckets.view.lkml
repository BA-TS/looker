view: spc_buckets {
  derived_table: {
    explore_source: base {
      bind_all_filters: yes
      column: parent_order_uid { field: transactions.parent_order_uid }
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

  dimension: spc_tier {
    type: tier
    tiers: [0,100]
    style: integer
    sql: ${spc_net_sales} ;;
  }
}
