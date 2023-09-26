view: customer_spending {

    derived_table: {
      #parameter value specifies which of the rankings from the inner table to use
      explore_source: base {
        bind_all_filters: yes
        column: net_sales { field: transactions.total_net_sales }
        column: customer_uid { field: customers.customer_uid }
      }
    }

    dimension: customer_uid {
      primary_key: yes
      hidden: yes
      type: string
      sql: ${TABLE}.customer_uid ;;
    }

    dimension: net_sales {
      hidden: yes
      type: number
      sql: sum(${TABLE}.net_sales) ;;
    }

    dimension: customer_rank {
      hidden: yes
      type: string
      sql: ${TABLE}.ranking_2 ;;
    }

  dimension: customer_sales {
    hidden: yes
    type: string
    sql: case when ${net_sales} < 49.99 then "Less_than_50"
          when ${net_sales} >= 50 and ${net_sales} < 99.99 then "between_50_100"
          when ${net_sales} >= 100 and ${net_sales} < 149.99 then "between_100_150"
          when ${net_sales} >= 150 and ${net_sales} < 249.99 then "between_150_250"
          when ${net_sales} >= 250 and ${net_sales} < 499.99 then "between_250_500"
          when ${net_sales} >= 500 and ${net_sales} < 999.99 then "between_500_1000"
          when ${net_sales} >= 1000 then "over_1000"
        end ;;
  }
#### This parameter will allow a user to select a Top N ranking limit for bucketing the brands, almost like parameterizing the Row Limit in the UI

#### Top customer Segments for number of customers ##########


    parameter: top_rank_limit_2 {
      label: "Top N Customer Segments by Customers Filter"
      type: unquoted
      default_value: "5"
      allowed_value: {
        label: "< £50"
        value: "Less_than_50"
      }
      allowed_value: {
        label: ">£50 and <£100"
        value: "between_50_100"
      }
      allowed_value: {
        label: ">£100 and <£150"
        value: "between_100_150"
      }
      allowed_value: {
        label: ">£150 and <£250"
        value: "between_150_250"
      }
      allowed_value: {
        label: ">£250 and <£500"
        value: "between_250_500"
      }
      allowed_value: {
        label: ">£500 and <£1000"
        value: "between_500_1000"
      }

      allowed_value: {
        label: ">£1000"
        value: "over_1000"
      }
    }

    dimension: brand_rank_top_brands_bigquery_2 {
      hidden: yes
      label_from_parameter: top_rank_limit_2
      type: string
      sql:
      CASE
        WHEN ${customer_sales}="{% parameter top_rank_limit_2 %}"
          THEN ${customer_uid}
        ELSE "Other"
      END
    ;;
    }

  }
