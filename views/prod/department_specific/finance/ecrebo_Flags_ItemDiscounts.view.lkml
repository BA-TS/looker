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

  dimension: discountValue_dim{
    type: number
    sql: ${TABLE}.discountValue ;;
    hidden: yes
  }

  measure: discount_value{
    type: sum
    sql: ${discountValue_dim} ;;
    hidden: yes
  }

  dimension: DiscountValue_Bulksave_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Bulksave ;;
    hidden: yes
  }

  measure: discount_value_bulksave{
    label: "Bulksave Discount Value (gross)"
    type: sum
    sql: ${DiscountValue_Bulksave_dim} ;;
  }

  dimension: DiscountValue_Free_product_offer_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Free_product_offer ;;
    hidden: yes
  }

  measure: discount_value_free_product_offer{
    label: "Free Product Offer Discount Value (gross)"
    type: sum
    sql: ${DiscountValue_Free_product_offer_dim} ;;
  }

  dimension: DiscountValue_Linksave_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Linksave ;;
    hidden: yes
  }

  measure: discount_value_linksave{
    label: "Linksave Discount Value (gross)"
    type: sum
    sql: ${DiscountValue_Linksave_dim} ;;
  }

  dimension: DiscountValue_Multibuy_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Multibuy ;;
    hidden: yes
  }

  measure: discount_value_multibuy{
    type: sum
    label: "Multibuy Discount Value (gross)"
    sql: ${DiscountValue_Multibuy_dim} ;;
  }

  dimension: DiscountValue_Other_item_discount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Other_item_discount ;;
    hidden: yes
  }

  measure: discount_value_other_item_discount{
    type: sum
    label: "Other Item Discount Discount Value (gross)"
    sql: ${DiscountValue_Other_item_discount_dim} ;;
  }

  dimension: DiscountValue_net_Bulksave_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Bulksave ;;
    hidden: yes
  }

  measure: discount_value_net_bulksave{
    type: sum
    label: "Bulksave Discount Value (net)"
    sql: ${DiscountValue_net_Bulksave_dim} ;;
  }

  dimension: DiscountValue_net_Free_product_offer_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Free_product_offer ;;
    hidden: yes
  }

  measure: DiscountValue_net_Free_product_offer{
    label: "Free Product Offer Discount Value (net)"
    type: sum
    sql: ${DiscountValue_net_Free_product_offer_dim} ;;
  }

  dimension: DiscountValue_net_Linksave_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Linksave ;;
    hidden: yes
  }

  measure: discount_value_net_linksave{
    type: sum
    label: "Linksave Discount Value (net)"
    sql: ${DiscountValue_net_Linksave_dim} ;;
  }

  dimension: DiscountValue_net_Multibuy_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Multibuy ;;
    hidden: yes
  }

  measure: discount_value_net_multibuy{
    type: sum
    label: "Multibuy Discount Value (net)"
    sql: ${DiscountValue_net_Multibuy_dim} ;;
  }

  dimension: DiscountValue_net_Other_item_discount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Other_item_discount ;;
    hidden: yes
  }

  measure: discount_value_net_other_item_discount{
    type: sum
    label: "Other Item Discount Discount Value (net)"
    sql: ${DiscountValue_net_Other_item_discount_dim} ;;
  }

  # dimension: Category_Unallocated_discount_dim{
  #   type: number
  #   sql: ${TABLE}.Category_Unallocated_discount ;;
  #   hidden: yes
  # }

  # measure: Category_Unallocated_discount{
  #   type: sum
  #   label: "Unallocated Discount (Yes / No)"
  #   sql: ${Category_Unallocated_discount_dim} ;;
  # }

  dimension: Unallocated_discount{
    type: yesno
    sql: ${TABLE}.Category_Unallocated_discount ;;
  }

  # measure: Category_Unallocated_discount{
  #   type: sum
  #   label: "Unallocated Discount (Yes / No)"
  #   sql: ${Category_Unallocated_discount_dim} ;;
  # }

  dimension: DiscountValue_Unallocated_discount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Unallocated_discount ;;
    hidden: yes
  }

  measure:DiscountValue_Unallocated_discount{
    type: sum
    label: "Unallocated Discount Value (gross)"
    sql: ${DiscountValue_Unallocated_discount_dim} ;;
  }

  dimension: DiscountValue_net_Unallocated_discount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Unallocated_discount ;;
    hidden: yes
  }

  measure:DiscountValue_net_Unallocated_discount{
    type: sum
    label: "Unallocated Discount Value (net)"
    sql: ${DiscountValue_net_Unallocated_discount_dim} ;;
  }
}
