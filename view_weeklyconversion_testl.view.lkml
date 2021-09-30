view: view_weeklyconversion_testl {
  derived_table: {
    sql: SELECT
        date,
        sessionDate,
        --Completed Transactions--
        count(distinct case when parsedDate >= DATE_SUB(current_date, INTERVAL 8 DAY) and parsedDate <= DATE_SUB(current_date, INTERVAL 2 DAY) then GAMatch end) as transctions,
        count(distinct case when parsedDate >= DATE_SUB(current_date, INTERVAL 15 DAY) and parsedDate <= DATE_SUB(current_date, INTERVAL 9 DAY)then GAMAtch end) as transactionsLW,
        count(distinct case when parsedDate >= DATE_SUB(current_date, INTERVAL 372 DAY) and parsedDate <= DATE_SUB(current_date, INTERVAL 366 DAY)then GAMatch end) as transactionsLY,
        sessions,
        sessionsLW,
        sessionsLY
        from digitalreporting.DS_Digital_Transactions_All
        LEFT JOIN(
            SELECT
            date AS sessionDate,
            sum(Last_Week_Sessions) as sessions,
            sum(Previous_Week_Sessions) as sessionsLW,
            sum(sessionLY) as sessionsLY
            from `digitalreporting.gadigmetricsweekly` GROUP BY 1 )
            ON date = sessionDate
            WHERE trans_check = "OK"
            GROUP BY
            1,
            2,
            6,
            7,
            8
            ORDER BY 1 DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: session_date {
    type: string
    sql: ${TABLE}.sessionDate ;;
  }

  dimension: transctions {
    type: number
    sql: ${TABLE}.transctions ;;
  }

  dimension: transactions_lw {
    type: number
    sql: ${TABLE}.transactionsLW ;;
  }

  dimension: transactions_ly {
    type: number
    sql: ${TABLE}.transactionsLY ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: sessions_lw {
    type: number
    sql: ${TABLE}.sessionsLW ;;
  }

  dimension: sessions_ly {
    type: number
    sql: ${TABLE}.sessionsLY ;;
  }

  set: detail {
    fields: [
      date,
      session_date,
      transctions,
      transactions_lw,
      transactions_ly,
      sessions,
      sessions_lw,
      sessions_ly
    ]
  }
}
