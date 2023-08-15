view: stock_cover {
  derived_table: {
    sql:
      SELECT distinct
      row_number() over () as P_K,
      timestamp(date) as date,
      productCode,
      type,
      weeklyUnits,
      stockUnits,
      cover8,
      cover16,
      cover32,
      cover52,
      coverOver52
      FROM
      `toolstation-data-storage.looker_persistent_tables.stock_cover` ;;
    }

  dimension: P_K {
    description: "Primary key"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K ;;
  }

  filter: date_filter {
      label: "Date - Select 1 Day ON LY"
      description: "Date refers to the relevant stock cover based on the prescribed date. Limited to 90 days."
      type: date
      datatype: date
      convert_tz: yes
  }

  dimension_group: stock_date  {
    description: "date"
    type: time
    timeframes: [
      raw,
      time,
      date,
      month_num
    ]
    sql: ${TABLE}.date ;;
  }

    dimension: product_code {
      description: "FK for products view"
      type: string
      sql: ${TABLE}.productCode ;;
    }

    dimension: site_location_type {
      description: "Redditch, Middleton and Daventry are DC, Bridgwater is separate. Stores contains all stores excluding the DCs."
      type: string
      sql: ${TABLE}.type ;;
    }

    dimension: average_weekly_units {
      type: number
      sql: ${TABLE}.weeklyUnits ;;
      hidden: yes
    }

    dimension: stock_level {
      type: number
      sql: ${TABLE}.stockUnits ;;
    }

    dimension: stock_cover_8 {
      type: number
      sql: ${TABLE}.cover8 ;;
    }

    dimension: stock_cover_16 {
      type: number
      sql: ${TABLE}.cover16 ;;
      hidden: yes
    }

    dimension: stock_cover_32 {
      type: number
      sql: ${TABLE}.cover32 ;;
      hidden: yes
    }

    dimension: stock_cover_52 {
      type: number
      sql: ${TABLE}.cover52 ;;
      hidden: yes
    }

    dimension: aac_averagePrice {
      type: number
      value_format_name: gbp
      sql: ${aac.average_cost_price} ;;
    }

    dimension: stock_cover_over_52 {
      type: number
      sql: ${TABLE}.coverOver52 ;;
      hidden: yes
    }

    measure: total_average_weekly_units {
      label: "Average Weekly Units"
      type: sum
      sql: ${average_weekly_units} ;;
      value_format_name: decimal_0
    }

    measure: total_stock_level {
      label: "Stock Level"
      type: sum
      sql: ${stock_level} ;;
      value_format_name: decimal_0
    }

  measure: total_stock_value {
    label: "Stock Level Value"
    type: sum
    sql: ${stock_level}*${aac_averagePrice} ;;
    value_format_name: gbp
  }

    measure: total_cover_8 {
      label: "Cover <8"
      type: sum
      sql: ${stock_cover_8} ;;
      value_format_name: decimal_0
    }

  measure: total_cover_value_8 {
    label: "Cover <8 value"
    type: sum
    sql: ${stock_cover_8}*${aac_averagePrice} ;;
    value_format_name: gbp
  }

    measure: total_cover_16 {
      label: "Cover 8-16"
      type: sum
      sql: ${stock_cover_16} ;;
      value_format_name: decimal_0
    }

  measure: total_cover_value_16 {
    label: "Cover 8-16 value"
    type: sum
    sql: ${stock_cover_16}*${aac_averagePrice} ;;
    value_format_name: gbp
  }

    measure: total_cover_32 {
      label: "Cover 16-32"
      type: sum
      sql: ${stock_cover_32} ;;
      value_format_name: decimal_0
    }

  measure: total_cover_value_32 {
    label: "Cover 16-32 value"
    type: sum
    sql: ${stock_cover_32}*${aac_averagePrice} ;;
    value_format_name: gbp
  }

    measure: total_cover_52 {
      label: "Cover 32-52"
      type: sum
      sql: ${stock_cover_52} ;;
      value_format_name: decimal_0
    }

  measure: total_cover_value_52 {
    label: "Cover 32-52 value"
    type: sum
    sql: ${stock_cover_52}*${aac_averagePrice} ;;
    value_format_name: gbp
  }

    measure: total_cover_over_52 {
      label: "Cover 52+"
      type: sum
      sql: ${stock_cover_over_52} ;;
      value_format_name: decimal_0
    }

  measure: total_cover_value_over_52 {
    label: "Cover 52+ value"
    type: sum
    sql: ${stock_cover_over_52}*${aac_averagePrice} ;;
    value_format_name: gbp
  }

  }
