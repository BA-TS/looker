- dashboard: sales_alerts
  title: Sales Alerts
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Sales Channel Warning Breakdown
    name: Sales Channel Warning Breakdown
    model: ts_alerts
    explore: sales_alerts
    type: looker_grid
    fields: [sales_alerts.sales_channel, sales_alerts.wow_flag, sales_alerts.2wow_flag,
      sales_alerts.yoy_flag, sales_alerts.any_flag]
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
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: equal to, value: 0, background_color: "#72D16D",
        font_color: '', color_application: {collection_id: toolstation, custom: {
            id: 2608d1c8-a8e6-cd96-b87f-b06dd00f5181, label: Custom, type: continuous,
            stops: [{color: "#0be60b", offset: 0}, {color: "#f9fa95", offset: 25},
              {color: "#ffffff", offset: 50}, {color: "#3EB0D5", offset: 75}, {color: "#004f9f",
                offset: 100}]}, options: {steps: 5}}, bold: false, italic: false,
        strikethrough: false, fields: [sales_alerts.wow_flag, sales_alerts.2wow_flag,
          sales_alerts.yoy_flag, sales_alerts.any_flag]}, {type: equal to, value: 1,
        background_color: "#d32f2f", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: [sales_alerts.wow_flag, sales_alerts.2wow_flag, sales_alerts.yoy_flag,
          sales_alerts.any_flag]}]
    series_value_format:
      sales_alerts.wow_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.2wow_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.yoy_flag: '[=0]"No";[>0]"Yes"'
      sales_alerts.any_flag: '[=0]"No";[>0]"Yes"'
    defaults_version: 1
    title_hidden: true
    listen: {}
    row: 2
    col: 0
    width: 24
    height: 3
  - title: Untitled
    name: Untitled
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
  - name: ''
    type: text
    title_text: ''
    body_text: "# Overall"
    row: 0
    col: 0
    width: 22
    height: 2

  - title: Date Prompt
    name: Date Prompt
    model: transactions
    explore: base
    type: single_value
    fields: [base.date_date]
    filters:
      base.select_date_range: Yesterday
    sorts: [base.date_date desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    value_format: ''
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
    row: 0
    col: 22
    width: 2
    height: 2




  - title: Untitled
    name: Untitled (2)
    model: ts_alerts
    explore: sales_alerts
    type: looker_grid
    fields: [sales_alerts.net_sales_value, sales_alerts.net_sales_wow_change, sales_alerts.net_sales_wow_percent,
      sales_alerts.net_sales_2wow_change, sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_change,
      sales_alerts.net_sales_yoy_percent, sales_alerts.sales_channel]
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
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.net_sales_wow_percent,
          sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_percent]},
      {type: less than, value: 0, background_color: !!null '', font_color: "#d32f2f",
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [sales_alerts.net_sales_wow_percent,
          sales_alerts.net_sales_2wow_percent, sales_alerts.net_sales_yoy_percent]}]
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
    row: 5
    col: 0
    width: 24
    height: 5
  - name: " (2)"
    type: text
    title_text: ''
    body_text: "# Past 28 Days #"
    row: 10
    col: 0
    width: 24
    height: 2
  - title: Performance History
    name: Performance History
    model: ts_alerts
    explore: sales_alerts
    type: looker_grid
    fields: [sales_alerts.date_date, sales_alerts.net_sales_value, sales_alerts.net_sales_wow_change,
      sales_alerts.net_sales_wow_value, sales_alerts.net_sales_2wow_change, sales_alerts.net_sales_2wow_value,
      sales_alerts.net_sales_yoy_change, sales_alerts.net_sales_yoy_value]
    fill_fields: [sales_alerts.date_date]
    filters:
      sales_alerts.date_date: 28 days ago for 28 days
    sorts: [sales_alerts.date_date desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${sales_alerts.net_sales_wow_change}/${sales_alerts.net_sales_wow_value}",
        label: WoW %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: wow, _type_hint: number}, {category: table_calculation,
        expression: "${sales_alerts.net_sales_2wow_change}/${sales_alerts.net_sales_2wow_value}",
        label: 2WoW %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: 2wow, _type_hint: number}, {category: table_calculation,
        expression: "${sales_alerts.net_sales_yoy_change}/${sales_alerts.net_sales_yoy_value}",
        label: YoY %, value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: yoy, _type_hint: number}]
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
      wow, sales_alerts.net_sales_2wow_change, 2wow, sales_alerts.net_sales_yoy_change,
      yoy, sales_alerts.net_sales_2y_change, 2yoy]
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
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    series_value_format:
      sales_alerts.net_sales_value:
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
    hidden_fields: [sales_alerts.net_sales_wow_value, sales_alerts.net_sales_2wow_value,
      sales_alerts.net_sales_yoy_value]
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
        name: sales_alerts.net_sales
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
        suggest_dimension: sales_alerts.net_sales
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
        name: sales_alerts.net_sales_wow_change
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
        suggest_dimension: sales_alerts.net_sales_wow_change
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
        sql: "${net_sales}-${net_sales_wow_value} "
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
        name: sales_alerts.net_sales_wow_value
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
        suggest_dimension: sales_alerts.net_sales_wow_value
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
        name: sales_alerts.net_sales_2wow_change
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
        suggest_dimension: sales_alerts.net_sales_2wow_change
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
        sql: "${net_sales}-${net_sales_2wow_value} "
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
        name: sales_alerts.net_sales_2wow_value
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
        suggest_dimension: sales_alerts.net_sales_2wow_value
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
        name: sales_alerts.net_sales_yoy_change
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
        suggest_dimension: sales_alerts.net_sales_yoy_change
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
        sql: "${net_sales}-${net_sales_yoy_value} "
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
        name: sales_alerts.net_sales_yoy_value
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
        suggest_dimension: sales_alerts.net_sales_yoy_value
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
        name: sales_alerts.net_sales_2y_change
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
        suggest_dimension: sales_alerts.net_sales_2y_change
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
        name: sales_alerts.net_sales_2y_prior
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
        suggest_dimension: sales_alerts.net_sales_2y_prior
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
        name: sales_alerts.date_date
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
        dimension_group: sales_alerts.date
        error:
        field_group_variant: Date
        measure: false
        parameter: false
        primary_key: false
        project_name: toolstation
        scope: sales_alert
        suggest_dimension: sales_alerts.date_date
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
        expression: "${sales_alerts.net_sales_wow_change}/${sales_alerts.net_sales_wow_value}"
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
        expression: "${sales_alerts.net_sales_2wow_change}/${sales_alerts.net_sales_2wow_value}"
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
        expression: "${sales_alerts.net_sales_yoy_change}/${sales_alerts.net_sales_yoy_value}"
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
        expression: "${sales_alerts.net_sales_2y_change}/${sales_alerts.net_sales_2y_prior}"
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
    listen:
      Sales Channel: sales_alerts.sales_channel
    row: 20
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
