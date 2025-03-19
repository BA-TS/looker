include: "/views/**/base.view"
include: "/views/**/calendar.view"
include: "/views/**/transactions.view"
include: "/views/**/sites.view"
include: "/views/**/catalogue.view"
include: "/views/**/po_numbers.view"
include: "/views/**/products.view"
include: "/views/**/customer/**.view"
include: "/views/**/bdm/**.view"
include: "/views/**/single_line_transactions.view"


persist_with: ts_transactions_datagroup

explore: bdm {
  required_access_grants: [is_bdm]
  view_name: base
  label: "BDM"
  always_filter: {
    filters: [
      select_date_reference: "Transaction"
    ]
  }

  conditionally_filter: {
    filters: [
      select_date_range: "this month",
      bdm_ka_customers.team: "BDM",
      bdm_ka_customers.bdm: ""
    ]
    unless: [
      select_fixed_range,
      dynamic_fiscal_year,
      dynamic_fiscal_half,
      dynamic_fiscal_quarter,
      dynamic_fiscal_month,
      dynamic_actual_year,
      combined_week,
      combined_month,
      combined_quarter,
      combined_year,
      separate_month,
    ]
  }

  fields: [
    ALL_FIELDS*,
    -catalogue*,
  ]

  sql_always_where:${period_over_period};;

  join: calendar_completed_date{
    fields: [calendar_completed_date.date,calendar_completed_date.calendar_year,calendar_completed_date.calendar_year_month,calendar_completed_date.calendar_year_month2,calendar_completed_date.calendar_year_quarter]
    from:  calendar
    view_label: "Date"
    type:  inner
    relationship:  many_to_one
    sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
  }

  join: transactions {
    type: left_outer
    relationship: one_to_many
    fields: [transactions.rise_and_save_hours,transactions.has_trade_account,transactions.number_of_branches,transactions.number_of_unique_products,transactions.number_of_transactions,transactions.spc_net_sales,transactions.aov_net_sales,transactions.aov_units,transactions.total_margin_rate_incl_funding,transactions.total_margin_incl_funding,transactions.total_net_sales,transactions.payment_type,transactions.product_department,transactions.aov_gross_sales,transactions.number_of_departments]
    sql_on: ${base.base_date_date} = ${transactions.transaction_date_filter}
          AND
        (${transactions.is_cancelled} = 0
          OR
        ${transactions.is_cancelled} IS NULL)
      {% if transactions.charity_status == "1" %}
      AND (transactions.product_code IN ('85699', '00053','44842'))
      {% else %}
      AND (${transactions.product_code} NOT IN ('85699', '00053','44842') OR ${transactions.product_code} IS NULL)
      {% endif %}
    ;;
  }

  join: sites {
    view_label: "Location"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }

  join: catalogue {
    view_label: "Catalogue"
    type: left_outer
    relationship: many_to_one
    sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
  }

  join: bdm_ka_customers {
    view_label: "Teams"
    type: left_outer
    relationship: many_to_many
    sql_on:  ${bdm_ka_customers.customer_uid}=${transactions.customer_uid} and ${base.base_date_date} between ${bdm_ka_customers.start_date} and date_sub(${bdm_ka_customers.end_date},interval 0 day);;
  }

  join: bdm_ka_customers_py {
    view_label: "Incremental"
    type: left_outer
    relationship: many_to_one
    sql_on: ${bdm_ka_customers_py.customer_uid}=${transactions.customer_uid} and ${bdm_ka_customers_py.month}=${calendar_completed_date.calendar_year_month2};;
}

  join: targets {
    view_label: "Targets"
    type: left_outer
    relationship: many_to_one
    sql_on: ${targets.bdm} = ${bdm_ka_customers.bdm} and ${targets.month}=${calendar_completed_date.calendar_year_month2};;
  }

  join: ledger {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ledger.bdm} = ${bdm_ka_customers.bdm} and ${ledger.customer_uid} = ${bdm_ka_customers.customer_uid};;
  }

  join: po_numbers {
    view_label: "Transactions"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.parent_order_uid} = ${po_numbers.order_id};;
  }

  join: customers {
    view_label: "Customers"
    fields: [customers.customer__company]
    type :  left_outer
    relationship: many_to_one
    sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
  }

  join: trade_customers {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid} ;;
  }

  join: trade_credit_details {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    fields: [trade_credit_details.total_credit_limit,trade_credit_details.total_remaining_balance]
    sql_on: ${trade_credit_ids.main_trade_credit_account_uid} = ${trade_credit_details.main_trade_credit_account_uid} ;;
  }

  join: trade_credit_ids {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_credit_ids.customer_uid} ;;
  }

  join: products {
    type:  left_outer
    relationship: many_to_one
    fields: [products.is_own_brand,products.product_code,products.product_name,products.subdepartment]
    sql_on: ${transactions.product_uid}=${products.product_uid};;
  }

  join: incremental {
    type:  left_outer
    relationship: many_to_one
   sql_on: ${base.date_date}=${incremental.ty_date} and ${ledger.bdm} = ${incremental.bdm} ;;
  }

  join: bdm_ka_incremental {
    view_label: "Incremental"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${calendar_completed_date.calendar_year_month2}=${bdm_ka_incremental.yearMonth} and ${bdm_ka_incremental.bdm} = ${bdm_ka_customers.bdm} ;;
  }

  join: incremental_customer {
    view_label: "Incremental"
    fields: [incremental_customer.total_customer_number,incremental_customer.incremental_customer_number,incremental_customer.spc_net_sales,incremental_customer.incremental_spc]
    type:  left_outer
    relationship: many_to_many
    sql_on: ${base.date_date}=${incremental_customer.ty_date} and ${ledger.bdm} = ${incremental_customer.bdm} ;;
  }

  join: bdm_cumulative_sales {
    view_label: "Transactions"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${calendar_completed_date.calendar_year_month}=${bdm_cumulative_sales.ty_calendar_year_month} and ${bdm_cumulative_sales.bdm} = ${bdm_ka_customers.bdm} ;;
  }
}

