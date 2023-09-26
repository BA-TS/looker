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
      sql: ${TABLE}.net_sales ;;
    }

    dimension: customer_rank {
      hidden: yes
      type: string
      sql: ${TABLE}.ranking_2 ;;
    }

  dimension: customer_sales {
    hidden: yes
    type: string
    sql: case when ${net_sales} < 50 then "Less_than_50"
         case when 50 <= ${net_sales} < 100 then "between_50_100"
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
        label: ">50 and <100"
        value: "between_50_100"
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
