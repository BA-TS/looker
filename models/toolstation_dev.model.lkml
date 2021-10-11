connection: "toolstation"

# include all the views
include: "/views/**/*.view"

datagroup: toolstation_dev_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: toolstation_dev_default_datagroup

explore: transactions {
  sql_always_where:
    {% if transactions.current_date_range._is_filtered %}
      {% condition transactions.current_date_range %} ${event_raw} {% endcondition %}

      {% if transactions.previous_date_range._is_filtered or transactions.compare_to._in_query %}
        {% if transactions.comparison_periods._parameter_value == "2" %}
          or
          ${event_raw} between ${period_2_start} and ${period_2_end}

          {% elsif transactions.comparison_periods._parameter_value == "3" %}
            or
            ${event_raw} between ${period_2_start} and ${period_2_end}
            or
            ${event_raw} between ${period_3_start} and ${period_3_end}

        {% endif %}
      {% else %} 1 = 1
      {% endif %}
    AND
    {% endif %}

    ${is_cancelled} = 0 AND ${product_code} <> '85699'

   ;;


  # {% elsif transactions.comparison_periods._parameter_value == "4" %}
  # or
  # ${event_raw} between ${period_2_start} and ${period_2_end}
  # or
  # ${event_raw} between ${period_3_start} and ${period_3_end}
  # or
  # ${event_raw} between ${period_4_start} and ${period_4_end}

  # {% else %} 1 = 1
  # {% endif %}

  join: products {
    type:  inner
    relationship: many_to_one
    sql_on: ${transactions.product_uid}=${products.product_uid} ;;
  }
  join: customers {
    type :  inner
    relationship: many_to_one
    sql_on: ${transactions.customer_uid}=${customers.customer_uid} ;;
  }

  # join: customer_segmentation {
  #   type: inner
  #   relationship: many_to_one
  #   sql_on: ${transactions.customer_uid}=${customer_segmentation.ucu_uid} ;;
  # }


  join: suppliers {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
  }
  join: sites {
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${sites.site_uid} ;;
  }
  join: completed_date_calendar{
    from:  calendar
    type:  inner
    relationship:  many_to_one
    sql_on: date(${transactions.transaction_date})=${completed_date_calendar.date} ;;
  }
  join: placed_date_calendar{
    from:  calendar
    type:  inner
    relationship:  many_to_one
    sql_on: date(${transactions.placed_date})=${placed_date_calendar.date} ;;
  }
  join: category_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: date(${transactions.transaction_date})=${category_budget.date_date} and ${products.department}=${category_budget.department} ;;
  }
  join: channel_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: date(${transactions.transaction_date})=${channel_budget.date_date} and upper(${transactions.sales_channel})=${channel_budget.channel} ;;
  }
  join: site_budget {
    view_label: "Budget"
    type: left_outer
    relationship: many_to_one
    sql_on: ${transactions.site_uid}=${site_budget.site_uid} and date(${transactions.transaction_date})=${site_budget.date_date} ;;
  }
  join: trade_customers {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_number} ;;
  }

  # Exclude cancelled orders and the charity SKU
  # sql_always_where: ${is_cancelled} = 0 and ${product_code} <> '85699' ;;
}



explore: stock_intake {
  join: products {
    type:  inner
    relationship: many_to_one
    sql_on: ${stock_intake.product_uid}=${products.product_uid} ;;
  }
  join: sites {
    type:  inner
    relationship:  many_to_one
    sql_on: ${stock_intake.destination_site_uid}=${sites.site_uid} ;;
  }
  join: disctribution_centre_names {
    type:  left_outer
    relationship: many_to_one
    sql_on: ${stock_intake.destination_site_uid}=${disctribution_centre_names.site_uid} ;;
  }
}

########
explore: view_weeklyconversion_testl {}
explore: test_dgtl_ds_contibution {}


explore: dgtl_product_conversion {
  label: "Product Conversion (DIGITAL)"
  join: products {
    type: inner
    relationship: many_to_one
    sql_on: ${dgtl_product_conversion.ga_sku}=${products.product_code} ;;
  }
}
