view: ecrebo_Flags_ItemDiscounts {

  derived_table: {
    sql:
    select *,
    row_number () over () as prim_key
    from
    "toolstation-data-storage.sales.ecrebo_Flags_ItemDiscounts"
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

  measure: discountValue{
    type: sum
    sql: ${TABLE}.discountValue_dim ;;
  }

  dimension: Category{
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension: bulksave{
    type: yesno
    sql: ${Category}="Bulksave" ;;
  }

  dimension: free_product_offer{
    type: yesno
    sql: ${Category}="Free product offer" ;;
  }

  dimension: multibuy{
    type: yesno
    sql: ${Category}="Multibuy" ;;
  }

  dimension: other_item_discount{
    type: yesno
    sql: ${Category}="Other item discount" ;;
  }

  dimension: Linksave{
    type: yesno
    sql: ${Category}="Linksave" ;;
  }
}
