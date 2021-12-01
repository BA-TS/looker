- dashboard: top_10_performances_dsr
  title: Top 10 Performances (DSR)
  layout: newspaper
  preferred_viewer: dashboards-next
  refresh: 1 day
  elements:
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "# Top 10 Performances"
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

               <a style="color: #ffffff; padding: 0 20px ; float: right; line-height: 40px; font-weight: regular" href="https://tpdev.cloud.looker.com/embed/dashboards-next/ts_sales::top_10_performances_dsr" target="_blank" fullscreen="yes">View Full Screen</a>
              </span>
               <a style="color: #efefef; padding: 0 20px; float: right; line-height: 40px; font-weight: bold; text-decoration: none;"><span style="color: #ffffff;">Daily Sales Report - Top 10 Performances</span></a>
            </nav>
         </div>

      </div>
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Top 10 (Products)
    name: Top 10 (Products)
    model: ts_sales
    explore: base
    type: looker_grid
    fields: [transactions.total_net_sales, transactions.total_units, transactions.total_margin_rate_incl_funding,
      base.pivot_dimension, products.product_code, products.description, transactions.product_department]
    pivots: [base.pivot_dimension]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Week
      products.product_code: "-000%"
    sorts: [transactions.total_net_sales desc 0, base.pivot_dimension desc]
    limit: 10
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(${transactions.total_net_sales},
          1)', label: Net Sales, value_format: !!null '', value_format_name: gbp,
        _kind_hint: supermeasure, table_calculation: net_sales, _type_hint: number},
      {category: table_calculation, expression: 'coalesce((pivot_index(${transactions.total_net_sales},1)
          / pivot_index(${transactions.total_net_sales}, 2)) - 1,0)', label: Net Sales
          vs LW, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: net_sales_vs_lw, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_units}, 1)', label: Units, value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: supermeasure, table_calculation: units,
        _type_hint: number}, {category: table_calculation, expression: 'coalesce((pivot_index(${transactions.total_units},1)
          / pivot_index(${transactions.total_units}, 2)) - 1,0)', label: Units vs
          LW, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: units_vs_lw, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_margin_rate_incl_funding}, 1)',
        label: Margin %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: margin, _type_hint: number}, {category: table_calculation,
        expression: 'coalesce((pivot_index(${transactions.total_margin_rate_incl_funding},1)
          / pivot_index(${transactions.total_margin_rate_incl_funding}, 2)) - 1,0)',
        label: Margin % vs LW, value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: margin_vs_lw, _type_hint: number}]
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
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      transactions.total_net_sales:
        is_active: false
    series_text_format:
      products.product_code:
        align: left
      products.description:
        align: left
      net_sales:
        align: center
      net_sales_vs_lw:
        align: center
      units:
        align: center
      margin:
        align: center
      margin_vs_lw:
        align: center
      transactions.product_department:
        align: center
      units_vs_lw:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [net_sales_vs_lw,
          units_vs_lw, margin_vs_lw]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [net_sales_vs_lw,
          units_vs_lw, margin_vs_lw]}]
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
    hidden_fields: [transactions.total_net_sales, transactions.total_units, transactions.total_margin_rate_incl_funding]
    title_hidden: true
    listen: {}
    row: 7
    col: 0
    width: 24
    height: 10
  - title: Top 10 (Categories)
    name: Top 10 (Categories)
    model: ts_sales
    explore: base
    type: looker_grid
    fields: [transactions.total_net_sales, transactions.total_units, transactions.total_margin_rate_incl_funding,
      base.pivot_dimension, transactions.product_department]
    pivots: [base.pivot_dimension]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Week
      products.product_code: "-000%"
    sorts: [transactions.total_net_sales desc 0, base.pivot_dimension desc]
    limit: 10
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(${transactions.total_net_sales},
          1)', label: Net Sales, value_format: !!null '', value_format_name: gbp,
        _kind_hint: supermeasure, table_calculation: net_sales, _type_hint: number},
      {category: table_calculation, expression: 'coalesce((pivot_index(${transactions.total_net_sales},1)
          / pivot_index(${transactions.total_net_sales}, 2)) - 1,0)', label: Net Sales
          vs LW, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: net_sales_vs_lw, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_units}, 1)', label: Units, value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: supermeasure, table_calculation: units,
        _type_hint: number}, {category: table_calculation, expression: 'coalesce((pivot_index(${transactions.total_units},1)
          / pivot_index(${transactions.total_units}, 2)) - 1,0)', label: Units vs
          LW, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: units_vs_lw, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_margin_rate_incl_funding}, 1)',
        label: Margin %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: margin, _type_hint: number}, {category: table_calculation,
        expression: 'coalesce((pivot_index(${transactions.total_margin_rate_incl_funding},1)
          / pivot_index(${transactions.total_margin_rate_incl_funding}, 2)) - 1,0)',
        label: Margin % vs LW, value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: margin_vs_lw, _type_hint: number}]
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
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      transactions.total_net_sales:
        is_active: false
    series_text_format:
      base.pivot_dimension:
        align: center
      net_sales:
        align: center
      net_sales_vs_lw:
        align: center
      units:
        align: center
      margin:
        align: center
      margin_vs_lw:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [net_sales_vs_lw,
          units_vs_lw, margin_vs_lw]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [net_sales_vs_lw,
          units_vs_lw, margin_vs_lw]}]
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
    hidden_fields: [transactions.total_net_sales, transactions.total_units, transactions.total_margin_rate_incl_funding]
    title_hidden: true
    listen: {}
    row: 18
    col: 0
    width: 24
    height: 7
  - title: Top 10 (Sub Category)
    name: Top 10 (Sub Category)
    model: ts_sales
    explore: base
    type: looker_grid
    fields: [transactions.total_net_sales, transactions.total_units, transactions.total_margin_rate_incl_funding,
      base.pivot_dimension, products.subdepartment]
    pivots: [base.pivot_dimension]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Week
      products.product_code: "-000%"
    sorts: [transactions.total_net_sales desc 0, base.pivot_dimension desc]
    limit: 10
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(${transactions.total_net_sales},
          1)', label: Net Sales, value_format: !!null '', value_format_name: gbp,
        _kind_hint: supermeasure, table_calculation: net_sales, _type_hint: number},
      {category: table_calculation, expression: 'coalesce((pivot_index(${transactions.total_net_sales},1)
          / pivot_index(${transactions.total_net_sales}, 2)) - 1,0)', label: Net Sales
          vs LW, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: net_sales_vs_lw, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_units}, 1)', label: Units, value_format: !!null '',
        value_format_name: decimal_0, _kind_hint: supermeasure, table_calculation: units,
        _type_hint: number}, {category: table_calculation, expression: 'coalesce((pivot_index(${transactions.total_units},1)
          / pivot_index(${transactions.total_units}, 2)) - 1,0)', label: Units vs
          LW, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: units_vs_lw, _type_hint: number}, {category: table_calculation,
        expression: 'pivot_index(${transactions.total_margin_rate_incl_funding}, 1)',
        label: Margin %, value_format: !!null '', value_format_name: percent_1, _kind_hint: supermeasure,
        table_calculation: margin, _type_hint: number}, {category: table_calculation,
        expression: 'coalesce((pivot_index(${transactions.total_margin_rate_incl_funding},1)
          / pivot_index(${transactions.total_margin_rate_incl_funding}, 2)) - 1,0)',
        label: Margin % vs LW, value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: margin_vs_lw, _type_hint: number}]
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
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      transactions.total_net_sales:
        is_active: false
    series_text_format:
      products.subdepartment:
        align: left
      net_sales:
        align: center
      net_sales_vs_lw:
        align: center
      units:
        align: center
      units_vs_lw:
        align: center
      margin:
        align: center
      margin_vs_lw:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [net_sales_vs_lw,
          units_vs_lw, margin_vs_lw]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [net_sales_vs_lw,
          units_vs_lw, margin_vs_lw]}]
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
    hidden_fields: [transactions.total_net_sales, transactions.total_units, transactions.total_margin_rate_incl_funding]
    title_hidden: true
    listen: {}
    row: 27
    col: 0
    width: 24
    height: 7
  - title: Top 10 (Regions)
    name: Top 10 (Regions)
    model: ts_sales
    explore: base
    type: looker_grid
    fields: [sites.region_name, base.pivot_dimension, transactions.lfl_net_sales,
      transactions.lfl_number_of_units, transactions.lfl_margin_rate_incl_funding]
    pivots: [base.pivot_dimension]
    filters:
      base.select_fixed_range: PD
      base.select_comparison_period: Year
      sites.region_name: Region%
    sorts: [base.pivot_dimension desc, transactions.lfl_net_sales desc 0]
    limit: 10
    dynamic_fields: [{category: table_calculation, expression: 'pivot_index(${transactions.lfl_net_sales},1)',
        label: LFL Net Sales CY, value_format: !!null '', value_format_name: gbp_0,
        _kind_hint: supermeasure, table_calculation: lfl_net_sales_cy, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.lfl_margin_rate_incl_funding},
          1)', label: LFL Margin CY, value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: lfl_margin_cy, _type_hint: number},
      {category: table_calculation, expression: 'pivot_index(${transactions.lfl_number_of_units},
          1)', label: LFL Units CY, value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: supermeasure, table_calculation: lfl_units_cy, _type_hint: number},
      {category: table_calculation, expression: "(${lfl_net_sales_cy} / pivot_index(${transactions.lfl_number_of_units},\
          \ 2)) - 1", label: LFL Net Sales YoY, value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: lfl_net_sales_yoy, _type_hint: number},
      {category: table_calculation, expression: "(${lfl_margin_cy} / pivot_index(${transactions.lfl_margin_rate_incl_funding},2))\
          \ - 1", label: LFL Margin YoY, value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: lfl_margin_yoy, _type_hint: number},
      {category: table_calculation, expression: "(${lfl_units_cy} / pivot_index(${transactions.lfl_number_of_units},2))\
          \ - 1", label: LFL Units YoY, value_format: !!null '', value_format_name: percent_1,
        _kind_hint: supermeasure, table_calculation: lfl_units_yoy, _type_hint: number}]
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
    show_totals: true
    show_row_totals: true
    series_text_format:
      lfl_net_sales_cy:
        align: center
      lfl_margin_cy:
        align: center
      lfl_units_cy:
        align: center
      lfl_net_sales_yoy:
        align: center
      lfl_margin_yoy:
        align: center
      lfl_units_yoy:
        align: center
    header_font_color: "#FFFFFF"
    header_background_color: "#004f9f"
    conditional_formatting: [{type: greater than, value: 0, background_color: !!null '',
        font_color: "#72D16D", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [lfl_net_sales_yoy,
          lfl_margin_yoy, lfl_units_yoy]}, {type: less than, value: 0, background_color: !!null '',
        font_color: "#d32f2f", color_application: {collection_id: toolstation, palette_id: toolstation-diverging-0},
        bold: false, italic: false, strikethrough: false, fields: [lfl_net_sales_yoy,
          lfl_margin_yoy, lfl_units_yoy]}]
    hidden_fields: [transactions.lfl_net_sales, transactions.lfl_number_of_units,
      transactions.lfl_margin_rate_incl_funding]
    series_types: {}
    defaults_version: 1
    title_hidden: true
    listen: {}
    row: 36
    col: 0
    width: 24
    height: 7
  - name: " (3)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "## Product ##"
    row: 5
    col: 0
    width: 24
    height: 2
  - name: " (4)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "## Department ##"
    row: 16
    col: 0
    width: 24
    height: 2
  - name: " (5)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "### Sub Department ###"
    row: 25
    col: 0
    width: 24
    height: 2
  - name: " (6)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "### Regions ###"
    row: 34
    col: 0
    width: 24
    height: 2
