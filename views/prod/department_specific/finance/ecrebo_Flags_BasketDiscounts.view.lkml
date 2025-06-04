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

}
