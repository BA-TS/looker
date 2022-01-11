- dashboard: digital_daily_sales_report__channel_performance
  title: Channel Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  elements:
  - name: ''
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

               <a style="color: #ffffff; padding: 0 20px ; float: right; line-height: 40px; font-weight: regular" href="https://tpdev.cloud.looker.com/embed/dashboards-next/ts_digital::digital_ds_test" target="_blank" fullscreen="yes">View Full Screen</a>
              </span>
               <a style="color: #efefef; padding: 0 20px; float: right; line-height: 40px; font-weight: bold; text-decoration: none;"><span style="color: #ffffff;">Daily Digital Report - Channel Performance</span></a>
            </nav>
         </div>

      </div>
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Sessions by Channel
    name: Sessions by Channel
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.channel_grouping, ga_sessions.visits_total, ga_sessions.transaction_revenue_total,
      ga_sessions.transaction_conversion_rate, ga_sessions.transactions_count, ga_sessions.partition_date]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_date]
    filters:
      ga_sessions.partition_date: 60 days
      ga_sessions.channel_grouping: "-(Other)"
    sorts: [ga_sessions.channel_grouping, ga_sessions.partition_date desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'mean(offset_list(${ga_sessions.visits_total},0,7))',
        label: 7 Day Average Sessions, value_format: !!null '', value_format_name: '',
        _kind_hint: measure, table_calculation: 7_day_average_sessions, _type_hint: number}]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count, ga_sessions.visits_total]
    listen: {}
    row: 5
    col: 0
    width: 24
    height: 8
  - title: Direct Sessions
    name: Direct Sessions
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.partition_week, ga_sessions.channel_grouping, ga_sessions.visits_total,
      ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_week]
    filters:
      ga_sessions.channel_grouping: Direct
      ga_sessions.partition_date: 12 weeks
    sorts: [ga_sessions.partition_week desc, ga_sessions.channel_grouping]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    listen: {}
    row: 23
    col: 0
    width: 8
    height: 6
  - name: " (2)"
    type: text
    title_text: ''
    body_text: "# Channel Analysis"
    row: 3
    col: 0
    width: 24
    height: 2
  - title: Revenue by Channel
    name: Revenue by Channel
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.channel_grouping, ga_sessions.visits_total, ga_sessions.transaction_revenue_total,
      ga_sessions.transaction_conversion_rate, ga_sessions.transactions_count, ga_sessions.partition_date]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_date]
    filters:
      ga_sessions.partition_date: 60 days
      ga_sessions.channel_grouping: "-(Other)"
    sorts: [ga_sessions.channel_grouping, ga_sessions.partition_date desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: 'mean(offset_list(${ga_sessions.transaction_revenue_total},0,7))',
        label: 7 Day Moving Average Revenue, value_format: !!null '', value_format_name: Default
          formatting, _kind_hint: measure, table_calculation: 7_day_moving_average_revenue,
        _type_hint: number}]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_conversion_rate, ga_sessions.transactions_count,
      ga_sessions.visits_total, ga_sessions.transaction_revenue_total]
    listen: {}
    row: 13
    col: 0
    width: 24
    height: 8
  - name: " (3)"
    type: text
    title_text: ''
    body_text: "# Direct"
    row: 21
    col: 0
    width: 24
    height: 2
  - title: Direct Transactions
    name: Direct Transactions
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.partition_week, ga_sessions.channel_grouping, ga_sessions.visits_total,
      ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_week]
    filters:
      ga_sessions.channel_grouping: Direct
      ga_sessions.partition_date: 12 weeks
    sorts: [ga_sessions.partition_week desc, ga_sessions.channel_grouping]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.visits_total]
    listen: {}
    row: 23
    col: 16
    width: 8
    height: 6
  - title: Direct Revenue
    name: Direct Revenue
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.partition_week, ga_sessions.channel_grouping, ga_sessions.visits_total,
      ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_week]
    filters:
      ga_sessions.channel_grouping: Direct
      ga_sessions.partition_date: 12 weeks
    sorts: [ga_sessions.partition_week desc, ga_sessions.channel_grouping]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_conversion_rate, ga_sessions.transactions_count,
      ga_sessions.visits_total]
    listen: {}
    row: 23
    col: 8
    width: 8
    height: 6
  - title: Direct Conversion
    name: Direct Conversion
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.partition_week, ga_sessions.channel_grouping, ga_sessions.visits_total,
      ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_week]
    filters:
      ga_sessions.channel_grouping: Direct
      ga_sessions.partition_date: 12 weeks
    sorts: [ga_sessions.partition_week desc, ga_sessions.channel_grouping]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_revenue_total, ga_sessions.visits_total,
      ga_sessions.transactions_count]
    listen: {}
    row: 29
    col: 0
    width: 8
    height: 6
  - name: " (4)"
    type: text
    title_text: ''
    body_text: "# Overall"
    row: 35
    col: 0
    width: 24
    height: 2
  - title: Overall Transactions
    name: Overall Transactions
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.partition_week, ga_sessions.channel_grouping, ga_sessions.visits_total,
      ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_week]
    filters:
      ga_sessions.partition_date: 12 weeks
    sorts: [ga_sessions.partition_week desc, ga_sessions.channel_grouping]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.visits_total]
    listen: {}
    row: 37
    col: 16
    width: 8
    height: 6
  - title: Overall Revenue
    name: Overall Revenue
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.partition_week, ga_sessions.channel_grouping, ga_sessions.visits_total,
      ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_week]
    filters:
      ga_sessions.partition_date: 12 weeks
    sorts: [ga_sessions.partition_week desc, ga_sessions.channel_grouping]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_conversion_rate, ga_sessions.transactions_count,
      ga_sessions.visits_total]
    listen: {}
    row: 37
    col: 8
    width: 8
    height: 6
  - title: Overall Conversion
    name: Overall Conversion
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.partition_week, ga_sessions.channel_grouping, ga_sessions.visits_total,
      ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_week]
    filters:
      ga_sessions.partition_date: 12 weeks
    sorts: [ga_sessions.partition_week desc, ga_sessions.channel_grouping]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_revenue_total, ga_sessions.visits_total,
      ga_sessions.transactions_count]
    listen: {}
    row: 43
    col: 0
    width: 8
    height: 6
  - title: Direct Data Table
    name: Direct Data Table
    model: ga_sessions
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.channel_grouping, ga_sessions.visits_total, ga_sessions.transaction_revenue_total,
      ga_sessions.transaction_conversion_rate, ga_sessions.transactions_count, ga_sessions.partition_date]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_date]
    filters:
      ga_sessions.partition_date: 60 days ago for 60 days
      ga_sessions.channel_grouping: Direct
    sorts: [ga_sessions.channel_grouping, ga_sessions.partition_date desc]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '13'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      ga_sessions.transaction_revenue_total: Revenue
      ga_sessions.transaction_conversion_rate: Conversion
    series_cell_visualizations:
      ga_sessions.visits_total:
        is_active: false
    series_text_format:
      ga_sessions.partition_date:
        align: center
      ga_sessions.visits_total:
        align: center
      ga_sessions.transaction_revenue_total:
        align: center
      ga_sessions.transaction_conversion_rate:
        align: center
      ga_sessions.transactions_count:
        align: center
      ga_sessions.channel_grouping:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    series_value_format:
      ga_sessions.transaction_revenue_total:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields:
    title_hidden: true
    listen: {}
    row: 29
    col: 8
    width: 16
    height: 6
  - title: Overall Sessions
    name: Overall Sessions
    model: ga_sessions
    explore: ga_sessions
    type: looker_area
    fields: [ga_sessions.partition_week, ga_sessions.channel_grouping, ga_sessions.visits_total,
      ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_week]
    filters:
      ga_sessions.partition_date: 12 weeks
    sorts: [ga_sessions.partition_week desc, ga_sessions.channel_grouping]
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
      options:
        steps: 5
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields: [ga_sessions.transaction_revenue_total, ga_sessions.transaction_conversion_rate,
      ga_sessions.transactions_count]
    row: 37
    col: 0
    width: 8
    height: 6
  - title: Direct Data Table (Copy)
    name: Direct Data Table (Copy)
    model: ga_sessions
    explore: ga_sessions
    type: looker_grid
    fields: [ga_sessions.channel_grouping, ga_sessions.visits_total, ga_sessions.transaction_revenue_total,
      ga_sessions.transaction_conversion_rate, ga_sessions.transactions_count, ga_sessions.partition_date]
    pivots: [ga_sessions.channel_grouping]
    fill_fields: [ga_sessions.partition_date]
    filters:
      ga_sessions.partition_date: 60 days ago for 60 days
    sorts: [ga_sessions.channel_grouping, ga_sessions.partition_date desc]
    limit: 500
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '13'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      ga_sessions.transaction_revenue_total: Revenue
      ga_sessions.transaction_conversion_rate: Conversion
    series_cell_visualizations:
      ga_sessions.visits_total:
        is_active: false
    series_text_format:
      ga_sessions.partition_date:
        align: center
      ga_sessions.visits_total:
        align: center
      ga_sessions.transaction_revenue_total:
        align: center
      ga_sessions.transaction_conversion_rate:
        align: center
      ga_sessions.transactions_count:
        align: center
      ga_sessions.channel_grouping:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    series_value_format:
      ga_sessions.transaction_revenue_total:
        name: gbp
        decimals: '2'
        format_string: '"£"#,##0.00'
        label: British Pounds (2)
        label_prefix: British Pounds
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
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_fields:
    title_hidden: true
    row: 43
    col: 8
    width: 16
    height: 6
