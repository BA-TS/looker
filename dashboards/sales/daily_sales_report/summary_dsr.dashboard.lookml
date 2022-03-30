- dashboard: summary_dsr
  title: Summary
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  refresh: 2147484 seconds
  elements:
  - name: ''
    type: text
    title_text: ''
    body_text: "# Net Sales"
    row: 3
    col: 0
    width: 24
    height: 2
  - name: " (2)"
    type: text
    title_text: ''
    body_text: |-
      <div style="padding: 20px 0 20px 0; border-radius: 5px; background: #ffe200; height: 80px;">
         <div style="background: #004f9f; height: 40px; width:100%">
              <a href="https://tpdev.cloud.looker.com/boards/7">
                 <img style="color: #ffffff; float: left; height: 40px" src="https://www.toolstation.com/img/toolstation.svg"/>
               </a>
            <nav style="font-size: 18px;">
              <span style="color: #000000;">
                <a style="color: #ffffff; padding: 0 20px; float: right; line-height: 40px; font_weight: regular" href="https://tpdev.cloud.looker.com/dashboards/ts_sales::next_14_days_dsr" >Next 14 Days</a>
                <a style="color: #ffffff; padding: 0 20px; float: right; line-height: 40px; font_weight: regular" href="https://tpdev.cloud.looker.com/dashboards/ts_sales::top_10_performances_dsr" >Top 10</a>
                <a style="color: #ffffff; padding: 0 20px; float: right; line-height: 40px; font_weight: regular" href="https://tpdev.cloud.looker.com/dashboards/ts_sales::channel_performance_dsr" >Channel Performance</a>
                <a style="color: #efefef; padding: 0 20px; float: right; line-height: 40px; font-weight: bold; text-decoration: none;">Summary</a>
              </span>
            </nav>
         </div>
      </div>
    row: 0
    col: 0
    width: 24
    height: 3
  - name: " (3)"
    type: text
    title_text: ''
    body_text: "# Margin (Including Funding)"
    row: 13
    col: 0
    width: 24
    height: 2
  - name: " (4)"
    type: text
    title_text: ''
    body_text: "# Average Order Value (AOV)"
    row: 23
    col: 0
    width: 24
    height: 2
  - title: 7 Day Moving Average Trend (Sales)
    name: 7 Day Moving Average Trend (Sales)
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales, total_budget.net_sales_budget]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_number_of_periods: '3'
      base.select_comparison_period: Year
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(mean(offset_list(${total_budget.net_sales_budget},0,7)),1)',
        label: Budget, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: budget, _type_hint: number}, {category: table_calculation,
        expression: "if(\n  ${transactions.total_net_sales} = 0.00 AND \n  (offset(${transactions.total_net_sales},\
          \ -2) = 0.00 OR offset(${transactions.total_net_sales}, -2) = null), null,\n\
          \nif(mean(offset_list(${transactions.total_net_sales},0,7)) = 0 , null,\
          \ mean(offset_list(${net_sales_coalesce},0,7))\n)\n)\n", label: Net Sales,
        value_format: !!null '', value_format_name: gbp_0, _kind_hint: measure, table_calculation: net_sales,
        _type_hint: number}, {category: table_calculation, expression: 'if (${transactions.total_net_sales}
          = 0, null, ${transactions.total_net_sales})', label: Net Sales coalesce,
        value_format: !!null '', value_format_name: Default formatting, _kind_hint: measure,
        table_calculation: net_sales_coalesce, _type_hint: number, is_disabled: false},
      {category: table_calculation, expression: "if(\n  ${transactions.total_net_sales}\
          \ = 0.00 AND \n  offset(${transactions.total_net_sales}, -2) = 0.00, 0,\
          \ 1\n)", label: yesno, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: yesno, _type_hint: number, is_disabled: true}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: monotone
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: net_sales, id: This
              Year - 1 - net_sales, name: CY}, {axisId: net_sales, id: Last Year -
              2 - net_sales, name: LY}, {axisId: net_sales, id: 2 Years Ago - 3 -
              net_sales, name: 2LY}, {axisId: budget, id: budget, name: Budget}],
        showLabels: true, showValues: true, maxValue: !!null '', minValue: !!null '',
        valueFormat: '0.0,, "M"', unpinAxis: true, tickDensity: custom, tickDensityCustom: 20,
        type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '44'
    series_colors: {}
    series_labels:
      This Year - 1 - net_sales: CY
      Last Year - 2 - net_sales: LY
      2 Years Ago - 3 - net_sales: 2LY
    discontinuous_nulls: true
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales, total_budget.net_sales_budget, net_sales_1,
      net_sales_coalesce]
    note_state: expanded
    note_display: above
    note_text: 7 Day Moving Average
    title_hidden: true
    listen: {}
    row: 5
    col: 0
    width: 12
    height: 8
  - title: net_salesdayvalue
    name: net_salesdayvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_net_sales, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: PD
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: Day
    value_format: '[>=1000000] [$£-en-GB] #,##0.00,, "M"; [>=1000] [$£-en-GB] #,##0.00,
      "K"; [=0] "No Data";[$£-en-GB] #,##0.00'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          null, value: 0, background_color: "#004f9f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 5
    col: 12
    width: 3
    height: 2
  - title: net_saleswtdvalue
    name: net_saleswtdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_net_sales, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: WTD
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: WTD
    value_format: '[>=1000000] [$£-en-GB] #,##0.00,, "M"; [>=1000] [$£-en-GB] #,##0.00,
      "K"; [$£-en-GB] #,##0.00'
    conditional_formatting: [{type: not null, value: 0, background_color: "#004f9f",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: 'null',
        value: !!null '', background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 7
    col: 12
    width: 3
    height: 2
  - title: net_salesmtdvalue
    name: net_salesmtdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_net_sales, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: MTD
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: MTD
    value_format: '[>=1000000] [$£-en-GB] #,##0.00,, "M"; [>=1000] [$£-en-GB] #,##0.00,
      "K"; [$£-en-GB] #,##0.00'
    conditional_formatting: [{type: not null, value: 0, background_color: "#004f9f",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: 'null',
        value: !!null '', background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 9
    col: 12
    width: 3
    height: 2
  - title: net_salesytdvalue
    name: net_salesytdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_net_sales, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: YTD
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: YTD
    value_format: '[>=1000000] [$£-en-GB] #,##0.00,, "M"; [>=1000] [$£-en-GB] #,##0.00,
      "K"; [$£-en-GB] #,##0.00'
    conditional_formatting: [{type: not null, value: 0, background_color: "#004f9f",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: 'null',
        value: !!null '', background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 11
    col: 12
    width: 3
    height: 2
  - title: net_salesdayvsLY
    name: net_salesdayvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_net_sales]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.total_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 5
    col: 15
    width: 3
    height: 2
  - title: net_saleswtdvsLY
    name: net_saleswtdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_net_sales]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.total_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 7
    col: 15
    width: 3
    height: 2
  - title: net_salesmtdvsLY
    name: net_salesmtdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_net_sales]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.total_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 9
    col: 15
    width: 3
    height: 2
  - title: net_salesytdvsLY
    name: net_salesytdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_net_sales]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.total_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 11
    col: 15
    width: 3
    height: 2
  - title: net_salesdayvs2LY
    name: net_salesdayvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_net_sales]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, expression: "(${transactions.total_net_sales}\
          \ / offset(${transactions.total_net_sales}, 2) -1)", table_calculation: vs_ly,
        args: [transactions.total_net_sales], _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 5
    col: 18
    width: 3
    height: 2
  - title: net_saleswtdvs2LY
    name: net_saleswtdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_net_sales]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, expression: "(${transactions.total_net_sales}\
          \ / offset(${transactions.total_net_sales}, 2) -1)", table_calculation: vs_ly,
        args: [transactions.total_net_sales], _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 7
    col: 18
    width: 3
    height: 2
  - title: net_salesmtdvs2LY
    name: net_salesmtdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_net_sales]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, expression: "(${transactions.total_net_sales}\
          \ / offset(${transactions.total_net_sales}, 2) -1)", table_calculation: vs_ly,
        args: [transactions.total_net_sales], _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 9
    col: 18
    width: 3
    height: 2
  - title: net_salesytdvs2LY
    name: net_salesytdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_net_sales]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, expression: "(${transactions.total_net_sales}\
          \ / offset(${transactions.total_net_sales}, 2) -1)", table_calculation: vs_ly,
        args: [transactions.total_net_sales], _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 11
    col: 18
    width: 3
    height: 2
  - title: net_salesdayvsBudget
    name: net_salesdayvsBudget
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_net_sales, total_budget.net_sales_budget, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${total_budget.net_sales_budget}", label: vs Budget £, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
        _type_hint: number}, {category: table_calculation, expression: "(${transactions.total_net_sales}\
          \ / ${total_budget.net_sales_budget}) - 1", label: "%", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, table_calculation: calculation,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    value_format: '[>=1000] [$£-en-GB] #,##0.00, "K"; [<=-1000000] - [$£-en-GB] #,##0.00,,
      "M"; [<=-1000] - [$£-en-GB] #,##0.00, "K";[$£-en-GB] #,##0.00'
    comparison_label: vs Budget
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_net_sales, total_budget.net_sales_budget]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 5
    col: 21
    width: 3
    height: 2
  - title: net_saleswtdvsBudget
    name: net_saleswtdvsBudget
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_net_sales, total_budget.net_sales_budget, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${total_budget.net_sales_budget}", label: vs Budget £, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
        _type_hint: number}, {category: table_calculation, expression: "(${transactions.total_net_sales}\
          \ / ${total_budget.net_sales_budget}) - 1", label: "%", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, table_calculation: calculation,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    value_format: '[>=1000] [$£-en-GB] #,##0.00, "K"; [<=-1000000] - [$£-en-GB] #,##0.00,,
      "M"; [<=-1000] - [$£-en-GB] #,##0.00, "K";[$£-en-GB] #,##0.00'
    comparison_label: vs Budget
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_net_sales, total_budget.net_sales_budget]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 7
    col: 21
    width: 3
    height: 2
  - title: net_salesmtdvsBudget
    name: net_salesmtdvsBudget
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_net_sales, total_budget.net_sales_budget, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${total_budget.net_sales_budget}", label: vs Budget £, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
        _type_hint: number}, {category: table_calculation, expression: "(${transactions.total_net_sales}\
          \ / ${total_budget.net_sales_budget}) - 1", label: "%", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, table_calculation: calculation,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    value_format: '[>=1000] [$£-en-GB] #,##0.00, "K"; [<=-1000000] - [$£-en-GB] #,##0.00,,
      "M"; [<=-1000] - [$£-en-GB] #,##0.00, "K";[$£-en-GB] #,##0.00'
    comparison_label: vs Budget
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_net_sales, total_budget.net_sales_budget]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 9
    col: 21
    width: 3
    height: 2
  - title: net_salesytdvsBudget
    name: net_salesytdvsBudget
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_net_sales, total_budget.net_sales_budget, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${total_budget.net_sales_budget}", label: vs Budget £, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
        _type_hint: number}, {category: table_calculation, expression: "(${transactions.total_net_sales}\
          \ / ${total_budget.net_sales_budget}) - 1", label: "%", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, table_calculation: calculation,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    value_format: '[>=1000] [$£-en-GB] #,##0.00, "K"; [<=-1000000] - [$£-en-GB] #,##0.00,,
      "M"; [<=-1000] - [$£-en-GB] #,##0.00, "K";[$£-en-GB] #,##0.00'
    comparison_label: vs Budget
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_net_sales, total_budget.net_sales_budget]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 11
    col: 21
    width: 3
    height: 2
  - title: net_margindayvalue
    name: net_margindayvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_margin_rate_incl_funding, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: PD
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: Day
    value_format: '[=0] "No Data";'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          null, value: 0, background_color: "#004f9f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 15
    col: 12
    width: 3
    height: 2
  - title: net_marginwtdvalue
    name: net_marginwtdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_margin_rate_incl_funding, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: WTD
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: WTD
    value_format: '[=0] "No Data";'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          null, value: 0, background_color: "#004f9f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 17
    col: 12
    width: 3
    height: 2
  - title: net_marginmtdvalue
    name: net_marginmtdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_margin_rate_incl_funding, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: MTD
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: MTD
    value_format: '[=0] "No Data";'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          null, value: 0, background_color: "#004f9f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 19
    col: 12
    width: 3
    height: 2
  - title: net_marginytdvalue
    name: net_marginytdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_margin_rate_incl_funding, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: YTD
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: YTD
    value_format: '[=0] "No Data";'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          null, value: 0, background_color: "#004f9f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 21
    col: 12
    width: 3
    height: 2
  - title: net_margindayvsLY
    name: net_margindayvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_margin_rate_incl_funding]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'if(${transactions.total_margin_rate_incl_funding}
          = 0, -1, (${transactions.total_margin_rate_incl_funding} - offset(${transactions.total_margin_rate_incl_funding},
          1)))', label: "% vs LY", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: measure, table_calculation: vs_ly, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "%PTS vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: equal
          to, value: 0, background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: greater than,
        value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 15
    col: 15
    width: 3
    height: 2
  - title: net_marginwtdvsLY
    name: net_marginwtdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_margin_rate_incl_funding]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'if(${transactions.total_margin_rate_incl_funding}
          = 0, -1, (${transactions.total_margin_rate_incl_funding} - offset(${transactions.total_margin_rate_incl_funding},
          1)))', label: "% vs LY", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: measure, table_calculation: vs_ly, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "%PTS vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: equal
          to, value: 0, background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: greater than,
        value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 17
    col: 15
    width: 3
    height: 2
  - title: net_marginmtdvsLY
    name: net_marginmtdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_margin_rate_incl_funding]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(${transactions.total_margin_rate_incl_funding}\
          \ - offset(${transactions.total_margin_rate_incl_funding}, 1))", label: "%\
          \ vs LY", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: vs_ly, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "%PTS vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: equal
          to, value: 0, background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: greater than,
        value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 19
    col: 15
    width: 3
    height: 2
  - title: net_marginytdvsLY
    name: net_marginytdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_margin_rate_incl_funding]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(${transactions.total_margin_rate_incl_funding}\
          \ - offset(${transactions.total_margin_rate_incl_funding}, 1))", label: "%\
          \ vs LY", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: vs_ly, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "%PTS vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 21
    col: 15
    width: 3
    height: 2
  - title: net_margindayvs2LY
    name: net_margindayvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_margin_rate_incl_funding]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: 2YearsAgo
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'if(${transactions.total_margin_rate_incl_funding}
          = 0, -1, (${transactions.total_margin_rate_incl_funding} - offset(${transactions.total_margin_rate_incl_funding},
          1)))', label: "% vs 2LY", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: measure, table_calculation: vs_ly, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "%PTS vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 15
    col: 18
    width: 3
    height: 2
  - title: net_marginwtdvs2LY
    name: net_marginwtdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_margin_rate_incl_funding]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: 2YearsAgo
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(${transactions.total_margin_rate_incl_funding}\
          \ - offset(${transactions.total_margin_rate_incl_funding}, 1))", label: "%\
          \ vs LY", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: vs_ly, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "%PTS vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 17
    col: 18
    width: 3
    height: 2
  - title: net_marginmtdvs2LY
    name: net_marginmtdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_margin_rate_incl_funding]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: 2YearsAgo
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(${transactions.total_margin_rate_incl_funding}\
          \ - offset(${transactions.total_margin_rate_incl_funding}, 1))", label: "%\
          \ vs LY", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: vs_ly, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "%PTS vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: equal
          to, value: 0, background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: greater than,
        value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 19
    col: 18
    width: 3
    height: 2
  - title: net_marginytdvs2LY
    name: net_marginytdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.total_margin_rate_incl_funding]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: 2YearsAgo
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(${transactions.total_margin_rate_incl_funding}\
          \ - offset(${transactions.total_margin_rate_incl_funding}, 1))", label: "%\
          \ vs LY", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: vs_ly, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "%PTS vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 21
    col: 18
    width: 3
    height: 2
  - title: net_margindayvsBudget
    name: net_margindayvsBudget
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_margin_rate_incl_funding, total_budget.gross_margin_rate_inc_retro_funding_budget,
      base.dynamic_actual_year]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_margin_rate_incl_funding}\
          \ - ${total_budget.gross_margin_rate_inc_retro_funding_budget}", label: "%",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: calculation, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: vs Budget %PTS
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding, total_budget.gross_margin_rate_inc_retro_funding_budget]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 15
    col: 21
    width: 3
    height: 2
  - title: net_marginwtdvsBudget
    name: net_marginwtdvsBudget
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_margin_rate_incl_funding, total_budget.gross_margin_rate_inc_retro_funding_budget,
      base.dynamic_actual_year]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_margin_rate_incl_funding}\
          \ - ${total_budget.gross_margin_rate_inc_retro_funding_budget}", label: "%",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: calculation, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: vs Budget %PTS
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding, total_budget.gross_margin_rate_inc_retro_funding_budget]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 17
    col: 21
    width: 3
    height: 2
  - title: net_marginmtdvsBudget
    name: net_marginmtdvsBudget
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_margin_rate_incl_funding, total_budget.gross_margin_rate_inc_retro_funding_budget,
      base.dynamic_actual_year]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_margin_rate_incl_funding}\
          \ - ${total_budget.gross_margin_rate_inc_retro_funding_budget}", label: "%",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: calculation, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: vs Budget %PTS
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding, total_budget.gross_margin_rate_inc_retro_funding_budget]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 19
    col: 21
    width: 3
    height: 2
  - title: net_marginytdvsBudget
    name: net_marginytdvsBudget
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.total_margin_rate_incl_funding, total_budget.gross_margin_rate_inc_retro_funding_budget,
      base.dynamic_actual_year]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_margin_rate_incl_funding}\
          \ - ${total_budget.gross_margin_rate_inc_retro_funding_budget}", label: "%",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: calculation, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: vs Budget %PTS
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    hidden_fields: [transactions.total_margin_rate_incl_funding, total_budget.gross_margin_rate_inc_retro_funding_budget]
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 21
    col: 21
    width: 3
    height: 2
  - title: aovdayvalue
    name: aovdayvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.aov_net_sales, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: Day
    value_format: '[=0] "No Data";'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          null, value: 0, background_color: "#004f9f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 25
    col: 12
    width: 3
    height: 2
  - title: aovwtdvalue
    name: aovwtdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.aov_net_sales, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: WTD
    value_format: ''
    conditional_formatting: [{type: not null, value: 0, background_color: "#004f9f",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: 'null',
        value: !!null '', background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 27
    col: 12
    width: 3
    height: 2
  - title: aovmtdvalue
    name: aovmtdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.aov_net_sales, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: MTD
    value_format: ''
    conditional_formatting: [{type: not null, value: 0, background_color: "#004f9f",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: 'null',
        value: !!null '', background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 29
    col: 12
    width: 3
    height: 2
  - title: aovytdvalue
    name: aovytdvalue
    model: ts_sales
    explore: base
    type: single_value
    fields: [transactions.aov_net_sales, base.dynamic_actual_year]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    custom_color: ''
    single_value_title: YTD
    value_format: ''
    conditional_formatting: [{type: not null, value: 0, background_color: "#004f9f",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: 'null',
        value: !!null '', background_color: "#FFE200", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 31
    col: 12
    width: 3
    height: 2
  - title: aovdayvsLY
    name: aovdayvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.aov_net_sales]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.aov_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales]
    series_types: {}
    listen: {}
    row: 25
    col: 15
    width: 3
    height: 2
  - title: aovwtdvsLY
    name: aovwtdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.aov_net_sales]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.aov_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales]
    series_types: {}
    listen: {}
    row: 27
    col: 15
    width: 3
    height: 2
  - title: aovmtdvsLY
    name: aovmtdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.aov_net_sales]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.aov_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales]
    series_types: {}
    listen: {}
    row: 29
    col: 15
    width: 3
    height: 2
  - title: aovytdvsLY
    name: aovytdvsLY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.aov_net_sales]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.aov_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales]
    series_types: {}
    listen: {}
    row: 31
    col: 15
    width: 3
    height: 2
  - title: aovdayvs2LY
    name: aovdayvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.aov_net_sales]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: 2YearsAgo
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.aov_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales]
    series_types: {}
    listen: {}
    row: 25
    col: 18
    width: 3
    height: 2
  - title: aovwtdvs2LY
    name: aovwtdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.aov_net_sales]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: 2YearsAgo
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.aov_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales]
    series_types: {}
    listen: {}
    row: 27
    col: 18
    width: 3
    height: 2
  - title: aovmtdvs2LY
    name: aovmtdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.aov_net_sales]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: 2YearsAgo
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.aov_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales]
    series_types: {}
    listen: {}
    row: 29
    col: 18
    width: 3
    height: 2
  - title: aovytdvs2LY
    name: aovytdvs2LY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_actual_year, transactions.aov_net_sales]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: 2YearsAgo
      base.select_number_of_periods: '3'
    sorts: [base.dynamic_actual_year desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, calculation_type: percent_difference_from_previous,
        table_calculation: vs_ly, args: [transactions.aov_net_sales], _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    single_value_title: "% vs 2LY"
    value_format: '[=-1] "No Data";'
    conditional_formatting: [{type: equal to, value: -1, background_color: "#FFE200",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: greater
          than, value: 0, background_color: "#72D16D", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: less than,
        value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales]
    series_types: {}
    listen: {}
    row: 31
    col: 18
    width: 3
    height: 2
  - title: 7 Day Moving Average Trend (Margin)
    name: 7 Day Moving Average Trend (Margin)
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_margin_rate_incl_funding,
      total_budget.gross_margin_inc_retro_budget, total_budget.net_sales_budget]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_number_of_periods: '3'
      base.select_comparison_period: Year
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(mean(offset_list(${total_budget.gross_margin_inc_retro_budget}
          / ${total_budget.net_sales_budget}, 0, 7)),1)

          ', label: Budget, value_format: !!null '', value_format_name: percent_2,
        _kind_hint: supermeasure, table_calculation: budget, _type_hint: number},
      {category: table_calculation, expression: 'if((${net_margin_coalesce} = 0 OR
          ${net_margin_coalesce} = null OR ${net_margin_coalesce} < 1) OR offset(${net_margin_coalesce},
          -2) < 1, mean(offset_list(${net_margin_coalesce},0,7)),null)', label: Net
          Margin, value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        table_calculation: net_margin, _type_hint: number}, {category: table_calculation,
        expression: 'if (${transactions.total_margin_rate_incl_funding} = 0, null,
          ${transactions.total_margin_rate_incl_funding})', label: Net Margin coalesce,
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: net_margin_coalesce, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: monotone
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: net_margin, id: This
              Year - 1 - net_margin, name: CY}, {axisId: net_margin, id: Last Year
              - 2 - net_margin, name: LY}, {axisId: net_margin, id: 2 Years Ago -
              3 - net_margin, name: 2LY}, {axisId: budget, id: budget, name: Budget}],
        showLabels: true, showValues: true, maxValue: !!null '', minValue: !!null '', valueFormat: 0%,
        unpinAxis: true, tickDensity: custom, tickDensityCustom: 19, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '44'
    series_colors: {}
    series_labels:
      This Year - 1 - net_sales: CY
      Last Year - 2 - net_sales: LY
      2 Years Ago - 3 - net_sales: 2LY
      This Year - 1 - net_margin: CY
      Last Year - 2 - net_margin: LY
      2 Years Ago - 3 - net_margin: 2LY
    discontinuous_nulls: true
    defaults_version: 1
    hidden_fields: [transactions.total_margin_rate_incl_funding, total_budget.net_sales_budget,
      total_budget.gross_margin_inc_retro_budget, new_calculation, net_margin_coalesce]
    note_state: expanded
    note_display: above
    note_text: 7 Day Moving Average
    title_hidden: true
    listen: {}
    row: 15
    col: 0
    width: 12
    height: 8
  - title: 7 Day Moving Average Trend (AOV)
    name: 7 Day Moving Average Trend (AOV)
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.aov_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_number_of_periods: '3'
      base.select_comparison_period: Year
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(mean(offset_list(${category_budget.department_margin_inc_all_funding_budget}
          / ${category_budget.department_net_sales_budget}, 0, 7)),1)

          ', label: Budget, value_format: !!null '', value_format_name: percent_2,
        _kind_hint: supermeasure, table_calculation: budget, _type_hint: number, is_disabled: true},
      {category: table_calculation, expression: "mean(offset_list(${transactions.total_margin_rate_incl_funding},0,7))\n\
          \n", label: Net Margin, value_format: !!null '', value_format_name: percent_2,
        _kind_hint: measure, table_calculation: net_margin, _type_hint: number, is_disabled: true},
      {category: table_calculation, expression: "\nif(\n  ${transactions.aov_net_sales}\
          \ = 0.00 AND \n  (offset(${transactions.aov_net_sales}, -2) = 0.00 OR offset(${transactions.aov_net_sales},\
          \ -2) = null), null,\n\nif(mean(offset_list(${transactions.aov_net_sales},0,7))\
          \ = 0 , null, mean(offset_list(${aov_coalesce},0,7))\n)\n)\n", label: AOV,
        value_format: !!null '', value_format_name: gbp, _kind_hint: measure, table_calculation: aov,
        _type_hint: number}, {category: table_calculation, expression: 'if(${transactions.aov_net_sales} = 0, null, if(${transactions.aov_net_sales} / 2 > offset(${transactions.aov_net_sales}, 1), null, ${transactions.aov_net_sales}))', label: AOV coalesce, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: measure, table_calculation: aov_coalesce,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: monotone
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
        reverse: false
    y_axes: [{label: '', orientation: left, series: [{axisId: aov, id: This Year -
              1 - aov, name: This Year}, {axisId: aov, id: Last Year - 2 - aov, name: Last
              Year}, {axisId: aov, id: 2 Years Ago - 3 - aov, name: 2 Years Ago}],
        showLabels: true, showValues: true, maxValue: !!null '', minValue: !!null '', valueFormat: '0',
        unpinAxis: true, tickDensity: custom, tickDensityCustom: 19, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '44'
    series_colors: {}
    series_labels:
      This Year - 1 - net_sales: CY
      Last Year - 2 - net_sales: LY
      2 Years Ago - 3 - net_sales: 2LY
      This Year - 1 - net_margin: CY
      Last Year - 2 - net_margin: LY
      2 Years Ago - 3 - net_margin: 2LY
    defaults_version: 1
    hidden_fields: [transactions.aov_net_sales, aov_coalesce]
    note_state: expanded
    note_display: above
    note_text: 7 Day Moving Average
    title_hidden: true
    listen: {}
    row: 25
    col: 0
    width: 12
    height: 8