explore: +bdm {
  aggregate_table: rollup__bdm_ka_customers_bdm__bdm_ka_customers_customer_name__bdm_ka_customers_customer_uid__bdm_ka_customers_end_date__bdm_ka_customers_start_date__bdm_ka_customers_team__ledger_account_number__ledger_credit_limit__0 {
    query: {
      dimensions: [
        bdm_ka_customers.bdm,
        bdm_ka_customers.customer_name,
        bdm_ka_customers.customer_uid,
        bdm_ka_customers.end_date,
        bdm_ka_customers.start_date,
        bdm_ka_customers.team,
        ledger.account_number,
        ledger.credit_limit
      ]
      filters: [
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        bdm_ka_customers.customer_uid: "-NULL"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__transactions_total_net_sales__1 {
    query: {
      measures: [transactions.total_net_sales]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        bdm_ka_customers.is_bdm_ka_customer: "Yes",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__transactions_spc_net_sales__2 {
    query: {
      measures: [transactions.spc_net_sales]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        bdm_ka_customers.is_active: "Yes",
        bdm_ka_customers.is_bdm_ka_customer: "Yes",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__bdm_ka_customers_bdm__3 {
    query: {
      dimensions: [bdm_ka_customers.bdm]
      measures: [incremental.incremental_net_sales, incremental.total_net_sales, transactions.total_net_sales]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__bdm_ka_customers_bdm__4 {
    query: {
      dimensions: [bdm_ka_customers.bdm]
      measures: [incremental_customer.incremental_spc, incremental_customer.spc_net_sales, transactions.spc_net_sales]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        bdm_ka_customers.is_active: "Yes",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__incremental_customer_incremental_customer_number__5 {
    query: {
      measures: [incremental_customer.incremental_customer_number]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        bdm_ka_customers.is_active: "Yes",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__transactions_total_margin_rate_incl_funding__6 {
    query: {
      measures: [transactions.total_margin_rate_incl_funding]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        bdm_ka_customers.is_active: "Yes",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__transactions_aov_net_sales__7 {
    query: {
      measures: [transactions.aov_net_sales]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        bdm_ka_customers.is_bdm_ka_customer: "Yes",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__bdm_ka_incremental_incremental_sales_existing__8 {
    query: {
      measures: [bdm_ka_incremental.incremental_sales_existing]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        bdm_ka_customers.customer_TY: "No",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__bdm_ka_incremental_incremental_sales_total__9 {
    query: {
      measures: [bdm_ka_incremental.incremental_sales_total]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__bdm_ka_incremental_incremental_sales_new__10 {
    query: {
      measures: [bdm_ka_incremental.incremental_sales_new]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        bdm_ka_customers.customer_TY: "Yes",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__targets_sales_vs_target_monthly__11 {
    query: {
      measures: [targets.sales_vs_target_monthly]
      filters: [
        # "base.select_date_range" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        base.select_date_range: "2 month ago for 2 month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }

  aggregate_table: rollup__targets_total_net_sales_vs_target__12 {
    query: {
      measures: [targets.total_net_sales_vs_target]
      filters: [
        base.select_date_range: "this month",
        base.select_date_reference: "Transaction",
        # "bdm_ka_customers.bdm" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.bdm: "Rob,Louise,Matty,Rachel,Damien,Gary,Central BDM,Elena",
        # "bdm_ka_customers.team" was filtered by dashboard. The aggregate table will only optimize against exact match queries.
        bdm_ka_customers.team: "BDM"
      ]
    }

    materialization: {
      datagroup_trigger: ts_transactions_datagroup
    }
  }
}
