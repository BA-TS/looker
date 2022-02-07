- dashboard: leadership_summary_report_v2
  title: Leadership Summary Report V2
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - name: ''
    type: text
    title_text: ''
    body_text: |-
      <div style="padding:20px 0 20px 0;border-radius:5px;background:#ffe200;height: 80px;">
         <div style="background:#004f9f;height: 40px;width:100%;">
              <a href="https://tpdev.cloud.looker.com/boards/7" rel="noopener noreferrer">
                 <img style="color: #ffffff;float: left;height: 40px;" src="https://www.toolstation.com/img/toolstation.svg">
               </a>
            <nav style="font-size: 18px;">
              <span style="color: #000000;">
                <a style="color: #ffffff;padding:0 20px;float: right;line-height: 40px;" href="https://tpdev.cloud.looker.com/dashboards/ts_sales::next_14_days_dsr" rel="noopener noreferrer">Next 14 Days</a>
                <a style="color: #ffffff;padding:0 20px;float: right;line-height: 40px;" href="https://tpdev.cloud.looker.com/dashboards/ts_sales::top_10_performances_dsr" rel="noopener noreferrer">Top 10</a>
                <a style="color: #ffffff;padding:0 20px;float: right;line-height: 40px;" href="https://tpdev.cloud.looker.com/dashboards/ts_sales::channel_performance_dsr" rel="noopener noreferrer">Channel Performance</a>
                <a style="color: #efefef;padding:0 20px;float: right;line-height: 40px;font-weight: bold;text-decoration: none;" rel="noopener noreferrer">Summary</a>
              </span>
            </nav>
         </div>
      </div>
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Division 1
    name: Division 1
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Division 1"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 7
    col: 0
    width: 3
    height: 2
  - title: Division 2
    name: Division 2
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Division 2"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 37
    col: 0
    width: 3
    height: 2
  - title: Total
    name: Total
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Total"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 13
    col: 0
    width: 3
    height: 2
  - title: Other Channels
    name: Other Channels
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Other Channels"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 39
    col: 0
    width: 3
    height: 2
  - title: Division 1 WoW
    name: Division 1 WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 37
    col: 6
    width: 3
    height: 2
  - title: Division 2 WoW
    name: Division 2 WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 35
    col: 6
    width: 3
    height: 2
  - title: Other Channels WoW
    name: Other Channels WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 39
    col: 6
    width: 3
    height: 2
  - title: Total WoW
    name: Total WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 13
    col: 6
    width: 3
    height: 2
  - title: Division 1 YoY
    name: Division 1 YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 7
    col: 3
    width: 3
    height: 2
  - title: Division 2 YoY
    name: Division 2 YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 9
    col: 3
    width: 3
    height: 2
  - title: Other Channel YoY
    name: Other Channel YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 35
    col: 3
    width: 3
    height: 2
  - title: Total YoY
    name: Total YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 13
    col: 3
    width: 3
    height: 2
  - title: Division 1 Sales
    name: Division 1 Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 37
    col: 9
    width: 3
    height: 2
  - title: Division 2 Sales
    name: Division 2 Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 35
    col: 9
    width: 3
    height: 2
  - title: Other Channels Sales
    name: Other Channels Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 39
    col: 9
    width: 3
    height: 2
  - title: Total Sales
    name: Total Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 41
    col: 9
    width: 3
    height: 2
  - name: " (2)"
    type: text
    title_text: ''
    body_text: "## Retail Performance ##\n"
    row: 33
    col: 0
    width: 24
    height: 2
  - name: " (3)"
    type: text
    title_text: ''
    body_text: "## Channel Performance ##"
    row: 15
    col: 0
    width: 24
    height: 2
  - title: Branches
    name: Branches
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Branches"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 45
    col: 0
    width: 3
    height: 2
  - title: Click & Collect
    name: Click & Collect
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Click & Collect"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 47
    col: 0
    width: 3
    height: 2
  - title: Web
    name: Web
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Web"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 49
    col: 0
    width: 3
    height: 2
  - title: Other
    name: Other
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Other"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 51
    col: 0
    width: 3
    height: 2
  - title: Branches YoY
    name: Branches YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 47
    col: 3
    width: 3
    height: 2
  - title: Branches WoW
    name: Branches WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 47
    col: 6
    width: 3
    height: 2
  - title: Branches Sales
    name: Branches Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 47
    col: 9
    width: 3
    height: 2
  - title: Click & Collect YoY
    name: Click & Collect YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 45
    col: 3
    width: 3
    height: 2
  - title: Web YoY
    name: Web YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 49
    col: 3
    width: 3
    height: 2
  - title: Other YoY
    name: Other YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 23
    col: 3
    width: 3
    height: 2
  - title: Click & Collect WoW
    name: Click & Collect WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 45
    col: 6
    width: 3
    height: 2
  - title: Web WoW
    name: Web WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 49
    col: 6
    width: 3
    height: 2
  - title: Other WoW
    name: Other WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 51
    col: 6
    width: 3
    height: 2
  - title: Click & Collect Sales
    name: Click & Collect Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 45
    col: 9
    width: 3
    height: 2
  - title: Other Sales
    name: Other Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 23
    col: 9
    width: 3
    height: 2
  - title: Web Sales
    name: Web Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 49
    col: 9
    width: 3
    height: 2
  - name: " (4)"
    type: text
    title_text: ''
    body_text: "## Trade Performance ##"
    row: 53
    col: 0
    width: 24
    height: 2
  - title: DIY
    name: DIY
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"DIY"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 55
    col: 0
    width: 3
    height: 2
  - title: Trade
    name: Trade
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Trade"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 57
    col: 0
    width: 3
    height: 2
  - title: DIY YoY
    name: DIY YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 55
    col: 3
    width: 3
    height: 2
  - title: Trade YoY
    name: Trade YoY
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 57
    col: 3
    width: 3
    height: 2
  - title: DIY WoW
    name: DIY WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 55
    col: 6
    width: 3
    height: 2
  - title: Trade WoW
    name: Trade WoW
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 57
    col: 6
    width: 3
    height: 2
  - title: DIY Sales
    name: DIY Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 55
    col: 9
    width: 3
    height: 2
  - title: Trade Sales
    name: Trade Sales
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 29
    col: 9
    width: 3
    height: 2
  - title: Division 1 vs Budget
    name: Division 1 vs Budget
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 37
    col: 12
    width: 3
    height: 2
  - title: Division 2 vs Budget
    name: Division 2 vs Budget
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 35
    col: 12
    width: 3
    height: 2
  - title: Other Channels vs Budget
    name: Other Channels vs Budget
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 39
    col: 12
    width: 3
    height: 2
  - title: Total vs Budget
    name: Total vs Budget
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 41
    col: 12
    width: 3
    height: 2
  - title: Branches vs Budget
    name: Branches vs Budget
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 47
    col: 12
    width: 3
    height: 2
  - title: Click & Collect vs Budget
    name: Click & Collect vs Budget
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 45
    col: 12
    width: 3
    height: 2
  - title: Web vs Budget
    name: Web vs Budget
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 49
    col: 12
    width: 3
    height: 2
  - title: Other vs Budget
    name: Other vs Budget
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 51
    col: 12
    width: 3
    height: 2
  - name: " (5)"
    type: text
    title_text: ''
    body_text: "# Week Performance #"
    row: 3
    col: 0
    width: 24
    height: 2
  - name: " (6)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "# Month Performance #"
    row: 31
    col: 0
    width: 24
    height: 2
  - title: Retail Performance
    name: Retail Performance
    model: ts_sales
    explore: base
    type: looker_area
    fields: [transactions.total_net_sales, sites.division, base.dynamic_fiscal_month]
    pivots: [sites.division]
    filters:
      base.select_date_range: 6 months
      sites.division: Division 1,Division 2,Other Channels
    sorts: [sites.division, base.dynamic_fiscal_month]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    series_types: {}
    swap_axes: false
    custom_color_enabled: true
    custom_color: "#004f9f"
    show_single_value_title: true
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 35
    col: 15
    width: 9
    height: 8
  - title: Channel Performance
    name: Channel Performance
    model: ts_sales
    explore: base
    type: looker_area
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, transactions.sales_channel]
    pivots: [transactions.sales_channel]
    filters:
      base.select_date_range: 18 weeks ago for 18 weeks
      transactions.sales_channel: "-NULL"
    sorts: [base.dynamic_fiscal_week, transactions.total_net_sales desc 0, transactions.sales_channel]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    series_types: {}
    swap_axes: false
    custom_color_enabled: true
    custom_color: "#004f9f"
    show_single_value_title: true
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 17
    col: 15
    width: 9
    height: 8
  - title: Division 1
    name: Division 1 (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Division 1"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 35
    col: 0
    width: 3
    height: 2
  - title: a Division 2
    name: a Division 2
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Division 2"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 9
    col: 0
    width: 3
    height: 2
  - title: Total
    name: Total (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Total"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 41
    col: 0
    width: 3
    height: 2
  - title: Other Channels
    name: Other Channels (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Other Channels"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 11
    col: 0
    width: 3
    height: 2
  - title: Division 1 WoW
    name: Division 1 WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 7
    col: 6
    width: 3
    height: 2
  - title: Division 2 WoW
    name: Division 2 WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 9
    col: 6
    width: 3
    height: 2
  - title: Other Channels WoW
    name: Other Channels WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 11
    col: 6
    width: 3
    height: 2
  - title: Total WoW
    name: Total WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 41
    col: 6
    width: 3
    height: 2
  - title: Division 1 YoY
    name: Division 1 YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 37
    col: 3
    width: 3
    height: 2
  - title: Division 2 YoY
    name: Division 2 YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 39
    col: 3
    width: 3
    height: 2
  - title: Other Channel YoY
    name: Other Channel YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 11
    col: 3
    width: 3
    height: 2
  - title: Total YoY
    name: Total YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 41
    col: 3
    width: 3
    height: 2
  - title: Division 1 Sales
    name: Division 1 Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 7
    col: 9
    width: 3
    height: 2
  - title: Division 2 Sales
    name: Division 2 Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 9
    col: 9
    width: 3
    height: 2
  - title: Other Channels Sales
    name: Other Channels Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 11
    col: 9
    width: 3
    height: 2
  - title: Total Sales
    name: Total Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 13
    col: 9
    width: 3
    height: 2
  - name: " (7)"
    type: text
    title_text: ''
    body_text: "## Retail Performance ##\n"
    row: 5
    col: 0
    width: 24
    height: 2
  - name: " (8)"
    type: text
    title_text: ''
    body_text: "## Channel Performance ##"
    row: 43
    col: 0
    width: 24
    height: 2
  - title: Branches
    name: Branches (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Branches"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 17
    col: 0
    width: 3
    height: 2
  - title: Click & Collect
    name: Click & Collect (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Click & Collect"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 19
    col: 0
    width: 3
    height: 2
  - title: Web
    name: Web (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Web"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 21
    col: 0
    width: 3
    height: 2
  - title: Other
    name: Other (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Other"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 23
    col: 0
    width: 3
    height: 2
  - title: Branches YoY
    name: Branches YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 17
    col: 3
    width: 3
    height: 2
  - title: Branches WoW
    name: Branches WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 17
    col: 6
    width: 3
    height: 2
  - title: Branches Sales
    name: Branches Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 17
    col: 9
    width: 3
    height: 2
  - title: Click & Collect YoY
    name: Click & Collect YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 19
    col: 3
    width: 3
    height: 2
  - title: Web YoY
    name: Web YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 21
    col: 3
    width: 3
    height: 2
  - title: Other YoY
    name: Other YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 51
    col: 3
    width: 3
    height: 2
  - title: Click & Collect WoW
    name: Click & Collect WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 19
    col: 6
    width: 3
    height: 2
  - title: Web WoW
    name: Web WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 21
    col: 6
    width: 3
    height: 2
  - title: Other WoW
    name: Other WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 23
    col: 6
    width: 3
    height: 2
  - title: Click & Collect Sales
    name: Click & Collect Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 19
    col: 9
    width: 3
    height: 2
  - title: Other Sales
    name: Other Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 51
    col: 9
    width: 3
    height: 2
  - title: Web Sales
    name: Web Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 21
    col: 9
    width: 3
    height: 2
  - name: " (9)"
    type: text
    title_text: ''
    body_text: "## Trade Performance ##"
    row: 25
    col: 0
    width: 24
    height: 2
  - title: DIY
    name: DIY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"DIY"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 27
    col: 0
    width: 3
    height: 2
  - title: Trade
    name: Trade (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Trade"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 29
    col: 0
    width: 3
    height: 2
  - title: DIY YoY
    name: DIY YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 27
    col: 3
    width: 3
    height: 2
  - title: Trade YoY
    name: Trade YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 29
    col: 3
    width: 3
    height: 2
  - title: DIY WoW
    name: DIY WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 27
    col: 6
    width: 3
    height: 2
  - title: Trade WoW
    name: Trade WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 29
    col: 6
    width: 3
    height: 2
  - title: DIY Sales
    name: DIY Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 27
    col: 9
    width: 3
    height: 2
  - title: Trade Sales
    name: Trade Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 57
    col: 9
    width: 3
    height: 2
  - title: Division 1 vs Budget
    name: Division 1 vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 7
    col: 12
    width: 3
    height: 2
  - title: Division 2 vs Budget
    name: Division 2 vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 9
    col: 12
    width: 3
    height: 2
  - title: Other Channels vs Budget
    name: Other Channels vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 11
    col: 12
    width: 3
    height: 2
  - title: Total vs Budget
    name: Total vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 13
    col: 12
    width: 3
    height: 2
  - title: Branches vs Budget
    name: Branches vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 17
    col: 12
    width: 3
    height: 2
  - title: Click & Collect vs Budget
    name: Click & Collect vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 19
    col: 12
    width: 3
    height: 2
  - title: Web vs Budget
    name: Web vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 21
    col: 12
    width: 3
    height: 2
  - title: Other vs Budget
    name: Other vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 23
    col: 12
    width: 3
    height: 2
  - title: Retail Performance
    name: Retail Performance (2)
    model: ts_sales
    explore: base
    type: looker_area
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, sites.division]
    pivots: [sites.division]
    filters:
      base.select_date_range: 18 weeks ago for 18 weeks
      sites.division: Division 1,Division 2,Other Channels
    sorts: [base.dynamic_fiscal_week, transactions.total_net_sales desc 0, sites.division]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    series_types: {}
    swap_axes: false
    custom_color_enabled: true
    custom_color: "#004f9f"
    show_single_value_title: true
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 7
    col: 15
    width: 9
    height: 8
  - title: Channel Performance
    name: Channel Performance (2)
    model: ts_sales
    explore: base
    type: looker_area
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, transactions.sales_channel]
    pivots: [transactions.sales_channel]
    filters:
      base.select_date_range: 18 weeks ago for 18 weeks
      transactions.sales_channel: "-NULL"
    sorts: [base.dynamic_fiscal_week, transactions.total_net_sales desc 0, transactions.sales_channel]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    series_types: {}
    swap_axes: false
    custom_color_enabled: true
    custom_color: "#004f9f"
    show_single_value_title: true
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 45
    col: 15
    width: 9
    height: 8














  - title: Division 1
    name: b  Division 1 (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Division 1"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 35
    col: 0
    width: 3
    height: 2
  - title: a Division 2
    name: b  a Division 2
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Division 2"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 9
    col: 0
    width: 3
    height: 2
  - title: Total
    name: b  Total (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Total"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 41
    col: 0
    width: 3
    height: 2
  - title: Other Channels
    name: b  Other Channels (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Other Channels"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 11
    col: 0
    width: 3
    height: 2
  - title: Division 1 WoW
    name: b  Division 1 WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 7
    col: 6
    width: 3
    height: 2
  - title: Division 2 WoW
    name: b  Division 2 WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 9
    col: 6
    width: 3
    height: 2
  - title: Other Channels WoW
    name: b  Other Channels WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 11
    col: 6
    width: 3
    height: 2
  - title: Total WoW
    name: b  Total WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 41
    col: 6
    width: 3
    height: 2
  - title: Division 1 YoY
    name: b  Division 1 YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 37
    col: 3
    width: 3
    height: 2
  - title: Division 2 YoY
    name: b  Division 2 YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 39
    col: 3
    width: 3
    height: 2
  - title: Other Channel YoY
    name: b  Other Channel YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 11
    col: 3
    width: 3
    height: 2
  - title: Total YoY
    name: b  Total YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: MTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 41
    col: 3
    width: 3
    height: 2
  - title: Division 1 Sales
    name: b  Division 1 Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 7
    col: 9
    width: 3
    height: 2
  - title: Division 2 Sales
    name: b  Division 2 Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 9
    col: 9
    width: 3
    height: 2
  - title: Other Channels Sales
    name: b  Other Channels Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 11
    col: 9
    width: 3
    height: 2
  - title: Total Sales
    name: b  Total Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 13
    col: 9
    width: 3
    height: 2
  - name: b  " (7)"
    type: text
    title_text: ''
    body_text: "## Retail Performance ##\n"
    row: 5
    col: 0
    width: 24
    height: 2
  - name: b  " (8)"
    type: text
    title_text: ''
    body_text: "## Channel Performance ##"
    row: 43
    col: 0
    width: 24
    height: 2
  - title: Branches
    name: b  Branches (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Branches"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 17
    col: 0
    width: 3
    height: 2
  - title: Click & Collect
    name: b  Click & Collect (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Click & Collect"', label: Text,
        value_format: !!null '', value_format_name: !!null '', dimension: text, _kind_hint: dimension,
        _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 19
    col: 0
    width: 3
    height: 2
  - title: Web
    name: b  Web (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Web"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 21
    col: 0
    width: 3
    height: 2
  - title: Other
    name: b  Other (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Other"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 23
    col: 0
    width: 3
    height: 2
  - title: Branches YoY
    name: b  Branches YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 17
    col: 3
    width: 3
    height: 2
  - title: Branches WoW
    name: b  Branches WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 17
    col: 6
    width: 3
    height: 2
  - title: Branches Sales
    name: b  Branches Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 17
    col: 9
    width: 3
    height: 2
  - title: Click & Collect YoY
    name: b  Click & Collect YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 19
    col: 3
    width: 3
    height: 2
  - title: Web YoY
    name: b  Web YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 21
    col: 3
    width: 3
    height: 2
  - title: Other YoY
    name: b  Other YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 51
    col: 3
    width: 3
    height: 2
  - title: Click & Collect WoW
    name: b  Click & Collect WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 19
    col: 6
    width: 3
    height: 2
  - title: Web WoW
    name: b  Web WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 21
    col: 6
    width: 3
    height: 2
  - title: Other WoW
    name: b  Other WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 23
    col: 6
    width: 3
    height: 2
  - title: Click & Collect Sales
    name: b  Click & Collect Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 19
    col: 9
    width: 3
    height: 2
  - title: Other Sales
    name: b  Other Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 51
    col: 9
    width: 3
    height: 2
  - title: Web Sales
    name: b  Web Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 21
    col: 9
    width: 3
    height: 2
  - name: b  " (9)"
    type: text
    title_text: ''
    body_text: "## Trade Performance ##"
    row: 25
    col: 0
    width: 24
    height: 2
  - title: DIY
    name: b  DIY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"DIY"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 27
    col: 0
    width: 3
    height: 2
  - title: Trade
    name: b  Trade (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [text]
    filters:
      base.select_date_range: Yesterday
    sorts: [text]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: dimension, expression: '"Trade"', label: Text, value_format: !!null '',
        value_format_name: !!null '', dimension: text, _kind_hint: dimension, _type_hint: string}]
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
    custom_color: "#004f9f"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 29
    col: 0
    width: 3
    height: 2
  - title: DIY YoY
    name: b  DIY YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 27
    col: 3
    width: 3
    height: 2
  - title: Trade YoY
    name: b  Trade YoY (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Year
      base.select_number_of_periods: '2'
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: YoY Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 29
    col: 3
    width: 3
    height: 2
  - title: DIY WoW
    name: b  DIY WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 27
    col: 6
    width: 3
    height: 2
  - title: Trade WoW
    name: b  Trade WoW (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      base.select_comparison_period: Week
      base.select_number_of_periods: '2'
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number}]
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
    single_value_title: WoW Change
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales]
    series_types: {}
    listen: {}
    row: 29
    col: 6
    width: 3
    height: 2
  - title: DIY Sales
    name: b  DIY Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      customers.is_trade: 'No'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 27
    col: 9
    width: 3
    height: 2
  - title: Trade Sales
    name: b  Trade Sales (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      customers.is_trade: 'Yes'
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    custom_color: "#004f9f"
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
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
    hidden_fields:
    series_types: {}
    listen: {}
    row: 57
    col: 9
    width: 3
    height: 2
  - title: Division 1 vs Budget
    name: b  Division 1 vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 1
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 7
    col: 12
    width: 3
    height: 2
  - title: Division 2 vs Budget
    name: b  Division 2 vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Division 2
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 9
    col: 12
    width: 3
    height: 2
  - title: Other Channels vs Budget
    name: b  Other Channels vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: Other Channels
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 11
    col: 12
    width: 3
    height: 2
  - title: Total vs Budget
    name: b  Total vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, site_budget.site_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      sites.division: "-NULL"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${site_budget.site_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 13
    col: 12
    width: 3
    height: 2
  - title: Branches vs Budget
    name: b  Branches vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: BRANCHES
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 17
    col: 12
    width: 3
    height: 2
  - title: Click & Collect vs Budget
    name: b  Click & Collect vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 19
    col: 12
    width: 3
    height: 2
  - title: Web vs Budget
    name: b  Web vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: WEB
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 21
    col: 12
    width: 3
    height: 2
  - title: Other vs Budget
    name: b  Other vs Budget (2)
    model: ts_sales
    explore: base
    type: single_value
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    pivots: [base.dynamic_fiscal_week]
    filters:
      base.select_fixed_range: WTD
      transactions.sales_channel: "-BRANCHES,-CLICK & COLLECT,-WEB"
    sorts: [base.dynamic_fiscal_week]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "${transactions.total_net_sales}\
          \ - ${channel_budget.channel_net_sales_budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: measure, table_calculation: vs_budget,
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
    single_value_title: vs Budget
    conditional_formatting: [{type: greater than, value: 0, background_color: "#72D16D",
        font_color: !!null '', color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: less
          than, value: 0, background_color: "#d32f2f", font_color: !!null '', color_application: {
          collection_id: toolstation, palette_id: toolstation-diverging-0}, bold: false,
        italic: false, strikethrough: false, fields: !!null ''}, {type: 'null', value: !!null '',
        background_color: "#FFE200", font_color: !!null '', color_application: {collection_id: toolstation,
          palette_id: toolstation-diverging-0}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
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
    hidden_fields: [transactions.total_net_sales, channel_budget.channel_net_sales_budget]
    series_types: {}
    value_labels: legend
    label_type: labPer
    listen: {}
    row: 23
    col: 12
    width: 3
    height: 2
  - title: Retail Performance
    name: b  Retail Performance (2)
    model: ts_sales
    explore: base
    type: looker_area
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, sites.division]
    pivots: [sites.division]
    filters:
      base.select_date_range: 18 weeks ago for 18 weeks
      sites.division: Division 1,Division 2,Other Channels
    sorts: [base.dynamic_fiscal_week, transactions.total_net_sales desc 0, sites.division]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    series_types: {}
    swap_axes: false
    custom_color_enabled: true
    custom_color: "#004f9f"
    show_single_value_title: true
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 7
    col: 15
    width: 9
    height: 8
  - title: Channel Performance
    name: b  Channel Performance (2)
    model: ts_sales
    explore: base
    type: looker_area
    fields: [base.dynamic_fiscal_week, transactions.total_net_sales, transactions.sales_channel]
    pivots: [transactions.sales_channel]
    filters:
      base.select_date_range: 18 weeks ago for 18 weeks
      transactions.sales_channel: "-NULL"
    sorts: [base.dynamic_fiscal_week, transactions.total_net_sales desc 0, transactions.sales_channel]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(pivot_index(${transactions.total_net_sales},\
          \ 2) / pivot_index(${transactions.total_net_sales}, 1)) - 1", label: WoW
          %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: wow, _type_hint: number, is_disabled: true}]
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
    series_types: {}
    swap_axes: false
    custom_color_enabled: true
    custom_color: "#004f9f"
    show_single_value_title: true
    single_value_title: Current Week Sales
    value_format: "[$£-en-GB] #,##0"
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields:
    listen: {}
    row: 45
    col: 15
    width: 9
    height: 8
