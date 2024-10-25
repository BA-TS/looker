include: "/views/prod/department_specific/customer/customers.view"

view: ds_assumed_trade_paul_test{
  derived_table: {
    sql:
      select
      customer_UID,
      max(assumed_trade_probability),
      case when max(assumed_trade_probability)>0.55 then 1 else 0 end as flag
      from
      `toolstation-data-storage.customer.ds_assumed_trade_history_v2`
      group by all
     ;;
    }

    dimension: customer_uid {
      type: string
      sql: ${TABLE}.customer_UID;;
      hidden: yes
    }

    dimension: flag {
      type:  number
      label: "Is Assumed Trade"
      sql:${TABLE}.flag;;
      hidden: yes
    }

    dimension: final_prediction {
      type:  yesno
      label: "Is Assumed Trade"
      sql:${flag} =1 ;;
      hidden: yes
    }

    dimension: final_prediction2 {
      type:  string
      label: "Customer Type (Assumed Trade/Trade/DIY)"
      sql:
          CASE
          WHEN ${customers.is_trade} = true then "Trade"
          When ${customers.flags__customer_anonymous} = true then "DIY"
          When ${customers.customer__first_name} = "EBAY" AND ${customers.customer__last_name} = "USER" then "DIY"
          When ${final_prediction} = true then "Assumed Trade"
          Else "DIY"
          END
          ;;
    }
}
