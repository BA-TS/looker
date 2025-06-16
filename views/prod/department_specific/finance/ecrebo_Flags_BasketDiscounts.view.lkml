view: ecrebo_Flags_BasketDiscounts {

  derived_table: {
    sql:  select
          *,
          row_number () over () as prim_key,
          from `toolstation-data-storage.sales.ecrebo_Flags_BasketDiscounts`
          ;;
  }

  dimension: prim_key {
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parentOrderUID;;
    hidden: yes
  }

  dimension: productCode {
    type: string
    sql: ${TABLE}.productCode;;
    hidden: yes
  }

  dimension: transactionLineType {
    type: string
    sql: ${TABLE}.transactionLineType;;
    hidden: yes
  }

  dimension: transactionUID {
    type: string
    sql: ${TABLE}.transactionUID;;
    hidden: yes
  }

  dimension: trade_account {
    type: yesno
    sql: ${TABLE}.Flag_Tradeaccount = "Yes" ;;
  }

  dimension: staff_discount {
    type: yesno
    sql: ${TABLE}.Flag_Staffdiscount = "Yes" ;;
  }

  dimension: loyalty_club {
    type: yesno
    sql: ${TABLE}.Flag_Loyaltyclub = "Yes" ;;
  }

  dimension: other_basket_discount {
    type: yesno
    sql: ${TABLE}.Flag_Otherbasket = "Yes" ;;
  }

  dimension: DiscountValue_Loyaltyclub_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Loyaltyclub ;;
    hidden: yes
  }

  measure: DiscountValue_Loyaltyclub{
    type: sum
    label: "Loyalty Club Discount Value (gross)"
    sql: ${DiscountValue_Loyaltyclub_dim} ;;
  }

  dimension: DiscountValue_Otherbasket_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Otherbasket ;;
    hidden: yes
  }

  measure: DiscountValue_Otherbasket{
    type: sum
    label: "Other Basket Discount Discount Value (gross)"
    sql: ${DiscountValue_Otherbasket_dim} ;;
  }

  dimension: DiscountValue_Staffdiscount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Staffdiscount ;;
    hidden: yes
  }

  measure: DiscountValue_Staffdiscount{
    type: sum
    label: "Staff Discount Discount Value (gross)"
    sql: ${DiscountValue_Staffdiscount_dim} ;;
  }

  dimension: DiscountValue_Tradeaccount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Tradeaccount ;;
    hidden: yes
  }

  measure: DiscountValue_Tradeaccount{
    type: sum
    label: "Trade Account Discount Value (gross)"
    sql: ${DiscountValue_Tradeaccount_dim} ;;
  }

  dimension: DiscountValue_net_Loyaltyclub_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Loyaltyclub ;;
    hidden: yes
  }

  measure: DiscountValue_net_Loyaltyclub{
    type: sum
    label: "Loyalty Club Discount Value (net)"
    sql: ${DiscountValue_net_Loyaltyclub_dim} ;;
  }

  dimension: DiscountValue_net_Otherbasket_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Otherbasket ;;
    hidden: yes
  }

  measure: DiscountValue_net_Otherbasket{
    type: sum
    label: "Other Basket Discount Discount Value (net)"
    sql: ${DiscountValue_net_Otherbasket_dim} ;;
  }

  dimension: DiscountValue_net_Staffdiscount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Staffdiscount ;;
    hidden: yes
  }

  measure: DiscountValue_net_Staffdiscount{
    type: sum
    label: "Staff Discount Discount Value (net)"
    sql: ${DiscountValue_net_Staffdiscount_dim} ;;
  }

  dimension: DiscountValue_net_Tradeaccount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Tradeaccount ;;
    hidden: yes
  }

  measure: DiscountValue_net_Tradeaccount{
    type: sum
    label: "Trade Account Discount Value (net)"
    sql: ${DiscountValue_net_Tradeaccount_dim} ;;
  }

  dimension: DiscountValue_Unallocated_discount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_Unallocated_discount ;;
    hidden: yes
  }

  measure: DiscountValue_Unallocated_discount{
    type: sum
    label: "Unallocated Discount Value (gross)"
    sql: ${DiscountValue_Unallocated_discount_dim} ;;
  }

  dimension: Flag_Unallocated_discount_dim{
    type: number
    sql: ${TABLE}.Flag_Unallocated_discount ;;
    hidden: yes
  }

  measure: Flag_Unallocated_discount{
    type: sum
    label: "Unallocated Discount (Yes / No)"
    sql: ${Flag_Unallocated_discount_dim} ;;
  }

  dimension: DiscountValue_net_Unallocated_discount_dim{
    type: number
    sql: ${TABLE}.DiscountValue_net_Unallocated_discount ;;
    hidden: yes
  }

  measure: DiscountValue_net_Unallocated_discount{
    type: sum
    label: "Unallocated Discount Value (net)"
    sql: ${DiscountValue_net_Unallocated_discount_dim} ;;
  }

}
