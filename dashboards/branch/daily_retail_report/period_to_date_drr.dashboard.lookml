- dashboard: period_to_date_drr
  title: Period to Date (DRR)
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  elements:
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: |-
      <div style="padding: 20px 0 20px 0; border-radius: 5px; background: #ffe200; height: 80px;">

         <div style="background: #004f9f; height: 40px; width:100%">

              <a href="https://tpdev.cloud.looker.com/boards/10">

                       <img style="color: #ffffff; float: left; height: 40px" src="https://www.toolstation.com/img/toolstation.svg"/>

               </a>

            <nav style="font-size: 18px;">

               <span style="color: #000000;">

               <a style="color: #ffffff; padding: 0 20px ; float: right; line-height: 40px; font-weight: regular" href="https://tpdev.cloud.looker.com/boards/10" >Back to Board </a>

               <a style="color: #ffffff; padding: 0 20px ; float: right; line-height: 40px; font-weight: regular" href="https://tpdev.cloud.looker.com/embed/dashboards-next/149" target="_blank" fullscreen="yes">View Full Screen</a>
              </span>
               <a style="color: #efefef; padding: 0 20px; float: right; line-height: 40px; font-weight: bold; text-decoration: none;"><span style="color: #ffffff;">Daily Sales Report - Branch (Period to Date)</span></a>
            </nav>
         </div>

      </div>
    row: 0
    col: 0
    width: 24
    height: 3
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "# Division Breakdown"
    row: 3
    col: 0
    width: 24
    height: 2
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "# Region Breakdown"
    row: 11
    col: 0
    width: 24
    height: 2
  - title: Sales by Division
    name: Sales by Division
    model: ts_sales
    explore: base
    type: looker_grid
    fields: [transactions.total_net_sales, site_budget.site_net_sales_budget, base.date_year,
      transactions.lfl_net_sales, sites.region_director, sites.head_ofdivision, sites.division]
    pivots: [base.date_year]
    filters:
      base.select_comparison_period: Year
    sorts: [base.date_year desc, sites.division]
    limit: 500
    total: true
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(${transactions.total_net_sales},
          1)', label: Actual, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: actual, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${site_budget.site_net_sales_budget}, 1)', label: Budget,
        value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: budget, _type_hint: number}, {category: table_calculation,
        expression: "${actual} - ${budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: supermeasure, table_calculation: vs_budget,
        _type_hint: number}, {category: table_calculation, expression: "(${actual}\
          \ / ${budget}) - 1", label: "% vs Budget", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: vs_budget_1, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.total_net_sales},
          2)', label: Actual LY, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: supermeasure, table_calculation: actual_ly, _type_hint: number},
      {category: table_calculation, expression: "${actual} - ${actual_ly}", label: vs
          LY, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: vs_ly, _type_hint: number}, {category: table_calculation,
        expression: "(${actual} / ${actual_ly}) - 1", label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: supermeasure, table_calculation: vs_ly_1,
        _type_hint: number}, {category: table_calculation, expression: 'pivot_index(${transactions.lfl_net_sales},
          1  )', label: Actual LFL, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: supermeasure, table_calculation: actual_lfl, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.lfl_net_sales},2)',
        label: Actual LFL LY, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: actual_lfl_ly, _type_hint: number}, {category: table_calculation,
        expression: "${actual_lfl} - ${actual_lfl_ly}", label: vs LFL, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: supermeasure, table_calculation: vs_lfl,
        _type_hint: number}, {category: table_calculation, expression: "(${actual_lfl}\
          \ / ${actual_lfl_ly}) - 1", label: "% vs LFL LY", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: supermeasure, table_calculation: vs_lfl_ly,
        _type_hint: number}]
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
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      transactions.total_net_sales:
        is_active: true
    series_text_format:
      sites.division:
        align: left
      actual:
        align: center
      sites.region_manager:
        align: left
      sites.region_name:
        align: left
      base.date_year:
        align: left
      budget:
        align: center
      vs_budget:
        align: center
      vs_budget_1:
        align: center
      actual_ly:
        align: center
      vs_ly:
        align: center
      vs_ly_1:
        align: center
      actual_lfl:
        align: center
      actual_lfl_ly:
        align: center
      vs_lfl:
        align: center
      vs_lfl_ly:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [vs_budget, vs_budget_1,
          vs_ly, vs_ly_1, vs_lfl, vs_lfl_ly]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [vs_budget, vs_budget_1,
          vs_ly, vs_ly_1, vs_lfl_ly, vs_lfl]}]
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
    series_types: {}
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget,
      transactions.lfl_net_sales]
    title_hidden: true
    listen:
      Division: sites.division
      Region Name: sites.region_name
      Region Manager: sites.region_manager
      Head of Division: sites.head_ofdivision
      Fixed Range: base.select_fixed_range
    row: 5
    col: 0
    width: 24
    height: 6
  - title: Sales by Region
    name: Sales by Region
    model: ts_sales
    explore: base
    type: looker_grid
    fields: [sites.division, sites.region_manager, sites.region_name, transactions.total_net_sales,
      site_budget.site_net_sales_budget, transactions.lfl_net_sales, base.date_year]
    pivots: [base.date_year]
    filters:
      base.select_comparison_period: Year
    sorts: [base.date_year desc, sites.division, sites.region_manager]
    limit: 500
    total: true
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(${transactions.total_net_sales},
          1)', label: Actual, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: actual, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${site_budget.site_net_sales_budget}, 1)', label: Budget,
        value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: budget, _type_hint: number}, {category: table_calculation,
        expression: "${actual} - ${budget}", label: vs Budget, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: supermeasure, table_calculation: vs_budget,
        _type_hint: number}, {category: table_calculation, expression: "(${actual}\
          \ / ${budget}) - 1", label: "% vs Budget", value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: vs_budget_1, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.total_net_sales},
          2)', label: Actual LY, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: supermeasure, table_calculation: actual_ly, _type_hint: number},
      {category: table_calculation, expression: "${actual} - ${actual_ly}", label: vs
          LY, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: vs_ly, _type_hint: number}, {category: table_calculation,
        expression: "(${actual} / ${actual_ly}) - 1", label: "% vs LY", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: supermeasure, table_calculation: vs_ly_1,
        _type_hint: number}, {category: table_calculation, expression: 'pivot_index(${transactions.lfl_net_sales},
          1  )', label: Actual LFL, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: supermeasure, table_calculation: actual_lfl, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.lfl_net_sales},2)',
        label: Actual LFL LY, value_format: !!null '', value_format_name: gbp_0, _kind_hint: supermeasure,
        table_calculation: actual_lfl_ly, _type_hint: number}, {category: table_calculation,
        expression: "${actual_lfl} - ${actual_lfl_ly}", label: vs LFL, value_format: !!null '',
        value_format_name: gbp_0, _kind_hint: supermeasure, table_calculation: vs_lfl,
        _type_hint: number}, {category: table_calculation, expression: "(${actual_lfl}\
          \ / ${actual_lfl_ly}) - 1", label: "% vs LFL LY", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: supermeasure, table_calculation: vs_lfl_ly,
        _type_hint: number}]
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
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      transactions.total_net_sales:
        is_active: true
    series_text_format:
      sites.division:
        align: left
      actual:
        align: center
      sites.region_manager:
        align: left
      sites.region_name:
        align: left
      base.date_year:
        align: left
      budget:
        align: center
      vs_budget:
        align: center
      vs_budget_1:
        align: center
      actual_ly:
        align: center
      vs_ly:
        align: center
      vs_ly_1:
        align: center
      actual_lfl:
        align: center
      actual_lfl_ly:
        align: center
      vs_lfl:
        align: center
      vs_lfl_ly:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [vs_budget, vs_budget_1,
          vs_ly, vs_ly_1, vs_lfl, vs_lfl_ly]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [vs_budget, vs_budget_1,
          vs_ly, vs_ly_1, vs_lfl_ly, vs_lfl]}]
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
    series_types: {}
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
    hidden_fields: [transactions.total_net_sales, site_budget.site_net_sales_budget,
      transactions.lfl_net_sales]
    title_hidden: true
    listen:
      Division: sites.division
      Region Name: sites.region_name
      Region Manager: sites.region_manager
      Head of Division: sites.head_ofdivision
      Fixed Range: base.select_fixed_range
    row: 13
    col: 0
    width: 24
    height: 14
  filters:
  - name: Division
    title: Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options:
      - Division 1 - London & South East
      - Division 1 - South & East
      - Division 2 - Central & West
      - Division 2 - Scotland & North
    model: ts_sales
    explore: base
    listens_to_filters: []
    field: sites.division
  - name: Region Name
    title: Region Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
      options: []
    model: ts_sales
    explore: base
    listens_to_filters: []
    field: sites.region_name
  - name: Region Manager
    title: Region Manager
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: ts_sales
    explore: base
    listens_to_filters: []
    field: sites.region_manager
  - name: Head of Division
    title: Head of Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
      options: []
    model: ts_sales
    explore: base
    listens_to_filters: []
    field: sites.head_ofdivision
  - name: Region Director
    title: Region Director
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
      options: []
    model: ts_sales
    explore: base
    listens_to_filters: []
    field: sites.head_ofdivision
  - name: Fixed Range
    title: Fixed Range
    type: field_filter
    default_value: PD
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    model: ts_sales
    explore: base
    listens_to_filters: []
    field: base.select_fixed_range
