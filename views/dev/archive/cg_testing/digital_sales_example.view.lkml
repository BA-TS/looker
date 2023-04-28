
view: digital_sales_example {

  fields_hidden_by_default: yes
  sql_table_name: `toolstation-data-storage.tmp.digitalSalesExample`;;


  dimension: is_digital_channel {
    type: yesno
    sql: ${sales_channel} NOT IN ("Branches") ;;
    hidden: no
  }











  dimension: fullDate {
    group_label: ""
    type: date
    sql: ${TABLE}.fullDate ;;
    hidden: no
  }

  # dimension: calendar_year_week {
  #   label: ""
  #   type: string
  #   sql: ${TABLE}.calendarYearWeek ;;
  # } # !

  dimension: originating_site_uid {
    label: "Originating Site UID"
    type: string
    sql: ${TABLE}.originatingSiteUID ;;
  }

  dimension: product_code {

    view_label: "Product"
    # group_label: ""

    label: "Product Code (SKU)"
    description: "this is a product code."
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: no
  }

  dimension: sales_channel {
    label: "Sales Channel"
    type: string
    sql: ${TABLE}.salesChannel ;;
    hidden: no
  }

  dimension: site_uid {
    label: "Site UID"
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: no
  }



  dimension: total_sales {
    type: number
    sql: ${TABLE}.totalSales ;;
    hidden: yes
  }
  dimension: total_margin_excl_funding {
    type: number
    sql: ${TABLE}.totalMarginExclFunding ;;
    hidden: yes
  }
  dimension: total_margin_incl_funding {
    type: number
    sql: ${TABLE}.totalMarginInclFunding ;;
    hidden: yes
  }
  dimension: total_units {
    type: number
    sql: ${TABLE}.totalUnits ;;
    hidden: yes
  }



  measure: total_total_sales {
    type: sum
    sql: ${total_sales} ;;
    hidden: no
    value_format_name: decimal_2
  }

  measure: total_total_margin_excl_funding {
    type: sum
    sql: ${total_margin_excl_funding} ;;
    hidden: no
    value_format_name: decimal_2
  }

  measure: total_total_margin_incl_funding {
    type: sum
    sql: ${total_margin_incl_funding} ;;
    hidden: no
    value_format_name: decimal_2
  }

  measure: total_total_units {
    type: sum
    sql: ${total_units} ;;
    hidden: no
    value_format_name: decimal_2
  }



}
