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

  dimension: buyer {
    type: string
    sql: ${TABLE}.buyerName ;;
  }

  dimension: buying_manager {
    type: string
    sql: ${TABLE}.buyingManager ;;
  }

  dimension: end_of_life {
    type: string
    sql: ${TABLE}.endOfLife ;;
  }

  # dimension: is_active {
  #   type: number
  #   sql: ${TABLE}.isActive ;;
  # }

  dimension: manufacturer {
    type: string
    sql: ${TABLE}.manufacturer ;;
  }

  dimension: manufacturer_id {
    type: string
    sql: ${TABLE}.manufacturerID ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.productBrand ;;
  }

  dimension: buying_status {
    type: string
    sql: ${TABLE}.productBuyingStatus ;;
  }

  dimension: product_channel {
    type: string
    sql: ${TABLE}.productChannel ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: default_supplier {
    type: string
    sql: ${TABLE}.productDefaultSupplier ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: department_uid {
    type: number
    value_format_name: id
    sql: ${TABLE}.productDepartmentUID ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.productDescription ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.productName ;;
  }

  dimension: product_name_quantity {
    type: string
    sql: ${TABLE}.productNameQuantity ;;
  }

  dimension: product_name_type {
    type: string
    sql: ${TABLE}.productNameType ;;
  }

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

  dimension: product_status {
    type: string
    sql: ${TABLE}.productStatus ;;
  }

  dimension: subdepartment {
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: subdepartment_uid {
    type: number
    value_format_name: id
    sql: ${TABLE}.productSubdepartmentUID ;;
  }

  dimension: product_type {
    type: string
    sql: ${TABLE}.productType ;;
  }

  dimension: product_uid {
    primary_key:  yes
    type: string
    sql: ${TABLE}.productUID ;;
  }

  dimension: rec_replen_multiple {
    type: number
    sql: ${TABLE}.recReplenMultiple ;;
  }

  dimension: stock_shop_replen_delay {
    type: string
    sql: ${TABLE}.stockShopReplenDelay ;;
  }

  dimension: supplier_part_number {
    type: string
    sql: ${TABLE}.supplierPartNumber ;;
  }

  dimension: suspended {
    type: number
    sql: ${TABLE}.suspended ;;
  }

  dimension: warranty_years {
    type: number
    sql: ${TABLE}.warrantyYears ;;
  }

  #####


  dimension: trade_department{
    type: yesno
    sql: ${buying_manager} <> "Matt Rockliff" ;;
  }


}
