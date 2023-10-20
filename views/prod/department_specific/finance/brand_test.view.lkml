view: brand_test {

    derived_table: {
      #parameter value specifies which of the rankings from the inner table to use
      explore_source: base {
        bind_all_filters: yes
        column: date {field: base.base_date_date}
        column: Brand2 { field: products.brand}
        column: product_code { field: products.product_code}
        column: net_sales { field: transactions.total_net_sales }
        column: units { field: transactions.total_units }
        column: margin_inc_funding { field: transactions.total_margin_incl_funding }
        column: rate_margin_inc_funding { field: transactions.total_margin_rate_incl_funding }
        column: number_customers { field: customers.number_of_customers }
        column: customer_uid {field:customers.customer_uid}
        derived_column: ranking {
          sql: rank() over (order by Net_sales desc) ;;
        }
        derived_column: ranking_2 {
          sql: rank() over (order by Number_customers desc) ;;
        }
        derived_column: P_K {
          sql: row_number() over () ;;
        }

        derived_column: Brand {
          sql: case when Brand2 is null then "Unknown" else Brand2 end ;;
        }

      }
    }

    dimension_group: date {
      type: time
      hidden: yes
      timeframes: [date,raw]
      sql: ${TABLE}.date ;;
    }

    dimension: P_K {
      hidden: yes
      primary_key: yes
      sql: ${TABLE}.P_K ;;
    }

    dimension: Brand {
      hidden: yes
      type: string
      sql: ${TABLE}.Brand ;;
    }

  dimension: productCode {
    hidden: yes
    type: string
    sql: ${TABLE}.product_code ;;
  }

  dimension: customer_uid {
    hidden: yes
    type: string
    sql: ${TABLE}.customer_uid ;;
  }

  dimension: net_sales {
    hidden: yes
    type: number
    value_format_name: gbp
    sql: ${TABLE}.Net_sales ;;
  }

  dimension: units {
    hidden: yes
    type: number
    sql: ${TABLE}.units ;;
  }

  dimension: margin_inc_funding {
    hidden: yes
    type: number
    value_format_name: gbp
    sql: ${TABLE}.margin_inc_funding ;;
  }

  dimension: rate_margin_inc_funding {
    hidden: yes
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.rate_margin_inc_funding ;;
  }


    dimension: sales_rank {
      hidden: yes
      type: string
      sql: ${TABLE}.ranking ;;
    }

    dimension: customer_rank {
      hidden: yes
      type: string
      sql: ${TABLE}.ranking_2 ;;
    }

    measure: sum2 {
      label: "Net Sales of Brand"
      group_label: "Brand Selected"
      description: "Net sales of the brand selected by Brand Filter"
      type: sum
      value_format_name: gbp
      sql:
          CASE
            WHEN ${Brand} = {% parameter category_to_count %}
            THEN (${net_sales})
          END
        ;;
    }

  measure: sum3 {
    label: "Net Sales of Other Brand"
    group_label: "Other Brands"
    description: "Net sales of the brands not included in Brand Filter"
    type: sum
    value_format_name: gbp
    sql:
          CASE
            WHEN ${Brand} != {% parameter category_to_count %}
            THEN (${net_sales})
          END
        ;;
  }

  measure: all_net_sales {
    label: "Overall Net Sales"
    group_label: "Overall"
    description: "total Net sales"
    hidden: yes
    type: sum
    value_format_name: gbp
    sql:${net_sales}
        ;;
  }

  measure: sum4 {
    label: "Units of Brand"
    group_label: "Brand Selected"
    description: "Total Units sold of the brand selected by Brand Filter"
    type: sum
    sql:
          CASE
            WHEN ${Brand} = {% parameter category_to_count %}
            THEN (${units})
          END
        ;;
  }

  measure: sum5 {
    label: "Units of Other Brand"
    group_label: "Other Brands"
    description: "Total Units sold of brands not included in Brand Filter"
    type: sum
    sql:
          CASE
            WHEN ${Brand} != {% parameter category_to_count %}
            THEN (${units})
          END
        ;;
  }

  measure: all_units {
    label: "Overall Units"
    group_label: "Overall"
    hidden: yes
    type: sum
    sql: ${units} ;;
  }

  measure: sum6 {
    label: "Margin (inc fund) of Brand"
    group_label: "Brand Selected"
    description: "Margin(inc fund) of the brand selected by Brand Filter"
    type: sum
    value_format_name: gbp
    sql:
          CASE
            WHEN ${Brand} = {% parameter category_to_count %}
            THEN (${margin_inc_funding})
          END
        ;;
  }

  measure: sum7 {
    label: "Margin (inc fund) of Other Brand"
    group_label: "Other Brands"
    description: "Margin(inc fund) of other brands not included in Brand Filter"
    type: sum
    value_format_name: gbp
    sql:
          CASE
            WHEN ${Brand} != {% parameter category_to_count %}
            THEN (${margin_inc_funding})
          END
        ;;
  }

  measure: overall_margin_funding {
    label: "Overall Margin (inc fund)"
    group_label: "Overall"
    hidden: yes
    type: sum
    value_format_name: gbp
    sql:${margin_inc_funding}
        ;;
  }

  measure: sum8 {
    label: "Margin rate (inc fund) of Brand"
    group_label: "Brand Selected"
    description: "Margin Rate(inc fund) of the brand selected by Brand Filter"
    type: average
    value_format_name: percent_2
    sql:
          CASE
            WHEN ${Brand} = {% parameter category_to_count %}
            THEN (${rate_margin_inc_funding})
          END
        ;;
  }

  measure: sum9 {
    label: "Margin rate (inc fund) of Other Brand"
    group_label: "Other Brands"
    description: "Margin rate (inc fund) of other brands not included in Brand Filter"
    type: average
    value_format_name: percent_2
    sql:
          CASE
            WHEN ${Brand} != {% parameter category_to_count %}
            THEN (${rate_margin_inc_funding})
          END
        ;;
  }

  measure: sum10 {
    label: "Overall Margin rate (inc fund)"
    group_label: "Overall"
    hidden: yes
    type: average
    value_format_name: percent_2
    sql:${rate_margin_inc_funding}
    ;;
  }

    parameter: category_to_count {
      label: "Brand"
      type: string
      suggest_dimension: Brand
    }
#### This parameter will allow a user to select a Top N ranking limit for bucketing the brands, almost like parameterizing the Row Limit in the UI

#### Top customer Segments for number of customers ##########


  }
