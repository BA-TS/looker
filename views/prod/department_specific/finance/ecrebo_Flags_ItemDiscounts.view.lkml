view: ecrebo_Flags_ItemDiscounts {

  derived_table: {
    sql:
    select *,
    row_number () over () as prim_key
    from
    `toolstation-data-storage.sales.ecrebo_Flags_ItemDiscounts`
    ;;
  }

  dimension: prim_key{
    type: number
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: parent_order_uid{
    type: string
    sql: ${TABLE}.parentOrderUID ;;
    hidden: yes
  }

  dimension: transactionUID{
    type: string
    sql: ${TABLE}.transactionUID ;;
    hidden: yes
  }

  dimension: productCode{
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }

  dimension: transactionLineType{
    type: string
    sql: ${TABLE}.transactionLineType ;;
    hidden: yes
  }

  dimension: discountValue_dim{
    type: number
    sql: ${TABLE}.discountValue ;;
    hidden: yes
  }

  measure: discount_value{
    type: sum
    sql: ${discountValue_dim} ;;
  }

  dimension: category{
    type: string
    sql: ${TABLE}.Category ;;
    hidden: yes
  }

  dimension: bulksave{
    type: yesno
    sql: ${TABLE}.Category_Bulksave="Yes" ;;
  }

  dimension: free_product_offer{
    type: yesno
    sql: ${TABLE}.Category_Free_product_offer="Yes" ;;
  }

  dimension: multibuy{
    type: yesno
    sql: ${TABLE}.Category_Multibuy="Yes" ;;
  }

  dimension: other_item_discount{
    type: yesno
    sql: ${TABLE}.Category_Other_item_discount="Yes" ;;
  }

  dimension: Linksave{
    type: yesno
    sql: ${TABLE}.Category_Linksave="Yes" ;;
  }
}
