- dashboard: next_14_days_dsr
  title: Next 14 Days
  layout: newspaper
  preferred_viewer: dashboards-next
  refresh: 1 day
  elements:
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "# Next 14 Days"
    row: 3
    col: 0
    width: 24
    height: 2
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      <div style="padding: 20px 0 20px 0; border-radius: 5px; background: #ffe200; height: 80px;">

         <div style="background: #004f9f; height: 40px; width:100%">

              <a href="https://tpdev.cloud.looker.com/boards/7">

                       <img style="color: #ffffff; float: left; height: 40px" src="https://www.toolstation.com/img/toolstation.svg"/>

               </a>

            <nav style="font-size: 18px;">

               <span style="color: #000000;">

               <a style="color: #ffffff; padding: 0 20px ; float: right; line-height: 40px; font-weight: regular" href="https://tpdev.cloud.looker.com/boards/7" >Back to Menu</a>

               <a style="color: #ffffff; padding: 0 20px ; float: right; line-height: 40px; font-weight: regular" href="https://tpdev.cloud.looker.com/embed/dashboards-next/ts_sales::next_14_days_dsr" target="_blank">View Full Screen</a>
              </span>
               <a style="color: #efefef; padding: 0 20px; float: right; line-height: 40px; font-weight: bold; text-decoration: none;"><span style="color: #ffffff;">Daily Sales Report - Next 14 Days</span></a>
            </nav>
         </div>

      </div>
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Next 14 Days
    name: Next 14 Days
    model: ts_sales
    explore: base
    type: looker_grid
    fields: [base.date_date, base.pivot_dimension, transactions.total_gross_sales,
      transactions.total_net_sales, transactions.total_margin_rate_incl_funding, transactions.number_of_transactions,
      transactions.total_margin_incl_funding, transactions.aov_net_sales, transactions.number_of_unique_customers]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 0 days ago for 13 days
      base.select_number_of_periods: '3'
      base.select_comparison_period: Year
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(${transactions.total_gross_sales},2)',
        label: LY Gross Sales, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: supermeasure, table_calculation: ly_gross_sales, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.total_gross_sales},2)
          / pivot_index(${transactions.total_gross_sales}, 3) - 1', label: LY Gross
          Sales YoY, value_format: !!null '', value_format_name: percent_2, _kind_hint: supermeasure,
        table_calculation: ly_gross_sales_yoy, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_net_sales},2)', label: LY Net
          Sales, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: ly_net_sales, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_net_sales},2) / pivot_index(${transactions.total_net_sales},
          3) - 1', label: LY Net Sales YoY, value_format: !!null '', value_format_name: percent_2,
        _kind_hint: supermeasure, table_calculation: ly_net_sales_yoy, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.total_margin_rate_incl_funding},2)',
        label: LY Margin Inc Retro %, value_format: !!null '', value_format_name: percent_2,
        _kind_hint: supermeasure, table_calculation: ly_margin_inc_retro, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.aov_net_sales},
          2)', label: LY AOV, value_format: !!null '', value_format_name: gbp, _kind_hint: supermeasure,
        table_calculation: ly_aov, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.number_of_unique_customers}, 2)',
        label: LY Customers, value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: supermeasure, table_calculation: ly_customers, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.number_of_transactions},2)',
        label: LY Orders, value_format: !!null '', value_format_name: decimal_0, _kind_hint: supermeasure,
        table_calculation: ly_orders, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_margin_rate_incl_funding},2)
          - pivot_index(${transactions.total_margin_rate_incl_funding}, 3)', label: LY
          Margin v 2LY (%PTS), value_format: !!null '', value_format_name: percent_2,
        _kind_hint: supermeasure, table_calculation: ly_margin_v_2ly_pts, _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: center
    header_font_size: '13'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    show_sql_query_menu_options: false
    column_order: [base.date_date, ly_gross_sales, ly_gross_sales_yoy, ly_net_sales,
      ly_net_sales_yoy, ly_margin_inc_retro, ly_margin_v_2ly_pts, ly_aov, ly_customers,
      ly_orders]
    show_totals: true
    show_row_totals: true
    series_text_format:
      base.pivot_dimension:
        align: left
      ly_gross_sales:
        align: center
      ly_gross_sales_yoy:
        align: center
      ly_net_sales:
        align: center
      ly_net_sales_yoy:
        align: center
      ly_margin_inc_retro:
        align: center
      ly_aov:
        align: center
      ly_customers:
        align: center
      ly_orders:
        align: center
      ly_margin_v_2ly_pts:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [ly_gross_sales_yoy,
          ly_net_sales_yoy, ly_margin_v_2ly_pts]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [ly_gross_sales_yoy,
          ly_net_sales_yoy, ly_margin_v_2ly_pts]}]
    hidden_fields: [transactions.total_gross_sales, transactions.total_net_sales,
      transactions.total_margin_rate_incl_funding, transactions.number_of_transactions,
      transactions.total_margin_incl_funding, transactions.aov_net_sales, transactions.number_of_unique_customers]
    series_types: {}
    defaults_version: 1
    query_fields:
      measures:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label: Core
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Measures Gross Sales
        label_from_parameter:
        label_short: Gross Sales
        map_layer:
        name: transactions.total_gross_sales
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: transactions
        view_label: Measures
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Gross Sales
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: transactions
        suggest_dimension: transactions.total_gross_sales
        suggest_explore: base
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Ffinance%2Ftransactions.view.lkml?line=733"
        permanent:
        source_file: views/prod/finance/transactions.view.lkml
        source_file_path: toolstation/views/prod/finance/transactions.view.lkml
        sql: "${gross_sales_value} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label: Core
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Measures Net Sales
        label_from_parameter:
        label_short: Net Sales
        map_layer:
        name: transactions.total_net_sales
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: transactions
        view_label: Measures
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: transactions
        suggest_dimension: transactions.total_net_sales
        suggest_explore: base
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Ffinance%2Ftransactions.view.lkml?line=741"
        permanent:
        source_file: views/prod/finance/transactions.view.lkml
        source_file_path: toolstation/views/prod/finance/transactions.view.lkml
        sql: "${net_sales_value} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label: Core
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Measures Margin Rate (Including Funding)
        label_from_parameter:
        label_short: Margin Rate (Including Funding)
        map_layer:
        name: transactions.total_margin_rate_incl_funding
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: 0.00%;(0.00%)
        view: transactions
        view_label: Measures
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Margin Rate (Including Funding)
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: transactions
        suggest_dimension: transactions.total_margin_rate_incl_funding
        suggest_explore: base
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Ffinance%2Ftransactions.view.lkml?line=792"
        permanent:
        source_file: views/prod/finance/transactions.view.lkml
        source_file_path: toolstation/views/prod/finance/transactions.view.lkml
        sql: 'SAFE_DIVIDE(${total_margin_incl_funding}, ${total_net_sales}) '
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label: Core
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Measures Number of Transactions
        label_from_parameter:
        label_short: Number of Transactions
        map_layer:
        name: transactions.number_of_transactions
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0;(#,##0)"
        view: transactions
        view_label: Measures
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Number of Transactions
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: transactions
        suggest_dimension: transactions.number_of_transactions
        suggest_explore: base
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Ffinance%2Ftransactions.view.lkml?line=817"
        permanent:
        source_file: views/prod/finance/transactions.view.lkml
        source_file_path: toolstation/views/prod/finance/transactions.view.lkml
        sql:
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label: Core
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Measures Margin (Including Funding)
        label_from_parameter:
        label_short: Margin (Including Funding)
        map_layer:
        name: transactions.total_margin_incl_funding
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: transactions
        view_label: Measures
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Margin (Including Funding)
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: transactions
        suggest_dimension: transactions.total_margin_incl_funding
        suggest_explore: base
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Ffinance%2Ftransactions.view.lkml?line=774"
        permanent:
        source_file: views/prod/finance/transactions.view.lkml
        source_file_path: toolstation/views/prod/finance/transactions.view.lkml
        sql: "${margin_incl_funding} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label: AOV
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Measures Net Sales AOV
        label_from_parameter:
        label_short: Net Sales AOV
        map_layer:
        name: transactions.aov_net_sales
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0.00'
        view: transactions
        view_label: Measures
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales AOV
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: transactions
        suggest_dimension: transactions.aov_net_sales
        suggest_explore: base
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Ffinance%2Ftransactions.view.lkml?line=1715"
        permanent:
        source_file: views/prod/finance/transactions.view.lkml
        source_file_path: toolstation/views/prod/finance/transactions.view.lkml
        sql: 'SAFE_DIVIDE(${total_net_sales}, ${number_of_transactions}) '
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label: Core
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Measures Number of Customers
        label_from_parameter:
        label_short: Number of Customers
        map_layer:
        name: transactions.number_of_unique_customers
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0;(#,##0)"
        view: transactions
        view_label: Measures
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Number of Customers
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: transactions
        suggest_dimension: transactions.number_of_unique_customers
        suggest_explore: base
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Ffinance%2Ftransactions.view.lkml?line=825"
        permanent:
        source_file: views/prod/finance/transactions.view.lkml
        source_file_path: toolstation/views/prod/finance/transactions.view.lkml
        sql:
        sql_case:
        filters:
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: Use this as your date dimension when comparing periods. Aligns
          the all previous periods onto the current period
        enumerations:
        field_group_label: ''
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Date  Date
        label_from_parameter:
        label_short: " Date"
        map_layer:
        name: base.date_date
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: date_date
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        view: base
        view_label: Date
        dynamic: false
        week_start_day: sunday
        dimension_group: base.date
        error:
        field_group_variant: " Date"
        measure: false
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: base
        suggest_dimension: base.date_date
        suggest_explore: base
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: day
          count: 1
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Fdate%2Fperiod_over_period.view.lkml?line=105"
        permanent:
        source_file: views/prod/date/transaction_base_date.view.lkml
        source_file_path: toolstation/views/prod/date/transaction_base_date.view.lkml
        sql: "{% if pivot_dimension._in_query %}\n        {% if select_fixed_range._in_query\
          \ %}\n\n          {% if select_fixed_range._parameter_value == \"PD\" and\
          \ (select_comparison_period._parameter_value == \"Week\" or select_comparison_period._parameter_value\
          \ == \"Month\") %}\n            ${__current_date__}\n\n          {% else\
          \ %}\n\n            CASE\n\n              WHEN EXTRACT(YEAR FROM ${__target_date__})\
          \ = EXTRACT(YEAR FROM ${__current_date__}) - 1\n              THEN ${__target_date__}\
          \ + ${__length_of_year__}\n\n              WHEN EXTRACT(YEAR FROM ${__target_date__})\
          \ = EXTRACT(YEAR FROM ${__current_date__}) - 2\n              THEN ${__target_date__}\
          \ + ${__length_of_year__} * 2\n\n              ELSE ${__target_date__}\n\
          \n            END\n\n          {% endif %}\n\n        {% elsif select_date_range._in_query\
          \ %}\n        TIMESTAMP_ADD({% date_start select_date_range %}, INTERVAL\
          \ (${day_in_period}) - 1 DAY)\n        {% else %}\n        ${base_date_raw}\n\
          \        {% endif %}\n      {% else %}\n        ${base_date_raw}\n     \
          \ {% endif %}\n\n      "
        sql_case:
        filters:
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: LY Gross Sales
        name: ly_gross_sales
        expression: pivot_index(${transactions.total_gross_sales},2)
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: '"£"#,##0'
        is_numeric: true
      - label: LY Gross Sales YoY
        name: ly_gross_sales_yoy
        expression: pivot_index(${transactions.total_gross_sales},2) / pivot_index(${transactions.total_gross_sales},
          3) - 1
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0.00%"
        is_numeric: true
      - label: LY Net Sales
        name: ly_net_sales
        expression: pivot_index(${transactions.total_net_sales},2)
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: '"£"#,##0'
        is_numeric: true
      - label: LY Net Sales YoY
        name: ly_net_sales_yoy
        expression: pivot_index(${transactions.total_net_sales},2) / pivot_index(${transactions.total_net_sales},
          3) - 1
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0.00%"
        is_numeric: true
      - label: LY Margin Inc Retro %
        name: ly_margin_inc_retro
        expression: pivot_index(${transactions.total_margin_rate_incl_funding},2)
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0.00%"
        is_numeric: true
      - label: LY AOV
        name: ly_aov
        expression: pivot_index(${transactions.aov_net_sales}, 2)
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: '"£"#,##0.00'
        is_numeric: true
      - label: LY Customers
        name: ly_customers
        expression: pivot_index(${transactions.number_of_unique_customers}, 2)
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      - label: LY Orders
        name: ly_orders
        expression: pivot_index(${transactions.number_of_transactions},2)
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      - label: LY Margin v 2LY (%PTS)
        name: ly_margin_v_2ly_pts
        expression: pivot_index(${transactions.total_margin_rate_incl_funding},2)
          - pivot_index(${transactions.total_margin_rate_incl_funding}, 3)
        can_pivot: false
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0.00%"
        is_numeric: true
      pivots:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: Pivot this to view direct date comparisons.
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Date Comparison Period
        label_from_parameter:
        label_short: Comparison Period
        map_layer:
        name: base.pivot_dimension
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: string
        user_attribute_filter_types: []
        value_format:
        view: base
        view_label: Date
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Comparison Period
        measure: false
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: base
        suggest_dimension: base.pivot_dimension
        suggest_explore: base
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fprod%2Fdate%2Fperiod_over_period.view.lkml?line=150"
        permanent:
        source_file: views/prod/date/transaction_base_date.view.lkml
        source_file_path: toolstation/views/prod/date/transaction_base_date.view.lkml
        sql: "{% if select_date_range._is_filtered %}\n\n        CASE\n          WHEN\
          \ {% condition select_date_range %}  ${base_date_raw} {% endcondition %}\n\
          \          THEN \"This {% parameter select_comparison_period %}\"\n\n  \
          \        WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw}\
          \ < ${period_2_end}\n          THEN \"Last {% parameter select_comparison_period\
          \ %}\"\n\n          WHEN ${base_date_raw}  >= ${period_3_start} and ${base_date_raw}\
          \ < ${period_3_end}\n          THEN \"2 {% parameter select_comparison_period\
          \ %}s Ago\"\n\n        END\n\n      {% elsif select_fixed_range._is_filtered\
          \ %}\n\n      CASE\n          WHEN\n            {% if select_fixed_range._parameter_value\
          \ == \"PD\" %}\n              CASE WHEN ${previous_full_day} THEN true ELSE\
          \ false END\n            {% elsif select_fixed_range._parameter_value ==\
          \ \"WTD\" %}\n              CASE WHEN ${week_to_date} THEN true ELSE false\
          \ END\n            {% elsif select_fixed_range._parameter_value == \"MTD\"\
          \ %}\n              CASE WHEN ${month_to_date} THEN true ELSE false END\n\
          \            {% elsif select_fixed_range._parameter_value == \"YTD\" %}\n\
          \              CASE WHEN ${year_to_date} THEN true ELSE false END\n    \
          \        {% else %}\n              false\n            {% endif %}\n    \
          \      THEN \"This {% parameter select_comparison_period %}\"\n\n      \
          \    WHEN\n          {% if select_fixed_range._parameter_value == \"PD\"\
          \ %}\n              CASE WHEN ${previous_full_day_LY} THEN true WHEN ${previous_full_day_LW}\
          \ THEN true WHEN ${previous_full_day_LM} THEN true ELSE false END\n    \
          \        {% elsif select_fixed_range._parameter_value == \"WTD\" %}\n  \
          \            CASE WHEN ${week_to_date_LY} THEN true ELSE false END\n   \
          \         {% elsif select_fixed_range._parameter_value == \"MTD\" %}\n \
          \             CASE WHEN ${month_to_date_LY} THEN true ELSE false END\n \
          \           {% elsif select_fixed_range._parameter_value == \"YTD\" %}\n\
          \              CASE WHEN ${year_to_date_LY} THEN true ELSE false END\n \
          \           {% else %}\n              false\n            {% endif %}\n \
          \         THEN \"Last {% parameter select_comparison_period %}\"\n\n   \
          \       WHEN\n          {% if select_fixed_range._parameter_value == \"\
          PD\" %}\n              CASE WHEN ${previous_full_day_2LY} THEN true ELSE\
          \ true END\n            {% elsif select_fixed_range._parameter_value ==\
          \ \"WTD\" %}\n              CASE WHEN ${week_to_date_2LY} THEN true ELSE\
          \ false END\n            {% elsif select_fixed_range._parameter_value ==\
          \ \"MTD\" %}\n              CASE WHEN ${month_to_date_2LY} THEN true ELSE\
          \ false END\n            {% elsif select_fixed_range._parameter_value ==\
          \ \"YTD\" %}\n              CASE WHEN ${year_to_date_2LY} THEN true ELSE\
          \ false END\n            {% else %}\n              false\n            {%\
          \ endif %}\n          THEN \"2 {% parameter select_comparison_period %}s\
          \ Ago\"\n\n          ELSE \"UNKNOWN PERIOD!\"\n\n      END\n\n      {% else\
          \ %}\n        NULL\n      {% endif %}\n\n    "
        sql_case:
        filters:
        sorted:
          desc: false
          sort_index: 1
    title_hidden: true
    listen: {}
    row: 5
    col: 0
    width: 24
    height: 9
