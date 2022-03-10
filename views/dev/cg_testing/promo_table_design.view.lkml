view: promo_table_design {

  sql_table_name: `toolstation-data-storage.tmp.promo_table_design`
    ;;

  dimension: catalogue_id {
    type: number
    sql: ${TABLE}.catalogue_id ;;
    value_format_name: id
  }


  filter: catalogue_cover {
    type: yesno
    sql: ${catalogue_promotion__cover__front} OR ${catalogue_promotion__cover__back} ;;
    view_label: "Catalogue"
    label: "On Cover?"
  }




  filter: catalogue_insert {
    type: yesno
    sql:

    ${catalogue_promotion__inserts__f1}
      OR
    ${catalogue_promotion__inserts__f2}
      OR
    ${catalogue_promotion__inserts__f3}
      OR
    ${catalogue_promotion__inserts__f4}
      OR
    ${catalogue_promotion__inserts__f5}
      OR
    ${catalogue_promotion__inserts__f6}
      OR
    ${catalogue_promotion__inserts__f7}
      OR
    ${catalogue_promotion__inserts__r1}
      OR
    ${catalogue_promotion__inserts__r2}
      OR
    ${catalogue_promotion__inserts__r3}
      OR
    ${catalogue_promotion__inserts__r4}
      OR
    ${catalogue_promotion__inserts__r5}
      OR
    ${catalogue_promotion__inserts__r6}
      OR
    ${catalogue_promotion__inserts__r7}

    ;;
    view_label: "Catalogue"
    label: "On Insert?"
  }

  filter: catalogue_roll_fold {
    type: yesno
    sql:

    ${catalogue_promotion__roll__ibcl}
      OR
    ${catalogue_promotion__roll__ibcr}
      OR
    ${catalogue_promotion__roll__ifcl}
      OR
    ${catalogue_promotion__roll__ifcr}
      OR
    ${catalogue_promotion__roll__rfil}
      OR
    ${catalogue_promotion__roll__rfir}

    ;;
    view_label: "Catalogue"
    label: "On Roll Fold?"
  }


  filter: catalogue_promotion__supplier_page {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.supplier_page = TRUE ;;
    view_label: "Catalogue"
    # group_label: "Catalogue Promotion"
    group_item_label: "On Supplier Page?"
  }

  filter: catalogue_promotion__on_page_offer {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.on_page_offer = TRUE ;;
    view_label: "Catalogue"
    # group_label: "Catalogue Promotion"
    group_item_label: "On Page Offer?"
  }



  filter: catalogue_extra {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.extra = TRUE ;;
    view_label: "Catalogue"
    # group_label: "Catalogue Promotion"
    group_item_label: "On Extra?"
  }

  filter: catalogue_hotspot {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.hotspot = TRUE ;;
    view_label: "Catalogue"
    # group_label: "Catalogue Promotion"
    group_item_label: "On Hotspot?"
  }


  filter: catalogue_promotion__landing_page {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.landing_page = TRUE ;;
    view_label: "Catalogue"
    # group_label: "Catalogue Promotion"
    group_item_label: "On Landing Page?"
  }


  dimension: catalogue_promotion__cover__back {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.cover.back ;;
    view_label: "Catalogue"
    group_label: "Cover Page and Roll Fold"
    group_item_label: "Back"
  }

  dimension: catalogue_promotion__cover__front {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.cover.front ;;
    view_label: "Catalogue"
    group_label: "Cover Page and Roll Fold"
    group_item_label: "Front"
  }

  dimension: catalogue_promotion__location_description {
    type: string
    sql: ${TABLE}.catalogue_promotion.location_description ;;
    view_label: "Catalogue"
    label: "Location Description"
  }

  dimension: catalogue_promotion__inserts__f1 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.f1 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "F1"
  }

  dimension: catalogue_promotion__inserts__f2 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.f2 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "F2"
  }

  dimension: catalogue_promotion__inserts__f3 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.f3 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "F3"
  }

  dimension: catalogue_promotion__inserts__f4 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.f4 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "F4"
  }

  dimension: catalogue_promotion__inserts__f5 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.f5 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "F5"
  }

  dimension: catalogue_promotion__inserts__f6 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.f6 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "F6"
  }

  dimension: catalogue_promotion__inserts__f7 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.f7 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "F7"
  }

  dimension: catalogue_promotion__inserts__r1 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.r1 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "R1"
  }

  dimension: catalogue_promotion__inserts__r2 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.r2 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "R2"
  }

  dimension: catalogue_promotion__inserts__r3 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.r3 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "R3"
  }

  dimension: catalogue_promotion__inserts__r4 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.r4 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "R4"
  }

  dimension: catalogue_promotion__inserts__r5 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.r5 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "R5"
  }

  dimension: catalogue_promotion__inserts__r6 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.r6 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "R6"
  }

  dimension: catalogue_promotion__inserts__r7 {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.inserts.r7 ;;
    view_label: "Catalogue"
    group_label: "Insert(s)"
    group_item_label: "R7"
  }

  dimension: catalogue_promotion__roll__ibcl {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.roll.ibcl ;;
    view_label: "Catalogue"
    group_label: "Cover Page and Roll Fold"
    group_item_label: "IBCL"
  }

  dimension: catalogue_promotion__roll__ibcr {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.roll.ibcr ;;
    view_label: "Catalogue"
    group_label: "Cover Page and Roll Fold"
    group_item_label: "IBCR"
  }

  dimension: catalogue_promotion__roll__ifcl {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.roll.ifcl ;;
    view_label: "Catalogue"
    group_label: "Cover Page and Roll Fold"
    group_item_label: "IFCL"
  }

  dimension: catalogue_promotion__roll__ifcr {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.roll.ifcr ;;
    view_label: "Catalogue"
    group_label: "Cover Page and Roll Fold"
    group_item_label: "IFCR"
  }

  dimension: catalogue_promotion__roll__rfil {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.roll.rfil ;;
    view_label: "Catalogue"
    group_label: "Cover Page and Roll Fold"
    group_item_label: "RFIL"
  }

  dimension: catalogue_promotion__roll__rfir {
    type: yesno
    sql: ${TABLE}.catalogue_promotion.roll.rfir ;;
    view_label: "Catalogue"
    group_label: "Cover Page and Roll Fold"
    group_item_label: "RFIR"
  }










  dimension: extra1_publication__cover__back {
    type: yesno
    sql: ${TABLE}.extra1_publication.cover.back ;;
    group_label: "Extra1 Publication Cover"
    group_item_label: "Back"
  }

  dimension: extra1_publication__cover__front {
    type: yesno
    sql: ${TABLE}.extra1_publication.cover.front ;;
    group_label: "Extra1 Publication Cover"
    group_item_label: "Front"
  }

  dimension: extra1_publication__extra {
    type: yesno
    sql: ${TABLE}.extra1_publication.extra ;;
    group_label: "Extra1 Publication"
    group_item_label: "Extra"
  }

  dimension: extra1_publication__extra_id {
    type: number
    sql: ${TABLE}.extra1_publication.extraID ;;
    group_label: "Extra1 Publication"
    group_item_label: "Extra ID"
  }

  dimension: extra2_publication__cover__back {
    type: yesno
    sql: ${TABLE}.extra2_publication.cover.back ;;
    group_label: "Extra2 Publication Cover"
    group_item_label: "Back"
  }

  dimension: extra2_publication__cover__front {
    type: yesno
    sql: ${TABLE}.extra2_publication.cover.front ;;
    group_label: "Extra2 Publication Cover"
    group_item_label: "Front"
  }

  dimension: extra2_publication__extra {
    type: yesno
    sql: ${TABLE}.extra2_publication.extra ;;
    group_label: "Extra2 Publication"
    group_item_label: "Extra"
  }

  dimension: extra2_publication__extra_id {
    type: number
    sql: ${TABLE}.extra2_publication.extraID ;;
    group_label: "Extra2 Publication"
    group_item_label: "Extra ID"
  }

  dimension: extra3_publication__cover__back {
    type: yesno
    sql: ${TABLE}.extra3_publication.cover.back ;;
    group_label: "Extra3 Publication Cover"
    group_item_label: "Back"
  }

  dimension: extra3_publication__cover__front {
    type: yesno
    sql: ${TABLE}.extra3_publication.cover.front ;;
    group_label: "Extra3 Publication Cover"
    group_item_label: "Front"
  }

  dimension: extra3_publication__extra {
    type: yesno
    sql: ${TABLE}.extra3_publication.extra ;;
    group_label: "Extra3 Publication"
    group_item_label: "Extra"
  }

  dimension: extra3_publication__extra_id {
    type: number
    sql: ${TABLE}.extra3_publication.extraID ;;
    group_label: "Extra3 Publication"
    group_item_label: "Extra ID"
  }

  dimension: financial__bogof {
    type: yesno
    sql: ${TABLE}.financial.bogof ;;
    group_label: "Financial"
    group_item_label: "Bogof"
  }

  dimension: financial__bogop {
    type: number
    sql: ${TABLE}.financial.bogop ;;
    group_label: "Financial"
    group_item_label: "Bogop"
  }

  dimension: financial__bundled_price {
    type: number
    sql: ${TABLE}.financial.bundled_price ;;
    group_label: "Financial"
    group_item_label: "Bundled Price"
  }

  # # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # # measures for this dimension, but you can also add measures of many different aggregates.
  # # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_financial__bundled_price {
  #   type: sum
  #   sql: ${financial__bundled_price} ;;
  # }

  # measure: average_financial__bundled_price {
  #   type: average
  #   sql: ${financial__bundled_price} ;;
  # }

  # dimension: financial__cost_price {
  #   type: number
  #   sql: ${TABLE}.financial.cost_price ;;
  #   group_label: "Financial"
  #   group_item_label: "Cost Price"
  # }

  # dimension: financial__multibuy_price {
  #   type: number
  #   sql: ${TABLE}.financial.multibuy_price ;;
  #   group_label: "Financial"
  #   group_item_label: "Multibuy Price"
  # }

  # dimension: financial__promo_price {
  #   type: number
  #   sql: ${TABLE}.financial.promo_price ;;
  #   group_label: "Financial"
  #   group_item_label: "Promo Price"
  # }

  # dimension: financial__regular_price {
  #   type: number
  #   sql: ${TABLE}.financial.regular_price ;;
  #   group_label: "Financial"
  #   group_item_label: "Regular Price"
  # }

  # dimension: financial__vat_rate {
  #   type: number
  #   sql: ${TABLE}.financial.vat_rate ;;
  #   group_label: "Financial"
  #   group_item_label: "Vat Rate"
  # }

  # dimension: funding__lump {
  #   type: number
  #   sql: ${TABLE}.funding.lump ;;
  #   group_label: "Funding"
  #   group_item_label: "Lump"
  # }

  # dimension: funding__unit {
  #   type: number
  #   sql: ${TABLE}.funding.unit ;;
  #   group_label: "Funding"
  #   group_item_label: "Unit"
  # }

  # # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  # dimension_group: inputted_by__completed {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.inputted_by.completed_at ;;
  # }

  # dimension: inputted_by__completed_by {
  #   type: string
  #   sql: ${TABLE}.inputted_by.completed_by ;;
  #   group_label: "Inputted By"
  #   group_item_label: "Completed By"
  # }

  dimension: offer__comments {
    type: string
    sql: ${TABLE}.offer.comments ;;
    group_label: "Offer"
    group_item_label: "Comments"
  }

  dimension: offer__message {
    type: string
    sql: ${TABLE}.offer.message ;;
    group_label: "Offer"
    group_item_label: "Message"
  }

  dimension: offer__relates_to {
    type: string
    sql: ${TABLE}.offer.relates_to ;;
    group_label: "Offer"
    group_item_label: "Relates To"
  }

  dimension: offer__type {
    type: string
    sql: ${TABLE}.offer.type ;;
    group_label: "Offer"
    group_item_label: "Type"
  }

  dimension: seasonal1_publication__cover__back {
    type: yesno
    sql: ${TABLE}.seasonal1_publication.cover.back ;;
    group_label: "Seasonal1 Publication Cover"
    group_item_label: "Back"
  }

  dimension: seasonal1_publication__cover__front {
    type: yesno
    sql: ${TABLE}.seasonal1_publication.cover.front ;;
    group_label: "Seasonal1 Publication Cover"
    group_item_label: "Front"
  }

  dimension: seasonal1_publication__extra {
    type: yesno
    sql: ${TABLE}.seasonal1_publication.extra ;;
    group_label: "Seasonal1 Publication"
    group_item_label: "Extra"
  }

  dimension: seasonal1_publication__extra_id {
    type: number
    sql: ${TABLE}.seasonal1_publication.extraID ;;
    group_label: "Seasonal1 Publication"
    group_item_label: "Extra ID"
  }

  dimension: seasonal2_publication__cover__back {
    type: yesno
    sql: ${TABLE}.seasonal2_publication.cover.back ;;
    group_label: "Seasonal2 Publication Cover"
    group_item_label: "Back"
  }

  dimension: seasonal2_publication__cover__front {
    type: yesno
    sql: ${TABLE}.seasonal2_publication.cover.front ;;
    group_label: "Seasonal2 Publication Cover"
    group_item_label: "Front"
  }

  dimension: seasonal2_publication__extra {
    type: yesno
    sql: ${TABLE}.seasonal2_publication.extra ;;
    group_label: "Seasonal2 Publication"
    group_item_label: "Extra"
  }

  dimension: seasonal2_publication__extra_id {
    type: number
    sql: ${TABLE}.seasonal2_publication.extraID ;;
    group_label: "Seasonal2 Publication"
    group_item_label: "Extra ID"
  }

  dimension: seasonal3_publication__cover__back {
    type: yesno
    sql: ${TABLE}.seasonal3_publication.cover.back ;;
    group_label: "Seasonal3 Publication Cover"
    group_item_label: "Back"
  }

  dimension: seasonal3_publication__cover__front {
    type: yesno
    sql: ${TABLE}.seasonal3_publication.cover.front ;;
    group_label: "Seasonal3 Publication Cover"
    group_item_label: "Front"
  }

  dimension: seasonal3_publication__extra {
    type: yesno
    sql: ${TABLE}.seasonal3_publication.extra ;;
    group_label: "Seasonal3 Publication"
    group_item_label: "Extra"
  }

  dimension: seasonal3_publication__extra_id {
    type: number
    sql: ${TABLE}.seasonal3_publication.extraID ;;
    group_label: "Seasonal3 Publication"
    group_item_label: "Extra ID"
  }

  dimension: seasonal4_publication__cover__back {
    type: yesno
    sql: ${TABLE}.seasonal4_publication.cover.back ;;
    group_label: "Seasonal4 Publication Cover"
    group_item_label: "Back"
  }

  dimension: seasonal4_publication__cover__front {
    type: yesno
    sql: ${TABLE}.seasonal4_publication.cover.front ;;
    group_label: "Seasonal4 Publication Cover"
    group_item_label: "Front"
  }

  dimension: seasonal4_publication__extra {
    type: yesno
    sql: ${TABLE}.seasonal4_publication.extra ;;
    group_label: "Seasonal4 Publication"
    group_item_label: "Extra"
  }

  dimension: seasonal4_publication__extra_id {
    type: number
    sql: ${TABLE}.seasonal4_publication.extraID ;;
    group_label: "Seasonal4 Publication"
    group_item_label: "Extra ID"
  }

  dimension: seasonal5_publication__cover__back {
    type: yesno
    sql: ${TABLE}.seasonal5_publication.cover.back ;;
    group_label: "Seasonal5 Publication Cover"
    group_item_label: "Back"
  }

  dimension: seasonal5_publication__cover__front {
    type: yesno
    sql: ${TABLE}.seasonal5_publication.cover.front ;;
    group_label: "Seasonal5 Publication Cover"
    group_item_label: "Front"
  }

  dimension: seasonal5_publication__extra {
    type: yesno
    sql: ${TABLE}.seasonal5_publication.extra ;;
    group_label: "Seasonal5 Publication"
    group_item_label: "Extra"
  }

  dimension: seasonal5_publication__extra_id {
    type: number
    sql: ${TABLE}.seasonal5_publication.extraID ;;
    group_label: "Seasonal5 Publication"
    group_item_label: "Extra ID"
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
    value_format_name: id
  }

  # dimension: verified__financial {
  #   type: yesno
  #   sql: ${TABLE}.verified.financial ;;
  #   group_label: "Verified"
  #   group_item_label: "Financial"
  # }

  # dimension: verified__promotion {
  #   type: yesno
  #   sql: ${TABLE}.verified.promotion ;;
  #   group_label: "Verified"
  #   group_item_label: "Promotion"
  # }

  # dimension: verified__publication {
  #   type: yesno
  #   sql: ${TABLE}.verified.publication ;;
  #   group_label: "Verified"
  #   group_item_label: "Publication"
  # }

  # dimension: verified__sku {
  #   type: yesno
  #   sql: ${TABLE}.verified.sku ;;
  #   group_label: "Verified"
  #   group_item_label: "SKU"
  # }

  # dimension: verified__unique {
  #   type: yesno
  #   sql: ${TABLE}.verified.unique ;;
  #   group_label: "Verified"
  #   group_item_label: "Unique"
  # }

  # dimension: weekly_forecast__bogof {
  #   type: number
  #   sql: ${TABLE}.weekly_forecast.bogof ;;
  #   group_label: "Weekly Forecast"
  #   group_item_label: "Bogof"
  # }

  # dimension: weekly_forecast__bogop {
  #   type: number
  #   sql: ${TABLE}.weekly_forecast.bogop ;;
  #   group_label: "Weekly Forecast"
  #   group_item_label: "Bogop"
  # }

  # dimension: weekly_forecast__bundled {
  #   type: number
  #   sql: ${TABLE}.weekly_forecast.bundled ;;
  #   group_label: "Weekly Forecast"
  #   group_item_label: "Bundled"
  # }

  # dimension: weekly_forecast__multibuy {
  #   type: number
  #   sql: ${TABLE}.weekly_forecast.multibuy ;;
  #   group_label: "Weekly Forecast"
  #   group_item_label: "Multibuy"
  # }

  # dimension: weekly_forecast__promo {
  #   type: number
  #   sql: ${TABLE}.weekly_forecast.promo ;;
  #   group_label: "Weekly Forecast"
  #   group_item_label: "Promo"
  # }

  # dimension: weekly_forecast__regular {
  #   type: number
  #   sql: ${TABLE}.weekly_forecast.regular ;;
  #   group_label: "Weekly Forecast"
  #   group_item_label: "Regular"
  # }

  # measure: count {
  #   type: count
  #   drill_fields: []
  # }
}
