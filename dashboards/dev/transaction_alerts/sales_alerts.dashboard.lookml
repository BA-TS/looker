- dashboard: sales_alerts
  title: Sales Alerts
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'Provides an integrated alerting system in conjunction with the data@toolstation.com AppsScript alerting system.'
  elements:
  - name: ''
    type: text
    title_text: ''
    body_text: "# Overall"
    row: 0
    col: 0
    width: 19
    height: 2
  - title: ''
    name: " (2)"
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.date_date]
    filters:
      base.select_date_range: Yesterday
    sorts: [base.date_date desc]
    limit: 1
    listen: {}
    row: 0
    col: 19
    width: 5
    height: 2
  - title: Warning (Total) Breakdown
    name: Warning (Total) Breakdown
    model: ts_alerts
    explore: sales_alerts
    type: looker_grid
    fields: [sales_channel, sales_alerts.wow_flag, sales_alerts.2wow_flag, sales_alerts.yoy_flag,
      sales_alerts.2yoy_flag, sales_alerts.any_flag]
    filters:
      sales_alerts.date_date: 1 days ago for 1 days
    sorts: [sales_alerts.wow_flag desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: '"Total"', label: Sales Channel,
        value_format: !!null '', value_format_name: !!null '', dimension: sales_channel,
        _kind_hint: dimension, _type_hint: string}]
    show_view_names: false
    show_row_numbers: false
    transpose: true
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
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      sales_alerts.wow_flag:
        is_active: false
    series_text_format:
      sales_alerts.wow_flag:
        align: center
      sales_alerts.yoy_flag:
        align: center
      sales_alerts.2wow_flag:
        align: center
      sales_alerts.sales_channel:
        align: center
      sales_alerts.any_flag:
        align: center
        bold: true
        bg_color: "#bababa"
      sales_alerts.2yoy_flag:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: '', color_application: {collection_id: toolstation, custom: {
            id: 2608d1c8-a8e6-cd96-b87f-b06dd00f5181, label: Custom, type: continuous,
            stops: [{color: "#0be60b", offset: 0}, {color: "#f9fa95", offset: 25},
              {color: "#ffffff", offset: 50}, {color: "#3EB0D5", offset: 75}, {color: "#004f9f",
                offset: 100}]}, options: {steps: 5}}, bold: false, italic: false,
        strikethrough: false, fields: [sales_alerts.wow_flag, sales_alerts.2wow_flag,
          sales_alerts.yoy_flag, sales_alerts.any_flag, sales_alerts.2yoy_flag]},
      {type: equal to, value: 1, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.wow_flag,
          sales_alerts.2wow_flag, sales_alerts.yoy_flag, sales_alerts.any_flag, sales_alerts.2yoy_flag]}]
    series_value_format:
      sales_alerts.wow_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.2wow_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.yoy_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.any_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.2yoy_flag: '[=0]"No";[>0]"Yes"'
    defaults_version: 1
    title_hidden: true
    listen: {}
    row: 2
    col: 0
    width: 24
    height: 4
  - title: Warning (Total) Table
    name: Warning (Total) Table
    model: ts_alerts
    explore: sales_alerts
    type: looker_grid
    fields: [sales_alerts.net_sales_value, sales_alerts.net_sales_wow_change, sales_alerts.net_sales_wow_percent,
      sales_alerts.net_sales_2wow_change, sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_change,
      sales_alerts.net_sales_yoy_percent, sales_channel, sales_alerts.net_sales_2yoy_change,
      sales_alerts.net_sales_2yoy_percent]
    filters:
      sales_alerts.date_date: Yesterday
    sorts: [sales_alerts.net_sales_value desc]
    limit: 500
    dynamic_fields: [{category: dimension, expression: '"Total"', label: Sales Channel,
        value_format: !!null '', value_format_name: !!null '', dimension: sales_channel,
        _kind_hint: dimension, _type_hint: string}]
    show_view_names: false
    show_row_numbers: false
    transpose: true
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
    show_totals: true
    show_row_totals: true
    series_labels:
      sales_alerts.net_sales_yoy_percent: YoY %
      sales_alerts.net_sales_yoy_change: YoY £
      sales_alerts.net_sales_2wow_percent: 2WoW %
      sales_alerts.net_sales_2wow_change: 2WoW £
      sales_alerts.net_sales_wow_percent: WoW %
      sales_alerts.net_sales_wow_change: WoW £
      sales_alerts.net_sales_value: Net Sales
      sales_alerts.sales_channel: Sales Channel
      sales_alerts.net_sales_2yoy_percent: 2YoY %
      sales_alerts.net_sales_2yoy_change: 2YoY £
    series_cell_visualizations:
      sales_alerts.net_sales_value:
        is_active: false
      sales_alerts.net_sales_wow_percent:
        is_active: false
    series_text_format:
      sales_alerts.net_sales_value:
        align: center
      sales_alerts.net_sales_wow_change:
        align: center
      sales_alerts.net_sales_wow_percent:
        align: center
      sales_alerts.net_sales_2wow_change:
        align: center
      sales_alerts.net_sales_2wow_percent:
        align: center
      sales_alerts.net_sales_yoy_change:
        align: center
      sales_alerts.net_sales_yoy_percent:
        align: center
      sales_alerts.net_sales_2yoy_change:
        align: center
      sales_alerts.net_sales_2yoy_percent:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.net_sales_wow_percent,
          sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_percent,
          sales_alerts.net_sales_2yoy_percent]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.net_sales_wow_percent,
          sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_percent,
          sales_alerts.net_sales_2yoy_percent]}]
    series_value_format:
      sales_alerts.net_sales_value:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      sales_alerts.net_sales_wow_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      sales_alerts.net_sales_wow_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_2wow_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      sales_alerts.net_sales_2wow_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_yoy_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      sales_alerts.net_sales_yoy_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_2yoy_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
      sales_alerts.net_sales_2yoy_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    title_hidden: true
    listen: {}
    row: 6
    col: 0
    width: 24
    height: 6
  - title: Graph
    name: Graph
    model: ts_alerts
    explore: sales_alerts
    type: looker_line
    fields: [sales_alerts.date_date, sales_alerts.net_sales_wow_percent, sales_alerts.net_sales_2wow_percent,
      sales_alerts.net_sales_yoy_percent]
    fill_fields: [sales_alerts.date_date]
    filters:
      sales_alerts.date_date: 28 days ago for 28 days
    sorts: [sales_alerts.date_date desc]
    limit: 500
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
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alerts.net_sales_wow_percent,
            id: sales_alerts.net_sales_wow_percent, name: WoW Change %}, {axisId: sales_alerts.net_sales_2wow_percent,
            id: sales_alerts.net_sales_2wow_percent, name: 2WoW Change %}, {axisId: sales_alerts.net_sales_yoy_percent,
            id: sales_alerts.net_sales_yoy_percent, name: YoY Change %}], showLabels: false,
        showValues: true, minValue: !!null '', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    reference_lines: [{reference_type: line, line_value: "-0.05", range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: right, color: "#000000", label: ''}]
    defaults_version: 1
    title_hidden: true
    listen:
      Sales Channel: sales_alerts.sales_channel
    row: 12
    col: 0
    width: 24
    height: 8
  - name: " (3)"
    type: text
    title_text: ''
    body_text: "# Sales Channel"
    row: 20
    col: 0
    width: 20
    height: 2
  - title: Warning (Sales Channel) Breakdown
    name: Warning (Sales Channel) Breakdown
    model: ts_alerts
    explore: sales_alerts
    type: looker_grid
    fields: [sales_alerts.sales_channel, sales_alerts.wow_flag, sales_alerts.2wow_flag,
      sales_alerts.yoy_flag, sales_alerts.2yoy_flag, sales_alerts.any_flag]
    filters:
      sales_alerts.date_date: 1 days ago for 1 days
    sorts: [sales_alerts.sales_channel]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    transpose: true
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
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      sales_alerts.wow_flag:
        is_active: false
    series_text_format:
      sales_alerts.wow_flag:
        align: center
      sales_alerts.yoy_flag:
        align: center
      sales_alerts.2wow_flag:
        align: center
      sales_alerts.sales_channel:
        align: center
      sales_alerts.any_flag:
        align: center
        bold: true
        bg_color: "#bababa"
      sales_alerts.2yoy_flag:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: '', color_application: {collection_id: toolstation, custom: {
            id: 2608d1c8-a8e6-cd96-b87f-b06dd00f5181, label: Custom, type: continuous,
            stops: [{color: "#0be60b", offset: 0}, {color: "#f9fa95", offset: 25},
              {color: "#ffffff", offset: 50}, {color: "#3EB0D5", offset: 75}, {color: "#004f9f",
                offset: 100}]}, options: {steps: 5}}, bold: false, italic: false,
        strikethrough: false, fields: [sales_alerts.wow_flag, sales_alerts.2wow_flag,
          sales_alerts.yoy_flag, sales_alerts.2yoy_flag]}, {type: equal to, value: 1,
        background_color: "#d32f2f", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: [sales_alerts.wow_flag, sales_alerts.2wow_flag, sales_alerts.yoy_flag,
          sales_alerts.2yoy_flag]}]
    series_value_format:
      sales_alerts.wow_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.2wow_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.yoy_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.any_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.2yoy_flag: '[=0]"No";[>0]"Yes"'
    defaults_version: 1
    title_hidden: true
    listen: {}
    row: 22
    col: 0
    width: 24
    height: 4
  - title: Warning (Sales Channel) Table
    name: Warning (Sales Channel) Table
    model: ts_alerts
    explore: sales_alerts
    type: looker_grid
    fields: [sales_alerts.net_sales_value, sales_alerts.net_sales_wow_change, sales_alerts.net_sales_wow_percent,
      sales_alerts.net_sales_2wow_change, sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_change,
      sales_alerts.net_sales_yoy_percent, sales_alerts.sales_channel, sales_alerts.net_sales_2yoy_change,
      sales_alerts.net_sales_2yoy_percent]
    filters:
      sales_alerts.date_date: Yesterday
    sorts: [sales_alerts.sales_channel]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    transpose: true
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
    show_totals: true
    show_row_totals: true
    series_labels:
      sales_alerts.net_sales_yoy_percent: YoY %
      sales_alerts.net_sales_yoy_change: YoY £
      sales_alerts.net_sales_2wow_percent: 2WoW %
      sales_alerts.net_sales_2wow_change: 2WoW £
      sales_alerts.net_sales_wow_percent: WoW %
      sales_alerts.net_sales_wow_change: WoW £
      sales_alerts.net_sales_value: Net Sales
      sales_alerts.sales_channel: Sales Channel
      sales_alerts.net_sales_2yoy_change: 2YoY £
      sales_alerts.net_sales_2yoy_percent: 2YoY %
    series_cell_visualizations:
      sales_alerts.net_sales_value:
        is_active: false
      sales_alerts.net_sales_wow_percent:
        is_active: false
    series_text_format:
      sales_alerts.net_sales_value:
        align: center
      sales_alerts.net_sales_wow_change:
        align: center
      sales_alerts.net_sales_wow_percent:
        align: center
      sales_alerts.net_sales_2wow_change:
        align: center
      sales_alerts.net_sales_2wow_percent:
        align: center
      sales_alerts.net_sales_yoy_change:
        align: center
      sales_alerts.net_sales_yoy_percent:
        align: center
      sales_alerts.net_sales_2yoy_change:
        align: center
      sales_alerts.net_sales_2yoy_percent:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.net_sales_wow_percent,
          sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_percent,
          sales_alerts.net_sales_2yoy_percent]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.net_sales_wow_percent,
          sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_percent,
          sales_alerts.net_sales_2yoy_percent]}]
    series_value_format:
      sales_alerts.net_sales_value:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      sales_alerts.net_sales_wow_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      sales_alerts.net_sales_wow_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_2wow_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      sales_alerts.net_sales_2wow_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_yoy_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0'
        label: British Pounds (0)
        label_prefix: British Pounds
      sales_alerts.net_sales_yoy_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_2yoy_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
      sales_alerts.net_sales_2yoy_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    title_hidden: true
    listen: {}
    row: 26
    col: 0
    width: 24
    height: 6
  - name: " (4)"
    type: text
    title_text: ''
    body_text: "# Past 28 Days #"
    row: 32
    col: 0
    width: 24
    height: 2
  - title: Performance History
    name: Performance History
    model: ts_alerts
    explore: sales_alerts
    type: looker_grid
    fields: [sales_alerts.date_date, sales_alerts.net_sales_value, sales_alerts.net_sales_wow_change,
      sales_alerts.net_sales_wow_percent, sales_alerts.net_sales_2wow_change, sales_alerts.net_sales_2wow_percent,
      sales_alerts.net_sales_yoy_change, sales_alerts.net_sales_yoy_percent, sales_alerts.net_sales_2yoy_change,
      sales_alerts.net_sales_2yoy_percent]
    fill_fields: [sales_alerts.date_date]
    filters:
      sales_alerts.date_date: 28 days ago for 28 days
    sorts: [sales_alerts.date_date desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${sales_alerts.net_sales_wow_change}/${sales_alerts.net_sales_wow_value}",
        label: WoW %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: wow, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: "${sales_alerts.net_sales_2wow_change}/${sales_alerts.net_sales_2wow_value}",
        label: 2WoW %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: 2wow, _type_hint: number, is_disabled: true}, {category: table_calculation,
        expression: "${sales_alerts.net_sales_yoy_change}/${sales_alerts.net_sales_yoy_value}",
        label: YoY %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: yoy, _type_hint: number, is_disabled: true}]
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
    column_order: [sales_alerts.date_date, sales_alerts.net_sales_value, sales_alerts.net_sales_wow_change,
      sales_alerts.net_sales_wow_percent, sales_alerts.net_sales_2wow_change, sales_alerts.net_sales_2wow_percent,
      sales_alerts.net_sales_yoy_change, sales_alerts.net_sales_yoy_percent, sales_alerts.net_sales_2yoy_change,
      sales_alerts.net_sales_2yoy_percent]
    show_totals: true
    show_row_totals: true
    series_labels:
      sales_alerts.date_date: Date
      sales_alerts.net_sales_wow_change: WoW £
      net_sales_wow: WoW Change %
      sales_alerts.net_sales_2wow_change: 2WoW £
      sales_alerts.net_sales_yoy_change: YoY £
      sales_alerts.net_sales_2y_change: 2YoY £
      sales_alerts.net_sales_value: Net Sales
      sales_alerts.net_sales_2yoy_percent: 2YoY %
      sales_alerts.net_sales_2yoy_change: 2YoY £
      sales_alerts.net_sales_yoy_percent: YoY %
    series_cell_visualizations:
      sales_alerts.net_sales_wow_change:
        is_active: false
    series_text_format:
      sales_alerts.date_date:
        align: center
      sales_alerts.net_sales_wow_change:
        align: center
      sales_alerts.net_sales_2wow_change:
        align: center
      sales_alerts.net_sales_yoy_change:
        align: center
      sales_alerts.net_sales_2y_change:
        align: center
      wow:
        align: center
      2wow:
        align: center
      yoy:
        align: center
      2yoy:
        align: center
      sales_alerts.net_sales:
        align: center
      sales_alerts.net_sales_value:
        align: center
      sales_alerts.net_sales_wow_percent:
        align: center
      sales_alerts.net_sales_2wow_percent:
        align: center
      sales_alerts.net_sales_yoy_percent:
        align: center
      sales_alerts.net_sales_2yoy_change:
        align: center
      sales_alerts.net_sales_2yoy_percent:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.net_sales_wow_percent,
          sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_percent,
          sales_alerts.net_sales_2yoy_percent]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.net_sales_wow_percent,
          sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_percent,
          sales_alerts.net_sales_2yoy_percent]}]
    series_value_format:
      sales_alerts.net_sales_value:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
      sales_alerts.net_sales_2yoy_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_2yoy_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
      sales_alerts.net_sales_yoy_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_yoy_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
      sales_alerts.net_sales_2wow_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_2wow_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
      sales_alerts.net_sales_wow_percent:
        name: percent_1
        decimals: '1'
        format_string: "#,##0.0%"
        label: Percent (1)
        label_prefix: Percent
      sales_alerts.net_sales_wow_change:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: Net Sales WoW
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    series_types: {}
    hidden_fields: []
    title_hidden: true
    listen:
      Sales Channel: sales_alerts.sales_channel
    row: 34
    col: 0
    width: 24
    height: 16
  filters:
  - name: Sales Channel
    title: Sales Channel
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options: []
    model: ts_alerts
    explore: sales_alerts
    listens_to_filters: []
    field: sales_alerts.sales_channel
