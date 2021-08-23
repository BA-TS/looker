view: site_budget {
  sql_table_name: `toolstation-data-storage.ts_finance.AOPBySiteAndDate`
    ;;

  dimension: aop {
    type: number
    sql: ${TABLE}.AOP ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: date_site  {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${date_date}||${site_uid} ;;
  }

  dimension: original_site_uid {
    type: string
    sql: ${TABLE}.originalSiteUID ;;
    hidden: yes
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.siteName ;;
    hidden:  yes
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

}
