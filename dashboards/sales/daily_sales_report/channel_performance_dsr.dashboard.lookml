- dashboard: channel_performance_dsr
  title: Channel Performance (DSR)
  layout: newspaper
  preferred_viewer: dashboards-next
  refresh: 1 day
  elements:
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "# Channel Performance"
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

               <a style="color: #ffffff; padding: 0 20px ; float: right; line-height: 40px; font-weight: regular" href="https://tpdev.cloud.looker.com/embed/dashboards-next/ts_sales::channel_performance_dsr" target="_blank" fullscreen="yes">View Full Screen</a>
              </span>
               <a style="color: #efefef; padding: 0 20px; float: right; line-height: 40px; font-weight: bold; text-decoration: none;"><span style="color: #ffffff;">Daily Sales Report - Channel Performance</span></a>
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
    subtitle_text: ''
    body_text: "# Channel Specific Performance"
    row: 22
    col: 0
    width: 24
    height: 2
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "# Data Table"
    row: 42
    col: 0
    width: 24
    height: 2
  - title: Sales Channel Performance (Net Sales)
    name: Sales Channel Performance (Net Sales)
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, transactions.total_net_sales, transactions.sales_channel]
    pivots: [transactions.sales_channel]
    filters:
      base.select_date_range: 37 days ago for 37 days
    sorts: [base.date_date desc, transactions.sales_channel]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "mean(offset_list(${transactions.total_net_sales},0,7))\n\
          \n", label: 7DMA Net Sales, value_format: !!null '', value_format_name: gbp,
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: BRANCHES
              - 7dma_net_sales, name: BRANCHES}, {axisId: 7dma_net_sales, id: CLICK
              & COLLECT - 7dma_net_sales, name: CLICK & COLLECT}, {axisId: 7dma_net_sales,
            id: CONTACT CENTRE - 7dma_net_sales, name: CONTACT CENTRE}, {axisId: 7dma_net_sales,
            id: DROPSHIP - 7dma_net_sales, name: DROPSHIP}, {axisId: 7dma_net_sales,
            id: EBAY - 7dma_net_sales, name: EBAY}, {axisId: 7dma_net_sales, id: EPOSAV
              - 7dma_net_sales, name: EPOSAV}, {axisId: 7dma_net_sales, id: EPOSER
              - 7dma_net_sales, name: EPOSER}, {axisId: 7dma_net_sales, id: WEB -
              7dma_net_sales, name: WEB}], showLabels: false, showValues: true, maxValue: 1000000,
        minValue: 0, valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K";  #,##0',
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 26, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '30'
    series_types: {}
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen:
      Sales Channel: transactions.sales_channel
    row: 5
    col: 0
    width: 24
    height: 8
  - title: Sales Channel Mix (Net Sales)
    name: Sales Channel Mix (Net Sales)
    model: ts_sales
    explore: base
    type: looker_area
    fields: [base.date_date, transactions.total_net_sales, transactions.sales_channel]
    pivots: [transactions.sales_channel]
    filters:
      base.select_date_range: 37 days ago for 37 days
    sorts: [base.date_date desc, transactions.sales_channel]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "mean(offset_list(${transactions.total_net_sales},0,7))\n\
          \n", label: 7DMA Net Sales, value_format: !!null '', value_format_name: gbp,
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    stacking: percent
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: monotone
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: toolstation
      palette_id: toolstation-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: BRANCHES - 7dma_net_sales,
            id: BRANCHES - 7dma_net_sales, name: BRANCHES}, {axisId: CLICK & COLLECT
              - 7dma_net_sales, id: CLICK & COLLECT - 7dma_net_sales, name: CLICK
              & COLLECT}, {axisId: CONTACT CENTRE - 7dma_net_sales, id: CONTACT CENTRE
              - 7dma_net_sales, name: CONTACT CENTRE}, {axisId: DROPSHIP - 7dma_net_sales,
            id: DROPSHIP - 7dma_net_sales, name: DROPSHIP}, {axisId: EBAY - 7dma_net_sales,
            id: EBAY - 7dma_net_sales, name: EBAY}, {axisId: EPOSAV - 7dma_net_sales,
            id: EPOSAV - 7dma_net_sales, name: EPOSAV}, {axisId: EPOSER - 7dma_net_sales,
            id: EPOSER - 7dma_net_sales, name: EPOSER}, {axisId: WEB - 7dma_net_sales,
            id: WEB - 7dma_net_sales, name: WEB}], showLabels: false, showValues: true,
        maxValue: !!null '', minValue: !!null '', valueFormat: '', unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 26, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '30'
    series_types: {}
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen:
      Sales Channel: transactions.sales_channel
    row: 13
    col: 0
    width: 24
    height: 9
  - title: Branch
    name: Branch
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: BRANCHES
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 24
    col: 0
    width: 8
    height: 6
  - title: Click and Collect
    name: Click and Collect
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: CLICK & COLLECT
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 24
    col: 8
    width: 8
    height: 6
  - title: Web
    name: Web
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: WEB
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 24
    col: 16
    width: 8
    height: 6
  - title: EPOS Total
    name: EPOS Total
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: EPOSAV,EPOSER
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 30
    col: 0
    width: 8
    height: 6
  - title: EPOS Availability
    name: EPOS Availability
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: EPOSAV
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 30
    col: 8
    width: 8
    height: 6
  - title: EPOS Extended
    name: EPOS Extended
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: EPOSER
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 30
    col: 16
    width: 8
    height: 6
  - title: Dropship
    name: Dropship
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: DROPSHIP
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 36
    col: 0
    width: 8
    height: 6
  - title: Contact Centre
    name: Contact Centre
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: CONTACT CENTRE
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 36
    col: 8
    width: 8
    height: 6
  - title: eBay
    name: eBay
    model: ts_sales
    explore: base
    type: looker_line
    fields: [base.date_date, base.pivot_dimension, transactions.total_net_sales]
    pivots: [base.pivot_dimension]
    filters:
      base.select_date_range: 45 days ago for 59 days
      base.select_comparison_period: Year
      base.select_number_of_periods: '3'
      transactions.sales_channel: EBAY
    sorts: [base.date_date desc, base.pivot_dimension]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${transactions.total_net_sales}\
          \ > 0,mean(offset_list(${transactions.total_net_sales},0,7)),null)\n\n",
        label: 7DMA Net Sales, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: 7dma_net_sales, _type_hint: number}]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: 7dma_net_sales, id: This
              Year - 1 - 7dma_net_sales, name: CY}, {axisId: 7dma_net_sales, id: Last
              Year - 2 - 7dma_net_sales, name: LY}, {axisId: 7dma_net_sales, id: 2
              Years Ago - 3 - 7dma_net_sales, name: 2LY}], showLabels: false, showValues: true,
        valueFormat: '[>=1000000] #,##0,, "M"; [>=1000] #,##0, "K"; #,##0', unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '43'
    series_types: {}
    series_colors: {}
    series_labels:
      This Year - 1 - 7dma_net_sales: CY
      Last Year - 2 - 7dma_net_sales: LY
      2 Years Ago - 3 - 7dma_net_sales: 2LY
    hidden_fields: [transactions.total_net_sales]
    defaults_version: 1
    listen: {}
    row: 36
    col: 16
    width: 8
    height: 6
  - title: Channel Performance (By Day)
    name: Channel Performance (By Day)
    model: ts_sales
    explore: base
    type: looker_grid
    fields: [base.date_date, transactions.total_net_sales, channel_budget.channel_net_sales_budget,
      transactions.sales_channel]
    pivots: [transactions.sales_channel]
    filters:
      base.select_fixed_range: YTD
      base.select_comparison_period: Year
    sorts: [base.date_date desc, transactions.sales_channel]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "(${transactions.total_net_sales}\
          \ / offset(${transactions.total_net_sales}, 364)) - 1", label: "% vs LY",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        table_calculation: vs_ly, _type_hint: number}, {category: table_calculation,
        expression: "(${transactions.total_net_sales} / ${channel_budget.channel_net_sales_budget})\
          \ - 1", label: "% vs Budget", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: measure, table_calculation: vs_budget, _type_hint: number}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
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
      transactions.total_net_sales:
        is_active: false
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [vs_ly, vs_budget]},
      {type: less than, value: 0, background_color: !!null '', font_color: "#d32f2f",
        color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [vs_ly, vs_budget]}]
    hidden_fields: [channel_budget.channel_net_sales_budget]
    series_types: {}
    defaults_version: 1
    listen:
      Sales Channel: transactions.sales_channel
    row: 44
    col: 0
    width: 24
    height: 14
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
    model: ts_sales
    explore: base
    listens_to_filters: []
    field: transactions.sales_channel
