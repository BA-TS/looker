view: product_dimensions {
  sql_table_name: `toolstation-data-storage.range.productDimensions`;;

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: hazardous {
    group_label: "Product Dimensions"
    type: string
    sql: ${TABLE}.hazardous ;;
    hidden: yes
  }

  dimension: item_type {
    group_label: "Dimensions"
    type: string
    sql: ${TABLE}.itemType ;;
  }

  dimension: pack_description {
    group_label: "Dimensions"
    type: string
    sql: ${TABLE}.packDescription ;;
  }

  dimension: pack_size_from_supplier {
    group_label: "Dimensions"
    type: string
    sql: ${TABLE}.packSizeFromSupplier ;;
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
    required_access_grants: [lz_only]
    group_label: "Dimensions"
    label: "Pack Weight (kg)"
    type: number
    sql: cast(${TABLE}.sellPackWeightG as decimal)/1000 ;;
    value_format_name: decimal_1
  }

  dimension: sell_pack_weight_tier {
    required_access_grants: [lz_only]
    group_label: "Dimensions"
    label: "Pack Weight (kg) - Tiers"
    type: tier
    style: integer
    tiers: [0,20,25,30]
    sql: ${sell_pack_weight_g}/1000 ;;
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
