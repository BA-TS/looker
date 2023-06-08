include: "/explores/**/sales/single_line_transactions.explore.lkml"

view: attached_products_derived {
  derived_table: {
    explore_source: single_line_transactions {
      column: product_code { field: products.product_code }
      column: description { field: products.description }
      column: number_of_transactions { field: transactions.number_of_transactions }
      column: filter_match  { field: attached_products.filter_match  }
      column: attached_count  { field: attached_products.attached_count  }
      column: product_code_attached { field: attached_products.product_code_attached }
      column: product_description_attached { field: attached_products.product_description_attached }
      derived_column: attached_product_rank {
        sql: RANK () OVER (PARTITION BY product_code ORDER BY number_of_transactions DESC) ;;
      }

     filters: {
        field: base.select_date_type
        value: "Calendar"
      }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "84 days"
      }
      filters: {
        field: attached_products.product_code_attached
        value: "-0%"
      }
      filters: {
        field: attached_products.filter_match
        value: "No"
      }
    }
  }

  dimension: attached_product_rank {
    type: number
  }

  dimension: product_code {
  }

  dimension: description {
  }

  dimension: number_of_transactions {
    description: "Number of orders"
    value_format: "#,##0;(#,##0)"
    type: number
  }

  dimension: product_code_attached {
  }

  dimension: product_description_attached {
  }

  dimension: filter_match {
  }

  dimension: attached_count  {
  }
}
