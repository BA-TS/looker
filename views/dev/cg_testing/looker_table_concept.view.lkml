view: looker_table_concept {

  sql_table_name: `toolstation-data-storage.promotions_testing.looker_table_concept`;;

  dimension: transaction_year_week {
    type: number
    label: "Year Week"
    view_label: "Date"
    sql: ${TABLE}.transactionYearWeek ;;
    value_format_name: "id"
  }

  dimension: __page_pre_url__ {
    sql: LPAD(REGEXP_EXTRACT(${catalogue__publication_name}, r"^Catalogue+ ([0-9-.]+$)"), 5, "10000") ;;
  }

  dimension: product_image {
    view_label: "Artwork"
    sql: ${product_code};;
    html: <img src="https://cdn.aws.toolstation.com/images/141020-UK/800/{{ value }}.jpg" /> ;;
  }

  dimension: page_image {
    view_label: "Artwork"
    sql: "TSUK" || ${__page_pre_url__} || "/" || ${catalogue__page_page_number} || "large.png";;
    html: <img width="300" src="https://cdn.aws.toolstation.com/catalogue/vcat/{{value}}" />;;

  }

  # dimension: transaction_year {
  #   type: number
  #   label: "Year"
  #   view_label: "Date"
  #   sql: LEFT(${TABLE}.transactionYearWeek,4) ;;
  # }

  # dimension: transaction_week {
  #   type: number
  #   label: "Week"
  #   view_label: "Date"
  #   sql: RIGHT(${TABLE}.transactionYearWeek,2) ;;
  # }

  dimension: product_code {
    type: string
    label: "Product Code"
    view_label: "Product"
    sql: ${TABLE}.productCode ;;
    primary_key: yes
  }

  dimension: product_uid {
    type: string
    label: "Product UID"
    view_label: "Product"
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  dimension: product_department {
    type: string
    label: "Product Department"
    view_label: "Product"
    sql: ${TABLE}.productDepartment ;;
  }

  dimension: sales_channel {
    type: string
    label: "Sales Channel"
    view_label: "Sales"
    sql: ${TABLE}.salesChannel ;;
    hidden: yes
  }
  dimension: site_uid {
    type: string
    label: "Site UID"
    view_label: "Sales"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  # dimension: is_lfl {
  #   type: yesno
  #   label: "Is LFL?"
  #   view_label: "Sales"
  #   sql: ${TABLE}.isLFL = 1 ;;
  # }





  measure: total_catalogue_forecast_quantity {
    type: sum
    view_label: "Forecast (Weekly)"
    label: "Total Catalogue Quantity"
    sql: ${TABLE}.catalogue.details.forecastWeeklyQuantity ;;
    value_format_name: decimal_0
  }
  measure: total_catalogue_forecast_sales {
    type: sum
    view_label: "Forecast (Weekly)"
    label: "Total Catalogue Sales"
    sql: ${TABLE}.catalogue.details.forecastWeeklySales ;;
    value_format_name: decimal_2
  }
  measure: total_catalogue_forecast_margin_excl {
    type: sum
    view_label: "Forecast (Weekly)"
    label: "Total Catalogue Margin (Ex Funding)"
    sql: ${TABLE}.catalogue.details.forecastWeeklyMarginExclFunding ;;
    value_format_name: decimal_2
  }
  measure: total_catalogue_forecast_margin_incl {
    type: sum
    view_label: "Forecast (Weekly)"
    label: "Total Catalogue Margin (In Funding)"
    sql: ${TABLE}.catalogue.details.forecastWeeklyMarginInclFunding ;;
    value_format_name: decimal_2
  }


  measure: average_catalogue_forecast_quantity {
    type: average
    view_label: "Forecast (Weekly)"
    label: "Average Catalogue Quantity"
    sql: ${TABLE}.catalogue.details.forecastWeeklyQuantity ;;
    value_format_name: decimal_0
  }
  measure: average_catalogue_forecast_sales {
    type: average
    view_label: "Forecast (Weekly)"
    label: "Average Catalogue Sales"
    sql: ${TABLE}.catalogue.details.forecastWeeklySales ;;
    value_format_name: decimal_2
  }
  measure: average_catalogue_forecast_margin_excl {
    type: average
    view_label: "Forecast (Weekly)"
    label: "Average Catalogue Margin (Ex Funding)"
    sql: ${TABLE}.catalogue.details.forecastWeeklyMarginExclFunding ;;
    value_format_name: decimal_2
  }
  measure: average_catalogue_forecast_margin_incl {
    type: average
    view_label: "Forecast (Weekly)"
    label: "Average Catalogue Margin (In Funding)"
    sql: ${TABLE}.catalogue.details.forecastWeeklyMarginInclFunding ;;
    value_format_name: decimal_2
  }







  measure: count_front_cover {
    type: sum_distinct
    sql: CASE WHEN ${catalogue__cover__front} THEN 1 ELSE 0 END ;;
    view_label: "Count"
  }

  measure: count_back_cover {
    type: sum_distinct
    sql: CASE WHEN ${catalogue__cover__back} THEN 1 ELSE 0 END ;;
    view_label: "Count"
  }

  measure: count_inserts {
    type: sum_distinct
    sql: CASE WHEN ${catalogue__inserts__any} THEN 1 ELSE 0 END ;;
    view_label: "Count"
  }

  measure: count_roll {
    type: sum_distinct
    sql: CASE WHEN ${catalogue__roll__any} THEN 1 ELSE 0 END ;;
    view_label: "Count"
  }
  measure: count_is_hotspot {
    type: sum_distinct
    sql: CASE WHEN ${catalogue__is_hotspot} THEN 1 ELSE 0 END ;;
    view_label: "Count"
  }
  measure: count_is_landing_page {
    type: sum_distinct
    sql: CASE WHEN ${catalogue__is_landing_page} THEN 1 ELSE 0 END ;;
    view_label: "Count"
  }
  measure: count_is_on_page_offer {
    type: sum_distinct
    sql: CASE WHEN ${catalogue__is_on_page_offer} THEN 1 ELSE 0 END ;;
    view_label: "Count"
  }
  measure: count_is_supplier_page {
    type: sum_distinct
    sql: CASE WHEN ${catalogue__is_supplier_page} THEN 1 ELSE 0 END ;;
    view_label: "Count"
  }








  dimension: margin_excl {
    type: number
    sql: ${TABLE}.marginExclFunding ;;
    hidden: yes
  }
  dimension: margin_incl {
    type: number
    sql: ${TABLE}.marginInclFunding ;;
    hidden: yes
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    hidden: yes
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.sales ;;
    hidden: yes
  }

  dimension: unit_funding {
    type: number
    sql: ${TABLE}.unitFunding ;;
    hidden: yes
  }





  dimension: catalogue__cover__back {
    type: yesno
    sql: ${TABLE}.catalogue.cover.back ;;
    view_label: "Catalogue"
    group_label: "Cover"
    label: "Back Cover"
  }

  dimension: catalogue__cover__front {
    type: yesno
    sql: ${TABLE}.catalogue.cover.front ;;
    view_label: "Catalogue"
    group_label: "Cover"
    label: "Front Cover"
  }

  dimension: catalogue__inserts__any {
    type: yesno
    sql: ${catalogue__inserts__f1} OR ${catalogue__inserts__f2} OR ${catalogue__inserts__f3} OR ${catalogue__inserts__f4} OR ${catalogue__inserts__f5} OR ${catalogue__inserts__f6} OR ${catalogue__inserts__f7} OR ${catalogue__inserts__r1} OR ${catalogue__inserts__r2} OR ${catalogue__inserts__r3} OR ${catalogue__inserts__r4} OR ${catalogue__inserts__r5} OR ${catalogue__inserts__r6} OR ${catalogue__inserts__r7} ;;
    view_label: "Catalogue"
    label: "Is Insert"
  }

  dimension: catalogue__inserts__f1 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.f1 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "1 - Front"
  }

  dimension: catalogue__inserts__f2 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.f2 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "2 - Front"
  }

  dimension: catalogue__inserts__f3 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.f3 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "3 - Front"
  }

  dimension: catalogue__inserts__f4 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.f4 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "4 - Front"
  }

  dimension: catalogue__inserts__f5 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.f5 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "5 - Front"
  }

  dimension: catalogue__inserts__f6 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.f6 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "6 - Front"
  }

  dimension: catalogue__inserts__f7 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.f7 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "7 - Front"
  }

  dimension: catalogue__inserts__r1 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.r1 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "1 - Rear"
  }

  dimension: catalogue__inserts__r2 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.r2 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "2 - Rear"
  }

  dimension: catalogue__inserts__r3 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.r3 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "3 - Rear"
  }

  dimension: catalogue__inserts__r4 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.r4 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "4 - Rear"
  }

  dimension: catalogue__inserts__r5 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.r5 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "5 - Rear"
  }

  dimension: catalogue__inserts__r6 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.r6 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "6 - Rear"
  }

  dimension: catalogue__inserts__r7 {
    type: yesno
    sql: ${TABLE}.catalogue.inserts.r7 ;;
    view_label: "Catalogue"
    group_label: "Insert"
    label: "7 - Rear"
  }

  dimension: catalogue__roll__any {
    type: yesno
    sql: ${catalogue__roll__ibcl} OR ${catalogue__roll__ibcr} OR ${catalogue__roll__ifcl} OR ${catalogue__roll__ifcr} OR ${catalogue__roll__rfil} OR ${catalogue__roll__rfir} ;;
    view_label: "Catalogue"
    label: "Is Roll-Fold"
  }

  dimension: catalogue__roll__ibcl {
    type: yesno
    sql: ${TABLE}.catalogue.roll.ibcl ;;
    view_label: "Catalogue"
    group_label: "Roll-Fold"
    label: "IBCL"
  }

  dimension: catalogue__roll__ibcr {
    type: yesno
    sql: ${TABLE}.catalogue.roll.ibcr ;;
    view_label: "Catalogue"
    group_label: "Roll-Fold"
    label: "IBCR"
  }

  dimension: catalogue__roll__ifcl {
    type: yesno
    sql: ${TABLE}.catalogue.roll.ifcl ;;
    view_label: "Catalogue"
    group_label: "Roll-Fold"
    label: "IFCL"
  }

  dimension: catalogue__roll__ifcr {
    type: yesno
    sql: ${TABLE}.catalogue.roll.ifcr ;;
    view_label: "Catalogue"
    group_label: "Roll-Fold"
    label: "IFCR"
  }

  dimension: catalogue__roll__rfil {
    type: yesno
    sql: ${TABLE}.catalogue.roll.rfil ;;
    view_label: "Catalogue"
    group_label: "Roll-Fold"
    label: "RFIL"
  }

  dimension: catalogue__roll__rfir {
    type: yesno
    sql: ${TABLE}.catalogue.roll.rfir ;;
    view_label: "Catalogue"
    group_label: "Roll-Fold"
    label: "RFIR"
  }

  dimension: catalogue__is_hotspot {
    type: yesno
    sql: ${TABLE}.catalogue.isHotspot ;;
    view_label: "Catalogue"
    label: "Hotspot"
  }

  dimension: catalogue__is_landing_page {
    type: yesno
    sql: ${TABLE}.catalogue.isLandingPage ;;
    view_label: "Catalogue"
    label: "Is Landing Page"
  }

  dimension: catalogue__is_on_page_offer {
    type: yesno
    sql: ${TABLE}.catalogue.isOnPageOffer ;;
    view_label: "Catalogue"
    label: "Is on Page Offer"
  }

  dimension: catalogue__is_supplier_page {
    type: yesno
    sql: ${TABLE}.catalogue.isSupplierPage ;;
    view_label: "Catalogue"
    label: "Is Supplier Page"
  }

  dimension: catalogue__publication_id {
    type: number
    sql: ${TABLE}.catalogue.publicationID ;;
    hidden: yes
  }

  dimension: catalogue__publication_name {
    type: string
    sql: ${TABLE}.catalogue.publicationName ;;
    view_label: "Catalogue"
    label: "Catalogue Name"
  }

  dimension: catalogue__is_in_catalogue {
    type: yesno
    sql: ${TABLE}.catalogue.isInCatalogue ;;
    view_label: "Catalogue"
    label: "Is In Catalogue"
  }

  dimension: catalogue__page_page_number {
    type: string
    sql: ${TABLE}.catalogue.page.pageNumber ;;
    view_label: "Catalogue"
    label: "Page Number(s)"
  }
  dimension: catalogue__page_table_id {
    type: string
    sql: ${TABLE}.catalogue.page.tableID ;;
    view_label: "Catalogue"
    label: "Table ID(s)"
  }




  dimension: is_catalogue_promo {
    type: yesno
    label: "Is Promo"
    sql: ${catalogue__cover__front} OR ${catalogue__cover__back} OR ${catalogue__inserts__any} OR ${catalogue__roll__any} OR ${catalogue__is_hotspot} OR ${catalogue__is_landing_page} OR ${catalogue__is_on_page_offer} OR ${catalogue__is_supplier_page} ;;
  }




  # dimension: extra1__publication_id {
  #   type: number
  #   sql: ${TABLE}.extra1.publication_id ;;
  #   group_label: "Extra1"
  #   group_item_label: "Publication ID"
  # }

  # dimension: extra1__publication_name {
  #   type: string
  #   sql: ${TABLE}.extra1.publication_name ;;
  #   group_label: "Extra1"
  #   group_item_label: "Publication Name"
  # }

  # dimension: extra1__front {
  #   type: yesno
  #   sql: ${TABLE}.extra1.front ;;
  #   group_label: "Extra1"
  #   group_item_label: "Front"
  # }

  # dimension: extra1__back {
  #   type: yesno
  #   sql: ${TABLE}.extra1.back ;;
  #   group_label: "Extra1"
  #   group_item_label: "Back"
  # }

  # dimension: extra1__is_extra {
  #   type: yesno
  #   sql: ${TABLE}.extra1.is_extra ;;
  #   group_label: "Extra1"
  #   group_item_label: "Is Extra"
  # }











  # dimension: extra2__publication_id {
  #   type: number
  #   sql: ${TABLE}.extra2.publication_id ;;
  #   group_label: "Extra2"
  #   group_item_label: "Publication ID"
  # }

  # dimension: extra2__publication_name {
  #   type: string
  #   sql: ${TABLE}.extra2.publication_name ;;
  #   group_label: "Extra2"
  #   group_item_label: "Publication Name"
  # }

  # dimension: extra2__front {
  #   type: yesno
  #   sql: ${TABLE}.extra2.front ;;
  #   group_label: "Extra2"
  #   group_item_label: "Front"
  # }

  # dimension: extra2__back {
  #   type: yesno
  #   sql: ${TABLE}.extra2.back ;;
  #   group_label: "Extra2"
  #   group_item_label: "Back"
  # }

  # dimension: extra2__is_extra {
  #   type: yesno
  #   sql: ${TABLE}.extra2.is_extra ;;
  #   group_label: "Extra2"
  #   group_item_label: "Is Extra"
  # }













  # dimension: extra3__publication_id {
  #   type: number
  #   sql: ${TABLE}.extra3.publication_id ;;
  #   group_label: "Extra3"
  #   group_item_label: "Publication ID"
  # }

  # dimension: extra3__publication_name {
  #   type: string
  #   sql: ${TABLE}.extra3.publication_name ;;
  #   group_label: "Extra3"
  #   group_item_label: "Publication Name"
  # }
  # dimension: extra3__front {
  #   type: yesno
  #   sql: ${TABLE}.extra3.front ;;
  #   group_label: "Extra3"
  #   group_item_label: "Front"
  # }
  # dimension: extra3__back {
  #   type: yesno
  #   sql: ${TABLE}.extra3.back ;;
  #   group_label: "Extra3"
  #   group_item_label: "Back"
  # }
  # dimension: extra3__is_extra {
  #   type: yesno
  #   sql: ${TABLE}.extra3.is_extra ;;
  #   group_label: "Extra3"
  #   group_item_label: "Is Extra"
  # }








  # dimension: seasonal1__back {
  #   type: yesno
  #   sql: ${TABLE}.seasonal1.back ;;
  #   group_label: "Seasonal1"
  #   group_item_label: "Back"
  # }

  # dimension: seasonal1__front {
  #   type: yesno
  #   sql: ${TABLE}.seasonal1.front ;;
  #   group_label: "Seasonal1"
  #   group_item_label: "Front"
  # }

  # dimension: seasonal1__is_extra {
  #   type: yesno
  #   sql: ${TABLE}.seasonal1.is_extra ;;
  #   group_label: "Seasonal1"
  #   group_item_label: "Is Extra"
  # }

  # dimension: seasonal1__publication_id {
  #   type: number
  #   sql: ${TABLE}.seasonal1.publication_id ;;
  #   group_label: "Seasonal1"
  #   group_item_label: "Publication ID"
  # }

  # dimension: seasonal1__publication_name {
  #   type: string
  #   sql: ${TABLE}.seasonal1.publication_name ;;
  #   group_label: "Seasonal1"
  #   group_item_label: "Publication Name"
  # }

















  # dimension: seasonal2__back {
  #   type: yesno
  #   sql: ${TABLE}.seasonal2.back ;;
  #   group_label: "Seasonal2"
  #   group_item_label: "Back"
  # }

  # dimension: seasonal2__front {
  #   type: yesno
  #   sql: ${TABLE}.seasonal2.front ;;
  #   group_label: "Seasonal2"
  #   group_item_label: "Front"
  # }

  # dimension: seasonal2__is_extra {
  #   type: yesno
  #   sql: ${TABLE}.seasonal2.is_extra ;;
  #   group_label: "Seasonal2"
  #   group_item_label: "Is Extra"
  # }

  # dimension: seasonal2__publication_id {
  #   type: number
  #   sql: ${TABLE}.seasonal2.publication_id ;;
  #   group_label: "Seasonal2"
  #   group_item_label: "Publication ID"
  # }

  # dimension: seasonal2__publication_name {
  #   type: string
  #   sql: ${TABLE}.seasonal2.publication_name ;;
  #   group_label: "Seasonal2"
  #   group_item_label: "Publication Name"
  # }






















  # dimension: seasonal3__back {
  #   type: yesno
  #   sql: ${TABLE}.seasonal3.back ;;
  #   group_label: "Seasonal3"
  #   group_item_label: "Back"
  # }

  # dimension: seasonal3__front {
  #   type: yesno
  #   sql: ${TABLE}.seasonal3.front ;;
  #   group_label: "Seasonal3"
  #   group_item_label: "Front"
  # }

  # dimension: seasonal3__is_extra {
  #   type: yesno
  #   sql: ${TABLE}.seasonal3.is_extra ;;
  #   group_label: "Seasonal3"
  #   group_item_label: "Is Extra"
  # }

  # dimension: seasonal3__publication_id {
  #   type: number
  #   sql: ${TABLE}.seasonal3.publication_id ;;
  #   group_label: "Seasonal3"
  #   group_item_label: "Publication ID"
  # }

  # dimension: seasonal3__publication_name {
  #   type: string
  #   sql: ${TABLE}.seasonal3.publication_name ;;
  #   group_label: "Seasonal3"
  #   group_item_label: "Publication Name"
  # }


















  # dimension: seasonal4__back {
  #   type: yesno
  #   sql: ${TABLE}.seasonal4.back ;;
  #   group_label: "Seasonal4"
  #   group_item_label: "Back"
  # }

  # dimension: seasonal4__front {
  #   type: yesno
  #   sql: ${TABLE}.seasonal4.front ;;
  #   group_label: "Seasonal4"
  #   group_item_label: "Front"
  # }

  # dimension: seasonal4__is_extra {
  #   type: yesno
  #   sql: ${TABLE}.seasonal4.is_extra ;;
  #   group_label: "Seasonal4"
  #   group_item_label: "Is Extra"
  # }

  # dimension: seasonal4__publication_id {
  #   type: number
  #   sql: ${TABLE}.seasonal4.publication_id ;;
  #   group_label: "Seasonal4"
  #   group_item_label: "Publication ID"
  # }

  # dimension: seasonal4__publication_name {
  #   type: string
  #   sql: ${TABLE}.seasonal4.publication_name ;;
  #   group_label: "Seasonal4"
  #   group_item_label: "Publication Name"
  # }












  # dimension: seasonal5__back {
  #   type: yesno
  #   sql: ${TABLE}.seasonal5.back ;;
  #   group_label: "Seasonal5"
  #   group_item_label: "Back"
  # }

  # dimension: seasonal5__front {
  #   type: yesno
  #   sql: ${TABLE}.seasonal5.front ;;
  #   group_label: "Seasonal5"
  #   group_item_label: "Front"
  # }

  # dimension: seasonal5__is_extra {
  #   type: yesno
  #   sql: ${TABLE}.seasonal5.is_extra ;;
  #   group_label: "Seasonal5"
  #   group_item_label: "Is Extra"
  # }

  # dimension: seasonal5__publication_id {
  #   type: number
  #   sql: ${TABLE}.seasonal5.publication_id ;;
  #   group_label: "Seasonal5"
  #   group_item_label: "Publication ID"
  # }

  # dimension: seasonal5__publication_name {
  #   type: string
  #   sql: ${TABLE}.seasonal5.publication_name ;;
  #   group_label: "Seasonal5"
  #   group_item_label: "Publication Name"
  # }




  measure: total_sales {
    type: sum
    sql: ${sales} ;;
    view_label: "Sales"
    label: "Total Sales"
  }

  measure: total_margin_excl {
    type: sum
    sql: ${margin_excl} ;;
    view_label: "Sales"
    label: "Total Margin (Exc Funding)"
  }
  measure: total_margin_incl {
    type: sum
    sql: ${margin_incl} ;;
    view_label: "Sales"
    label: "Total Margin (Inc Funding)"
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
    view_label: "Sales"
    label: "Total Quantity"
  }


  measure: average_sales {
    type: average
    sql: ${sales} ;;
    view_label: "Sales"
    label: "Average Sales"
  }
  measure: average_margin_excl {
    type: average
    sql: ${margin_excl} ;;
    view_label: "Sales"
    label: "Average Margin (Exc Funding)"
  }
  measure: average_margin_incl {
    type: average
    sql: ${margin_incl} ;;
    view_label: "Sales"
    label: "Average Margin (Inc Funding)"
  }
  measure: average_quantity {
    type: average
    sql: ${quantity} ;;
    view_label: "Sales"
    label: "Average Quantity"
  }



  # ----- Sets of fields for drilling ------
  # set: detail {
  #   fields: [
  #     extra2__publication_name,
  #     extra3__publication_name,
  #     extra1__publication_name,
  #     catalogue__publication_name,
  #     seasonal3__publication_name,
  #     seasonal2__publication_name,
  #     seasonal5__publication_name,
  #     seasonal4__publication_name,
  #     seasonal1__publication_name
  #   ]
  # }
}
