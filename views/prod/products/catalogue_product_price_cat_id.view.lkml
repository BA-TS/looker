view: catalogue_product_price_cat_id {
  sql_table_name: `toolstation-data-storage.range.catalogue_product_price_catID`
    ;;


  dimension: cat_number {
    label: "Catalogue Number"
    type: number
    sql: ${TABLE}.catNumber ;;
  }

  dimension: catalogue_name {
    type: string
    sql: ${TABLE}.catalogueName ;;
  }

  dimension: entry_number {
    type: number
    sql: ${TABLE}.entry_number ;;
  }

  dimension: gross_price {
    type: number
    sql: ${TABLE}.grossPrice ;;
    value_format_name: gbp
  }

  dimension: page_number {
    type: number
    sql: ${TABLE}.pageNumber ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: product_description {
    type: string
    sql: ${TABLE}.productDescription ;;
  }

  dimension: product_subdepartment {
    type: string
    sql: ${TABLE}.productSubdepartment ;;
  }

  dimension: vat_rate {
    type: number
    sql: ${TABLE}.vatRate ;;
  }

}
