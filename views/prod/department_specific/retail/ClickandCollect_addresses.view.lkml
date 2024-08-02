view: clickandcollect_addresses {
   derived_table: {
     sql: SELECT distinct row_number() over () as PK,addressUID,
max(sites.siteUID) as siteuid,
max(sites.siteName) as siteName,
max(sites.address1) as address1,
max(case when sites.address2 is null then ad.addressLine2 else sites.address2 end) as address2,
max(case when sites.address3 is null then ad.addressLine3 else sites.address3 end) as address3,
max(case when sites.town is null then ad.addressline4 else sites.town end) as town,
max(case when sites.county is null then ad.addressLine5 else sites.county end) as county,
max(case when sites.postcode is null then ad.postcode else sites.postcode end) as postcode

 FROM `toolstation-data-storage.locations.addresses` as ad left join `toolstation-data-storage.locations.sites` as sites on concat(regexp_extract(ad.postcode, "^(.*).{3}$"), " ",regexp_extract(ad.postcode, ".{3}$")) = sites.postcode
where customerUId is null
and ad.addressType in ("TOOLSTATION SITE")
and ad.country in ("UNITED KINGDOM")
and (sites.siteType in ("Shop") or sites.siteType is null)
and (sites.isClosed = 0 or sites.isClosed is null)
group by all
       ;;
   }
#

   dimension: PK {
    description: "primary key"
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.PK;;
   }
#
   dimension: addressUID {
     description: "Address UID"
     type: string
     sql: ${TABLE}.addressUID ;;
   }

  dimension: siteUID {
    description: "site UID"
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: siteName {
    description: "site Name"
    type: string
    sql: ${TABLE}.siteName ;;
  }

  dimension: address1 {
    description: "Address line 1"
    type: string
    sql: ${TABLE}.address1 ;;
  }

  dimension: address2 {
    description: "Address line 2"
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: address3 {
    description: "Address line 3"
    type: string
    sql: ${TABLE}.address3 ;;
  }

  dimension: town {
    description: "Town"
    type: string
    sql: ${TABLE}.town ;;
  }

  dimension: county {
    description: "County"
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: postcode {
    description: "Postcode"
    type: string
    sql: ${TABLE}.postcode ;;
  }

 }
