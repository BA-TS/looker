view: products {
  sql_table_name: `toolstation-data-storage.range.products_current`
    ;;


  # dimension_group: active_from {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.activeFrom ;;
  # }

  # dimension_group: active_to {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.activeTo ;;
  # }


  # dimension_group: product_start {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.productStartDate ;;
  # }

  # dimension: is_active {
  #   type: number
  #   sql: ${TABLE}.isActive ;;
  # }

  ########## Product Details ##########

  dimension: brand {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productBrand ;;
  }

  dimension: description {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productDescription ;;
  }

  dimension: product_name { # changed from name
    group_label: "Product Details"
    label: "Product Name"
    type: string
    sql: ${TABLE}.productName ;;
  }

  dimension: product_code {
    group_label: "Product Details"
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

  dimension: product_uid {
    group_label: "Product Details"
    label: "Product UID"
    primary_key:  yes
    type: string
    sql: ${TABLE}.productUID ;;
  }


  dimension: warranty_years {
    group_label: "Product Details"
    type: number
    sql: ${TABLE}.warrantyYears ;;
  }

  # HIDDEN #

  dimension: product_name_quantity {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productNameQuantity ;;
    hidden: yes
  }

  dimension: product_name_type {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productNameType ;;
    hidden: yes
  }


  ########## Commercial ##########

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
    group_label: "Commercial Details"
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: trade_department{
    group_label: "Commercial Details"
    type: yesno
    sql: ${buying_manager} <> "Matt Rockliff" ;;
  }

  # HIDDEN #

  dimension: department {
    group_label: "Commercial Details"
    label: "Department" # department raw
    type: string
    sql: ${TABLE}.productDepartment ;;
    hidden: yes # replaced by transactions.department coalesce
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

  ########## Flag ##########

  dimension: suspended {
    group_label: "Flags"
    type: number
    sql: ${TABLE}.suspended ;;
  }

  ########## Supply Chain ##########

  dimension: manufacturer {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: rec_replen_multiple {
    group_label: "Supply Chain"
    type: number
    sql: ${TABLE}.recReplenMultiple ;;
  }

  dimension: stock_shop_replen_delay {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.stockShopReplenDelay ;;
  }

  dimension: supplier_part_number {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.supplierPartNumber ;;
  }

  # HIDDEN #

  dimension: manufacturer_id {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.manufacturerID ;;
    hidden: yes
  }

  dimension: default_supplier {
    group_label: "Supply Chain"
    type: string
    sql: ${TABLE}.productDefaultSupplier ;;
    hidden: yes
  }

}
