include: "/**/*/*.view.lkml"
include: "/**/Google_Analytics/*.view.lkml"
include: "/**/Google_Analytics/Sessions/*.view.lkml"
include: "/**/Google_Analytics/Custom_Views/*.view.lkml"

explore: ga_sessions {

  required_access_grants: [is_developer]

  label: "Google Analytics"
  description: "Explores Google Analytics sessions data."

  join: audience_cohorts {
    type: left_outer
    sql_on:

    ${ga_sessions.audience_trait} = ${audience_cohorts.audience_trait}

    ;;
    relationship: many_to_one
  }

  join: hits {
    type: left_outer
    sql:

    LEFT JOIN UNNEST(${ga_sessions.hits}) AS hits

    ;;
    relationship: one_to_many
  }

  join: page_funnel {
    type: left_outer
    sql_on:

    ${page_funnel.page1_hit_id} = ${hits.id}

    ;;
    relationship: one_to_one
  }

  join: event_action_funnel {
    type: left_outer
    sql_on:

    ${event_action_funnel.event1_hit_id} = ${hits.id}

    ;;
    relationship: one_to_one
  }

  join: event_action_facts {
    type: left_outer
    sql_on:

    ${ga_sessions.id} = ${event_action_facts.session_id} AND (${hits.hit_number} BETWEEN ${event_action_facts.hit_number} AND COALESCE(${event_action_facts.next_event_hit_number}-1, ${event_action_facts.hit_number})

    ;;
    relationship: one_to_one
  }

  join: page_facts {
    type: left_outer
    sql_on:

    ${ga_sessions.id} = ${page_facts.session_id} AND (${hits.hit_number} BETWEEN ${page_facts.hit_number} AND COALESCE(${page_facts.next_page_hit_number}-1, ${page_facts.hit_number}))

    ;;
    relationship: one_to_one
  }

  join: session_flow {
    type: left_outer
    sql_on:

    ${ga_sessions.id} = ${session_flow.session_id}

    ;;
    relationship: one_to_one
  }

  join: time_on_page {
    view_label: "Behavior"
    type: left_outer
    sql_on:

    ${hits.id} = ${time_on_page.hit_id}

    ;;
    relationship: one_to_one
  }

  join: user_segment {
    type: left_outer
    sql_on:

    ${ga_sessions.full_visitor_id} = ${user_segment.full_visitor_id}

    ;;
    relationship: many_to_one
  }

  join: custom_dimensions {
    type: left_outer
    relationship: one_to_one
    sql:

    LEFT JOIN UNNEST(${ga_sessions.custom_dimensions}) AS custom_dimensions

    ;;
  }

  join: custom_variables {
    type: left_outer
    relationship: one_to_one
    sql:

    LEFT JOIN UNNEST(${ga_sessions.custom_variables}) AS custom_variables

    ;;
  }

}
