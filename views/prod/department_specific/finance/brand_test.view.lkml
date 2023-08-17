view: brand_test {

    derived_table: {
      #parameter value specifies which of the rankings from the inner table to use
      explore_source: base {
        bind_all_filters: yes
        column: date {field: base.base_date_date}
        column: Brand { field: products.brand}
        column: net_sales { field: transactions.total_net_sales }
        column: number_customers { field: customers.number_of_customers }
        derived_column: ranking {
          sql: rank() over (order by Net_sales desc) ;;
        }
        derived_column: ranking_2 {
          sql: rank() over (order by Number_customers desc) ;;
        }

      }
    }

    dimension_group: date {
      type: time
      timeframes: [date,raw]
      sql: ${TABLE}.date ;;
    }

    dimension: Brand {
      primary_key: yes
      hidden: yes
      type: string
      sql: ${TABLE}.Brand ;;
    }

  dimension: net_sales {
    #hidden: yes
    type: number
    value_format_name: gbp
    sql: ${TABLE}.Net_sales ;;
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
      type: sum
      sql:
          CASE
            WHEN ${Brand} = {% parameter category_to_count %}
            THEN (${net_sales})
          END
        ;;
    }

    parameter: category_to_count {
      type: string
      suggest_dimension: Brand
    }
#### This parameter will allow a user to select a Top N ranking limit for bucketing the brands, almost like parameterizing the Row Limit in the UI

#### Top customer Segments for number of customers ##########


  }
