include: "/views/**/*.view"
include: "/views/prod/department_specific/supply_chain/stockLocation.view.lkml"

explore: stock_level_date_site_product {
  required_access_grants: [can_use_supplier_information]

  label: "Stock Holding"
  description: "By Date, Site, Product"

  always_filter: {
    filters: [ stock_level_date_site_product.select_date_range: "7 days" ]
    #unless: [
     # closing_stock_date
      #]
  }

  sql_always_where:
  ${products.product_type} = "Real"
  AND
  ${sites.is_active} = TRUE
  AND
  ${scmatrix.is_active} = 1
  and
  ${products.isActive}

  ;;

  #and
  #${stocklocation.isPickable};;
  #AND UPPER(${sites.site_type}) NOT LIKE "%D%SHIP%"

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

  join: promoworking {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${products.product_code} = ${promoworking.Product_Code} ;;
  }

  join: sku_cover_dc_wrong_stock {
    view_label: "Wrong Stock"
    type: left_outer
    relationship: one_to_many
    sql_on: ${products.product_code} = ${sku_cover_dc_wrong_stock.productCode} ;;
  }

  join: stocklocation {
    view_label: "Stock Location"
    relationship: one_to_many
    type: left_outer
    sql_on:
    date(TIMESTAMP_SUB(${stock_level_date_site_product.opening_stock_date}, INTERVAL 1 SECOND)) = date(${stocklocation.closingStockDate_date})
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
