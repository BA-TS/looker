view: top_trade_types_customers {

  derived_table: {
    #parameter value specifies which of the rankings from the inner table to use
    explore_source: base {
      bind_all_filters: yes
      column: Trade_type { field: trade_customers.trade_type}
      column: Net_sales { field: transactions.total_net_sales }
      column: Number_customers { field: customers.number_of_customers }
      derived_column: ranking {
        sql: rank() over (order by Net_sales desc) ;;
      }
      derived_column: ranking_2 {
        sql: rank() over (order by Number_customers desc) ;;
      }
    }
  }

  dimension: Trade_type {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.Trade_type ;;
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
#### This parameter will allow a user to select a Top N ranking limit for bucketing the brands, almost like parameterizing the Row Limit in the UI

#### Top customer Segments for number of customers ##########


  parameter: top_rank_limit_4 {
    label: "Top N Trade Type Sales"
    type: unquoted
    default_value: "5"
    allowed_value: {
      label: "Top 5"
      value: "5"
    }
    allowed_value: {
      label: "Top 10"
      value: "10"
    }
    allowed_value: {
      label: "Top 20"
      value: "20"
    }
    allowed_value: {
      label: "Top 50"
      value: "50"
    }
  }

  dimension: brand_rank_top_brands_bigquery_4 {
    hidden: yes
    label_from_parameter: top_rank_limit_4
    type: string
    sql:
      CASE
        WHEN ${customer_rank}<={% parameter top_rank_limit_4 %}
          THEN
            CASE
              WHEN ${customer_rank}<10 THEN  CONCAT('0', CAST(${customer_rank} AS STRING))
              ELSE CAST(${customer_rank} AS STRING)
            END
        ELSE "Other"
      END
    ;;
  }

}
