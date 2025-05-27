view: ecrebo_Flags_BasketDiscounts {

  derived_table: {
    sql:  select
          *,
          row_number () over () as prim_key,
          from `toolstation-data-storage.sales.ecrebo_Flags_BasketDiscounts`
          where EcreboFlag_ItemDiscount is not null;;
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

  dimension: Ecrebo_Flag_Basket_Discount {
    type: string
    sql: ${TABLE}.EcreboFlag_BasketDiscount ;;
  }

  dimension: trade_account {
    type: yesno
    sql: ${Ecrebo_Flag_Basket_Discount} = "Trade account" ;;
  }

  dimension: staff_discount {
    type: yesno
    sql: ${Ecrebo_Flag_Basket_Discount} = "Staff discount" ;;
  }

  dimension: loyalty_club {
    type: yesno
    sql: ${Ecrebo_Flag_Basket_Discount} = "Loyalty club" ;;
  }

  dimension: other_basket_discount {
    type: yesno
    sql: ${Ecrebo_Flag_Basket_Discount} = "Other basket discount" ;;
  }

}
