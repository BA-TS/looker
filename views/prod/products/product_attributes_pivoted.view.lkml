view: product_attributes_pivoted {
  derived_table: {
    sql:
        with base as (
              select productUID,attribute,attributeValue from `toolstation-data-storage.range.productAttributes`
              where attribute  = "UN transport number"
        ),

        base2 as (
              select productUID,attribute,attributeValue from `toolstation-data-storage.range.productAttributes`
              where attribute  = "Safety Data Sheet"
        ),

        base3 as (
              select productUID,attribute,attributeValue from `toolstation-data-storage.range.productAttributes`
              where attribute  = "Hazardous"
        ),

        base4 as (
              select productUID,attribute,attributeValue from `toolstation-data-storage.range.productAttributes`
              where attribute  = "Hazard code"
        )

              select distinct
              coalesce(
                    a.productUID,b.productUID,c.productUID,d.productUID) as productUID,
              a.attributeValue as UN_transport_number,
              b.attributeValue as safety_data_sheet,
              c.attributeValue as hazardous,
              d.attributeValue as hazard_code,
              from base a
              full join base2 b using(productUID)
              full join base3 c using(productUID)
              full join base4 d using(productUID)
      ;;
    datagroup_trigger: ts_transactions_datagroup
  }


  dimension: product_uid {
    label: "Product UID TEST"
    primary_key:  yes
    type: string
    sql: ${TABLE}.productUID ;;
    # hidden: yes
    required_access_grants: [lz_only]
  }

  dimension: UN_transport_number {
    label: "UN Transport Number"
    type: string
    sql: ${TABLE}.UN_transport_number ;;
  }

  dimension:safety_data_sheet {
    type: string
    sql: ${TABLE}.safety_data_sheet ;;
  }

  # dimension: safety_data_sheet_raw {
  #   type: string
  #   sql: concat("https://",replace(${TABLE}.safety_data_sheet,"https://","")) ;;
  #   hidden: yes
  # }

  # dimension: website_label {
  #   type: string
  #   sql: replace(replace(replace(${TABLE}.website,"https:",""),"www.",""),"/","") ;;
  #   hidden: yes
  # }

  # dimension: safety_data_sheet {
  #   type: string
  #   sql: ${safety_data_sheet_raw} ;;
  #   html: <a href="{{safety_data_sheet_raw}}"target=”_blank”>{{ website_label }}</a>;;
  # }

  dimension: hazardous {
    type: string
    sql: ${TABLE}.hazardous ;;
  }

  dimension: hazard_code{
    type: string
    sql: ${TABLE}.hazard_code ;;
    hidden: yes
  }

}
