view: customer_segmentation {
  sql_table_name: `toolstation-data-storage.ts_analytics.ts_SCVFinal`
    ;;

  dimension: catalogue_opt_in {
    group_label: "Opt In"
    type: yesno
    sql: ${TABLE}.Catalogue_Opt_In ;;
  }

  dimension: cluster {
    type: string
    sql: ${TABLE}.cluster ;;
  }

  dimension: company {
    type: number
    sql: ${TABLE}.company ;;
    hidden: yes
  }

  dimension: conamepresent {
    type: number
    sql: ${TABLE}.conamepresent ;;
    hidden: yes
  }

  dimension: donotuse {
    type: number
    sql: ${TABLE}.donotuse ;;
    hidden: yes
  }

  dimension: email_opt_in {
    group_label: "Opt In"
    type: yesno
    sql: ${TABLE}.Email_Opt_In ;;
  }

  dimension: frequency {
    type: string
    sql: ${TABLE}.frequency ;;
    hidden: yes
  }

  dimension: ismaster {
    type: number
    sql: ${TABLE}.ismaster ;;
    hidden: yes
  }

  dimension: masterrec {
    type: string
    sql: ${TABLE}.masterrec ;;
    hidden: yes
  }

  dimension: pdmatch {
    type: string
    sql: ${TABLE}.pdmatch ;;
    hidden: yes
  }

  dimension: profanity {
    type: number
    sql: ${TABLE}.profanity ;;
    hidden: yes
  }

  dimension: recency {
    type: string
    sql: ${TABLE}.recency ;;
    hidden: yes
  }

  dimension: rfv_name {
    type: string
    sql: ${TABLE}.RFV_Name ;;
    hidden: yes
  }

  dimension: sms_opt_in {
    group_label: "Opt In"
    type: yesno
    sql: ${TABLE}.SMS_Opt_in ;;
  }

  dimension: toolstation {
    type: number
    sql: ${TABLE}.toolstation ;;
    hidden: yes
  }

  dimension: trade_flag {
    type: string
    sql: ${TABLE}.Trade_Flag ;;
  }

  dimension: trade_type {
    type: string
    sql: ${TABLE}.Trade_Type ;;
  }

  dimension: trade_type_grouping {
    type: string
    sql: ${TABLE}.Trade_Type_Grouping ;;
  }

  dimension: ucu_uid {
    label: "Customer UID"
    primary_key: yes
    type: string
    sql: ${TABLE}.ucu_uid ;;
    hidden: yes
  }

  dimension: unmailable {
    type: number
    sql: ${TABLE}.unmailable ;;
    hidden: yes
  }

  dimension: val {
    type: string
    sql: ${TABLE}.val ;;
    hidden: yes
  }


}
