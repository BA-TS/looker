view: product_dimensions {
  sql_table_name: `toolstation-data-storage.range.productDimensions`;;

  dimension: hazardous {
    type: string
    sql: ${TABLE}.hazardous ;;
  }

  dimension: item_type {
    type: string
    sql: ${TABLE}.itemType ;;
  }

  dimension: pack_description {
    type: string
    sql: ${TABLE}.packDescription ;;
  }

  dimension: pack_size_from_supplier {
    type: string
    sql: ${TABLE}.packSizeFromSupplier ;;
  }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  dimension: sell_pack_height_mm {
    group_label: "Dimensions"
    label: "Height"
    type: number
    sql: ${TABLE}.sellPackHeightMM ;;
  }

  dimension: sell_pack_length_mm {
    group_label: "Dimensions"
    label: "Length"
    type: number
    sql: ${TABLE}.sellPackLengthMM ;;
  }

  dimension: sell_pack_pack_size {
    group_label: "Dimensions"
    label: "Pack Size"
    type: number
    sql: ${TABLE}.sellPackPackSize ;;
  }

  dimension: sell_pack_weight_g {
    group_label: "Dimensions"
    label: "Weight"
    type: number
    sql: ${TABLE}.sellPackWeightG ;;
  }

  dimension: sell_pack_width_mm {
    group_label: "Dimensions"
    label: "Width"
    type: number
    sql: ${TABLE}.sellPackWidthMM ;;
  }

  # dimension: pallet_bwtr {
  #   type: string
  #   sql: ${TABLE}.palletBwtr ;;
  # }

  # dimension: pallet_dvty {
  #   type: string
  #   sql: ${TABLE}.palletDvty ;;
  # }

  # dimension: pallet_mdltn {
  #   type: string
  #   sql: ${TABLE}.palletMdltn ;;
  # }

  # dimension: pallet_rdtch {
  #   type: string
  #   sql: ${TABLE}.palletRdtch ;;
  # }

  # dimension: bin_bwtr {
  #   type: string
  #   sql: ${TABLE}.binBwtr ;;
  # }

  # dimension: bin_dvty {
  #   type: string
  #   sql: ${TABLE}.binDvty ;;
  # }

  # dimension: bin_mdltn {
  #   type: string
  #   sql: ${TABLE}.binMdltn ;;
  # }

  # dimension: bin_rdtch {
  #   type: string
  #   sql: ${TABLE}.binRdtch ;;
  # }

  # dimension: half_pallet_bwtr {
  #   type: string
  #   sql: ${TABLE}.halfPalletBwtr ;;
  # }

  # dimension: half_pallet_dvty {
  #   type: string
  #   sql: ${TABLE}.halfPalletDvty ;;
  # }

  # dimension: half_pallet_mdltn {
  #   type: string
  #   sql: ${TABLE}.halfPalletMdltn ;;
  # }

  # dimension: half_pallet_rdtch {
  #   type: string
  #   sql: ${TABLE}.halfPalletRdtch ;;
  # }
}
