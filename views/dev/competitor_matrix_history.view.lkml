view: competitor_matrix_history {
  fields_hidden_by_default: yes
  sql_table_name: `toolstation-data-storage.brandview.lookerTable`;;

  # AMAZON #
  dimension: product_code_amazon {
    type: string
    sql: ${TABLE}.amazon.productCode ;;
    view_label: "Product Code"
    label: "Amazon"
    hidden: no
  }

  dimension: shelf_price_amazon {
    type: number
    sql: ${TABLE}.amazon.shelfPrice ;;
    view_label: "Shelf Price"
    label: "Amazon"
    hidden: no
  }

  dimension: promo_message_amazon {
    type: string
    sql: ${TABLE}.amazon.promo.message ;;
    view_label: "Promo"
    group_label: "Amazon"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_amazon {
    type: number
    sql: ${TABLE}.amazon.promo.price ;;
    view_label: "Promo"
    group_label: "Amazon"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_amazon {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.amazon.promo.startDate ;;
    view_label: "Promo"
    group_label: "Amazon"
    label: "Start"
    hidden: no
  }

  # BANDQ #
  dimension: product_code_bandq {
    type: string
    sql: ${TABLE}.bAndQ.productCode ;;
    view_label: "Product Code"
    label: "B&Q"
    hidden: no
  }

  dimension: shelf_price_bandq {
    type: number
    sql: ${TABLE}.bAndQ.shelfPrice ;;
    view_label: "Shelf Price"
    label: "B&Q"
    hidden: no
  }

  dimension: promo_message_bandq {
    type: string
    sql: ${TABLE}.bAndQ.promo.message ;;
    view_label: "Promo"
    group_label: "B&Q"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_bandq {
    type: number
    sql: ${TABLE}.bAndQ.promo.price ;;
    view_label: "Promo"
    group_label: "B&Q"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_bandq {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.bAndQ.promo.startDate ;;
    view_label: "Promo"
    group_label: "B&Q"
    label: "Start"
    hidden: no
  }

  # CEF #
  dimension: product_code_cef {
    type: string
    sql: ${TABLE}.cef.productCode ;;
    view_label: "Product Code"
    label: "CEF"
    hidden: no
  }

  dimension: shelf_price_cef {
    type: number
    sql: ${TABLE}.cef.shelfPrice ;;
    view_label: "Shelf Price"
    label: "CEF"
    hidden: no
  }

  dimension: promo_message_cef {
    type: string
    sql: ${TABLE}.cef.promo.message ;;
    view_label: "Promo"
    group_label: "CEF"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_cef {
    type: number
    sql: ${TABLE}.cef.promo.price ;;
    view_label: "Promo"
    group_label: "CEF"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_cef {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.cef.promo.startDate ;;
    view_label: "Promo"
    group_label: "CEF"
    label: "Start"
    hidden: no
  }

  # CITYPLUMBING #
  dimension: product_code_cityplumbing {
    type: string
    sql: ${TABLE}.cityPlumbing.productCode ;;
    view_label: "Product Code"
    label: "City Plumbing"
    hidden: no
  }

  dimension: shelf_price_cityplumbing {
    type: number
    sql: ${TABLE}.cityPlumbing.shelfPrice ;;
    view_label: "Shelf Price"
    label: "City Plumbing"
    hidden: no
  }

  dimension: promo_message_cityplumbing {
    type: string
    sql: ${TABLE}.cityPlumbing.promo.message ;;
    view_label: "Promo"
    group_label: "City Plumbing"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_cityplumbing {
    type: number
    sql: ${TABLE}.cityPlumbing.promo.price ;;
    view_label: "Promo"
    group_label: "City Plumbing"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_cityplumbing {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.cityPlumbing.promo.startDate ;;
    view_label: "Promo"
    group_label: "City Plumbing"
    label: "Start"
    hidden: no
  }

  # FFX #
  dimension: product_code_ffx {
    type: string
    sql: ${TABLE}.ffx.productCode ;;
    view_label: "Product Code"
    label: "FFX"
    hidden: no
  }

  dimension: shelf_price_ffx {
    type: number
    sql: ${TABLE}.ffx.shelfPrice ;;
    view_label: "Shelf Price"
    label: "FFX"
    hidden: no
  }

  dimension: promo_message_ffx {
    type: string
    sql: ${TABLE}.ffx.promo.message ;;
    view_label: "Promo"
    group_label: "FFX"
    label: "Message"     hidden: no
  }

  dimension: promo_price_ffx {
    type: number
    sql: ${TABLE}.ffx.promo.price ;;
    view_label: "Promo"
    group_label: "FFX"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_ffx {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ffx.promo.startDate ;;
    view_label: "Promo"
    group_label: "FFX"
    label: "Start"
    hidden: no
  }

  # IRONMONGERYDIRECT #
  dimension: product_code_ironmongerydirect {
    type: string
    sql: ${TABLE}.ironmongeryDirect.productCode ;;
    view_label: "Product Code"
    label: "Ironmongery Direct"
    hidden: no
  }

  dimension: shelf_price_ironmongerydirect {
    type: number
    sql: ${TABLE}.ironmongeryDirect.shelfPrice ;;
    view_label: "Shelf Price"
    label: "Ironmongery Direct"
    hidden: no
  }

  dimension: promo_message_ironmongerydirect {
    type: string
    sql: ${TABLE}.ironmongeryDirect.promo.message ;;
    view_label: "Promo"
    group_label: "Ironmongery Direct"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_ironmongerydirect {
    type: number
    sql: ${TABLE}.ironmongeryDirect.promo.price ;;
    view_label: "Promo"
    group_label: "Ironmongery Direct"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_ironmongerydirect {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ironmongeryDirect.promo.startDate ;;
    view_label: "Promo"
    group_label: "Ironmongery Direct"
    label: "Start"
    hidden: no
  }

  # ITS #

  dimension: product_code_its {
    type: string
    sql: ${TABLE}.its.productCode ;;
    view_label: "Product Code"
    label: "ITS"
    hidden: no
  }

  dimension: shelf_price_its {
    type: number
    sql: ${TABLE}.its.shelfPrice ;;
    view_label: "Shelf Price"
    label: "ITS"
    hidden: no
  }

  dimension: promo_message_its {
    type: string
    sql: ${TABLE}.its.promo.message ;;
    view_label: "Promo"
    group_label: "ITS"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_its {
    type: number
    sql: ${TABLE}.its.promo.price ;;
    view_label: "Promo"
    group_label: "ITS"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_its {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.its.promo.startDate ;;
    view_label: "Promo"
    group_label: "ITS"
    label: "Start"
    hidden: no
  }

  # SCREWFIX #

  dimension: product_code_screwfix {
    type: string
    sql: ${TABLE}.screwfix.productCode ;;
    view_label: "Product Code"
    label: "Screwfix"
    hidden: no
  }

  dimension: shelf_price_screwfix {
    type: number
    sql: ${TABLE}.screwfix.shelfPrice ;;
    view_label: "Shelf Price"
    label: "Screwfix"
    hidden: yes
  }

  dimension: promo_message_screwfix {
    type: string
    sql: ${TABLE}.screwfix.promo.message ;;
    view_label: "Promo"
    group_label: "Screwfix"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_screwfix {
    type: number
    sql: ${TABLE}.screwfix.promo.price ;;
    view_label: "Promo"
    group_label: "Screwfix"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_screwfix {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.screwfix.promo.startDate ;;
    view_label: "Promo"
    group_label: "Screwfix"
    label: "Start"
    hidden: no
  }

  # SELCOBW #
  dimension: product_code_selcobw {
    type: string
    sql: ${TABLE}.selcoBW.productCode ;;
    view_label: "Product Code"
    label: "Selco BW"
    hidden: no
  }

  dimension: shelf_price_selcobw {
    type: number
    sql: ${TABLE}.selcoBW.shelfPrice ;;
    view_label: "Shelf Price"
    label: "Selco BW"
    hidden: no
  }

  dimension: promo_message_selcobw {
    type: string
    sql: ${TABLE}.selcoBW.promo.message ;;
    view_label: "Promo"
    group_label: "Selco BW"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_selcobw {
    type: number
    sql: ${TABLE}.selcoBW.promo.price ;;
    view_label: "Promo"
    group_label: "Selco BW"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_selcobw {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.selcoBW.promo.startDate ;;
    view_label: "Promo"
    group_label: "Selco BW"
    label: "Start"
    hidden: no
  }

  # TLCDIRECT #

  dimension: product_code_tlcdirect {
    type: string
    sql: ${TABLE}.tlcDirect.productCode ;;
    view_label: "Product Code"
    label: "TLC Direct"
    hidden: no
  }

  dimension: shelf_price_tlcdirect {
    type: number
    sql: ${TABLE}.tlcDirect.shelfPrice ;;
    view_label: "Shelf Price"
    label: "TLC Direct"
    hidden: no
  }

  dimension: promo_message_tlcdirect {
    type: string
    sql: ${TABLE}.tlcDirect.promo.message ;;
    view_label: "Promo"
    group_label: "TLC Direct"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_tlcdirect {
    type: number
    sql: ${TABLE}.tlcDirect.promo.price ;;
    view_label: "Promo"
    group_label: "TLC Direct"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_tlcdirect {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.tlcDirect.promo.startDate ;;
    view_label: "Promo"
    group_label: "TLC Direct"
    label: "Start"
    hidden: no
  }

  # TOOLSTATION #
  dimension: product_code_toolstation {
    type: string
    sql: ${TABLE}.toolstation.productCode ;;
    view_label: "Product Code"
    label: "Toolstation"
    hidden: no
  }

  dimension: shelf_price_toolstation {
    type: number
    sql: ${TABLE}.toolstation.shelfPrice ;;
    view_label: "Shelf Price"
    label: "Toolstation"
    hidden: yes
  }

  dimension: promo_message_toolstation {
    type: string
    sql: ${TABLE}.toolstation.promo.message ;;
    view_label: "Promo"
    group_label: "Toolstation"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_toolstation {
    type: number
    sql: ${TABLE}.toolstation.promo.price ;;
    view_label: "Promo"
    group_label: "Toolstation"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_toolstation {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.toolstation.promo.startDate ;;
    view_label: "Promo"
    group_label: "Toolstation"
    label: "Start"
    hidden: no
  }


  # VICTORIAPLUM #

  dimension: product_code_victoriaplum {
    type: string
    sql: ${TABLE}.victoriaplum.productCode ;;
    view_label: "Product Code"
    label: "Victoria Plum"
    hidden: no
  }

  dimension: shelf_price_victoriaplum {
    type: number
    sql: ${TABLE}.victoriaplum.shelfPrice ;;
    view_label: "Shelf Price"
    label: "Victoria Plum"
    hidden: no
  }

  dimension: promo_message_victoriaplum {
    type: string
    sql: ${TABLE}.victoriaplum.promo.message ;;
    view_label: "Promo"
    group_label: "Victoria Plum"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_victoriaplum {
    type: number
    sql: ${TABLE}.victoriaplum.promo.price ;;
    view_label: "Promo"
    group_label: "Victoria Plum"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_victoriaplum {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.victoriaplum.promo.startDate ;;
    view_label: "Promo"
    group_label: "Victoria Plum"
    label: "Start"
    hidden: no
  }


  # VICTORIANPLUMBING #

  dimension: product_code_victorianplumbing {
    type: string
    sql: ${TABLE}.victorianPlumbing.productCode ;;
    view_label: "Product Code"
    label: "Victorian Plumbing"
    hidden: no
  }

  dimension: shelf_price_victorianplumbing {
    type: number
    sql: ${TABLE}.victorianPlumbing.shelfPrice ;;
    view_label: "Shelf Price"
    label: "Victorian Plumbing"
    hidden: no
  }

  dimension: promo_message_victorianplumbing {
    type: string
    sql: ${TABLE}.victorianPlumbing.promo.message ;;
    view_label: "Promo"
    group_label: "Victorian Plumbing"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_victorianplumbing {
    type: number
    sql: ${TABLE}.victorianPlumbing.promo.price ;;
    view_label: "Promo"
    group_label: "Victorian Plumbing"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_victorianplumbing {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.victorianPlumbing.promo.startDate ;;
    view_label: "Promo"
    group_label: "Victorian Plumbing"
    label: "Start"
    hidden: no
  }

  # WICKES #

  dimension: product_code_wickes {
    type: string
    sql: ${TABLE}.wickes.productCode ;;
    view_label: "Product Code"
    label: "Wickes"
    hidden: no
  }

  dimension: shelf_price_wickes {
    type: number
    sql: ${TABLE}.wickes.shelfPrice ;;
    view_label: "Shelf Price"
    label: "Wickes"
    hidden: no
  }

  dimension: promo_message_wickes {
    type: string
    sql: ${TABLE}.wickes.promo.message ;;
    view_label: "Promo"
    group_label: "Wickes"
    label: "Message"
    hidden: no
  }

  dimension: promo_price_wickes {
    type: number
    sql: ${TABLE}.wickes.promo.price ;;
    view_label: "Promo"
    group_label: "Wickes"
    label: "Price"
    hidden: no
  }

  dimension_group: promo_start_wickes {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.wickes.promo.startDate ;;
    view_label: "Promo"
    group_label: "Wickes"
    label: "Start"
    hidden: no
  }

  # GENERAL #

  dimension_group: load_date {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.loadDate ;;
    view_label: "Date"
    group_label: ""
    hidden: no
  }

  # INDEXING #
  dimension: sales_data {
    type: number
    sql: ${TABLE}.unitsSold ;;
    hidden: yes
  }

  measure: sum_sales_data {
    type: sum
    sql: ${sales_data} ;;
    view_label: "Measures"
    label: "Units Sold"
    hidden: no
  }

  # DETAIL #

  dimension: product_description {
    type: string
    sql: ${products.description} ;;
    view_label: "Details"
    group_label: "Product"
    label: "Description"
    hidden: no
  }

  dimension: product_department {
    type: string
    sql: ${products.department} ;;
    view_label: "Details"
    group_label: "Product"
    label: "Department"
    hidden: no
  }

  dimension: product_subdepartment {
    type: string
    sql: ${products.subdepartment} ;;
    view_label: "Details"
    group_label: "Product"
    label: "Subdepartment"
    hidden: no
  }

  dimension: product_brand {
    type: string
    sql: ${products.brand} ;;
    view_label: "Details"
    group_label: "Product"
    label: "Brand"
    hidden: no
  }

  dimension: product_buyer {
    type: string
    sql: ${products.buyer} ;;
    view_label: "Details"
    group_label: "Product"
    label: "Buyer"
    hidden: no
  }

  dimension: product_buying_manager {
    type: string
    sql: ${products.buying_manager} ;;
    view_label: "Details"
    group_label: "Product"
    label: "Buying Manager"
    hidden: no
  }


  # SUPPLIER #
  dimension: supplier_name {
    type: string
    sql: ${suppliers.supplier_name} ;;
    view_label: "Details"
    group_label: "Supplier"
    hidden: no
  }

  dimension: master_supplier_name {
    type: string
    sql: ${suppliers.master_supplier_name} ;;
    view_label: "Details"
    group_label: "Supplier"
    hidden: no
  }

  measure: sum_shelf_price_screwfix {
    type: sum
    sql: ${shelf_price_screwfix} ;;
    view_label: "Shelf Price"
    label: "Screwfix"
    value_format_name: "decimal_2"
    hidden: no
  }

  measure: sum_shelf_price_toolstation {
    type: sum
    sql: ${shelf_price_toolstation} ;;
    view_label: "Shelf Price"
    label: "Toolstation"
    value_format_name: "decimal_2"
    hidden: no
  }

  measure: index_unweighted_shelf_price_screwfix {
    type: number
    sql: SAFE_DIVIDE(${sum_shelf_price_screwfix}, ${sum_shelf_price_toolstation}) * 100 ;;
    view_label: "Index"
    group_label: "Screwfix"
    label: "Unweighted (Shelf)"
    value_format_name: "decimal_2"
    hidden: no
  }

  measure: index_weighted_shelf_price_screwfix {
    type: number
    sql: SAFE_DIVIDE(${sum_shelf_price_screwfix} * ${sum_sales_data}, ${sum_shelf_price_toolstation} * ${sum_sales_data}) * 100 ;;
    view_label: "Index"
    group_label: "Screwfix"
    label: "Weighted (Shelf)"
    value_format_name: "decimal_2"
    hidden: no
  }

  filter: matched_with_amazon{
    type: yesno
    sql: ${product_code_amazon} IS NOT NULL ;;
    view_label: "Matches"
    label: "Amazon"
    hidden: no
  }
  filter: matched_with_bandq{
    type: yesno
    sql: ${product_code_bandq} IS NOT NULL ;;
    view_label: "Matches"
    label: "B&Q"
    hidden: no
  }
  filter: matched_with_cef{
    type: yesno
    sql: ${product_code_cef} IS NOT NULL ;;
    view_label: "Matches"
    label: "CEF"
    hidden: no
  }
  filter: matched_with_cityplumbing{
    type: yesno
    sql: ${product_code_cityplumbing} IS NOT NULL ;;
    view_label: "Matches"
    label: "City Plumbing"
    hidden: no
  }
  filter: matched_with_ffx{
    type: yesno
    sql: ${product_code_ffx} IS NOT NULL ;;
    view_label: "Matches"
    label: "FFX"
    hidden: no
  }
  filter: matched_with_ironmongerydirect{
    type: yesno
    sql: ${product_code_ironmongerydirect} IS NOT NULL ;;
    view_label: "Matches"
    label: "Ironmongery Direct"
    hidden: no
  }
  filter: matched_with_its{
    type: yesno
    sql: ${product_code_its} IS NOT NULL ;;
    view_label: "Matches"
    label: "ITS"
    hidden: no
  }
  filter: matched_with_screwfix {
    type: yesno
    sql: ${product_code_screwfix} IS NOT NULL ;;
    view_label: "Matches"
    label: "Screwfix"
    hidden: no
  }
  filter: matched_with_selcobw{
    type: yesno
    sql: ${product_code_selcobw} IS NOT NULL ;;
    view_label: "Matches"
    label: "Selco BW"
    hidden: no
  }
  filter: matched_with_tlcdirect{
    type: yesno
    sql: ${product_code_tlcdirect} IS NOT NULL ;;
    view_label: "Matches"
    label: "TLC Direct"
    hidden: no
  }
  filter: matched_with_victoriaplum{
    type: yesno
    sql: ${product_code_victoriaplum} IS NOT NULL ;;
    view_label: "Matches"
    label: "Victoria Plum"
    hidden: no
  }
  filter: matched_with_victorianplumbing{
    type: yesno
    sql: ${product_code_victorianplumbing} IS NOT NULL ;;
    view_label: "Matches"
    label: "Victorian Plumbing"
    hidden: no
  }
  filter: matched_with_wickes{
    type: yesno
    sql: ${product_code_wickes} IS NOT NULL ;;
    view_label: "Matches"
    label: "Wickes"
    hidden: no
  }

  measure: count_of_matches {
    type: count_distinct
    sql: ${product_code_toolstation} ;;
    view_label: "Measures"
    label: "Number of Matches"
    hidden: no
  }
}

view: cmh_product_detail {
  fields_hidden_by_default: yes
  sql_table_name: `toolstation-data-storage.brandview.productReference` ;;

  dimension: productDepartment {
    type: string
    sql: ${TABLE}.productDepartment ;;
    primary_key: yes
  }

  dimension: productSubdepartment {
    type: string
    sql: ${TABLE}.productSubdepartment ;;
    primary_key: yes
  }

  dimension: productBrand {
    type: string
    sql: ${TABLE}.productBrand ;;
  }

  dimension: productCount {
    type: number
    sql: ${TABLE}.productCount ;;
  }

  measure: totalProductCount {
    type: sum
    sql: ${productCount} ;;
    hidden: no
  }
}
