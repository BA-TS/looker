view: products {
  derived_table: {
  sql:
  /*SELECT distinct product.*
  FROM `toolstation-data-storage.range.products_current`as product
  union all
  SELECT "null", "null", "null", "null","null", "null",timestamp("2000-05-23 00:00:00"), "null", "null", "null","null", "null",cast(null as int),"null",cast(null as int),"null",cast(null as int),"null", "null", "null", "null",cast(null as int),cast(null as int),"null", "null", "null", "null",timestamp("2021-04-15 00:00:00 UTC"), timestamp("3000-01-01 00:00:00"), cast(null as int)*/


  SELECT distinct product.*,
  case when own.productBrand is not null then 1 else 0 end as is_own_brand
  FROM `toolstation-data-storage.range.products_current`as product
  left join `toolstation-data-storage.range.own_brand_list` own using (productBrand)
--need to include a null line to product table, as the ga4 table is left joined to this, if there is an event that does not include a SKU then this is excluded. in the ga4 table where there is no SKU, this is replaced with "null" so it can be joined to productTable and not filtered out
  union all
  SELECT "null", "null", "null", "null","null", "null",timestamp("2000-05-23 00:00:00"), "null", "null", "null","null", "null",cast(null as int),"null",cast(null as int),"null",cast(null as int),"null", "null", "null", "null",cast(null as int),cast(null as int),"null", "null", "null", "null",timestamp("2021-04-15 00:00:00 UTC"), timestamp("3000-01-01 00:00:00"), cast(null as int), 0
  ;;
  datagroup_trigger: ts_transactions_datagroup
  }

  dimension_group: date {
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.productStartDate ;;
  }

  dimension_group: activeTo {
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.activeTo ;;
  }

  dimension_group: activeFrom {
    type: time
    hidden: yes
    timeframes: [raw,date]
    sql: ${TABLE}.productStartDate ;;
  }

  dimension: product_uid {
    group_label: "Product Details"
    label: "Product UID"
    primary_key:  yes
    type: string
    sql: ${TABLE}.productUID ;;
  }

  dimension: brand {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productBrand ;;
  }

  dimension: is_own_brand {
    group_label: "Product Details"
    label: "Own Brand (Y/N/Unknown)"
    type: string
    description: "If brand is Toolstation's own brand, then Y, otherwise N, or Unknown for products which have no brands"
    sql:
    case when
    ${TABLE}.is_own_brand = 1 then "Y"
    when
    ${brand} is null then "Unknown"
    else "N"
    end
    ;;
  }

  dimension: description {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productDescription ;;
  }

  dimension: product_name {
    group_label: "Product Details"
    label: "Product Name"
    type: string
    sql: ${TABLE}.productName ;;
  }

  dimension: product_code {
    group_label: "Product Details"
    label: "Product Code (SKU)"
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: product_status {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productStatus ;;
  }

  dimension: product_type {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productType ;;
  }

  dimension: warranty_years {
    group_label: "Product Details"
    type: number
    sql: ${TABLE}.warrantyYears ;;
  }

  dimension: product_name_quantity {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productNameQuantity ;;
    hidden: yes
  }

  dimension: product_name_type {
    group_label: "Product Details"
    label: "Product Name Type"
    type: string
    sql: ${TABLE}.productNameType ;;
  }

  dimension: buyer {
    group_label: "Commercial Details"
    type: string
    sql: ${TABLE}.buyerName ;;
  }

  dimension: buying_manager {
    group_label: "Commercial Details"
    type: string
    sql: ${TABLE}.buyingManager ;;
  }

  dimension: buying_status {
    group_label: "Commercial Details"
    type: string
    sql: ${TABLE}.productBuyingStatus ;;
  }

  dimension: end_of_life {
    group_label: "Commercial Details"
    type: string
    sql: ${TABLE}.endOfLife ;;
  }

  dimension: product_channel {
    group_label: "Commercial Details"
    type: string
    sql: ${TABLE}.productChannel ;;
  }

  dimension: subdepartment {
    label: "Sub Department"
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: trade_department{
    group_label: "Flags"
    type: yesno
    sql: ${buying_manager} <> "Matt Rockliff" ;;
  }

  dimension: discontinued{
    group_label: "Flags"
    type: yesno
    sql: ${product_channel} = "Discontinued" ;;
  }

  dimension: department {
    group_label: "Product Details"
    label: "Department"
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: department_uid {
    group_label: "Commercial Details"
    type: number
    value_format_name: id
    sql: ${TABLE}.productDepartmentUID ;;
    hidden: yes
  }

  dimension: subdepartment_uid {
    group_label: "Commercial Details"
    type: number
    value_format_name: id
    sql: ${TABLE}.productSubdepartmentUID ;;
    hidden: yes
  }

  dimension: suspended {
    group_label: "Flags"
    type: number
    sql: ${TABLE}.suspended ;;
    hidden: yes
  }

  dimension: manufacturer {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.manufacturer ;;
    hidden: yes
  }

  dimension: rec_replen_multiple {
    group_label: "Supply Chain"
    type: number
    sql: ${TABLE}.recReplenMultiple ;;
    hidden: yes
  }

  dimension: stock_shop_replen_delay {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.stockShopReplenDelay ;;
    hidden: yes
  }

  dimension: supplier_part_number {
    group_label: "Supply Chain"
    label: "Supplier Part Number"
    type: string
    sql: ${TABLE}.supplierPartNumber ;;
  }

  dimension: manufacturer_id {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.manufacturerID ;;
  }

  dimension: default_supplier {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.productDefaultSupplier ;;
    hidden: yes
  }

  dimension: trade_products_10_subdepartments {
    group_label: "Product Details"
    type: yesno
    required_access_grants: [lz_testing]
    description: "These are the products that only trade customers will buy"
    sql: ${subdepartment} IN ("John Guest Speedfit","MDPE Pipe & Fittings","110mm Underground","160mm Underground","Expanding Foam","LV transformers","Din Rail & Terminals","Conduit & Trunking","Shower Pumps") OR ${subdepartment} LIKE "%Consumer Units%";;
  }

  dimension: product_promo {
    group_label: "Flags"
    label: "Product on Promotion?"
    type: yesno
    sql: ${catPromo.Product_Code} is not null ;;
  }


  measure: number_of_subdepartments {
    label: "Number of SubDepartments"
    view_label: "Measures"
    group_label: "Other Metrics"
    description: "Number of unique Sub departments"
    type: count_distinct
    required_access_grants: [lz_testing]
    sql: ${subdepartment} ;;
    value_format: "#,##0;(#,##0)"
  }

  measure: has_trade_products_10_subdepartments {
    view_label: "Measures"
    group_label: "Other Metrics"
    type: count_distinct
    required_access_grants: [lz_testing]
    sql: ${trade_products_10_subdepartments} = true ;;
    value_format: "#,##0;(#,##0)"
  }

  dimension: isActive {
    label: "is Active"
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isActive = 1 ;;
  }

  # dimension: Department_type{
  #   label: "Department Type"
  #   group_label: "Product Details"
  #   type: string
  #   sql:case
  #   when ${department} in ('Painting & Decorating', 'Workwear & Safety', 'Ventilation & Heating', 'Smart Technology & Consumer Electrical', 'Plumbing', 'Lighting', 'Kitchens', 'Electrical', 'Central Heating', 'Bathrooms') THEN 'Trade'
  #   WHEN ${department}  IN ('Hand Tools', 'Power Tools', 'Power Tool Accessories', 'Screws & Fixings', 'Ladders & Storage', 'Landscaping', 'Ironmongery & Security', 'Cleaning & Pest Control', 'Building & Joinery', 'Automotive', 'Adhesives & Sealants') THEN 'Hardware'
  #   ELSE 'Other (Uncatalogued, Deleted, Vouchers)'
  #   END;;
  # }

}
