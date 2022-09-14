view: stock_level_date_site_product {
  view_label: "Stock Measures"

  sql_table_name: `toolstation-data-storage.stock.stock_level_date_site_product`
    ;;


  dimension_group: opening_stock {
    view_label: "Dates"
    type: time
    datatype: timestamp
    timeframes: [
      date,
      week,
      week_of_year,
      month,
      year,
      day_of_month,
      month_name,
      month_num
    ]
    sql: ${TABLE}.openingStockDate ;;
  }

  # dimension_group: closing_stock {
  #   view_label: "Dates"
  #   type: time
  #   datatype: timestamp
  #   timeframes: [
  #     date,
  #     week,
  #     week_of_year,
  #     month,
  #     year,
  #     day_of_month,
  #     month_name,
  #     month_num
  #   ]
  #   sql: TIMESTAMP_SUB(${TABLE}.openingStockDate, INTERVAL 1 SECOND) ;;
  # }

  # dimension: is_last_day_closing {
  #   view_label: "Dates"
  #   group_label: "Closing Stock Date"
  #   label: "Is Last Day of Month?"
  #   type: yesno
  #   sql:  EXTRACT(DAY FROM DATE_ADD(${closing_stock_date}, INTERVAL 1 DAY)) = 1 ;;
  # }

  dimension: is_last_day_opening {
    view_label: "Dates"
    group_label: "Opening Stock Date"
    label: "Is Last Day of Month?"
    type: yesno
    sql:  EXTRACT(DAY FROM DATE_ADD(${opening_stock_date}, INTERVAL 1 DAY)) = 1 ;;
  }

  dimension: date_site_product_pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${opening_stock_date}||${site_uid}||${product_uid} ;;
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: stock_level {
    type: number
    hidden: yes
    sql: ${TABLE}.stockLevel ;;
  }

  dimension: average_cost_price {
    type: number
    hidden: yes
    sql: ${aac.average_cost_price} ;;
  }

  measure: total_stock_level {
    label: "Units On Hand"
    type: sum
    sql: CASE WHEN ${products.product_code} < '10000' THEN 0 ELSE ${stock_level} END ;;

  }

  measure: stock_value {
    label: "Stock Value"
    type: number
    sql: SUM(${TABLE}.stockLevel * ${average_cost_price}) ;;
  }


}
