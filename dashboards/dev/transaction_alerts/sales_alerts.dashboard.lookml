- dashboard: sales_alerts
  title: Sales Alerts
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  refresh: 1 day
  elements:
  - title: Period Change
    name: Period Change
    model: ts_alerts
    explore: sales_alert
    type: looker_line
    fields: [sales_alert.net_sales_1w_change, sales_alert.net_sales_1y_change, sales_alert.net_sales_2w_change,
      sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.date_date: 28 days ago for 28 days
    sorts: [sales_alert.date_date desc]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: WoW Change}, {axisId: sales_alert.net_sales_1y_change,
            id: sales_alert.net_sales_1y_change, name: YoY Change}, {axisId: sales_alert.net_sales_2w_change,
            id: sales_alert.net_sales_2w_change, name: 2WoW Change}, {axisId: sales_alert.net_sales_2y_change,
            id: sales_alert.net_sales_2y_change, name: 2YoY Change}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_labels:
      sales_alert.net_sales_1w_change: WoW Change
      sales_alert.net_sales_1y_change: YoY Change
      sales_alert.net_sales_2w_change: 2WoW Change
      sales_alert.net_sales_2y_change: 2YoY Change
    reference_lines: [{reference_type: line, line_value: '0', range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#ff0b27"}]
    defaults_version: 1
    listen: {}
    row: 27
    col: 12
    width: 12
    height: 6
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "# Performance #"
    row: 0
    col: 0
    width: 24
    height: 2
  - title: 1 Week Deviation 5%
    name: 1 Week Deviation 5%
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.alert_required]
    filters:
      sales_alert.1_week_deviation_parameter: 'YES'
      sales_alert.minimum_deviation: '0.05'
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          equal to, value: 0, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 4
    col: 0
    width: 6
    height: 2
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "## vs LW ##"
    row: 2
    col: 0
    width: 12
    height: 2
  - title: 1 Week Deviation 10%
    name: 1 Week Deviation 10%
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.alert_required]
    filters:
      sales_alert.1_week_deviation_parameter: 'YES'
      sales_alert.minimum_deviation: '0.10'
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          equal to, value: 0, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 4
    col: 6
    width: 6
    height: 2
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "## vs 2LW ##"
    row: 2
    col: 12
    width: 12
    height: 2
  - title: 2 Week Deviation 5%
    name: 2 Week Deviation 5%
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.minimum_deviation: '0.05'
      sales_alert.2_week_deviation_parameter: 'YES'
      sales_alert.date_date: Yesterday
    sorts: [sales_alert.date_date desc]
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          equal to, value: 0, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 4
    col: 12
    width: 6
    height: 2
  - title: 2 Week Deviation 10%
    name: 2 Week Deviation 10%
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.minimum_deviation: '0.10'
      sales_alert.2_week_deviation_parameter: 'YES'
      sales_alert.date_date: Yesterday
    sorts: [sales_alert.date_date desc]
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          equal to, value: 0, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 4
    col: 18
    width: 6
    height: 2
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "## vs LY ##"
    row: 13
    col: 0
    width: 24
    height: 2
  - title: 1 Year Deviation 5%
    name: 1 Year Deviation 5%
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.minimum_deviation: '0.05'
      sales_alert.date_date: Yesterday
      sales_alert.1_year_deviation_parameter: 'YES'
    sorts: [sales_alert.date_date desc]
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          equal to, value: 0, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 15
    col: 0
    width: 6
    height: 2
  - title: 1 Year Deviation 10%
    name: 1 Year Deviation 10%
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.minimum_deviation: '0.10'
      sales_alert.date_date: Yesterday
      sales_alert.1_year_deviation_parameter: 'YES'
    sorts: [sales_alert.date_date desc]
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          equal to, value: 0, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 15
    col: 6
    width: 6
    height: 2
  - title: WoW Performance Change (Past 14 Days)
    name: WoW Performance Change (Past 14 Days)
    model: ts_alerts
    explore: sales_alert
    type: looker_column
    fields: [sales_alert.net_sales_1w_change, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.date_date: 14 days ago for 14 days
    sorts: [sales_alert.date_date desc]
    limit: 500
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
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: Net Sales 1w Change}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '14'
    series_types: {}
    reference_lines: [{reference_type: line, line_value: '0', range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#ff2e49"}]
    trend_lines: []
    column_spacing_ratio: 0
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen: {}
    row: 6
    col: 0
    width: 12
    height: 7
  - title: 2WoW Performance Change (Past 14 Days)
    name: 2WoW Performance Change (Past 14 Days)
    model: ts_alerts
    explore: sales_alert
    type: looker_column
    fields: [sales_alert.date_date, sales_alert.net_sales_2w_change]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.date_date: 14 days ago for 14 days
    sorts: [sales_alert.date_date desc]
    limit: 500
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
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: Net Sales 1w Change}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '14'
    series_types: {}
    reference_lines: [{reference_type: line, line_value: '0', range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#ff2e49"}]
    trend_lines: []
    column_spacing_ratio: 0
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen: {}
    row: 6
    col: 12
    width: 12
    height: 7
  - title: YoY Performance Change (Past 28 Days)
    name: YoY Performance Change (Past 28 Days)
    model: ts_alerts
    explore: sales_alert
    type: looker_column
    fields: [sales_alert.date_date, sales_alert.net_sales_1y_change]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.date_date: 28 days ago for 28 days
    sorts: [sales_alert.date_date desc]
    limit: 500
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
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: Net Sales 1w Change}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: '14'
    series_types: {}
    reference_lines: [{reference_type: line, line_value: '0', range_start: max, range_end: min,
        margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
        color: "#ff2e49"}]
    trend_lines: []
    column_spacing_ratio: 0
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen: {}
    row: 17
    col: 0
    width: 24
    height: 8
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "## Past 28 Days ##"
    row: 25
    col: 0
    width: 24
    height: 2
  - title: Performance History
    name: Performance History
    model: ts_alerts
    explore: sales_alert
    type: looker_grid
    fields: [sales_alert.date_date, sales_alert.net_sales, sales_alert.net_sales_1w_change,
      sales_alert.net_sales_1w_prior, sales_alert.net_sales_2w_change, sales_alert.net_sales_2w_prior,
      sales_alert.net_sales_1y_change, sales_alert.net_sales_1y_prior]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.date_date: 28 days ago for 28 days
    sorts: [sales_alert.date_date desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${sales_alert.net_sales_1w_change}/${sales_alert.net_sales_1w_prior}",
        label: WoW %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: wow, _type_hint: number}, {category: table_calculation,
        expression: "${sales_alert.net_sales_2w_change}/${sales_alert.net_sales_2w_prior}",
        label: 2WoW %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: 2wow, _type_hint: number}, {category: table_calculation,
        expression: "${sales_alert.net_sales_1y_change}/${sales_alert.net_sales_1y_prior}",
        label: YoY %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: yoy, _type_hint: number}, {category: table_calculation,
        expression: "${sales_alert.net_sales_2y_change}/${sales_alert.net_sales_2y_prior}",
        label: 2YoY %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: 2yoy, _type_hint: number, is_disabled: true}]
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
    column_order: [sales_alert.date_date, sales_alert.net_sales, sales_alert.net_sales_1w_change,
      wow, sales_alert.net_sales_2w_change, 2wow, sales_alert.net_sales_1y_change,
      yoy, sales_alert.net_sales_2y_change, 2yoy]
    show_totals: true
    show_row_totals: true
    series_labels:
      sales_alert.date_date: Date
      sales_alert.net_sales_1w_change: WoW £
      net_sales_wow: WoW Change %
      sales_alert.net_sales_2w_change: 2WoW £
      sales_alert.net_sales_1y_change: YoY £
      sales_alert.net_sales_2y_change: 2YoY £
    series_cell_visualizations:
      sales_alert.net_sales_1w_change:
        is_active: false
    series_text_format:
      sales_alert.date_date:
        align: center
      sales_alert.net_sales_1w_change:
        align: center
      sales_alert.net_sales_2w_change:
        align: center
      sales_alert.net_sales_1y_change:
        align: center
      sales_alert.net_sales_2y_change:
        align: center
      wow:
        align: center
      2wow:
        align: center
      yoy:
        align: center
      2yoy:
        align: center
      sales_alert.net_sales:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: '', font_color: "#d32f2f", color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}]
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
    hidden_fields: [sales_alert.net_sales_1w_prior, sales_alert.net_sales_2w_prior,
      sales_alert.net_sales_1y_prior]
    query_fields:
      measures:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales
        label_from_parameter:
        label_short: Net Sales
        map_layer:
        name: sales_alert.net_sales
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=60"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales_dim} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales 1w Change
        label_from_parameter:
        label_short: Net Sales 1w Change
        map_layer:
        name: sales_alert.net_sales_1w_change
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales 1w Change
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales_1w_change
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=87"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales}-${net_sales_1w_prior} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales 1w Prior
        label_from_parameter:
        label_short: Net Sales 1w Prior
        map_layer:
        name: sales_alert.net_sales_1w_prior
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales 1w Prior
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales_1w_prior
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=66"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales_1w} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales 2w Change
        label_from_parameter:
        label_short: Net Sales 2w Change
        map_layer:
        name: sales_alert.net_sales_2w_change
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales 2w Change
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales_2w_change
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=92"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales}-${net_sales_2w_prior} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales 2w Prior
        label_from_parameter:
        label_short: Net Sales 2w Prior
        map_layer:
        name: sales_alert.net_sales_2w_prior
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales 2w Prior
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales_2w_prior
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=71"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales_2w} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales 1y Change
        label_from_parameter:
        label_short: Net Sales 1y Change
        map_layer:
        name: sales_alert.net_sales_1y_change
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales 1y Change
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales_1y_change
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=97"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales}-${net_sales_1y_prior} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales 1y Prior
        label_from_parameter:
        label_short: Net Sales 1y Prior
        map_layer:
        name: sales_alert.net_sales_1y_prior
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales 1y Prior
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales_1y_prior
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=76"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales_1y} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales 2y Change
        label_from_parameter:
        label_short: Net Sales 2y Change
        map_layer:
        name: sales_alert.net_sales_2y_change
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales 2y Change
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales_2y_change
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=102"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales}-${net_sales_2y_prior} "
        sql_case:
        filters:
      - align: right
        can_filter: true
        category: measure
        default_filter_value:
        description:
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: Sales Alert Net Sales 2y Prior
        label_from_parameter:
        label_short: Net Sales 2y Prior
        map_layer:
        name: sales_alert.net_sales_2y_prior
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: sum
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: '"£"#,##0'
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group:
        error:
        field_group_variant: Net Sales 2y Prior
        measure: true
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.net_sales_2y_prior
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=82"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${net_sales_2y} "
        sql_case:
        filters:
      dimensions:
      - align: left
        can_filter: true
        category: dimension
        default_filter_value:
        description:
        enumerations:
        field_group_label: Date Date
        fill_style: range
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Sales Alert Date Date
        label_from_parameter:
        label_short: Date Date
        map_layer:
        name: sales_alert.date_date
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
        view: sales_alert
        view_label: Sales Alert
        dynamic: false
        week_start_day: sunday
        dimension_group: sales_alert.date
        error:
        field_group_variant: Date
        measure: false
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alert.date_date
        suggest_explore: sales_alert
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: day
          count: 1
        lookml_link: "/projects/toolstation/files/views%2Fdev%2Fsales_alerting.view.lkml?line=7"
        permanent:
        source_file: views/dev/sales_alerting.view.lkml
        source_file_path: toolstation/views/dev/sales_alerting.view.lkml
        sql: "${TABLE}.date "
        sql_case:
        filters:
        sorted:
          desc: true
          sort_index: 0
      table_calculations:
      - label: WoW %
        name: wow
        expression: "${sales_alert.net_sales_1w_change}/${sales_alert.net_sales_1w_prior}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0.0%"
        is_numeric: true
      - label: 2WoW %
        name: 2wow
        expression: "${sales_alert.net_sales_2w_change}/${sales_alert.net_sales_2w_prior}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0.0%"
        is_numeric: true
      - label: YoY %
        name: yoy
        expression: "${sales_alert.net_sales_1y_change}/${sales_alert.net_sales_1y_prior}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0.0%"
        is_numeric: true
      - label: 2YoY %
        name: 2yoy
        expression: "${sales_alert.net_sales_2y_change}/${sales_alert.net_sales_2y_prior}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0.0%"
        is_numeric: true
      pivots: []
    title_hidden: true
    listen: {}
    row: 27
    col: 0
    width: 12
    height: 6
  - title: Any 5% Deviation
    name: Any 5% Deviation
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.date_date, sales_alert.alert_required, sales_alert.1_year_deviation,
      sales_alert.1_week_deviation, sales_alert.2_week_deviation]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.date_date: 1 days ago for 1 days
      sales_alert.minimum_deviation: '0.05'
      sales_alert.2_week_deviation_parameter: 'YES'
      sales_alert.1_year_deviation_parameter: 'YES'
      sales_alert.1_week_deviation_parameter: 'YES'
    sorts: [sales_alert.date_date desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(\nabs(${sales_alert.net_sales_2w_change}/${sales_alert.net_sales_2w_prior}\
          \ ) >= 0.05\nAND \nabs(${sales_alert.net_sales_1y_change}/${sales_alert.net_sales_1y_prior}\
          \ ) >= 0.05\nAND \nabs(${sales_alert.net_sales_1w_change}/${sales_alert.net_sales_1w_prior}\
          \ ) >= 0.05\n, 1, 0)\n\n\n", label: 1WOW >  10% & 2WOW > 10% & 1YOY > 10%,
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: 1wow_10_2wow_10_1yoy_10, _type_hint: number, is_disabled: true}]
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 1, background_color: "#d32f2f",
        font_color: "#000000", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: equal
          to, value: 0, background_color: "#72D16D", font_color: "#000000", color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: equal to,
        value: !!null '', background_color: !!null '', font_color: !!null '', color_application: {
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
    series_types: {}
    hidden_fields: []
    note_state: collapsed
    note_display: above
    listen: {}
    row: 33
    col: 0
    width: 24
    height: 2
  - title: 1 Year Deviation 15%
    name: 1 Year Deviation 15%
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.minimum_deviation: '0.15'
      sales_alert.date_date: Yesterday
      sales_alert.1_year_deviation_parameter: 'YES'
    sorts: [sales_alert.date_date desc]
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          equal to, value: 0, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 15
    col: 12
    width: 6
    height: 2
  - title: 1 Year Deviation 20%
    name: 1 Year Deviation 20%
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.minimum_deviation: '0.20'
      sales_alert.date_date: Yesterday
      sales_alert.1_year_deviation_parameter: 'YES'
    sorts: [sales_alert.date_date desc]
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
    value_format: '[=0]"No";[>0]"Yes"'
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          equal to, value: 0, background_color: "#d32f2f", font_color: !!null '',
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 15
    col: 18
    width: 6
    height: 2
  - name: " (6)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      # Sales Channel #

      Net Sales performance over the last 14 days.
    row: 35
    col: 0
    width: 24
    height: 3
  - title: Branch and EPOS
    name: Branch and EPOS
    model: ts_alerts
    explore: sales_alert
    type: looker_column
    fields: [sales_alert.net_sales_1w_change, sales_alert.net_sales_2w_change, sales_alert.net_sales_1y_change,
      sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.sales_channel: Branches,EposAv,EposEr
      sales_alert.minimum_deviation: '0.05'
      sales_alert.date_date: 14 days ago for 14 days
    sorts: [sales_alert.date_date desc]
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: WoW Change}, {axisId: sales_alert.net_sales_2w_change,
            id: sales_alert.net_sales_2w_change, name: 2WoW Change}, {axisId: sales_alert.net_sales_1y_change,
            id: sales_alert.net_sales_1y_change, name: YoY Change}], showLabels: true,
        showValues: true, valueFormat: '0, "K"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_labels:
      sales_alert.net_sales_1w_change: WoW Change
      sales_alert.net_sales_2w_change: 2WoW Change
      sales_alert.net_sales_1y_change: YoY Change
    defaults_version: 1
    hidden_fields: [sales_alert.alert_required]
    listen: {}
    row: 38
    col: 0
    width: 12
    height: 7
  - title: Click and Collect and Web
    name: Click and Collect and Web
    model: ts_alerts
    explore: sales_alert
    type: looker_column
    fields: [sales_alert.net_sales_1w_change, sales_alert.net_sales_2w_change, sales_alert.net_sales_1y_change,
      sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.sales_channel: Click & Collect,Web
      sales_alert.minimum_deviation: '0.05'
      sales_alert.date_date: 14 days ago for 14 days
    sorts: [sales_alert.date_date desc]
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: WoW Change}, {axisId: sales_alert.net_sales_2w_change,
            id: sales_alert.net_sales_2w_change, name: 2WoW Change}, {axisId: sales_alert.net_sales_1y_change,
            id: sales_alert.net_sales_1y_change, name: YoY Change}], showLabels: true,
        showValues: true, valueFormat: '0, "K"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_labels:
      sales_alert.net_sales_1w_change: WoW Change
      sales_alert.net_sales_2w_change: 2WoW Change
      sales_alert.net_sales_1y_change: YoY Change
    defaults_version: 1
    hidden_fields: [sales_alert.alert_required]
    listen: {}
    row: 38
    col: 12
    width: 12
    height: 7
  - title: Contact Centre
    name: Contact Centre
    model: ts_alerts
    explore: sales_alert
    type: looker_column
    fields: [sales_alert.net_sales_1w_change, sales_alert.net_sales_2w_change, sales_alert.net_sales_1y_change,
      sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.sales_channel: Contact Centre
      sales_alert.minimum_deviation: '0.05'
      sales_alert.date_date: 14 days ago for 14 days
    sorts: [sales_alert.date_date desc]
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: WoW Change}, {axisId: sales_alert.net_sales_2w_change,
            id: sales_alert.net_sales_2w_change, name: 2WoW Change}, {axisId: sales_alert.net_sales_1y_change,
            id: sales_alert.net_sales_1y_change, name: YoY Change}], showLabels: true,
        showValues: true, valueFormat: '0, "K"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_labels:
      sales_alert.net_sales_1w_change: WoW Change
      sales_alert.net_sales_2w_change: 2WoW Change
      sales_alert.net_sales_1y_change: YoY Change
    defaults_version: 1
    hidden_fields: [sales_alert.alert_required]
    listen: {}
    row: 48
    col: 0
    width: 8
    height: 7
  - title: Dropship
    name: Dropship
    model: ts_alerts
    explore: sales_alert
    type: looker_column
    fields: [sales_alert.net_sales_1w_change, sales_alert.net_sales_2w_change, sales_alert.net_sales_1y_change,
      sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.sales_channel: Dropship
      sales_alert.minimum_deviation: '0.05'
      sales_alert.date_date: 14 days ago for 14 days
    sorts: [sales_alert.date_date desc]
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: WoW Change}, {axisId: sales_alert.net_sales_2w_change,
            id: sales_alert.net_sales_2w_change, name: 2WoW Change}, {axisId: sales_alert.net_sales_1y_change,
            id: sales_alert.net_sales_1y_change, name: YoY Change}], showLabels: true,
        showValues: true, valueFormat: '0, "K"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_labels:
      sales_alert.net_sales_1w_change: WoW Change
      sales_alert.net_sales_2w_change: 2WoW Change
      sales_alert.net_sales_1y_change: YoY Change
    defaults_version: 1
    hidden_fields: [sales_alert.alert_required]
    listen: {}
    row: 48
    col: 8
    width: 8
    height: 7
  - title: eBay
    name: eBay
    model: ts_alerts
    explore: sales_alert
    type: looker_column
    fields: [sales_alert.net_sales_1w_change, sales_alert.net_sales_2w_change, sales_alert.net_sales_1y_change,
      sales_alert.alert_required, sales_alert.date_date]
    fill_fields: [sales_alert.date_date]
    filters:
      sales_alert.sales_channel: eBay
      sales_alert.minimum_deviation: '0.05'
      sales_alert.date_date: 14 days ago for 14 days
    sorts: [sales_alert.date_date desc]
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
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: sales_alert.net_sales_1w_change,
            id: sales_alert.net_sales_1w_change, name: WoW Change}, {axisId: sales_alert.net_sales_2w_change,
            id: sales_alert.net_sales_2w_change, name: 2WoW Change}, {axisId: sales_alert.net_sales_1y_change,
            id: sales_alert.net_sales_1y_change, name: YoY Change}], showLabels: true,
        showValues: true, valueFormat: '0, "K"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    series_types: {}
    series_labels:
      sales_alert.net_sales_1w_change: WoW Change
      sales_alert.net_sales_2w_change: 2WoW Change
      sales_alert.net_sales_1y_change: YoY Change
    defaults_version: 1
    hidden_fields: [sales_alert.alert_required]
    listen: {}
    row: 48
    col: 16
    width: 8
    height: 7
  - title: Channel Alerter - WEBHOOK TESTING
    name: Channel Alerter - WEBHOOK TESTING
    model: ts_alerts
    explore: sales_alert
    type: single_value
    fields: [sales_alert.sales_channel, sales_alert.alert_required]
    pivots: [sales_alert.sales_channel]
    filters:
      sales_alert.date_date: 1 days ago for 1 days
      sales_alert.1_week_deviation_parameter: 'YES'
      sales_alert.1_year_deviation_parameter: 'NO'
      sales_alert.2_week_deviation_parameter: 'YES'
      sales_alert.minimum_deviation: '0.05'
    sorts: [sales_alert.alert_required desc 0, sales_alert.sales_channel]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'pivot_row(${sales_alert.alert_required})',
        label: Testing Flags, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: supermeasure, table_calculation: testing_flags, _type_hint: number_list,
        is_disabled: true}, {category: table_calculation, expression: 'pivot_row(${sales_alert.sales_channel})',
        label: Test 2, value_format: !!null '', value_format_name: !!null '', _kind_hint: supermeasure,
        table_calculation: test_2, _type_hint: string_list, is_disabled: true}, {
        category: table_calculation, expression: "\nif(\n  \n  ${sales_alert.alert_required}\
          \ != 0,\n  concat(${sales_alert.sales_channel},\":\",${sales_alert.alert_required}),\n\
          \  null\n  \n)", label: New Calculation, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: new_calculation, _type_hint: string},
      {category: table_calculation, expression: 'replace(replace(replace(to_string(pivot_row(${new_calculation})),",,",","),":1",":
          Yes"),","," | ")', label: New Calculation OUT, value_format: !!null '',
        value_format_name: !!null '', _kind_hint: supermeasure, table_calculation: new_calculation_out,
        _type_hint: string}]
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
    conditional_formatting: []
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    hidden_fields: [sales_alert.alert_required, new_calculation]
    listen: {}
    row: 45
    col: 0
    width: 24
    height: 3
  - name: " (7)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      Could we have ID'd the issue with IT?

      Number of Transactions
      Number of Customers
      Units
      AOV
    row: 55
    col: 0
    width: 8
    height: 3
