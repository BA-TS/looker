include: "/views/**/stock_level_date_site_product.view"
include: "/views/**/aac.view"
include: "/views/**/products.view"
include: "/views/**/scmatrix.view"
include: "/views/**/suppliers.view"
include: "/views/**/sites.view"
include: "/views/**/catPromo.view"
include: "/views/**/sku_cover_dc_wrong_stock.view"
include: "/views/**/stocklocation.view"

explore: stock_level_date_site_product {
  required_access_grants: [can_use_supplier_information]
  persist_with: ts_transactions_datagroup
  label: "Stock Holding"

  always_filter: {
    filters: [ stock_level_date_site_product.select_date_range: "yesterday" ]
    #unless: [closing_stock_date]
  }
    sql_always_where:
    ${products.product_type} = "Real"
    AND
    ${sites.is_active} = TRUE
    AND
    ${scmatrix.is_active} = 1
    and
    ${products.isActive}  ;;

    join: aac {
      type:  left_outer
      relationship: many_to_one
      sql_on: ${stock_level_date_site_product.opening_stock_date} = ${aac.date} and ${stock_level_date_site_product.product_uid} = ${aac.product_uid} ;;
    }

    join: products {
      type: inner
      relationship: many_to_one
      sql_on: ${stock_level_date_site_product.product_uid} = ${products.product_uid} ;;
    }

    join: scmatrix {
      type: left_outer
      relationship: one_to_one
      sql_on: ${products.product_code}  =   ${scmatrix.product_code};;
    }

    join: suppliers {
      view_label: "Supplier"
      type: left_outer
      relationship: many_to_one
      sql_on: ${products.default_supplier}=${suppliers.supplier_uid} ;;
    }

    join: sites {
      type: left_outer
      relationship: many_to_one
      sql_on: ${stock_level_date_site_product.site_uid} = ${sites.site_uid} ;;
    }

  join: catPromo {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${catPromo.Product_Code} ;;
  }

  join: sku_cover_dc_wrong_stock {
    view_label: "Wrong Stock"
    type: left_outer
    relationship: one_to_many
    sql_on: ${products.product_code} = ${sku_cover_dc_wrong_stock.productCode} ;;
  }

  join: stocklocation {
    view_label: "Sites"
    relationship: one_to_many
    type: left_outer
    sql_on:
    date(TIMESTAMP_SUB(${stock_level_date_site_product.opening_stock_raw}, INTERVAL 1 SECOND)) = date(${stocklocation.closingStockDate_date})
    and
    ${products.product_uid} = ${stocklocation.productUID}
    and ${sites.site_uid} = ${stocklocation.siteUID};;
  }

    # join: dc_to_shop_mapping {
    #   type: left_outer
    #   relationship: many_to_one
    #   sql_on: ${stock_level_date_site_product.site_uid} = ${dc_to_shop_mapping.site_uid} ;;
    # }

    # join: distribution_centre_names {
    #   type: left_outer
    #   relationship: many_to_one
    #   sql_on: ${dc_to_shop_mapping.distribution_centre_id} = ${distribution_centre_names.site_uid} ;;
    # }
  }
