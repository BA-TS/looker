view: products {
  derived_table: {
  sql: SELECT distinct * FROM `toolstation-data-storage.range.products_current`
  ;;
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
    case: {
      when: {
        sql: ${brand} IN ("Minotaur", "Pinnacle", "Wessex Electrical", "Made4Trade", "Hawksmoor", "Ebb and Flo", "Bauker","Maverick Safety") ;;
        label: "Y"
        }
      when: {
        sql: ${brand} IS NULL OR ${brand} = "Unbranded";;
        label: "Unknown"
      }
      else: "N"
  }
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
}
