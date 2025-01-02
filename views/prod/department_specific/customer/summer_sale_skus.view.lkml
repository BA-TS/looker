view: summer_sale_skus {

  sql_table_name:`toolstation-data-storage.crm_reporting.zzz_Summer_Sale_SKUs`;;

  dimension: product_code{
    type: string
    primary_key: yes
    sql: cast(${TABLE}.Summer_Sale_SKU as string) ;;
    hidden: yes
  }

  dimension: summer_sale_skus{
    label: "Summer Sale SKUs"
    type: yesno
    sql: ${product_code} is not null ;;
  }
 }
