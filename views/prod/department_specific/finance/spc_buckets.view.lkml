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
    label: "Over/Under £100 (Net Sales)"
    group_label: "Spend Per Customer (by Transaction)"
    type: tier
    tiers: [0,100]
    style: integer
    sql: ${spc_net_sales} ;;
  }

  dimension: spend_per_customer_buckets_gross {
    label: "Over/Under £100 (Gross Sales)"
    group_label: "Spend Per Customer (by Transaction)"
    type: tier
    tiers: [0,100]
    style: integer
    sql: ${spc_gross_sales} ;;
  }

  dimension: spend_per_customer_buckets75 {
    label: "Over/Under £75 (Net Sales)"
    group_label: "Spend Per Customer (by Transaction)"
    type: tier
    tiers: [0,75]
    style: integer
    sql: ${spc_net_sales} ;;
  }

  dimension: spend_per_customer_buckets_gross75 {
    label: "Over/Under £75 (Gross Sales)"
    group_label: "Spend Per Customer (by Transaction)"
    type: tier
    tiers: [0,75]
    style: integer
    sql: ${spc_gross_sales} ;;
  }

  dimension: spend_per_customer_buckets50 {
    label: "Over/Under £50 (Net Sales)"
    group_label: "Spend Per Customer (by Transaction)"
    type: tier
    tiers: [0,50]
    style: integer
    sql: ${spc_net_sales} ;;
  }

  dimension: spend_per_customer_buckets_gross50 {
    label: "Over/Under £50 (Gross Sales)"
    group_label: "Spend Per Customer (by Transaction)"
    type: tier
    tiers: [0,50]
    style: integer
    sql: ${spc_gross_sales} ;;
  }

  dimension: spend_per_customer_buckets25 {
    label: "Over/Under £25 (Net Sales)"
    group_label: "Spend Per Customer (by Transaction)"
    type: tier
    tiers: [0,25]
    style: integer
    sql: ${spc_net_sales} ;;
  }

  dimension: spend_per_customer_buckets_gross25 {
    label: "Over/Under £25 (Gross Sales)"
    group_label: "Spend Per Customer (by Transaction)"
    type: tier
    tiers: [0,25]
    style: integer
    sql: ${spc_gross_sales} ;;
  }
}
