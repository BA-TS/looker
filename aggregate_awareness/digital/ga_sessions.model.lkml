include: "/explores/digital/ga_sessions.explore.lkml"

explore: +ga_sessions {

  aggregate_table: sessions_by_session_start_date {

    query: {
      dimensions: [visit_start_date]
      measures: [visits_total]
    }

    materialization: {
      sql_trigger_value: SELECT CURRENT_DATE() ;;
    }

  }

  ## Aggregate Tables for LookML Dashboards
  ## GA360 Overview Dashboard

  aggregate_table: percent_new_sessions_visits_total {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.landing_page_hostname, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.continent, ga_sessions.country]
      measures: [percent_new_sessions, visits_total]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: bounce_rate_bounces_total {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [bounce_rate, bounces_total]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: time_on_site_average_per_session {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [timeonsite_average_per_session]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: time_on_site_tier {

    query: {
      dimensions: [time_on_site_tier, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [visits_total]
      timezone: "Europe/London"
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: continent_visit_start_month {

    query: {
      dimensions: [continent, ga_sessions.visit_start_month, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [visits_total]
      timezone: "Europe/London"
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: region {

    query: {
      dimensions: [region, ga_sessions.country, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [visits_total]
      timezone: "Europe/London"
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: source {

    query: {
      dimensions: [source, ga_sessions.medium, ga_sessions.source_medium, ga_sessions.partition_date, ga_sessions.landing_page_hostname, ga_sessions.continent, ga_sessions.country]
      measures: [visits_total]
      timezone: "Europe/London"
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: landing_page_formatted {

    query: {
      dimensions: [landing_page_formatted, ga_sessions.landing_page_hostname, ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.source_medium, ga_sessions.continent, ga_sessions.country]
      measures: [visits_total, percent_new_sessions]
      timezone: "Europe/London"
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: hits_page_count_hits_unique_page_count {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [hits.page_count, hits.unique_page_count]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: hits_page_path_formatted {

    query: {
      dimensions: [hits.page_path_formatted, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [hits.page_count, hits.unique_page_count]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  ## End GA360 Dashboard
  ## Acquisition Dashboard

  aggregate_table: unique_visitors {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.continent, ga_sessions.country, ga_sessions.landing_page_hostname]
      measures: [unique_visitors]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: hits_page_count {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.continent, ga_sessions.country, ga_sessions.landing_page_hostname]
      measures: [hits.page_count]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: audience_trait {

    query: {
      dimensions: [audience_trait]
      measures: [bounce_rate, page_views_session, percent_new_sessions, timeonsite_average_per_session, visits_total]
      filters: [
        ga_sessions.audience_selector: "Channel",
        ga_sessions.partition_date: "7 days"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  ## End Acquisition Dashboard
  ## Audience Dashboard

  aggregate_table: visits_total {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.source_medium, ga_sessions.continent, ga_sessions.country]
      measures: [visits_total]
      filters: [
        ga_sessions.audience_selector: "Device"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: unique_visitors_02 {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.source_medium, ga_sessions.continent, ga_sessions.country]
      measures: [unique_visitors]
      filters: [
        ga_sessions.audience_selector: "Device"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: hits_page_count_02 {

    query: {
      dimensions: [ga_sessions.partition_date, ga_sessions.channel_grouping, ga_sessions.medium, ga_sessions.source, ga_sessions.source_medium, ga_sessions.continent, ga_sessions.country]
      measures: [hits.page_count]
      filters: [
        ga_sessions.audience_selector: "Device"
      ]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: visit_number_tier {

    query: {
      dimensions: [visit_number_tier, ga_sessions.partition_date, ga_sessions.landing_page_hostname]
      measures: [unique_visitors]
      filters: [
        ga_sessions.audience_selector: "Device"
      ]
      timezone: "Europe/London"
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: session_flow_days_since_previous_session_tier {

    query: {
      dimensions: [session_flow.days_since_previous_session_tier, ga_sessions.partition_date, ga_sessions.visit_number]
      measures: [visits_total]
      timezone: "Europe/London"
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  aggregate_table: session_flow_pages_visited {

    query: {
      dimensions: [ga_sessions.partition_date, session_flow.pages_visited]
      measures: [visits_total]
      timezone: "Europe/London"
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  ## End Audience Dashboard
  ## Behavior Dashboard

  aggregate_table: hits_full_event {

    query: {
      dimensions: [hits.full_event, ga_sessions.partition_date, hits.host_name]
      measures: [hits.event_count, hits.unique_event_count]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  ## End Behavior Dashboard
  ## Custom Page Funnel Dashboard

  aggregate_table: top_page_paths {

    query: {
      dimensions: [ga_sessions.partition_date,
        session_flow.page_path_1,
        session_flow.page_path_2,
        session_flow.page_path_3,
        session_flow.page_path_4,
        session_flow.page_path_5,
        session_flow.page_path_6
      ]
      measures: [visits_total]
    }

    materialization: {
      persist_for: "24 hours"
    }

  }

  ## End Custom Page Funnel Dashboard

}
