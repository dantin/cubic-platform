--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(36),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: oauth_access_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_access_token (
    token_id character varying(256),
    token bytea,
    authentication_id character varying(256) NOT NULL,
    user_name character varying(256),
    client_id character varying(256),
    authentication bytea,
    refresh_token character varying(256)
);


ALTER TABLE public.oauth_access_token OWNER TO postgres;

--
-- Name: oauth_client_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_client_details (
    client_id character varying(256) NOT NULL,
    resource_ids character varying(256),
    client_secret character varying(256) NOT NULL,
    scope character varying(256),
    authorized_grant_types character varying(256),
    web_server_redirect_uri character varying(256),
    authorities character varying(256),
    access_token_validity integer,
    refresh_token_validity integer,
    additional_information character varying(4096),
    autoapprove character varying(256)
);


ALTER TABLE public.oauth_client_details OWNER TO postgres;

--
-- Name: oauth_client_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_client_token (
    token_id character varying(256),
    token bytea,
    authentication_id character varying(256) NOT NULL,
    user_name character varying(256),
    client_id character varying(256)
);


ALTER TABLE public.oauth_client_token OWNER TO postgres;

--
-- Name: oauth_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_code (
    code character varying(256),
    authentication bytea
);


ALTER TABLE public.oauth_code OWNER TO postgres;

--
-- Name: oauth_refresh_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth_refresh_token (
    token_id character varying(256),
    token bytea,
    authentication bytea
);


ALTER TABLE public.oauth_refresh_token OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(36) NOT NULL,
    requester character varying(36) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(36)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(36) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(36),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
f3353b76-d754-43df-8ed8-5fb10e19be6e	\N	auth-cookie	master	d0761657-92f2-4533-b67c-59c2e2ab79e1	2	10	f	\N	\N
3c388096-68e5-41cc-9a27-573c58904e0d	\N	auth-spnego	master	d0761657-92f2-4533-b67c-59c2e2ab79e1	3	20	f	\N	\N
5a32b168-0516-44a5-b94b-2390305560af	\N	identity-provider-redirector	master	d0761657-92f2-4533-b67c-59c2e2ab79e1	2	25	f	\N	\N
be0fcd02-45b1-4767-98ed-c8850fb7b75f	\N	\N	master	d0761657-92f2-4533-b67c-59c2e2ab79e1	2	30	t	319f9022-5041-4e20-aaca-4168776dbec0	\N
d88ff976-b9c9-49e5-8349-7cabdd800a5d	\N	auth-username-password-form	master	319f9022-5041-4e20-aaca-4168776dbec0	0	10	f	\N	\N
2c6e989b-a50e-4ad5-9a4d-dc18cba4c8a0	\N	\N	master	319f9022-5041-4e20-aaca-4168776dbec0	1	20	t	a3b7e1c0-2980-4682-8936-b9b50f9b9a8f	\N
e430b4cd-6777-4095-b04b-22e3bbb3ba30	\N	conditional-user-configured	master	a3b7e1c0-2980-4682-8936-b9b50f9b9a8f	0	10	f	\N	\N
00ad97dc-1aa3-4bd1-aa9e-52dd04736841	\N	auth-otp-form	master	a3b7e1c0-2980-4682-8936-b9b50f9b9a8f	0	20	f	\N	\N
a02f89b1-be40-4cc2-9a66-a4fc36c0c968	\N	direct-grant-validate-username	master	37f5ff13-d759-4eee-a955-26c77953c96a	0	10	f	\N	\N
4df8978d-20e3-45c5-a672-f6ace5cdabc9	\N	direct-grant-validate-password	master	37f5ff13-d759-4eee-a955-26c77953c96a	0	20	f	\N	\N
5cca99e6-585e-4f3b-8b07-5cebcee46a2c	\N	\N	master	37f5ff13-d759-4eee-a955-26c77953c96a	1	30	t	663428d2-b0ce-49f2-8ce6-059ad5e77340	\N
8681d08b-0d19-4bd4-9798-8f788de67447	\N	conditional-user-configured	master	663428d2-b0ce-49f2-8ce6-059ad5e77340	0	10	f	\N	\N
c27b6cf9-06bf-4848-b2fa-02fdf1c6be93	\N	direct-grant-validate-otp	master	663428d2-b0ce-49f2-8ce6-059ad5e77340	0	20	f	\N	\N
92da45dc-f324-46e5-a8b9-cbab620ce2a5	\N	registration-page-form	master	8f91b253-d1f6-4cf7-935a-fde883ea940a	0	10	t	4298a362-1fe0-4185-b13c-2169dd40b26f	\N
e3d8e57b-ed35-460e-9ede-05bcc3c4db51	\N	registration-user-creation	master	4298a362-1fe0-4185-b13c-2169dd40b26f	0	20	f	\N	\N
7f17888b-cba3-4e62-8cea-59e681c91841	\N	registration-profile-action	master	4298a362-1fe0-4185-b13c-2169dd40b26f	0	40	f	\N	\N
cc908170-74c8-4752-adf4-09be5abc44ad	\N	registration-password-action	master	4298a362-1fe0-4185-b13c-2169dd40b26f	0	50	f	\N	\N
ba7d5ac0-15e4-471a-ae44-0795e11b867a	\N	registration-recaptcha-action	master	4298a362-1fe0-4185-b13c-2169dd40b26f	3	60	f	\N	\N
fa15c171-20f4-481e-9b7f-618049cf95c4	\N	reset-credentials-choose-user	master	1a467493-827a-486f-b6a9-7fb63c602bd8	0	10	f	\N	\N
f4b1eeda-efc2-4143-8a9e-88ea371ca6a4	\N	reset-credential-email	master	1a467493-827a-486f-b6a9-7fb63c602bd8	0	20	f	\N	\N
9d7eb1d0-d9dd-46af-9b1b-4dc1d0799aad	\N	reset-password	master	1a467493-827a-486f-b6a9-7fb63c602bd8	0	30	f	\N	\N
ada71505-b3a0-4892-a520-3cc766f43f8c	\N	\N	master	1a467493-827a-486f-b6a9-7fb63c602bd8	1	40	t	266a47f4-c5c3-459b-b3de-e91392d13578	\N
1b552069-c34a-4d4a-be0f-cb9643251bb4	\N	conditional-user-configured	master	266a47f4-c5c3-459b-b3de-e91392d13578	0	10	f	\N	\N
6c91fb3c-f4e1-412c-a10b-710111a64bd6	\N	reset-otp	master	266a47f4-c5c3-459b-b3de-e91392d13578	0	20	f	\N	\N
ac0f635f-ece5-4da9-821f-035ff754784b	\N	client-secret	master	ca5a4e5c-4bbf-4746-822b-67b6bcde199c	2	10	f	\N	\N
baeb13d5-df93-420e-b688-dd0d4be53d63	\N	client-jwt	master	ca5a4e5c-4bbf-4746-822b-67b6bcde199c	2	20	f	\N	\N
6f3af6af-9ff2-4eed-8681-94417ef3df63	\N	client-secret-jwt	master	ca5a4e5c-4bbf-4746-822b-67b6bcde199c	2	30	f	\N	\N
bebf4d17-3f21-4a8f-b789-99786021151c	\N	client-x509	master	ca5a4e5c-4bbf-4746-822b-67b6bcde199c	2	40	f	\N	\N
4bd5ab80-e584-439e-bb7c-80d09187c39e	\N	idp-review-profile	master	a2a4ef1d-f52e-4f72-a03b-d07d7262b4b0	0	10	f	\N	7f65290b-10c7-437a-8c28-3412aaedb1a6
a7516aac-ebd2-4856-9cc4-567e6499a36e	\N	\N	master	a2a4ef1d-f52e-4f72-a03b-d07d7262b4b0	0	20	t	cb4eb90d-c60c-4258-9ed0-1202c4899c0a	\N
6782608c-21df-49c4-83bb-4553c5102566	\N	idp-create-user-if-unique	master	cb4eb90d-c60c-4258-9ed0-1202c4899c0a	2	10	f	\N	4797ca4a-bc76-4f32-9d50-38b3fd41200a
32fcce6b-4b98-4345-8a20-d33e400f1322	\N	\N	master	cb4eb90d-c60c-4258-9ed0-1202c4899c0a	2	20	t	0d883cf5-25c9-4cc4-8790-ead987418c9b	\N
e8130d8a-0178-4367-a6c9-bb89472f3419	\N	idp-confirm-link	master	0d883cf5-25c9-4cc4-8790-ead987418c9b	0	10	f	\N	\N
050fa6b2-f8b2-4fc4-bd69-0b5d44ef6e3e	\N	\N	master	0d883cf5-25c9-4cc4-8790-ead987418c9b	0	20	t	de354b38-27d9-4916-8be0-d4f7a2cfc874	\N
c35c4b18-f159-4ca8-b8a8-3bdfd60cdf5c	\N	idp-email-verification	master	de354b38-27d9-4916-8be0-d4f7a2cfc874	2	10	f	\N	\N
2d78592c-b85b-4cf1-adb9-c3d92858a004	\N	\N	master	de354b38-27d9-4916-8be0-d4f7a2cfc874	2	20	t	0fc69646-bc33-4172-877c-d8470c8ce1a4	\N
af5d5f16-6dc3-45f1-ab20-a8670ba1ef8e	\N	idp-username-password-form	master	0fc69646-bc33-4172-877c-d8470c8ce1a4	0	10	f	\N	\N
8657fc84-c3cd-4d5d-90da-8515c13223fe	\N	\N	master	0fc69646-bc33-4172-877c-d8470c8ce1a4	1	20	t	d31355b5-e6fb-4e8f-be7d-9330d47e3fdb	\N
d03624cf-4d01-49dd-9086-7981cc40cdce	\N	conditional-user-configured	master	d31355b5-e6fb-4e8f-be7d-9330d47e3fdb	0	10	f	\N	\N
55b2f33f-6584-4cb4-b694-3182d83be2ab	\N	auth-otp-form	master	d31355b5-e6fb-4e8f-be7d-9330d47e3fdb	0	20	f	\N	\N
dd4f66ab-6619-480f-9401-57d99cd0cc27	\N	http-basic-authenticator	master	c5da8865-ef91-4327-87ae-e02a6cf67655	0	10	f	\N	\N
4d98bb4e-6c59-4b5d-8d95-d9f25b7bf622	\N	docker-http-basic-authenticator	master	96bf5ae3-8f9e-43cd-a629-76d48b41251c	0	10	f	\N	\N
31479597-6bcf-425a-93b9-d607f2dbaae5	\N	no-cookie-redirect	master	d7badf70-e9c3-42ef-8c8b-23f2467dff5f	0	10	f	\N	\N
8d23ba34-68eb-4627-9b3c-918b927b9531	\N	\N	master	d7badf70-e9c3-42ef-8c8b-23f2467dff5f	0	20	t	a73b7427-5aeb-4a0d-97ab-acd52027721a	\N
2dbc2fc2-bafe-4bde-84fe-2e01c1f3a890	\N	basic-auth	master	a73b7427-5aeb-4a0d-97ab-acd52027721a	0	10	f	\N	\N
f04aeccc-9030-41fb-b253-8cbe96d95780	\N	basic-auth-otp	master	a73b7427-5aeb-4a0d-97ab-acd52027721a	3	20	f	\N	\N
02369200-7386-4704-8c22-edda8bf3f9f2	\N	auth-spnego	master	a73b7427-5aeb-4a0d-97ab-acd52027721a	3	30	f	\N	\N
67eb9147-7e1a-47be-a110-07505ce152b9	\N	auth-cookie	ultrasound	f030f472-cd08-43d4-9828-b12392f48d05	2	10	f	\N	\N
cfd87ccd-cf6e-4dcc-bbca-b61ebf4f8928	\N	auth-spnego	ultrasound	f030f472-cd08-43d4-9828-b12392f48d05	3	20	f	\N	\N
c378405c-04a5-4f5f-b7dd-ea27a505b67a	\N	identity-provider-redirector	ultrasound	f030f472-cd08-43d4-9828-b12392f48d05	2	25	f	\N	\N
4ad632d8-8754-4eb5-a85c-e147e3752247	\N	\N	ultrasound	f030f472-cd08-43d4-9828-b12392f48d05	2	30	t	e9c1c0ef-d58f-45f0-b55b-fa45305bd733	\N
f561e1e8-2f7f-4ef6-b252-f078de7a1961	\N	auth-username-password-form	ultrasound	e9c1c0ef-d58f-45f0-b55b-fa45305bd733	0	10	f	\N	\N
e2ef16e2-a04d-4997-8906-4ce3c98138c8	\N	\N	ultrasound	e9c1c0ef-d58f-45f0-b55b-fa45305bd733	1	20	t	f0af6675-8158-4385-90fa-6eaf4bd11630	\N
0b3853ad-da40-409b-b510-04d91da2f158	\N	conditional-user-configured	ultrasound	f0af6675-8158-4385-90fa-6eaf4bd11630	0	10	f	\N	\N
eff843f5-e4c2-4944-a525-bdd3a995d1ef	\N	auth-otp-form	ultrasound	f0af6675-8158-4385-90fa-6eaf4bd11630	0	20	f	\N	\N
47e1ba8c-54ba-42bb-b538-16760949d48c	\N	direct-grant-validate-username	ultrasound	c0814b52-44e9-4a34-a5f9-31c68e9c8f7f	0	10	f	\N	\N
db71e2dc-fb12-4dcd-8e6a-1107ba87c6f5	\N	direct-grant-validate-password	ultrasound	c0814b52-44e9-4a34-a5f9-31c68e9c8f7f	0	20	f	\N	\N
829f9239-e324-48cc-9622-a18ab82e6669	\N	\N	ultrasound	c0814b52-44e9-4a34-a5f9-31c68e9c8f7f	1	30	t	4be07695-ad1c-47ff-adaa-81ed9dd87c0f	\N
7f1e175f-ee6e-4a7e-940c-a5e50c5ceaca	\N	conditional-user-configured	ultrasound	4be07695-ad1c-47ff-adaa-81ed9dd87c0f	0	10	f	\N	\N
bb18f86a-768e-4430-b835-6a7f45536f6a	\N	direct-grant-validate-otp	ultrasound	4be07695-ad1c-47ff-adaa-81ed9dd87c0f	0	20	f	\N	\N
aafc5c74-0a90-40e4-a856-945c5ef7c003	\N	registration-page-form	ultrasound	db79cb90-7e25-4100-8fbe-35a782f888c9	0	10	t	948a776c-acab-462a-9fef-e85f6603a0b2	\N
448f51cc-4e93-483f-942f-703d7b9be199	\N	registration-user-creation	ultrasound	948a776c-acab-462a-9fef-e85f6603a0b2	0	20	f	\N	\N
5b6864d8-6a86-4569-ac68-f7113047ec99	\N	registration-profile-action	ultrasound	948a776c-acab-462a-9fef-e85f6603a0b2	0	40	f	\N	\N
fe046232-c2f4-42dd-b9dd-676af989d811	\N	registration-password-action	ultrasound	948a776c-acab-462a-9fef-e85f6603a0b2	0	50	f	\N	\N
d9a25a71-689e-4088-b794-b97b6548ad86	\N	registration-recaptcha-action	ultrasound	948a776c-acab-462a-9fef-e85f6603a0b2	3	60	f	\N	\N
1ace0132-7287-40b9-98df-5f56e0fc92c4	\N	reset-credentials-choose-user	ultrasound	076ee7e3-e8cb-4a65-862c-18f585aa0209	0	10	f	\N	\N
55dd74f0-2e2e-464b-9d71-c3940ea0f58d	\N	reset-credential-email	ultrasound	076ee7e3-e8cb-4a65-862c-18f585aa0209	0	20	f	\N	\N
c5495223-1b95-432c-9247-5b9b90f7d0c4	\N	reset-password	ultrasound	076ee7e3-e8cb-4a65-862c-18f585aa0209	0	30	f	\N	\N
4333a5dd-7a5b-4192-b3e0-438eca7c08c4	\N	\N	ultrasound	076ee7e3-e8cb-4a65-862c-18f585aa0209	1	40	t	4ffad8fc-f2ce-4630-acd2-59b2073e32f3	\N
72297fa6-a2ef-4f02-89ae-ad77d2946e66	\N	conditional-user-configured	ultrasound	4ffad8fc-f2ce-4630-acd2-59b2073e32f3	0	10	f	\N	\N
e67c142d-5177-4aa7-8c73-eee525ebdf0a	\N	reset-otp	ultrasound	4ffad8fc-f2ce-4630-acd2-59b2073e32f3	0	20	f	\N	\N
808b8b43-388e-4623-88d9-a84c1c77134c	\N	client-secret	ultrasound	b81ecc35-9dbf-4135-a310-7ed67ca2c815	2	10	f	\N	\N
4427bce8-4347-45c9-8bbd-6aead535b981	\N	client-jwt	ultrasound	b81ecc35-9dbf-4135-a310-7ed67ca2c815	2	20	f	\N	\N
c3605f29-7501-40f4-87eb-a5b6d2381a99	\N	client-secret-jwt	ultrasound	b81ecc35-9dbf-4135-a310-7ed67ca2c815	2	30	f	\N	\N
7c40ca06-8373-4e47-bc63-bc1eaa193b32	\N	client-x509	ultrasound	b81ecc35-9dbf-4135-a310-7ed67ca2c815	2	40	f	\N	\N
dc59dbb5-0ce7-4dcd-95ea-7ef715d18eb8	\N	idp-review-profile	ultrasound	b995f7fd-dffa-46c0-861e-7100d7f0cdb2	0	10	f	\N	31c41fe6-77e8-4510-a5e2-c97bfad30312
1e570daf-d1df-492d-afbd-f0f05655a66a	\N	\N	ultrasound	b995f7fd-dffa-46c0-861e-7100d7f0cdb2	0	20	t	337a7832-220b-4835-b023-39961031dd42	\N
45bb54ab-f86c-4da4-9dd2-e0f2df4539ff	\N	idp-create-user-if-unique	ultrasound	337a7832-220b-4835-b023-39961031dd42	2	10	f	\N	c03eb3f4-00f0-4132-97f1-43f29ba09d1d
85f2e2d2-23c9-4d16-a0e9-5a61e1481f91	\N	\N	ultrasound	337a7832-220b-4835-b023-39961031dd42	2	20	t	7d122212-b6bc-4475-86f4-3c69aade8853	\N
a30a881c-8640-48b4-897b-a1cab7a42903	\N	idp-confirm-link	ultrasound	7d122212-b6bc-4475-86f4-3c69aade8853	0	10	f	\N	\N
1a6338b2-f546-48b0-9633-02c0c4a7c490	\N	\N	ultrasound	7d122212-b6bc-4475-86f4-3c69aade8853	0	20	t	34dfe87c-6fa1-47bd-828b-bf755ce89e90	\N
a991aaa0-ce8c-4176-bfe9-4ec1eb00c2ba	\N	idp-email-verification	ultrasound	34dfe87c-6fa1-47bd-828b-bf755ce89e90	2	10	f	\N	\N
d398524f-edc6-49e5-b4b4-9051d0c5d537	\N	\N	ultrasound	34dfe87c-6fa1-47bd-828b-bf755ce89e90	2	20	t	f8832c83-2535-418a-a7a2-be7c6a5e6539	\N
0a3a2127-707d-46f4-912c-21e66ee06676	\N	idp-username-password-form	ultrasound	f8832c83-2535-418a-a7a2-be7c6a5e6539	0	10	f	\N	\N
b28ebfa9-39bc-4075-829d-3f5c7cd44f2e	\N	\N	ultrasound	f8832c83-2535-418a-a7a2-be7c6a5e6539	1	20	t	c9fd1a9e-541b-409f-af8f-9b8292b256ec	\N
727ef9c8-3c50-4ebf-839e-f45d7656ad2f	\N	conditional-user-configured	ultrasound	c9fd1a9e-541b-409f-af8f-9b8292b256ec	0	10	f	\N	\N
c10005d2-04e9-4ee3-9ca1-f2b23e915d2a	\N	auth-otp-form	ultrasound	c9fd1a9e-541b-409f-af8f-9b8292b256ec	0	20	f	\N	\N
eebf76eb-1a7d-4a47-a0a5-5205aa156b50	\N	http-basic-authenticator	ultrasound	bdfe30e7-b7ce-4dee-87b7-8ecd0ffdbe6f	0	10	f	\N	\N
edd87fa8-778f-424e-802d-c1beef79659a	\N	docker-http-basic-authenticator	ultrasound	9ffa08b3-b49d-46b1-aff5-668490b92488	0	10	f	\N	\N
d16e7288-fc3f-46aa-97e0-4beaca2bb6e2	\N	no-cookie-redirect	ultrasound	4c03ac7d-cd47-4f87-bb41-12c211248ef8	0	10	f	\N	\N
28c5da0f-5617-4c42-82e2-83acfee4a721	\N	\N	ultrasound	4c03ac7d-cd47-4f87-bb41-12c211248ef8	0	20	t	93dc5cf8-9695-4faf-9891-fff60a9ead7a	\N
daf5cb05-be1e-43c5-a99c-f9f5a4d5aa37	\N	basic-auth	ultrasound	93dc5cf8-9695-4faf-9891-fff60a9ead7a	0	10	f	\N	\N
eba726ca-9b89-4f7c-b6d6-96d68cc7085e	\N	basic-auth-otp	ultrasound	93dc5cf8-9695-4faf-9891-fff60a9ead7a	3	20	f	\N	\N
b7da2c53-458a-41d9-a564-3177d98adc55	\N	auth-spnego	ultrasound	93dc5cf8-9695-4faf-9891-fff60a9ead7a	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
d0761657-92f2-4533-b67c-59c2e2ab79e1	browser	browser based authentication	master	basic-flow	t	t
319f9022-5041-4e20-aaca-4168776dbec0	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
a3b7e1c0-2980-4682-8936-b9b50f9b9a8f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
37f5ff13-d759-4eee-a955-26c77953c96a	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
663428d2-b0ce-49f2-8ce6-059ad5e77340	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
8f91b253-d1f6-4cf7-935a-fde883ea940a	registration	registration flow	master	basic-flow	t	t
4298a362-1fe0-4185-b13c-2169dd40b26f	registration form	registration form	master	form-flow	f	t
1a467493-827a-486f-b6a9-7fb63c602bd8	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
266a47f4-c5c3-459b-b3de-e91392d13578	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
ca5a4e5c-4bbf-4746-822b-67b6bcde199c	clients	Base authentication for clients	master	client-flow	t	t
a2a4ef1d-f52e-4f72-a03b-d07d7262b4b0	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
cb4eb90d-c60c-4258-9ed0-1202c4899c0a	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
0d883cf5-25c9-4cc4-8790-ead987418c9b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
de354b38-27d9-4916-8be0-d4f7a2cfc874	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
0fc69646-bc33-4172-877c-d8470c8ce1a4	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
d31355b5-e6fb-4e8f-be7d-9330d47e3fdb	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
c5da8865-ef91-4327-87ae-e02a6cf67655	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
96bf5ae3-8f9e-43cd-a629-76d48b41251c	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
d7badf70-e9c3-42ef-8c8b-23f2467dff5f	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
a73b7427-5aeb-4a0d-97ab-acd52027721a	Authentication Options	Authentication options.	master	basic-flow	f	t
f030f472-cd08-43d4-9828-b12392f48d05	browser	browser based authentication	ultrasound	basic-flow	t	t
e9c1c0ef-d58f-45f0-b55b-fa45305bd733	forms	Username, password, otp and other auth forms.	ultrasound	basic-flow	f	t
f0af6675-8158-4385-90fa-6eaf4bd11630	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	ultrasound	basic-flow	f	t
c0814b52-44e9-4a34-a5f9-31c68e9c8f7f	direct grant	OpenID Connect Resource Owner Grant	ultrasound	basic-flow	t	t
4be07695-ad1c-47ff-adaa-81ed9dd87c0f	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	ultrasound	basic-flow	f	t
db79cb90-7e25-4100-8fbe-35a782f888c9	registration	registration flow	ultrasound	basic-flow	t	t
948a776c-acab-462a-9fef-e85f6603a0b2	registration form	registration form	ultrasound	form-flow	f	t
076ee7e3-e8cb-4a65-862c-18f585aa0209	reset credentials	Reset credentials for a user if they forgot their password or something	ultrasound	basic-flow	t	t
4ffad8fc-f2ce-4630-acd2-59b2073e32f3	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	ultrasound	basic-flow	f	t
b81ecc35-9dbf-4135-a310-7ed67ca2c815	clients	Base authentication for clients	ultrasound	client-flow	t	t
b995f7fd-dffa-46c0-861e-7100d7f0cdb2	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	ultrasound	basic-flow	t	t
337a7832-220b-4835-b023-39961031dd42	User creation or linking	Flow for the existing/non-existing user alternatives	ultrasound	basic-flow	f	t
7d122212-b6bc-4475-86f4-3c69aade8853	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	ultrasound	basic-flow	f	t
34dfe87c-6fa1-47bd-828b-bf755ce89e90	Account verification options	Method with which to verity the existing account	ultrasound	basic-flow	f	t
f8832c83-2535-418a-a7a2-be7c6a5e6539	Verify Existing Account by Re-authentication	Reauthentication of existing account	ultrasound	basic-flow	f	t
c9fd1a9e-541b-409f-af8f-9b8292b256ec	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	ultrasound	basic-flow	f	t
bdfe30e7-b7ce-4dee-87b7-8ecd0ffdbe6f	saml ecp	SAML ECP Profile Authentication Flow	ultrasound	basic-flow	t	t
9ffa08b3-b49d-46b1-aff5-668490b92488	docker auth	Used by Docker clients to authenticate against the IDP	ultrasound	basic-flow	t	t
4c03ac7d-cd47-4f87-bb41-12c211248ef8	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	ultrasound	basic-flow	t	t
93dc5cf8-9695-4faf-9891-fff60a9ead7a	Authentication Options	Authentication options.	ultrasound	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
7f65290b-10c7-437a-8c28-3412aaedb1a6	review profile config	master
4797ca4a-bc76-4f32-9d50-38b3fd41200a	create unique user config	master
31c41fe6-77e8-4510-a5e2-c97bfad30312	review profile config	ultrasound
c03eb3f4-00f0-4132-97f1-43f29ba09d1d	create unique user config	ultrasound
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
7f65290b-10c7-437a-8c28-3412aaedb1a6	missing	update.profile.on.first.login
4797ca4a-bc76-4f32-9d50-38b3fd41200a	false	require.password.update.after.registration
31c41fe6-77e8-4510-a5e2-c97bfad30312	missing	update.profile.on.first.login
c03eb3f4-00f0-4132-97f1-43f29ba09d1d	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled) FROM stdin;
f11a806c-81a6-4626-ab1b-59ecada89b17	t	t	master-realm	0	f	aa17d7e4-5c33-4f7f-9911-b81bb0a00ef4	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f
99ec09f1-251e-4f3c-be53-251d59ab14bb	t	f	account	0	f	98deaf4a-5fd7-4d43-8ac2-035de9516089	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f
f30ae4ad-e498-49a8-8c00-c768cdc87f08	t	f	broker	0	f	81c04bae-5995-4fd5-b68e-79da388dc3a5	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f
bfd0065b-9fea-480f-a93a-795bb345b5d5	t	f	security-admin-console	0	t	1344b2f2-e197-4738-9b83-b9f419a9fd44	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f
4a701b4f-a2d1-42da-a341-f9af335e6127	t	f	admin-cli	0	t	994392cd-9c42-4a40-9836-8401a1679d7f	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t
78879382-f740-4c29-96ab-1d26dd48583a	t	t	ultrasound-realm	0	f	03a0d921-7c9a-4c83-ba17-1f06c2e2ec65	\N	t	\N	f	master	\N	0	f	f	ultrasound Realm	f	client-secret	\N	\N	\N	t	f	f
0ec9e52f-324b-4aba-a233-2fd843b59754	t	f	realm-management	0	f	645fe964-7bbf-4ce2-a3a1-5295b73218ee	\N	t	\N	f	ultrasound	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	t	f	account	0	f	2a80725b-bae2-4e6f-ad01-3eb6dc89d47d	/realms/ultrasound/account/	f	\N	f	ultrasound	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f
fcff7355-7928-40fa-a1a1-126359992233	t	f	broker	0	f	a0965ec9-4a15-4dd8-87b7-19c1e61afa11	\N	f	\N	f	ultrasound	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	t	f	security-admin-console	0	t	a236413d-fe4a-471c-a664-fa19c68e0ae4	/admin/ultrasound/console/	f	\N	f	ultrasound	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	t	f	admin-cli	0	t	8bf0a2c9-2f72-43b1-8276-ad407cd4d710	\N	f	\N	f	ultrasound	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t
ddea0ad0-022b-4e77-9b31-221b7facedce	t	t	ultrasound_api_service	0	f	3d973f0c-d0ed-43b9-8c13-67f5ea73e335	\N	f	http://localhost:10001	f	ultrasound	openid-connect	-1	f	f	Ultrasound API	f	client-secret	http://localhost:10001	Ultrasound Resource Server	\N	t	f	t
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
ddea0ad0-022b-4e77-9b31-221b7facedce	300	access.token.lifespan
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.server.signature
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.server.signature.keyinfo.ext
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.assertion.signature
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.client.signature
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.encrypt
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.authnstatement
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.onetimeuse.condition
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml_force_name_id_format
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.multivalued.roles
ddea0ad0-022b-4e77-9b31-221b7facedce	false	saml.force.post.binding
ddea0ad0-022b-4e77-9b31-221b7facedce	false	exclude.session.state.from.auth.response
ddea0ad0-022b-4e77-9b31-221b7facedce	false	tls.client.certificate.bound.access.tokens
ddea0ad0-022b-4e77-9b31-221b7facedce	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
99ec09f1-251e-4f3c-be53-251d59ab14bb	ac9c92a4-7ff1-4d4a-91af-214fbf898838
99ec09f1-251e-4f3c-be53-251d59ab14bb	436245c0-82c7-4c67-bb33-6c98db9dab61
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	7f82cff4-a8d8-4221-8c8c-37d3dc870a18
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	e731afdd-5538-4051-b8a5-91c662942f56
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
3d6af9ee-8514-445d-a696-c302ca2a2e23	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
2bc504b2-1b6d-4eff-a082-8883810739b4	role_list	master	SAML role list	saml
ac520590-b024-49e2-8a21-3d5e31a15894	profile	master	OpenID Connect built-in scope: profile	openid-connect
28f152e1-3239-4de2-b48b-1c07a1e53caf	email	master	OpenID Connect built-in scope: email	openid-connect
343319bd-b7a0-4152-bbcc-fc93e721e16d	address	master	OpenID Connect built-in scope: address	openid-connect
a44deca7-20ca-4b79-a7d1-0fd242e7c505	phone	master	OpenID Connect built-in scope: phone	openid-connect
ed03075d-3171-4093-b124-b1bf6c5ec848	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
439e3867-7b15-4a30-9ff4-c4424e762c85	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
caa64c12-0ae0-43d0-a545-5d23b5552079	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
5201b816-e4b6-48b0-a1b0-d1a2b50c777b	offline_access	ultrasound	OpenID Connect built-in scope: offline_access	openid-connect
14b11591-0678-41c2-a5b2-530480ab9285	role_list	ultrasound	SAML role list	saml
7ddce74c-ce2b-470a-876f-5cf5fe437acb	profile	ultrasound	OpenID Connect built-in scope: profile	openid-connect
adba83ad-f81c-49d0-9035-25f62179f4f3	email	ultrasound	OpenID Connect built-in scope: email	openid-connect
03cdde96-d844-41da-bbde-a3d4618c7518	address	ultrasound	OpenID Connect built-in scope: address	openid-connect
c05165c3-f634-4cec-935f-327f000758c4	phone	ultrasound	OpenID Connect built-in scope: phone	openid-connect
4533effa-57b8-43ce-95aa-e1339cbba4ec	roles	ultrasound	OpenID Connect scope for add user roles to the access token	openid-connect
280ec09a-0242-43b9-98ad-6175fb35c1d8	web-origins	ultrasound	OpenID Connect scope for add allowed web origins to the access token	openid-connect
434b9771-b87a-4e97-97f1-9ad9c5e268d7	microprofile-jwt	ultrasound	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
3d6af9ee-8514-445d-a696-c302ca2a2e23	true	display.on.consent.screen
3d6af9ee-8514-445d-a696-c302ca2a2e23	${offlineAccessScopeConsentText}	consent.screen.text
2bc504b2-1b6d-4eff-a082-8883810739b4	true	display.on.consent.screen
2bc504b2-1b6d-4eff-a082-8883810739b4	${samlRoleListScopeConsentText}	consent.screen.text
ac520590-b024-49e2-8a21-3d5e31a15894	true	display.on.consent.screen
ac520590-b024-49e2-8a21-3d5e31a15894	${profileScopeConsentText}	consent.screen.text
ac520590-b024-49e2-8a21-3d5e31a15894	true	include.in.token.scope
28f152e1-3239-4de2-b48b-1c07a1e53caf	true	display.on.consent.screen
28f152e1-3239-4de2-b48b-1c07a1e53caf	${emailScopeConsentText}	consent.screen.text
28f152e1-3239-4de2-b48b-1c07a1e53caf	true	include.in.token.scope
343319bd-b7a0-4152-bbcc-fc93e721e16d	true	display.on.consent.screen
343319bd-b7a0-4152-bbcc-fc93e721e16d	${addressScopeConsentText}	consent.screen.text
343319bd-b7a0-4152-bbcc-fc93e721e16d	true	include.in.token.scope
a44deca7-20ca-4b79-a7d1-0fd242e7c505	true	display.on.consent.screen
a44deca7-20ca-4b79-a7d1-0fd242e7c505	${phoneScopeConsentText}	consent.screen.text
a44deca7-20ca-4b79-a7d1-0fd242e7c505	true	include.in.token.scope
ed03075d-3171-4093-b124-b1bf6c5ec848	true	display.on.consent.screen
ed03075d-3171-4093-b124-b1bf6c5ec848	${rolesScopeConsentText}	consent.screen.text
ed03075d-3171-4093-b124-b1bf6c5ec848	false	include.in.token.scope
439e3867-7b15-4a30-9ff4-c4424e762c85	false	display.on.consent.screen
439e3867-7b15-4a30-9ff4-c4424e762c85		consent.screen.text
439e3867-7b15-4a30-9ff4-c4424e762c85	false	include.in.token.scope
caa64c12-0ae0-43d0-a545-5d23b5552079	false	display.on.consent.screen
caa64c12-0ae0-43d0-a545-5d23b5552079	true	include.in.token.scope
5201b816-e4b6-48b0-a1b0-d1a2b50c777b	true	display.on.consent.screen
5201b816-e4b6-48b0-a1b0-d1a2b50c777b	${offlineAccessScopeConsentText}	consent.screen.text
14b11591-0678-41c2-a5b2-530480ab9285	true	display.on.consent.screen
14b11591-0678-41c2-a5b2-530480ab9285	${samlRoleListScopeConsentText}	consent.screen.text
7ddce74c-ce2b-470a-876f-5cf5fe437acb	true	display.on.consent.screen
7ddce74c-ce2b-470a-876f-5cf5fe437acb	${profileScopeConsentText}	consent.screen.text
7ddce74c-ce2b-470a-876f-5cf5fe437acb	true	include.in.token.scope
adba83ad-f81c-49d0-9035-25f62179f4f3	true	display.on.consent.screen
adba83ad-f81c-49d0-9035-25f62179f4f3	${emailScopeConsentText}	consent.screen.text
adba83ad-f81c-49d0-9035-25f62179f4f3	true	include.in.token.scope
03cdde96-d844-41da-bbde-a3d4618c7518	true	display.on.consent.screen
03cdde96-d844-41da-bbde-a3d4618c7518	${addressScopeConsentText}	consent.screen.text
03cdde96-d844-41da-bbde-a3d4618c7518	true	include.in.token.scope
c05165c3-f634-4cec-935f-327f000758c4	true	display.on.consent.screen
c05165c3-f634-4cec-935f-327f000758c4	${phoneScopeConsentText}	consent.screen.text
c05165c3-f634-4cec-935f-327f000758c4	true	include.in.token.scope
4533effa-57b8-43ce-95aa-e1339cbba4ec	true	display.on.consent.screen
4533effa-57b8-43ce-95aa-e1339cbba4ec	${rolesScopeConsentText}	consent.screen.text
4533effa-57b8-43ce-95aa-e1339cbba4ec	false	include.in.token.scope
280ec09a-0242-43b9-98ad-6175fb35c1d8	false	display.on.consent.screen
280ec09a-0242-43b9-98ad-6175fb35c1d8		consent.screen.text
280ec09a-0242-43b9-98ad-6175fb35c1d8	false	include.in.token.scope
434b9771-b87a-4e97-97f1-9ad9c5e268d7	false	display.on.consent.screen
434b9771-b87a-4e97-97f1-9ad9c5e268d7	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
99ec09f1-251e-4f3c-be53-251d59ab14bb	2bc504b2-1b6d-4eff-a082-8883810739b4	t
4a701b4f-a2d1-42da-a341-f9af335e6127	2bc504b2-1b6d-4eff-a082-8883810739b4	t
f30ae4ad-e498-49a8-8c00-c768cdc87f08	2bc504b2-1b6d-4eff-a082-8883810739b4	t
f11a806c-81a6-4626-ab1b-59ecada89b17	2bc504b2-1b6d-4eff-a082-8883810739b4	t
bfd0065b-9fea-480f-a93a-795bb345b5d5	2bc504b2-1b6d-4eff-a082-8883810739b4	t
99ec09f1-251e-4f3c-be53-251d59ab14bb	ac520590-b024-49e2-8a21-3d5e31a15894	t
99ec09f1-251e-4f3c-be53-251d59ab14bb	28f152e1-3239-4de2-b48b-1c07a1e53caf	t
99ec09f1-251e-4f3c-be53-251d59ab14bb	ed03075d-3171-4093-b124-b1bf6c5ec848	t
99ec09f1-251e-4f3c-be53-251d59ab14bb	439e3867-7b15-4a30-9ff4-c4424e762c85	t
99ec09f1-251e-4f3c-be53-251d59ab14bb	3d6af9ee-8514-445d-a696-c302ca2a2e23	f
99ec09f1-251e-4f3c-be53-251d59ab14bb	343319bd-b7a0-4152-bbcc-fc93e721e16d	f
99ec09f1-251e-4f3c-be53-251d59ab14bb	a44deca7-20ca-4b79-a7d1-0fd242e7c505	f
99ec09f1-251e-4f3c-be53-251d59ab14bb	caa64c12-0ae0-43d0-a545-5d23b5552079	f
4a701b4f-a2d1-42da-a341-f9af335e6127	ac520590-b024-49e2-8a21-3d5e31a15894	t
4a701b4f-a2d1-42da-a341-f9af335e6127	28f152e1-3239-4de2-b48b-1c07a1e53caf	t
4a701b4f-a2d1-42da-a341-f9af335e6127	ed03075d-3171-4093-b124-b1bf6c5ec848	t
4a701b4f-a2d1-42da-a341-f9af335e6127	439e3867-7b15-4a30-9ff4-c4424e762c85	t
4a701b4f-a2d1-42da-a341-f9af335e6127	3d6af9ee-8514-445d-a696-c302ca2a2e23	f
4a701b4f-a2d1-42da-a341-f9af335e6127	343319bd-b7a0-4152-bbcc-fc93e721e16d	f
4a701b4f-a2d1-42da-a341-f9af335e6127	a44deca7-20ca-4b79-a7d1-0fd242e7c505	f
4a701b4f-a2d1-42da-a341-f9af335e6127	caa64c12-0ae0-43d0-a545-5d23b5552079	f
f30ae4ad-e498-49a8-8c00-c768cdc87f08	ac520590-b024-49e2-8a21-3d5e31a15894	t
f30ae4ad-e498-49a8-8c00-c768cdc87f08	28f152e1-3239-4de2-b48b-1c07a1e53caf	t
f30ae4ad-e498-49a8-8c00-c768cdc87f08	ed03075d-3171-4093-b124-b1bf6c5ec848	t
f30ae4ad-e498-49a8-8c00-c768cdc87f08	439e3867-7b15-4a30-9ff4-c4424e762c85	t
f30ae4ad-e498-49a8-8c00-c768cdc87f08	3d6af9ee-8514-445d-a696-c302ca2a2e23	f
f30ae4ad-e498-49a8-8c00-c768cdc87f08	343319bd-b7a0-4152-bbcc-fc93e721e16d	f
f30ae4ad-e498-49a8-8c00-c768cdc87f08	a44deca7-20ca-4b79-a7d1-0fd242e7c505	f
f30ae4ad-e498-49a8-8c00-c768cdc87f08	caa64c12-0ae0-43d0-a545-5d23b5552079	f
f11a806c-81a6-4626-ab1b-59ecada89b17	ac520590-b024-49e2-8a21-3d5e31a15894	t
f11a806c-81a6-4626-ab1b-59ecada89b17	28f152e1-3239-4de2-b48b-1c07a1e53caf	t
f11a806c-81a6-4626-ab1b-59ecada89b17	ed03075d-3171-4093-b124-b1bf6c5ec848	t
f11a806c-81a6-4626-ab1b-59ecada89b17	439e3867-7b15-4a30-9ff4-c4424e762c85	t
f11a806c-81a6-4626-ab1b-59ecada89b17	3d6af9ee-8514-445d-a696-c302ca2a2e23	f
f11a806c-81a6-4626-ab1b-59ecada89b17	343319bd-b7a0-4152-bbcc-fc93e721e16d	f
f11a806c-81a6-4626-ab1b-59ecada89b17	a44deca7-20ca-4b79-a7d1-0fd242e7c505	f
f11a806c-81a6-4626-ab1b-59ecada89b17	caa64c12-0ae0-43d0-a545-5d23b5552079	f
bfd0065b-9fea-480f-a93a-795bb345b5d5	ac520590-b024-49e2-8a21-3d5e31a15894	t
bfd0065b-9fea-480f-a93a-795bb345b5d5	28f152e1-3239-4de2-b48b-1c07a1e53caf	t
bfd0065b-9fea-480f-a93a-795bb345b5d5	ed03075d-3171-4093-b124-b1bf6c5ec848	t
bfd0065b-9fea-480f-a93a-795bb345b5d5	439e3867-7b15-4a30-9ff4-c4424e762c85	t
bfd0065b-9fea-480f-a93a-795bb345b5d5	3d6af9ee-8514-445d-a696-c302ca2a2e23	f
bfd0065b-9fea-480f-a93a-795bb345b5d5	343319bd-b7a0-4152-bbcc-fc93e721e16d	f
bfd0065b-9fea-480f-a93a-795bb345b5d5	a44deca7-20ca-4b79-a7d1-0fd242e7c505	f
bfd0065b-9fea-480f-a93a-795bb345b5d5	caa64c12-0ae0-43d0-a545-5d23b5552079	f
78879382-f740-4c29-96ab-1d26dd48583a	2bc504b2-1b6d-4eff-a082-8883810739b4	t
78879382-f740-4c29-96ab-1d26dd48583a	ac520590-b024-49e2-8a21-3d5e31a15894	t
78879382-f740-4c29-96ab-1d26dd48583a	28f152e1-3239-4de2-b48b-1c07a1e53caf	t
78879382-f740-4c29-96ab-1d26dd48583a	ed03075d-3171-4093-b124-b1bf6c5ec848	t
78879382-f740-4c29-96ab-1d26dd48583a	439e3867-7b15-4a30-9ff4-c4424e762c85	t
78879382-f740-4c29-96ab-1d26dd48583a	3d6af9ee-8514-445d-a696-c302ca2a2e23	f
78879382-f740-4c29-96ab-1d26dd48583a	343319bd-b7a0-4152-bbcc-fc93e721e16d	f
78879382-f740-4c29-96ab-1d26dd48583a	a44deca7-20ca-4b79-a7d1-0fd242e7c505	f
78879382-f740-4c29-96ab-1d26dd48583a	caa64c12-0ae0-43d0-a545-5d23b5552079	f
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	14b11591-0678-41c2-a5b2-530480ab9285	t
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	14b11591-0678-41c2-a5b2-530480ab9285	t
fcff7355-7928-40fa-a1a1-126359992233	14b11591-0678-41c2-a5b2-530480ab9285	t
0ec9e52f-324b-4aba-a233-2fd843b59754	14b11591-0678-41c2-a5b2-530480ab9285	t
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	14b11591-0678-41c2-a5b2-530480ab9285	t
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	7ddce74c-ce2b-470a-876f-5cf5fe437acb	t
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	adba83ad-f81c-49d0-9035-25f62179f4f3	t
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	4533effa-57b8-43ce-95aa-e1339cbba4ec	t
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	280ec09a-0242-43b9-98ad-6175fb35c1d8	t
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	5201b816-e4b6-48b0-a1b0-d1a2b50c777b	f
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	03cdde96-d844-41da-bbde-a3d4618c7518	f
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	c05165c3-f634-4cec-935f-327f000758c4	f
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	434b9771-b87a-4e97-97f1-9ad9c5e268d7	f
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	7ddce74c-ce2b-470a-876f-5cf5fe437acb	t
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	adba83ad-f81c-49d0-9035-25f62179f4f3	t
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	4533effa-57b8-43ce-95aa-e1339cbba4ec	t
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	280ec09a-0242-43b9-98ad-6175fb35c1d8	t
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	5201b816-e4b6-48b0-a1b0-d1a2b50c777b	f
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	03cdde96-d844-41da-bbde-a3d4618c7518	f
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	c05165c3-f634-4cec-935f-327f000758c4	f
9ea4ae8f-ef84-4443-9a86-bf2c1b5e84ec	434b9771-b87a-4e97-97f1-9ad9c5e268d7	f
fcff7355-7928-40fa-a1a1-126359992233	7ddce74c-ce2b-470a-876f-5cf5fe437acb	t
fcff7355-7928-40fa-a1a1-126359992233	adba83ad-f81c-49d0-9035-25f62179f4f3	t
fcff7355-7928-40fa-a1a1-126359992233	4533effa-57b8-43ce-95aa-e1339cbba4ec	t
fcff7355-7928-40fa-a1a1-126359992233	280ec09a-0242-43b9-98ad-6175fb35c1d8	t
fcff7355-7928-40fa-a1a1-126359992233	5201b816-e4b6-48b0-a1b0-d1a2b50c777b	f
fcff7355-7928-40fa-a1a1-126359992233	03cdde96-d844-41da-bbde-a3d4618c7518	f
fcff7355-7928-40fa-a1a1-126359992233	c05165c3-f634-4cec-935f-327f000758c4	f
fcff7355-7928-40fa-a1a1-126359992233	434b9771-b87a-4e97-97f1-9ad9c5e268d7	f
0ec9e52f-324b-4aba-a233-2fd843b59754	7ddce74c-ce2b-470a-876f-5cf5fe437acb	t
0ec9e52f-324b-4aba-a233-2fd843b59754	adba83ad-f81c-49d0-9035-25f62179f4f3	t
0ec9e52f-324b-4aba-a233-2fd843b59754	4533effa-57b8-43ce-95aa-e1339cbba4ec	t
0ec9e52f-324b-4aba-a233-2fd843b59754	280ec09a-0242-43b9-98ad-6175fb35c1d8	t
0ec9e52f-324b-4aba-a233-2fd843b59754	5201b816-e4b6-48b0-a1b0-d1a2b50c777b	f
0ec9e52f-324b-4aba-a233-2fd843b59754	03cdde96-d844-41da-bbde-a3d4618c7518	f
0ec9e52f-324b-4aba-a233-2fd843b59754	c05165c3-f634-4cec-935f-327f000758c4	f
0ec9e52f-324b-4aba-a233-2fd843b59754	434b9771-b87a-4e97-97f1-9ad9c5e268d7	f
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	7ddce74c-ce2b-470a-876f-5cf5fe437acb	t
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	adba83ad-f81c-49d0-9035-25f62179f4f3	t
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	4533effa-57b8-43ce-95aa-e1339cbba4ec	t
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	280ec09a-0242-43b9-98ad-6175fb35c1d8	t
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	5201b816-e4b6-48b0-a1b0-d1a2b50c777b	f
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	03cdde96-d844-41da-bbde-a3d4618c7518	f
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	c05165c3-f634-4cec-935f-327f000758c4	f
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	434b9771-b87a-4e97-97f1-9ad9c5e268d7	f
ddea0ad0-022b-4e77-9b31-221b7facedce	14b11591-0678-41c2-a5b2-530480ab9285	t
ddea0ad0-022b-4e77-9b31-221b7facedce	7ddce74c-ce2b-470a-876f-5cf5fe437acb	t
ddea0ad0-022b-4e77-9b31-221b7facedce	adba83ad-f81c-49d0-9035-25f62179f4f3	t
ddea0ad0-022b-4e77-9b31-221b7facedce	4533effa-57b8-43ce-95aa-e1339cbba4ec	t
ddea0ad0-022b-4e77-9b31-221b7facedce	280ec09a-0242-43b9-98ad-6175fb35c1d8	t
ddea0ad0-022b-4e77-9b31-221b7facedce	5201b816-e4b6-48b0-a1b0-d1a2b50c777b	f
ddea0ad0-022b-4e77-9b31-221b7facedce	03cdde96-d844-41da-bbde-a3d4618c7518	f
ddea0ad0-022b-4e77-9b31-221b7facedce	c05165c3-f634-4cec-935f-327f000758c4	f
ddea0ad0-022b-4e77-9b31-221b7facedce	434b9771-b87a-4e97-97f1-9ad9c5e268d7	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
3d6af9ee-8514-445d-a696-c302ca2a2e23	331c3eb9-de90-41d9-9fdb-955dafe55f60
5201b816-e4b6-48b0-a1b0-d1a2b50c777b	c8046c7f-6373-4bbc-9a7f-993b6573e14a
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
f2ba34b9-88e3-484c-abe8-63e3c700874f	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d765c9c3-d6fd-4305-a1cf-299a15824db7	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
8160c494-d516-4a48-90e3-42882d5de767	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
b7d2f1c6-151f-4e54-a955-d9325129168f	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a121bdd4-a59c-4094-837d-888e3a063ff6	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
81aeed5e-fcb0-4ebc-977f-52ce5237bb22	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
6c1cec90-a294-46c0-a112-a1b00d38629c	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
cac663a2-7879-4aa0-81f8-04d06a0ba8ba	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
344915aa-c7ac-4e7f-8338-86143cc97968	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
c0f1dc47-242d-4906-95b3-7dd8f128fac6	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
01564ce8-8035-4f28-86fb-8b4ff5dc5508	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
9f12ea4b-fa1e-45f9-b187-b74ab6936dfc	rsa-generated	ultrasound	rsa-generated	org.keycloak.keys.KeyProvider	ultrasound	\N
180f0308-1ed2-4d97-a080-9350329eddca	hmac-generated	ultrasound	hmac-generated	org.keycloak.keys.KeyProvider	ultrasound	\N
4b23b918-f66f-4300-9e97-5775a3235aec	aes-generated	ultrasound	aes-generated	org.keycloak.keys.KeyProvider	ultrasound	\N
09626b6b-6d96-494e-bff1-fa162dacaa5d	Trusted Hosts	ultrasound	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ultrasound	anonymous
9a14d355-6d90-4637-a8ea-b5d0760b615f	Consent Required	ultrasound	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ultrasound	anonymous
7394170d-9a43-4da5-9451-d448ef71e6af	Full Scope Disabled	ultrasound	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ultrasound	anonymous
365a7839-4d48-4ac3-a8d7-5ee87297cea9	Max Clients Limit	ultrasound	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ultrasound	anonymous
386b3322-258c-4ac0-970d-2ba91604e819	Allowed Protocol Mapper Types	ultrasound	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ultrasound	anonymous
a7fe9ac3-a2ab-4774-88bb-76b1ee3d6e5f	Allowed Client Scopes	ultrasound	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ultrasound	anonymous
2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	Allowed Protocol Mapper Types	ultrasound	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ultrasound	authenticated
b9c53c3e-2e9e-411e-8c6b-29f5f726d5bd	Allowed Client Scopes	ultrasound	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ultrasound	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
b7089e7e-98c0-4df0-a885-d5f55ed6016b	81aeed5e-fcb0-4ebc-977f-52ce5237bb22	allow-default-scopes	true
f44599c7-f6b3-4808-95d8-8ff6d663071b	6c1cec90-a294-46c0-a112-a1b00d38629c	allowed-protocol-mapper-types	saml-user-attribute-mapper
ed22a499-3f64-4a3a-aad3-d3fec4f9f7de	6c1cec90-a294-46c0-a112-a1b00d38629c	allowed-protocol-mapper-types	saml-role-list-mapper
035897fa-d3c7-4a39-9087-ba236ac356f8	6c1cec90-a294-46c0-a112-a1b00d38629c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
06b8eef4-4cd1-44e6-bd52-4d044f748342	6c1cec90-a294-46c0-a112-a1b00d38629c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6b522140-9bdb-4918-9247-e2d5358eaeb3	6c1cec90-a294-46c0-a112-a1b00d38629c	allowed-protocol-mapper-types	oidc-full-name-mapper
4c362f4f-5f84-4719-9863-d466d8d53bb4	6c1cec90-a294-46c0-a112-a1b00d38629c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
90e3f431-4188-48cf-a513-cfde9eb911c9	6c1cec90-a294-46c0-a112-a1b00d38629c	allowed-protocol-mapper-types	oidc-address-mapper
6403d948-8a21-43ab-b7f8-73ca0ef86737	6c1cec90-a294-46c0-a112-a1b00d38629c	allowed-protocol-mapper-types	saml-user-property-mapper
3c226140-1707-49a9-8614-6417ca693c86	f2ba34b9-88e3-484c-abe8-63e3c700874f	client-uris-must-match	true
644de455-295f-4098-bfb2-72fedeee72d4	f2ba34b9-88e3-484c-abe8-63e3c700874f	host-sending-registration-request-must-match	true
7af50ceb-f355-4bf3-854b-b38eb12d76e9	cac663a2-7879-4aa0-81f8-04d06a0ba8ba	allow-default-scopes	true
7def4956-bb10-482c-a438-91183ed04226	b7d2f1c6-151f-4e54-a955-d9325129168f	max-clients	200
d17979da-dbf7-4b6c-8f72-14c0bc1d606a	a121bdd4-a59c-4094-837d-888e3a063ff6	allowed-protocol-mapper-types	saml-user-attribute-mapper
73f038ac-8592-4224-98d8-02c344d44b49	a121bdd4-a59c-4094-837d-888e3a063ff6	allowed-protocol-mapper-types	oidc-address-mapper
66797830-c085-4476-aac4-e08721ab0947	a121bdd4-a59c-4094-837d-888e3a063ff6	allowed-protocol-mapper-types	saml-role-list-mapper
e46b2e11-cdfc-4532-815a-f06d32f202df	a121bdd4-a59c-4094-837d-888e3a063ff6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
71c82bf5-6075-49f3-9b2b-9ff8bec31eaf	a121bdd4-a59c-4094-837d-888e3a063ff6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7d6ad557-2104-4331-966a-df81d076b044	a121bdd4-a59c-4094-837d-888e3a063ff6	allowed-protocol-mapper-types	saml-user-property-mapper
41e3ea8f-bf9b-4db6-8634-e8e5724486a5	a121bdd4-a59c-4094-837d-888e3a063ff6	allowed-protocol-mapper-types	oidc-full-name-mapper
e9aa93fb-93ab-4495-999d-b384c11a0417	a121bdd4-a59c-4094-837d-888e3a063ff6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9e6fa57b-16cd-4568-80bf-507aae5714f0	344915aa-c7ac-4e7f-8338-86143cc97968	priority	100
90b1d192-2d10-413b-b3c5-ebc60a049340	344915aa-c7ac-4e7f-8338-86143cc97968	certificate	MIICmzCCAYMCBgFxyc3bOTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjAwNDMwMDYzNTQzWhcNMzAwNDMwMDYzNzIzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCYFlOZyOqJXR1pnA+BQIB1j9ZxmcxfxIjtYOQoTAIv+fSTzbRnaxatSlZPdyQiJRJJcgYhzWgDC2BHl7E1+PiKyTr54vybqTgChpxVLNW0NkTp2zzGn/P9g4HJcUovXZXCeSYlBL3KrTda7ZXt1mYWYHMiaz/RVe3x5t7364q+KsWhYp/rUk5aeMKOxS3UcdmRu9uVF43cx74hYQacTKmFPbeNW07ZbND3cG420QTrgA8U9fqmkXYoje/4TIlLjTWrogPl2gRawtk7MKgeL7QR74nXnFz1bnw0HxKZj6hNYbxZ53mvC6jjrBn3aq5xl8s/yAcU+57p3HIuAT1hHvb7AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIr4bDqOEB29xlGhC9MiajXU01XSCaIGRxfo0UXCDGXEW0wF2A5bflFAYeTMKTfTA5VBhGAbb/BHbfOmLMvkPL9c/U/Indl9HnEXBZt0AFRmvWGmgcrc4iE3DXbGDnD6pEd8+WbEKGsrtj7x5g/H92go+fLz+b1wxXYXQD5K2u5oF1J+thdlJPob5O5dAG5ycebDmA9352RwxuLGLXiqUpRuwUtEU1KYJqx1WxXe7XOBOnEfHUuQd+qDOuICuOl2jMbUX54eebJ8xRlZHn4IpLiwysrwny8QCv2hdVnAy3/eY4ZWBTxPdQo0lgJwtP4bQ7kwxg9BmUTDfuL83XJWOxk=
7968a4e9-8b4e-4c39-9d48-6d1873ea791d	344915aa-c7ac-4e7f-8338-86143cc97968	privateKey	MIIEpQIBAAKCAQEAmBZTmcjqiV0daZwPgUCAdY/WcZnMX8SI7WDkKEwCL/n0k820Z2sWrUpWT3ckIiUSSXIGIc1oAwtgR5exNfj4isk6+eL8m6k4AoacVSzVtDZE6ds8xp/z/YOByXFKL12VwnkmJQS9yq03Wu2V7dZmFmBzIms/0VXt8ebe9+uKvirFoWKf61JOWnjCjsUt1HHZkbvblReN3Me+IWEGnEyphT23jVtO2WzQ93BuNtEE64APFPX6ppF2KI3v+EyJS401q6ID5doEWsLZOzCoHi+0Ee+J15xc9W58NB8SmY+oTWG8Wed5rwuo46wZ92qucZfLP8gHFPue6dxyLgE9YR72+wIDAQABAoIBAQCGrrboKDHy5V/np4lfh/R6p59bSLzhTlWICdbjDLSfMfZycadCMmaJnZwjkTmRd0zjd7OQeauTjp57qA0J4+qOVTgCFQ5o9wkfy39kOmkhxzFt+3Wt2/ahWbU05DuzCGhYKRsrizBb7NtpjZ7JWaVcSZuMLnf8dOFb6H0qBg/+6NQC9BBXxSEJo5ft5UN7OjEy7/nBOfKXCF1nxIB4nF+pDJWGfq6V59MKykX7bq76x29RSqinOY514Crz8EmIiDw5KNF/HQIgsDShWs9ZKQZFfmGcENRkY+znXcfcAode76VvrQAlmqiGVlzC9Ytobzl8QEBXuKb/qxW1QJl9qeUZAoGBAO6M/XT9zMq77Csi/BJnF1kd2/t24a0KyiMomLJkfcDMmOBO7U7a8dRzfyJyqQJTM2ptTZZCGAN3wzGyFrOpX0/dSij+Y70AA+jdRLpLRUasw+Y9jE5o05mPGLBN+0yO6MIdokVe9H0U+5jooyOslbhsolgklp7TKtwUcewGtThfAoGBAKM2QOdaM5pk7P/v4VyH8uGu60rc4XmU1keQY2ebsO5MnjIA+rter7zODxEQ8/IOXcHiHdkTnaZ6XdUgh9iDwf4zj84zaZZX3TAiSaH7TQ8wCG4gIwxp0ZJEN/QcIiFGQpRjj7hE387wSvVjFu3jhl4zsQPGiMvzD7prGY8bELblAoGAOWx3FtKBmcvi7f9d7pAibrFhYwcbDCysvAnpuAe4vdCCfHyDY5gQ3rNuxzwSsxyUI+pr4t/GKA+MTUoxbM44w2DhmTyjhbubNVMOWEoGQx0TizkFrVpOlYh8yPP8qlE8dn3rsgdJk1KZvhVCMDQ7VknQSqeEGnd6ub+yLL7woMECgYEAkd+4zM6bFqCkDvCIvRopJDshw8x9nhxAFMBhiEXoMmS6c7jaYMN1UMvfPYKodi0O8W42/UECA7yUxxuHLyY8KgZNvp/G/H/ViuLqauNf8XYd4sfIa5zcmd1tITpP6uuQMG54EttEKgItDPuej8pu2x1aViSJObgp05VLx9MJ8l0CgYEA2fSktieLGYGc+lR9ULrQPc+R9Y9nyB7ls+WDvGiWOowT5GQwDAUmkkMVwuVWOXnkvEiRM1c8LxQSQjB8XQZZhPQ2Cy6AJMalqW8SxgSEO4/xZ684Ittcq6N23s6gh+BPXMzUbwVjIV6koqF3O1DIhvyql4V2NW1xpCaZtfiazuo=
3c39c264-4c6a-4b52-ba17-4520a4d20d92	01564ce8-8035-4f28-86fb-8b4ff5dc5508	kid	a552e0b5-03dc-4c10-9a71-0501d46ada96
d34de300-69d9-48d8-9da4-0abd556e9479	01564ce8-8035-4f28-86fb-8b4ff5dc5508	priority	100
b1550a64-6e2b-4b68-bc84-ca9755c65639	01564ce8-8035-4f28-86fb-8b4ff5dc5508	secret	Ii1zwglOH_leWKcMU0mGbQ
0bc67a1a-b45f-4bdd-8b7b-721d73e7c416	c0f1dc47-242d-4906-95b3-7dd8f128fac6	priority	100
c9808965-883a-4405-b2b9-ca7657889d22	c0f1dc47-242d-4906-95b3-7dd8f128fac6	algorithm	HS256
58194057-8f87-4f20-8ab0-da2000d33a61	c0f1dc47-242d-4906-95b3-7dd8f128fac6	kid	f7c6eda3-63c5-4773-964b-b87efc7b5c16
60921fc0-da55-459d-a08b-c7a53bba2c1f	c0f1dc47-242d-4906-95b3-7dd8f128fac6	secret	9MD56YlNV-0EKFUTt8pvIAZksjBs9z6aEwF9AQ95KcPh0NRGG5ghqpq0lHFxyESi82eAx5fz65Wb3ZvImbUNCA
fa8575ec-5e23-440d-bb1b-425ddc832814	180f0308-1ed2-4d97-a080-9350329eddca	priority	100
238a63f7-b0c4-4589-81d1-73ce00ea4d5a	180f0308-1ed2-4d97-a080-9350329eddca	kid	8086f34a-9a70-4fd7-bb9e-f30a158dc63b
e210af74-48c9-4bb1-8236-bf7e072ccd08	180f0308-1ed2-4d97-a080-9350329eddca	algorithm	HS256
32d9bfd5-a0b8-4d88-ab18-f286ea8eac20	180f0308-1ed2-4d97-a080-9350329eddca	secret	knugKDUVedHWacx8U6mB3Am07KkbnMws5X7z1mk85wDo6olOd5XOnvwm3F06nd33mbLXvLjsxGwMwLNS2WN7LA
71d5dfb6-afad-4b21-9fc6-c6956bb021d2	4b23b918-f66f-4300-9e97-5775a3235aec	kid	0c5704fc-419b-48bb-a5c5-e9bdfc7180d4
3b6a3b96-a35b-4cb1-aad6-63478d5d17d0	4b23b918-f66f-4300-9e97-5775a3235aec	secret	zeBvnp4p0jMqp_OmLkIvuQ
011a15c0-9d1a-4df6-bfd1-108cf90f9cbf	4b23b918-f66f-4300-9e97-5775a3235aec	priority	100
8fe9a658-eba9-432a-939e-1be7866ea541	9f12ea4b-fa1e-45f9-b187-b74ab6936dfc	priority	100
bbc0b182-0716-4b7d-980d-2285512742fd	9f12ea4b-fa1e-45f9-b187-b74ab6936dfc	privateKey	MIIEowIBAAKCAQEAhu22S2RekIykZgfYmhECnGsH5daeJ+Hsxy2RnRIp7NFJ4SzWnavQXasW5e2ajujijkek7FpLuM3a4AnGbDiKjxOs14/4BgFcUNJy6hvUCcuxwhJas/LJjTYoY6oZnVGJMFpjvxLW+b+y3b0VIdVhb4YK8nVtb+OveTYGnYq6+PRpeK+DURtaVAWMWMBuQjvKMjxNSwZHcjVzzVXeHz4ilrNJSk/zacffuJ6Yl9UYHRsJTzqVn/DBkFwOsKAbJqYONqi0ecq1x94UmCJtf/S8x1gY+cA3VvUU527LOB6eb/XdQx4j4vmlRbNYNUdg3VgnHEPjqZ/Cza9bmZu+zszaIwIDAQABAoIBACZAtnHhXr30YZdbmhjzwZ2+6lpK4kPEVXCShrnVMHWnUB66q42/7C7iFnfRSQRDGhfkT+mCH/2gvvDNVKfRz9aIaXQjqNlrAVUYlOOySAcO7LJsqbJinqmeNQ0saF6lgxNmTOka2j+sDXW36YnSCPGpOulKSWBzWIgwvOdlMWTq3F+pvbMBhluOnrA4UvAbMp2ETmzfWusKDkSplOXomWb0LhjHQ19EoMQk7bFjXsArsPRcS3xEZdZyoFDyGUsjLUfSkDB5pVDXe6f7iUV8LJlwZNsVWYOQf7ywGtkQjd0A+z0nfqAo/IcL7SZzZ0pyBGP6d+I85/vlTejF28/hDkECgYEAyDD5dWiCu1ec8GU0A4DXw709qGwVk7869aqgMOx75fYls0C0VMbnP7+id09JAI4YLFNyfBI29eU4dkFgUx3GSEf782AFTtBsui8d6Sb4uxkjgljm4QHk4ofMqcXf8zMeqdp9sE1AX75ok2RgxnqQvGiUNppshC5AUo/IVD8ATMsCgYEArIsj7lGKxNVuJQiPZ5up+zRAcySGAYp0/a9OGQGh5R0kTkRlDkKmbNErgHydSQ50Nxe07DAXIMdn16e067saaF0709ozU/kyBX0I6KOkg3MOMrcxyRCj6MgFAoMB5N1KYjmwG0xtwdzuc6gqJcvcioecjb7VodCv4OMx3zZIlQkCgYAEjGBOk5ZMzVvKdnItFjNQxi7tca830SN0y3CiS+0wt1v566FtP6unXiJB1bJR6eiQsUCrovpOseuLfEbE/KsxnzkROYBFXyTpQgLK9lC2Z4bQAlcUi6d4oh87SDyjWOj8cPNkGw04X6oelyw/ti8tqK6dYvrOMgLSHWQuzdOi6wKBgQCoOSBXAnlhXxV8VdQ7F7GqkU8k878TUYKus3RZPRYy4y66gERmmuTXwze+lcBjsgvsitiCToC+HKxJveDO1CTzC7OA4YSZoqP6ZeWBq8qBvnNhTurjNa4ZDqqTwFbgZEBZdBUXCHUaReTWLmapYxEqnv0r1ZtDoMtZXykIj0xEwQKBgAmWJ76C5ZUf9iVeA35LenzQEqB4Ga9nVBSHO1D9dK0xfzCQKBKAUXABaDB78W5OI5iXBpXWAj2l5a5bZS+NGWO6BDSsV0CfIrsKWFDSkVhyAzCnsvDPf2IC4CUmVAYCIcf7ZjRLestY590NR7UMxOYdo7Feao4LfPL12b0KcQTH
cccc148a-29eb-4e2c-87a4-fb8157567474	9f12ea4b-fa1e-45f9-b187-b74ab6936dfc	certificate	MIICozCCAYsCBgFxyc/0JjANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDAp1bHRyYXNvdW5kMB4XDTIwMDQzMDA2MzgwMVoXDTMwMDQzMDA2Mzk0MVowFTETMBEGA1UEAwwKdWx0cmFzb3VuZDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIbttktkXpCMpGYH2JoRApxrB+XWnifh7MctkZ0SKezRSeEs1p2r0F2rFuXtmo7o4o5HpOxaS7jN2uAJxmw4io8TrNeP+AYBXFDScuob1AnLscISWrPyyY02KGOqGZ1RiTBaY78S1vm/st29FSHVYW+GCvJ1bW/jr3k2Bp2Kuvj0aXivg1EbWlQFjFjAbkI7yjI8TUsGR3I1c81V3h8+IpazSUpP82nH37iemJfVGB0bCU86lZ/wwZBcDrCgGyamDjaotHnKtcfeFJgibX/0vMdYGPnAN1b1FOduyzgenm/13UMeI+L5pUWzWDVHYN1YJxxD46mfws2vW5mbvs7M2iMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAhZUDvpT/r0UleAkB0EdY4V0RcB2i7SXgfCuH3Dre+mtd40Wn52NrqeCBcmE8DNv1NNqpYMNJslSc3piM2yqz385IiK+AvdRTiEWLbO0JRY/0mwpN7+pNSlSm6MrsjytX44i5YPqPBREVc4USh03yJI0qKw3Novtf6C+e+JPQG8HOOchUpYX3fCzp2I7rrwaLJhTPXa1F5HXU6aXRjTyz0yiU+ZTG7FVwG5oHPi4pnPJRSnd9xvv+bVSeoCsUTXXAxIPwr+nQRniGZ0GX96kZY4rDjps+Zl0SQWZ7IoAeDXfIuL58KAuUlkvOaa7ljEA665rSYvYaXSqldiYdv1/Xaw==
f9338f8f-dddf-4bc9-ac00-af52d23062f8	b9c53c3e-2e9e-411e-8c6b-29f5f726d5bd	allow-default-scopes	true
94c8a27b-ff8d-4b53-96c5-8f5d89279e35	365a7839-4d48-4ac3-a8d7-5ee87297cea9	max-clients	200
0251cacd-2f53-45ee-b846-15931cbbbf85	09626b6b-6d96-494e-bff1-fa162dacaa5d	host-sending-registration-request-must-match	true
310b0ed2-2f79-4884-8949-d41b767b68c7	09626b6b-6d96-494e-bff1-fa162dacaa5d	client-uris-must-match	true
589b37e7-e105-4de8-ad8f-973dda49b168	386b3322-258c-4ac0-970d-2ba91604e819	allowed-protocol-mapper-types	oidc-full-name-mapper
a7daef7e-1f98-4fac-b793-de0d03e5a144	386b3322-258c-4ac0-970d-2ba91604e819	allowed-protocol-mapper-types	oidc-address-mapper
1ce80e51-dc21-4a7f-b07a-9bc9e5cd7a33	386b3322-258c-4ac0-970d-2ba91604e819	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c6723ddc-0328-491f-9945-4aa8bb762fca	386b3322-258c-4ac0-970d-2ba91604e819	allowed-protocol-mapper-types	saml-user-attribute-mapper
db1bbb11-09c0-47ea-aa3a-08fcaa02eada	386b3322-258c-4ac0-970d-2ba91604e819	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7d7fe263-a890-4e08-b1fc-53adfd00db57	386b3322-258c-4ac0-970d-2ba91604e819	allowed-protocol-mapper-types	saml-user-property-mapper
91be34f8-4466-4c0c-a22c-b0032435a659	386b3322-258c-4ac0-970d-2ba91604e819	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
23aedc79-5758-4b2d-96b2-f9e5b2a1596f	386b3322-258c-4ac0-970d-2ba91604e819	allowed-protocol-mapper-types	saml-role-list-mapper
095641c6-060b-4eba-abf6-5a6d590cd36f	a7fe9ac3-a2ab-4774-88bb-76b1ee3d6e5f	allow-default-scopes	true
df8dd813-0995-4801-9e2b-3b2586a2ca9b	2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9514570d-9aba-4ea3-970e-05b2594cdbf5	2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	allowed-protocol-mapper-types	oidc-full-name-mapper
159ddddd-c79f-4ab2-bf11-0e457a6331c0	2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	allowed-protocol-mapper-types	saml-user-attribute-mapper
f9e6c76c-4194-4d49-8091-00d87c67122e	2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
92d94f9f-f0e7-441c-9891-93675bdf4c79	2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	allowed-protocol-mapper-types	saml-role-list-mapper
04f8786b-e3af-4d7a-899c-928017bf9850	2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	allowed-protocol-mapper-types	oidc-address-mapper
f8c5df75-ea3d-47d9-87f7-8dc43365a099	2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
db7cbaf8-d266-4382-b1a4-f0e4de654ed0	2b2f81e7-3ab5-49c8-bda7-c699bd8ced90	allowed-protocol-mapper-types	saml-user-property-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
130afcfe-7580-4e1e-ab62-83ddb0fa10db	a4419619-8d68-481a-ae8b-d48d36bbba70
130afcfe-7580-4e1e-ab62-83ddb0fa10db	0f01c6dd-8f39-4b6c-a360-4c1803eca487
130afcfe-7580-4e1e-ab62-83ddb0fa10db	4e738e06-2b9d-45b9-80ae-a750d9441c46
130afcfe-7580-4e1e-ab62-83ddb0fa10db	a3d7a508-ab37-410c-8df6-bdd6170d2143
130afcfe-7580-4e1e-ab62-83ddb0fa10db	bc2708c6-ca10-40ae-82f5-ddee312a5e4e
130afcfe-7580-4e1e-ab62-83ddb0fa10db	bea5ccb9-cec0-46e1-8bf0-376c8ecdd2a2
130afcfe-7580-4e1e-ab62-83ddb0fa10db	46d21384-65a2-44b6-a4fd-8bca8f9a152f
130afcfe-7580-4e1e-ab62-83ddb0fa10db	e9dc81cd-1140-48c9-a065-6b98f1655cbc
130afcfe-7580-4e1e-ab62-83ddb0fa10db	a60af95c-abb5-4d3b-91b4-e32a6dcbafe9
130afcfe-7580-4e1e-ab62-83ddb0fa10db	ee092b26-bb50-4b37-8952-9e6a0ff4bb85
130afcfe-7580-4e1e-ab62-83ddb0fa10db	f1cfbb4c-3e78-4720-a235-fbb3dcc95810
130afcfe-7580-4e1e-ab62-83ddb0fa10db	44e34c6b-54ec-49a8-9d19-77d9e88fd5d6
130afcfe-7580-4e1e-ab62-83ddb0fa10db	2a1acb2e-880a-4191-a408-23b3c87f71af
130afcfe-7580-4e1e-ab62-83ddb0fa10db	448421ed-8f9c-41f6-a3cc-8620c83d0105
130afcfe-7580-4e1e-ab62-83ddb0fa10db	63a61f52-0b8a-4147-9e93-d20261835834
130afcfe-7580-4e1e-ab62-83ddb0fa10db	77e79e1f-b20f-4f93-bc1a-ec32c0cebf04
130afcfe-7580-4e1e-ab62-83ddb0fa10db	d166bd78-dd15-4e71-8379-20eef0e67479
130afcfe-7580-4e1e-ab62-83ddb0fa10db	ca3f69e1-4b93-40ba-8625-37ca7d0d468e
a3d7a508-ab37-410c-8df6-bdd6170d2143	ca3f69e1-4b93-40ba-8625-37ca7d0d468e
a3d7a508-ab37-410c-8df6-bdd6170d2143	63a61f52-0b8a-4147-9e93-d20261835834
bc2708c6-ca10-40ae-82f5-ddee312a5e4e	77e79e1f-b20f-4f93-bc1a-ec32c0cebf04
436245c0-82c7-4c67-bb33-6c98db9dab61	47ab20a5-af60-4c66-9cd0-d321e7d432ba
130afcfe-7580-4e1e-ab62-83ddb0fa10db	ac1d3713-11c0-4151-b916-1443d857c711
130afcfe-7580-4e1e-ab62-83ddb0fa10db	bd02bcc6-aaeb-4435-ab50-5cb6122fa8c8
130afcfe-7580-4e1e-ab62-83ddb0fa10db	74c5b1e4-1d9d-4fff-a0f4-c2781ea57d3f
130afcfe-7580-4e1e-ab62-83ddb0fa10db	9525ef92-737e-4093-8d8d-bd31c1612e2c
130afcfe-7580-4e1e-ab62-83ddb0fa10db	b5c60d24-4320-4704-a097-59208e216dc5
130afcfe-7580-4e1e-ab62-83ddb0fa10db	4a48c319-44a5-4f72-83a8-79765edfdb48
130afcfe-7580-4e1e-ab62-83ddb0fa10db	0c2005c2-adc1-40ed-a9c3-e01d95d53a5d
130afcfe-7580-4e1e-ab62-83ddb0fa10db	b4ba9b05-d5f3-420b-8bc6-699097231ee8
130afcfe-7580-4e1e-ab62-83ddb0fa10db	f203d34d-0f27-4d33-a8b9-fa9c212cc1bb
130afcfe-7580-4e1e-ab62-83ddb0fa10db	76a97999-0e64-4288-932e-5fb8618a3312
130afcfe-7580-4e1e-ab62-83ddb0fa10db	96eb8cf6-520d-4ecc-a107-9ee1605b774a
130afcfe-7580-4e1e-ab62-83ddb0fa10db	b420f4cc-1638-4ab8-b7fd-9f8aa13458ca
130afcfe-7580-4e1e-ab62-83ddb0fa10db	7a8e2a64-858c-43fc-8eaa-628128b9ed86
130afcfe-7580-4e1e-ab62-83ddb0fa10db	ddd851b4-1a14-4829-bad2-96322e7e85fc
130afcfe-7580-4e1e-ab62-83ddb0fa10db	07d58b56-bce3-451a-96c0-ac129666ccb7
130afcfe-7580-4e1e-ab62-83ddb0fa10db	c708515c-cd1c-45e4-b7f6-2cc8d0f61f58
130afcfe-7580-4e1e-ab62-83ddb0fa10db	dd50817d-b2ec-4aca-a18f-12293ef84db3
130afcfe-7580-4e1e-ab62-83ddb0fa10db	fdddc34d-1c96-4c2e-92a3-e8e216e249e4
9525ef92-737e-4093-8d8d-bd31c1612e2c	fdddc34d-1c96-4c2e-92a3-e8e216e249e4
9525ef92-737e-4093-8d8d-bd31c1612e2c	07d58b56-bce3-451a-96c0-ac129666ccb7
b5c60d24-4320-4704-a097-59208e216dc5	c708515c-cd1c-45e4-b7f6-2cc8d0f61f58
3c0c7b1f-4feb-484b-a0af-2105855a4da4	dda8b5f2-6f9d-4792-a039-01f8221d7f30
3c0c7b1f-4feb-484b-a0af-2105855a4da4	3162f2b1-234d-4941-bb9f-e32ff6133a0c
3c0c7b1f-4feb-484b-a0af-2105855a4da4	77ac8698-5a9f-4d6a-bdb3-f2d322b817b1
3c0c7b1f-4feb-484b-a0af-2105855a4da4	acf8bd00-ad64-435a-9a47-7802e00e7e80
3c0c7b1f-4feb-484b-a0af-2105855a4da4	7c3a8dbc-31c6-40da-9f88-ee918358aa60
3c0c7b1f-4feb-484b-a0af-2105855a4da4	a5e9d9ed-6198-4a36-9e12-09aceaa58f0b
3c0c7b1f-4feb-484b-a0af-2105855a4da4	b902fec1-3295-4e0b-95dd-9d7a313f977b
3c0c7b1f-4feb-484b-a0af-2105855a4da4	ca6e855c-422e-4a59-b97d-433484e02e17
3c0c7b1f-4feb-484b-a0af-2105855a4da4	04cea247-16e8-4465-8670-dd064f5f2830
3c0c7b1f-4feb-484b-a0af-2105855a4da4	9c4e5558-0cfe-4933-b99c-f22a9a7a9054
3c0c7b1f-4feb-484b-a0af-2105855a4da4	e62e31a3-c182-41bf-8583-b50fc6da0470
3c0c7b1f-4feb-484b-a0af-2105855a4da4	25add928-f1f1-4456-ad8e-e0ee5058c6e2
3c0c7b1f-4feb-484b-a0af-2105855a4da4	e6dd92fa-3f9e-437d-877f-3df6c15662f3
3c0c7b1f-4feb-484b-a0af-2105855a4da4	7fcbd65a-a5d8-4c52-a087-7ade9f651220
3c0c7b1f-4feb-484b-a0af-2105855a4da4	11ea189a-afca-48af-aa53-c5a1c7b9e691
3c0c7b1f-4feb-484b-a0af-2105855a4da4	a828b184-34c5-4779-a082-86d178a42ffb
3c0c7b1f-4feb-484b-a0af-2105855a4da4	1703b197-23b3-4f2b-b8eb-f813eea539fc
77ac8698-5a9f-4d6a-bdb3-f2d322b817b1	1703b197-23b3-4f2b-b8eb-f813eea539fc
77ac8698-5a9f-4d6a-bdb3-f2d322b817b1	7fcbd65a-a5d8-4c52-a087-7ade9f651220
acf8bd00-ad64-435a-9a47-7802e00e7e80	11ea189a-afca-48af-aa53-c5a1c7b9e691
130afcfe-7580-4e1e-ab62-83ddb0fa10db	95f71433-273e-4420-9925-f4f29793f72e
e731afdd-5538-4051-b8a5-91c662942f56	33faed14-d331-44ff-89c2-0b2644077fc5
3c0c7b1f-4feb-484b-a0af-2105855a4da4	502e69e6-6fa6-4dd2-93f0-056ef6109109
71b96c25-955b-4b13-b549-cd0e7cef7f11	fbd9e6d4-578a-4386-88ba-f3877bf17162
9d32512b-5961-43fa-a3ef-910f997b662d	a430d01a-7ce9-48d4-a29f-fe7fd0a6a53e
0bf49efc-d31c-4a24-8536-2bfdaa09aa26	baf94d6a-6e93-4eef-b0ba-11c8e786be48
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
727e2aa5-bd14-4d81-89e2-8d965e8abc38	\N	password	20d60a50-b274-4fb7-a106-b0ae37304b72	1588228644111	\N	{"value":"xxSPZrdvw/IxENHLGPQSECNShclXQRxShv6V6NXkFwqyCSJQvr9+UIQ0Q5gJ6wBLre3yrzcOSpZfH4Cfi08QDQ==","salt":"c2b41cKqXBQ266765OB3xA=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
401514b5-d19f-471b-b38f-5b58e52cdb22	\N	password	3759993d-d3de-4eea-8d34-526e46484168	1588231542591	\N	{"value":"5PEkcdt159U7XG/MaJj1wkJv42XfhH2Gd/TJeO0LSNLXCaXuSYWtsleoZDa03+d6YemRL3KZ6lkzovlCWrw3lA==","salt":"PawrqHrT3T7KbvLc7D7O3A=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
6c3ec759-fa4a-4a40-93ef-1fe56496aec9	\N	password	32a8c53c-130c-456c-9163-9a3206528d60	1588231711970	\N	{"value":"i+3Ioba0dQqOGfFxEJhf96YAgse3x4R0qnyD2Uop1VY9K4kS3FlBL1v9Ovglb610CGBMKR+puwj/avgI0fPqSA==","salt":"bvxYbBi9Q6B5cyl/vBrINA=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
ad6fed94-1b3a-43c0-be48-2f1312984eec	\N	password	8dc4c492-ce8d-4368-9484-7a2e122b988e	1588231859377	\N	{"value":"tn1t49qGcWMufcqJPjmaSGan/IRrkGpWPFTB1FBzr41Uz7ZpMcohrKBAlcdLhZVyjQavlmo+EAM1PoOEzPHBeg==","salt":"6/LPQb4Y3aqvkHlYBSuPKg=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
2462b083-e1b4-4d9a-9569-46b15ca5619c	\N	password	6b27bda4-9237-4b87-b6a9-474e7e68a87a	1588231906974	\N	{"value":"G7eItl7ksACYymECrWqWt1oC99Ri28xfHCyWhDeYa/f959FWa4PVIgsmyymM+45f0x/yZKBteX+pa/Wd201BDw==","salt":"kPnYcfp/tTYTDZhMywdixQ=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
27abaa52-c910-4737-9654-2bc62ac7cef4	\N	password	6ac3a59a-8d32-4a7c-aa4d-6124179672aa	1588232106827	\N	{"value":"wgQl7R/l6EjCL6ILzO1Fu0a5yz6m3fYJakOeqUQjYQPQH9zgZaGTUidm5qZMiQQJ7YR++qWd6FgYIytO8og02Q==","salt":"b91egwIsa71fEibuD98nRA=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
6c2a5b1f-dd6b-4b5a-9223-75354225c8b8	\N	password	1ade46d6-d1bd-4890-9d67-02782dd9dd41	1588232161153	\N	{"value":"813OPVAe5wedsf53ZRediuZa/fnBge0tIXBfO+wwGZKuhR628O/D81faMla+XD9Eqx/w0M2yFDrJ7IWCHRRSKQ==","salt":"88FyAY4R6W20QKbzS+MIqw=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
be1fbd07-0cce-4b8d-a223-805b1cc6a963	\N	password	288a0b04-acd1-4452-8bde-13d4c01baae0	1588232211842	\N	{"value":"vaH7frQU97U1UtDI1kGU48qko5yMWQULVOU3dVhPF6aFZhKn0KqajXOCg5hD6Cqxib/+wzdMou0gEpcDOKyIyA==","salt":"P2OLHrAwEj1OwAs9BnVLEg=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
1471a2ec-f450-4f1e-a9ad-a8662b7455be	\N	password	7bc53c30-bdb8-4bdb-82d3-d474733dfb82	1588232272233	\N	{"value":"3dgRp/4DBHc9JA1cv5qEKBimZ3qUWQeDH7RfoJ5O4X9nrhycmacbKnI5/rKW+7WUdFnYZCpAcQ3OayqEo1ugPg==","salt":"9RQVT7YyetnXz52uZQ0uCQ=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
20cc1be0-0e59-40a8-8c5d-36bfd5d92855	\N	password	f23867df-662c-4959-a648-a4059881016c	1588234183798	\N	{"value":"Wo7878UHbZQwSGyyENAb1aUOB+rvTQbsqlkhFpMVoOZ3UuVj6dgIF4bRa0zWd/J5vbIbm3b42bT5x2upzATQ4w==","salt":"j5DncHLcT4LkyJ1gzKryZw=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2020-04-30 14:37:12.851855	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.8.2	\N	\N	8228631439
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2020-04-30 14:37:12.888545	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.8.2	\N	\N	8228631439
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2020-04-30 14:37:13.052314	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.8.2	\N	\N	8228631439
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2020-04-30 14:37:13.073924	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.8.2	\N	\N	8228631439
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2020-04-30 14:37:13.5425	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.8.2	\N	\N	8228631439
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2020-04-30 14:37:13.55504	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.8.2	\N	\N	8228631439
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2020-04-30 14:37:13.903639	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.8.2	\N	\N	8228631439
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2020-04-30 14:37:13.916836	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.8.2	\N	\N	8228631439
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2020-04-30 14:37:13.937543	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.8.2	\N	\N	8228631439
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2020-04-30 14:37:14.526251	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.8.2	\N	\N	8228631439
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2020-04-30 14:37:14.908335	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.8.2	\N	\N	8228631439
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2020-04-30 14:37:14.925657	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.8.2	\N	\N	8228631439
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2020-04-30 14:37:14.985901	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.8.2	\N	\N	8228631439
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-04-30 14:37:15.112488	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.8.2	\N	\N	8228631439
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-04-30 14:37:15.124839	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.8.2	\N	\N	8228631439
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-04-30 14:37:15.134796	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.8.2	\N	\N	8228631439
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-04-30 14:37:15.14532	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.8.2	\N	\N	8228631439
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2020-04-30 14:37:15.350865	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.8.2	\N	\N	8228631439
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2020-04-30 14:37:15.547083	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.8.2	\N	\N	8228631439
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2020-04-30 14:37:15.565642	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.8.2	\N	\N	8228631439
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-30 14:37:18.772505	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.8.2	\N	\N	8228631439
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2020-04-30 14:37:15.580374	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.8.2	\N	\N	8228631439
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2020-04-30 14:37:15.592413	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.8.2	\N	\N	8228631439
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2020-04-30 14:37:15.65869	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.8.2	\N	\N	8228631439
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2020-04-30 14:37:15.678528	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.8.2	\N	\N	8228631439
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2020-04-30 14:37:15.69034	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.8.2	\N	\N	8228631439
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2020-04-30 14:37:15.974267	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.8.2	\N	\N	8228631439
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2020-04-30 14:37:16.534762	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.8.2	\N	\N	8228631439
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2020-04-30 14:37:16.558676	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	3.8.2	\N	\N	8228631439
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2020-04-30 14:37:16.997203	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.8.2	\N	\N	8228631439
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2020-04-30 14:37:17.074791	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.8.2	\N	\N	8228631439
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2020-04-30 14:37:17.153971	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.8.2	\N	\N	8228631439
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2020-04-30 14:37:17.172657	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	3.8.2	\N	\N	8228631439
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-04-30 14:37:17.198443	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.8.2	\N	\N	8228631439
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-04-30 14:37:17.21096	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.8.2	\N	\N	8228631439
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-04-30 14:37:17.349667	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.8.2	\N	\N	8228631439
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2020-04-30 14:37:17.36879	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	3.8.2	\N	\N	8228631439
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-04-30 14:37:17.414175	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.8.2	\N	\N	8228631439
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2020-04-30 14:37:17.436538	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	3.8.2	\N	\N	8228631439
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2020-04-30 14:37:17.459346	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	3.8.2	\N	\N	8228631439
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-04-30 14:37:17.471383	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.8.2	\N	\N	8228631439
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-04-30 14:37:17.481522	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.8.2	\N	\N	8228631439
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2020-04-30 14:37:17.496106	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	3.8.2	\N	\N	8228631439
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-04-30 14:37:18.734104	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.8.2	\N	\N	8228631439
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2020-04-30 14:37:18.750075	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	3.8.2	\N	\N	8228631439
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-30 14:37:18.785805	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	3.8.2	\N	\N	8228631439
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-30 14:37:18.795064	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.8.2	\N	\N	8228631439
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-30 14:37:19.027697	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.8.2	\N	\N	8228631439
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-04-30 14:37:19.044029	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	3.8.2	\N	\N	8228631439
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2020-04-30 14:37:19.388727	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.8.2	\N	\N	8228631439
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2020-04-30 14:37:19.769638	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.8.2	\N	\N	8228631439
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2020-04-30 14:37:19.79117	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.8.2	\N	\N	8228631439
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2020-04-30 14:37:19.805656	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	3.8.2	\N	\N	8228631439
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2020-04-30 14:37:19.817606	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	3.8.2	\N	\N	8228631439
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-04-30 14:37:19.858547	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.8.2	\N	\N	8228631439
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-04-30 14:37:19.881847	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.8.2	\N	\N	8228631439
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-04-30 14:37:20.020911	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.8.2	\N	\N	8228631439
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-04-30 14:37:20.473166	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.8.2	\N	\N	8228631439
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2020-04-30 14:37:20.598443	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.8.2	\N	\N	8228631439
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2020-04-30 14:37:20.619704	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.8.2	\N	\N	8228631439
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-04-30 14:37:20.642255	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.8.2	\N	\N	8228631439
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-04-30 14:37:20.698762	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.8.2	\N	\N	8228631439
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2020-04-30 14:37:20.720892	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.8.2	\N	\N	8228631439
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2020-04-30 14:37:20.732872	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.8.2	\N	\N	8228631439
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2020-04-30 14:37:20.744222	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.8.2	\N	\N	8228631439
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2020-04-30 14:37:20.834088	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.8.2	\N	\N	8228631439
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2020-04-30 14:37:20.87892	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.8.2	\N	\N	8228631439
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2020-04-30 14:37:20.902634	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	3.8.2	\N	\N	8228631439
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2020-04-30 14:37:20.957954	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.8.2	\N	\N	8228631439
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2020-04-30 14:37:20.980263	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.8.2	\N	\N	8228631439
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2020-04-30 14:37:21.002799	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	3.8.2	\N	\N	8228631439
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-30 14:37:21.036557	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.8.2	\N	\N	8228631439
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-30 14:37:21.053824	73	EXECUTED	8:aa47e66c23e04356194fe287169e9c35	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.8.2	\N	\N	8228631439
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-30 14:37:21.058897	74	MARK_RAN	8:aa8d0292cba5b0ca2749f792784db4ce	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.8.2	\N	\N	8228631439
8.0.0-credential-cleanup	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-30 14:37:21.082461	75	EXECUTED	8:d038572f5530ba733aa35dc03bc5ab3f	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.8.2	\N	\N	8228631439
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-04-30 14:37:21.127874	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.8.2	\N	\N	8228631439
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	3d6af9ee-8514-445d-a696-c302ca2a2e23	f
master	2bc504b2-1b6d-4eff-a082-8883810739b4	t
master	ac520590-b024-49e2-8a21-3d5e31a15894	t
master	28f152e1-3239-4de2-b48b-1c07a1e53caf	t
master	343319bd-b7a0-4152-bbcc-fc93e721e16d	f
master	a44deca7-20ca-4b79-a7d1-0fd242e7c505	f
master	ed03075d-3171-4093-b124-b1bf6c5ec848	t
master	439e3867-7b15-4a30-9ff4-c4424e762c85	t
master	caa64c12-0ae0-43d0-a545-5d23b5552079	f
ultrasound	5201b816-e4b6-48b0-a1b0-d1a2b50c777b	f
ultrasound	14b11591-0678-41c2-a5b2-530480ab9285	t
ultrasound	7ddce74c-ce2b-470a-876f-5cf5fe437acb	t
ultrasound	adba83ad-f81c-49d0-9035-25f62179f4f3	t
ultrasound	03cdde96-d844-41da-bbde-a3d4618c7518	f
ultrasound	c05165c3-f634-4cec-935f-327f000758c4	f
ultrasound	4533effa-57b8-43ce-95aa-e1339cbba4ec	t
ultrasound	280ec09a-0242-43b9-98ad-6175fb35c1d8	t
ultrasound	434b9771-b87a-4e97-97f1-9ad9c5e268d7	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
130afcfe-7580-4e1e-ab62-83ddb0fa10db	master	f	${role_admin}	admin	master	\N	master
a4419619-8d68-481a-ae8b-d48d36bbba70	master	f	${role_create-realm}	create-realm	master	\N	master
0f01c6dd-8f39-4b6c-a360-4c1803eca487	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_create-client}	create-client	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
4e738e06-2b9d-45b9-80ae-a750d9441c46	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_view-realm}	view-realm	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
a3d7a508-ab37-410c-8df6-bdd6170d2143	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_view-users}	view-users	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
bc2708c6-ca10-40ae-82f5-ddee312a5e4e	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_view-clients}	view-clients	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
bea5ccb9-cec0-46e1-8bf0-376c8ecdd2a2	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_view-events}	view-events	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
46d21384-65a2-44b6-a4fd-8bca8f9a152f	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_view-identity-providers}	view-identity-providers	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
e9dc81cd-1140-48c9-a065-6b98f1655cbc	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_view-authorization}	view-authorization	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
a60af95c-abb5-4d3b-91b4-e32a6dcbafe9	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_manage-realm}	manage-realm	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
ee092b26-bb50-4b37-8952-9e6a0ff4bb85	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_manage-users}	manage-users	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
f1cfbb4c-3e78-4720-a235-fbb3dcc95810	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_manage-clients}	manage-clients	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
44e34c6b-54ec-49a8-9d19-77d9e88fd5d6	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_manage-events}	manage-events	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
2a1acb2e-880a-4191-a408-23b3c87f71af	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_manage-identity-providers}	manage-identity-providers	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
448421ed-8f9c-41f6-a3cc-8620c83d0105	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_manage-authorization}	manage-authorization	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
63a61f52-0b8a-4147-9e93-d20261835834	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_query-users}	query-users	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
77e79e1f-b20f-4f93-bc1a-ec32c0cebf04	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_query-clients}	query-clients	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
d166bd78-dd15-4e71-8379-20eef0e67479	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_query-realms}	query-realms	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
ca3f69e1-4b93-40ba-8625-37ca7d0d468e	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_query-groups}	query-groups	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
ac9c92a4-7ff1-4d4a-91af-214fbf898838	99ec09f1-251e-4f3c-be53-251d59ab14bb	t	${role_view-profile}	view-profile	master	99ec09f1-251e-4f3c-be53-251d59ab14bb	\N
436245c0-82c7-4c67-bb33-6c98db9dab61	99ec09f1-251e-4f3c-be53-251d59ab14bb	t	${role_manage-account}	manage-account	master	99ec09f1-251e-4f3c-be53-251d59ab14bb	\N
47ab20a5-af60-4c66-9cd0-d321e7d432ba	99ec09f1-251e-4f3c-be53-251d59ab14bb	t	${role_manage-account-links}	manage-account-links	master	99ec09f1-251e-4f3c-be53-251d59ab14bb	\N
75a21f8e-dc41-4171-a9a8-8435ea330883	f30ae4ad-e498-49a8-8c00-c768cdc87f08	t	${role_read-token}	read-token	master	f30ae4ad-e498-49a8-8c00-c768cdc87f08	\N
ac1d3713-11c0-4151-b916-1443d857c711	f11a806c-81a6-4626-ab1b-59ecada89b17	t	${role_impersonation}	impersonation	master	f11a806c-81a6-4626-ab1b-59ecada89b17	\N
331c3eb9-de90-41d9-9fdb-955dafe55f60	master	f	${role_offline-access}	offline_access	master	\N	master
62fc9f49-5d36-49f6-89c0-c0f201369f43	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
bd02bcc6-aaeb-4435-ab50-5cb6122fa8c8	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_create-client}	create-client	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
74c5b1e4-1d9d-4fff-a0f4-c2781ea57d3f	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_view-realm}	view-realm	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
9525ef92-737e-4093-8d8d-bd31c1612e2c	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_view-users}	view-users	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
b5c60d24-4320-4704-a097-59208e216dc5	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_view-clients}	view-clients	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
4a48c319-44a5-4f72-83a8-79765edfdb48	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_view-events}	view-events	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
0c2005c2-adc1-40ed-a9c3-e01d95d53a5d	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_view-identity-providers}	view-identity-providers	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
b4ba9b05-d5f3-420b-8bc6-699097231ee8	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_view-authorization}	view-authorization	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
f203d34d-0f27-4d33-a8b9-fa9c212cc1bb	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_manage-realm}	manage-realm	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
76a97999-0e64-4288-932e-5fb8618a3312	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_manage-users}	manage-users	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
96eb8cf6-520d-4ecc-a107-9ee1605b774a	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_manage-clients}	manage-clients	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
b420f4cc-1638-4ab8-b7fd-9f8aa13458ca	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_manage-events}	manage-events	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
7a8e2a64-858c-43fc-8eaa-628128b9ed86	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_manage-identity-providers}	manage-identity-providers	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
ddd851b4-1a14-4829-bad2-96322e7e85fc	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_manage-authorization}	manage-authorization	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
07d58b56-bce3-451a-96c0-ac129666ccb7	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_query-users}	query-users	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
c708515c-cd1c-45e4-b7f6-2cc8d0f61f58	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_query-clients}	query-clients	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
dd50817d-b2ec-4aca-a18f-12293ef84db3	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_query-realms}	query-realms	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
fdddc34d-1c96-4c2e-92a3-e8e216e249e4	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_query-groups}	query-groups	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
3c0c7b1f-4feb-484b-a0af-2105855a4da4	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_realm-admin}	realm-admin	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
dda8b5f2-6f9d-4792-a039-01f8221d7f30	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_create-client}	create-client	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
3162f2b1-234d-4941-bb9f-e32ff6133a0c	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_view-realm}	view-realm	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
77ac8698-5a9f-4d6a-bdb3-f2d322b817b1	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_view-users}	view-users	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
acf8bd00-ad64-435a-9a47-7802e00e7e80	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_view-clients}	view-clients	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
7c3a8dbc-31c6-40da-9f88-ee918358aa60	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_view-events}	view-events	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
a5e9d9ed-6198-4a36-9e12-09aceaa58f0b	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_view-identity-providers}	view-identity-providers	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
b902fec1-3295-4e0b-95dd-9d7a313f977b	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_view-authorization}	view-authorization	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
ca6e855c-422e-4a59-b97d-433484e02e17	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_manage-realm}	manage-realm	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
04cea247-16e8-4465-8670-dd064f5f2830	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_manage-users}	manage-users	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
9c4e5558-0cfe-4933-b99c-f22a9a7a9054	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_manage-clients}	manage-clients	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
e62e31a3-c182-41bf-8583-b50fc6da0470	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_manage-events}	manage-events	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
25add928-f1f1-4456-ad8e-e0ee5058c6e2	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_manage-identity-providers}	manage-identity-providers	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
e6dd92fa-3f9e-437d-877f-3df6c15662f3	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_manage-authorization}	manage-authorization	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
7fcbd65a-a5d8-4c52-a087-7ade9f651220	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_query-users}	query-users	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
11ea189a-afca-48af-aa53-c5a1c7b9e691	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_query-clients}	query-clients	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
a828b184-34c5-4779-a082-86d178a42ffb	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_query-realms}	query-realms	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
1703b197-23b3-4f2b-b8eb-f813eea539fc	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_query-groups}	query-groups	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	t	${role_view-profile}	view-profile	ultrasound	4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	\N
e731afdd-5538-4051-b8a5-91c662942f56	4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	t	${role_manage-account}	manage-account	ultrasound	4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	\N
33faed14-d331-44ff-89c2-0b2644077fc5	4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	t	${role_manage-account-links}	manage-account-links	ultrasound	4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	\N
95f71433-273e-4420-9925-f4f29793f72e	78879382-f740-4c29-96ab-1d26dd48583a	t	${role_impersonation}	impersonation	master	78879382-f740-4c29-96ab-1d26dd48583a	\N
502e69e6-6fa6-4dd2-93f0-056ef6109109	0ec9e52f-324b-4aba-a233-2fd843b59754	t	${role_impersonation}	impersonation	ultrasound	0ec9e52f-324b-4aba-a233-2fd843b59754	\N
9eca793a-df4e-4349-9daf-f4b0e48a2192	fcff7355-7928-40fa-a1a1-126359992233	t	${role_read-token}	read-token	ultrasound	fcff7355-7928-40fa-a1a1-126359992233	\N
c8046c7f-6373-4bbc-9a7f-993b6573e14a	ultrasound	f	${role_offline-access}	offline_access	ultrasound	\N	ultrasound
0b823a7c-6178-49ea-ba98-827feb70e24a	ultrasound	f	${role_uma_authorization}	uma_authorization	ultrasound	\N	ultrasound
a430d01a-7ce9-48d4-a29f-fe7fd0a6a53e	ddea0ad0-022b-4e77-9b31-221b7facedce	t	Authorize Administrator permission to Ultrasound API Service	ultrasound-admin	ultrasound	ddea0ad0-022b-4e77-9b31-221b7facedce	\N
fbd9e6d4-578a-4386-88ba-f3877bf17162	ddea0ad0-022b-4e77-9b31-221b7facedce	t	Authorize User permission to Ultrasound API Service	ultrasound-user	ultrasound	ddea0ad0-022b-4e77-9b31-221b7facedce	\N
baf94d6a-6e93-4eef-b0ba-11c8e786be48	ddea0ad0-022b-4e77-9b31-221b7facedce	t	Authorize Root role to Ultrasound API Service	ultrasound-root	ultrasound	ddea0ad0-022b-4e77-9b31-221b7facedce	\N
71b96c25-955b-4b13-b549-cd0e7cef7f11	ultrasound	f	Application user permissions	app-user	ultrasound	\N	ultrasound
9d32512b-5961-43fa-a3ef-910f997b662d	ultrasound	f	Application admin permissions	app-admin	ultrasound	\N	ultrasound
0bf49efc-d31c-4a24-8536-2bfdaa09aa26	ultrasound	f	Application root permissions	app-root	ultrasound	\N	ultrasound
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
3lbl7	8.0.0	1588228642
\.


--
-- Data for Name: oauth_access_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_access_token (token_id, token, authentication_id, user_name, client_id, authentication, refresh_token) FROM stdin;
\.


--
-- Data for Name: oauth_client_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove) FROM stdin;
ultrasound_service	\N	{bcrypt}$2a$10$QSiaExBA191pRyjHFTmYfO8rB6s.oUZyZVVmqupRpAni.AKQnx8nq	read,write	password,refresh_token,client_credentials	\N	ROLE_CLIENT	300	\N	\N	\N
\.


--
-- Data for Name: oauth_client_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_client_token (token_id, token, authentication_id, user_name, client_id) FROM stdin;
\.


--
-- Data for Name: oauth_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_code (code, authentication) FROM stdin;
\.


--
-- Data for Name: oauth_refresh_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth_refresh_token (token_id, token, authentication) FROM stdin;
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
fc105058-12e2-48e9-be7a-78fc1097e78f	locale	openid-connect	oidc-usermodel-attribute-mapper	bfd0065b-9fea-480f-a93a-795bb345b5d5	\N
c883ed61-9aa2-44ad-b7dc-8bc966f25f92	role list	saml	saml-role-list-mapper	\N	2bc504b2-1b6d-4eff-a082-8883810739b4
78f521d9-c63e-4a76-834c-9a86dca540a9	full name	openid-connect	oidc-full-name-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
1d977c73-f23e-46ef-90bb-1afef1574fa8	family name	openid-connect	oidc-usermodel-property-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
b1e827ff-601b-4974-b4e7-829be3012f6d	given name	openid-connect	oidc-usermodel-property-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
90e84219-6ee9-491b-bff4-36a60d851857	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
69046cf3-960d-4897-8d46-c6dd297ce758	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
317c3fb4-fb42-4deb-9aa0-103f40ab80b5	username	openid-connect	oidc-usermodel-property-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
364d4534-09ef-43b9-b210-8b10c9a66b77	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
9efeb2b4-e037-49a5-abec-076c788f78c2	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
d004775b-37bc-48ac-a57f-3b213071ba1c	website	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
d2c8f219-6f7a-4990-9aa1-7bf3daa9f52a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
47d54def-2db7-4288-adf9-dc2167960f3a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
f2b82fed-56da-49d2-9ea8-8c44bd677d8f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
debb41ea-7cd7-4256-9802-0c5c3d76351b	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
f370974e-016a-4764-bf45-9ec6b54ea6df	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	ac520590-b024-49e2-8a21-3d5e31a15894
f385c284-519a-4d6b-b1d7-3b519351270b	email	openid-connect	oidc-usermodel-property-mapper	\N	28f152e1-3239-4de2-b48b-1c07a1e53caf
dfb0765f-1112-4784-b046-d7b26ec68987	email verified	openid-connect	oidc-usermodel-property-mapper	\N	28f152e1-3239-4de2-b48b-1c07a1e53caf
6eff8a68-7e76-4f64-a925-a63672992039	address	openid-connect	oidc-address-mapper	\N	343319bd-b7a0-4152-bbcc-fc93e721e16d
96871f21-cfae-426b-b7e2-ae02c303f6cc	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a44deca7-20ca-4b79-a7d1-0fd242e7c505
ec047019-07de-4f08-b725-2bffdbce1e05	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a44deca7-20ca-4b79-a7d1-0fd242e7c505
475c2776-4c32-48bf-9ec4-4b1fdad66f37	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	ed03075d-3171-4093-b124-b1bf6c5ec848
780c53da-19e4-4e79-8111-35fc1c05c70e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	ed03075d-3171-4093-b124-b1bf6c5ec848
4a75b0d6-3dff-41ec-894a-09e61ae0f230	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	ed03075d-3171-4093-b124-b1bf6c5ec848
3d7b89b2-2edd-4185-807e-325246a84318	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	439e3867-7b15-4a30-9ff4-c4424e762c85
aa03fbe4-9fbe-4566-9a74-d968834a0877	upn	openid-connect	oidc-usermodel-property-mapper	\N	caa64c12-0ae0-43d0-a545-5d23b5552079
b91b4dad-da0a-455c-a757-bee39b45d3ed	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	caa64c12-0ae0-43d0-a545-5d23b5552079
2a3d0eda-416f-4a82-aa12-95270e1341b2	role list	saml	saml-role-list-mapper	\N	14b11591-0678-41c2-a5b2-530480ab9285
3e51fc62-556b-4492-baf6-4465d1c68fa0	full name	openid-connect	oidc-full-name-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
8a743931-df96-4a84-bc62-369ddf63afe1	family name	openid-connect	oidc-usermodel-property-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
83aa8d30-6162-43a4-8da1-2679d054f54f	given name	openid-connect	oidc-usermodel-property-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
8ec49f84-caae-478c-b1dd-e60e0594370b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
781cadae-f65a-4c09-b7c3-09adb6f79d72	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
51451033-8b5d-4b84-b0ab-d4111df1e8dc	username	openid-connect	oidc-usermodel-property-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
529cde45-aec6-4e78-9501-edcd3998e056	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
0182d970-8c59-4a59-9748-44384a004a16	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
9e175716-2d66-4705-bcb7-08c75b2a1dc4	website	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
bafdee19-6c6f-481d-9aab-fbdcc904e7db	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
3b9dcff4-fda9-4690-86f7-8fc5ecb5e6eb	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
52d762e1-4c76-4707-b081-ad9bd79dc527	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
dd728ca5-5f4b-4a84-8e87-f18ebe47d2e3	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
76f51975-0c2d-4709-9a02-c2462eb08bc9	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	7ddce74c-ce2b-470a-876f-5cf5fe437acb
1399e17a-83cc-4c5e-90be-01b2fa26fb14	email	openid-connect	oidc-usermodel-property-mapper	\N	adba83ad-f81c-49d0-9035-25f62179f4f3
174143fc-0bbd-4df9-9876-2799d4a6dbb4	email verified	openid-connect	oidc-usermodel-property-mapper	\N	adba83ad-f81c-49d0-9035-25f62179f4f3
b52bb536-9d78-49ac-8a89-6f543a87b456	address	openid-connect	oidc-address-mapper	\N	03cdde96-d844-41da-bbde-a3d4618c7518
a2495845-ece9-422e-aca9-ec6e6fcde2de	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	c05165c3-f634-4cec-935f-327f000758c4
f804d9b1-4e67-4967-8735-929a1f85f672	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	c05165c3-f634-4cec-935f-327f000758c4
bd6e64d2-7efd-47de-a436-09eab2b1d6d9	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	4533effa-57b8-43ce-95aa-e1339cbba4ec
3acc404a-97af-448e-9d14-727b008b882a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	4533effa-57b8-43ce-95aa-e1339cbba4ec
a78c8dcc-0b1f-487c-9385-e7aa6be3fdaa	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	4533effa-57b8-43ce-95aa-e1339cbba4ec
31c90254-a79a-4e5c-86fc-8fe19b715ee0	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	280ec09a-0242-43b9-98ad-6175fb35c1d8
a7587510-4007-4775-a864-b3c2277aa4e4	upn	openid-connect	oidc-usermodel-property-mapper	\N	434b9771-b87a-4e97-97f1-9ad9c5e268d7
02490472-a3e1-4d9f-90e3-e11c84efd0f3	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	434b9771-b87a-4e97-97f1-9ad9c5e268d7
5767dfd4-c011-40b2-9fb3-230ea6666cec	locale	openid-connect	oidc-usermodel-attribute-mapper	0b8bd679-34a6-44d6-8728-a0217ab5a5bb	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
fc105058-12e2-48e9-be7a-78fc1097e78f	true	userinfo.token.claim
fc105058-12e2-48e9-be7a-78fc1097e78f	locale	user.attribute
fc105058-12e2-48e9-be7a-78fc1097e78f	true	id.token.claim
fc105058-12e2-48e9-be7a-78fc1097e78f	true	access.token.claim
fc105058-12e2-48e9-be7a-78fc1097e78f	locale	claim.name
fc105058-12e2-48e9-be7a-78fc1097e78f	String	jsonType.label
c883ed61-9aa2-44ad-b7dc-8bc966f25f92	false	single
c883ed61-9aa2-44ad-b7dc-8bc966f25f92	Basic	attribute.nameformat
c883ed61-9aa2-44ad-b7dc-8bc966f25f92	Role	attribute.name
78f521d9-c63e-4a76-834c-9a86dca540a9	true	userinfo.token.claim
78f521d9-c63e-4a76-834c-9a86dca540a9	true	id.token.claim
78f521d9-c63e-4a76-834c-9a86dca540a9	true	access.token.claim
1d977c73-f23e-46ef-90bb-1afef1574fa8	true	userinfo.token.claim
1d977c73-f23e-46ef-90bb-1afef1574fa8	lastName	user.attribute
1d977c73-f23e-46ef-90bb-1afef1574fa8	true	id.token.claim
1d977c73-f23e-46ef-90bb-1afef1574fa8	true	access.token.claim
1d977c73-f23e-46ef-90bb-1afef1574fa8	family_name	claim.name
1d977c73-f23e-46ef-90bb-1afef1574fa8	String	jsonType.label
b1e827ff-601b-4974-b4e7-829be3012f6d	true	userinfo.token.claim
b1e827ff-601b-4974-b4e7-829be3012f6d	firstName	user.attribute
b1e827ff-601b-4974-b4e7-829be3012f6d	true	id.token.claim
b1e827ff-601b-4974-b4e7-829be3012f6d	true	access.token.claim
b1e827ff-601b-4974-b4e7-829be3012f6d	given_name	claim.name
b1e827ff-601b-4974-b4e7-829be3012f6d	String	jsonType.label
90e84219-6ee9-491b-bff4-36a60d851857	true	userinfo.token.claim
90e84219-6ee9-491b-bff4-36a60d851857	middleName	user.attribute
90e84219-6ee9-491b-bff4-36a60d851857	true	id.token.claim
90e84219-6ee9-491b-bff4-36a60d851857	true	access.token.claim
90e84219-6ee9-491b-bff4-36a60d851857	middle_name	claim.name
90e84219-6ee9-491b-bff4-36a60d851857	String	jsonType.label
69046cf3-960d-4897-8d46-c6dd297ce758	true	userinfo.token.claim
69046cf3-960d-4897-8d46-c6dd297ce758	nickname	user.attribute
69046cf3-960d-4897-8d46-c6dd297ce758	true	id.token.claim
69046cf3-960d-4897-8d46-c6dd297ce758	true	access.token.claim
69046cf3-960d-4897-8d46-c6dd297ce758	nickname	claim.name
69046cf3-960d-4897-8d46-c6dd297ce758	String	jsonType.label
317c3fb4-fb42-4deb-9aa0-103f40ab80b5	true	userinfo.token.claim
317c3fb4-fb42-4deb-9aa0-103f40ab80b5	username	user.attribute
317c3fb4-fb42-4deb-9aa0-103f40ab80b5	true	id.token.claim
317c3fb4-fb42-4deb-9aa0-103f40ab80b5	true	access.token.claim
317c3fb4-fb42-4deb-9aa0-103f40ab80b5	preferred_username	claim.name
317c3fb4-fb42-4deb-9aa0-103f40ab80b5	String	jsonType.label
364d4534-09ef-43b9-b210-8b10c9a66b77	true	userinfo.token.claim
364d4534-09ef-43b9-b210-8b10c9a66b77	profile	user.attribute
364d4534-09ef-43b9-b210-8b10c9a66b77	true	id.token.claim
364d4534-09ef-43b9-b210-8b10c9a66b77	true	access.token.claim
364d4534-09ef-43b9-b210-8b10c9a66b77	profile	claim.name
364d4534-09ef-43b9-b210-8b10c9a66b77	String	jsonType.label
9efeb2b4-e037-49a5-abec-076c788f78c2	true	userinfo.token.claim
9efeb2b4-e037-49a5-abec-076c788f78c2	picture	user.attribute
9efeb2b4-e037-49a5-abec-076c788f78c2	true	id.token.claim
9efeb2b4-e037-49a5-abec-076c788f78c2	true	access.token.claim
9efeb2b4-e037-49a5-abec-076c788f78c2	picture	claim.name
9efeb2b4-e037-49a5-abec-076c788f78c2	String	jsonType.label
d004775b-37bc-48ac-a57f-3b213071ba1c	true	userinfo.token.claim
d004775b-37bc-48ac-a57f-3b213071ba1c	website	user.attribute
d004775b-37bc-48ac-a57f-3b213071ba1c	true	id.token.claim
d004775b-37bc-48ac-a57f-3b213071ba1c	true	access.token.claim
d004775b-37bc-48ac-a57f-3b213071ba1c	website	claim.name
d004775b-37bc-48ac-a57f-3b213071ba1c	String	jsonType.label
d2c8f219-6f7a-4990-9aa1-7bf3daa9f52a	true	userinfo.token.claim
d2c8f219-6f7a-4990-9aa1-7bf3daa9f52a	gender	user.attribute
d2c8f219-6f7a-4990-9aa1-7bf3daa9f52a	true	id.token.claim
d2c8f219-6f7a-4990-9aa1-7bf3daa9f52a	true	access.token.claim
d2c8f219-6f7a-4990-9aa1-7bf3daa9f52a	gender	claim.name
d2c8f219-6f7a-4990-9aa1-7bf3daa9f52a	String	jsonType.label
47d54def-2db7-4288-adf9-dc2167960f3a	true	userinfo.token.claim
47d54def-2db7-4288-adf9-dc2167960f3a	birthdate	user.attribute
47d54def-2db7-4288-adf9-dc2167960f3a	true	id.token.claim
47d54def-2db7-4288-adf9-dc2167960f3a	true	access.token.claim
47d54def-2db7-4288-adf9-dc2167960f3a	birthdate	claim.name
47d54def-2db7-4288-adf9-dc2167960f3a	String	jsonType.label
f2b82fed-56da-49d2-9ea8-8c44bd677d8f	true	userinfo.token.claim
f2b82fed-56da-49d2-9ea8-8c44bd677d8f	zoneinfo	user.attribute
f2b82fed-56da-49d2-9ea8-8c44bd677d8f	true	id.token.claim
f2b82fed-56da-49d2-9ea8-8c44bd677d8f	true	access.token.claim
f2b82fed-56da-49d2-9ea8-8c44bd677d8f	zoneinfo	claim.name
f2b82fed-56da-49d2-9ea8-8c44bd677d8f	String	jsonType.label
debb41ea-7cd7-4256-9802-0c5c3d76351b	true	userinfo.token.claim
debb41ea-7cd7-4256-9802-0c5c3d76351b	locale	user.attribute
debb41ea-7cd7-4256-9802-0c5c3d76351b	true	id.token.claim
debb41ea-7cd7-4256-9802-0c5c3d76351b	true	access.token.claim
debb41ea-7cd7-4256-9802-0c5c3d76351b	locale	claim.name
debb41ea-7cd7-4256-9802-0c5c3d76351b	String	jsonType.label
f370974e-016a-4764-bf45-9ec6b54ea6df	true	userinfo.token.claim
f370974e-016a-4764-bf45-9ec6b54ea6df	updatedAt	user.attribute
f370974e-016a-4764-bf45-9ec6b54ea6df	true	id.token.claim
f370974e-016a-4764-bf45-9ec6b54ea6df	true	access.token.claim
f370974e-016a-4764-bf45-9ec6b54ea6df	updated_at	claim.name
f370974e-016a-4764-bf45-9ec6b54ea6df	String	jsonType.label
f385c284-519a-4d6b-b1d7-3b519351270b	true	userinfo.token.claim
f385c284-519a-4d6b-b1d7-3b519351270b	email	user.attribute
f385c284-519a-4d6b-b1d7-3b519351270b	true	id.token.claim
f385c284-519a-4d6b-b1d7-3b519351270b	true	access.token.claim
f385c284-519a-4d6b-b1d7-3b519351270b	email	claim.name
f385c284-519a-4d6b-b1d7-3b519351270b	String	jsonType.label
dfb0765f-1112-4784-b046-d7b26ec68987	true	userinfo.token.claim
dfb0765f-1112-4784-b046-d7b26ec68987	emailVerified	user.attribute
dfb0765f-1112-4784-b046-d7b26ec68987	true	id.token.claim
dfb0765f-1112-4784-b046-d7b26ec68987	true	access.token.claim
dfb0765f-1112-4784-b046-d7b26ec68987	email_verified	claim.name
dfb0765f-1112-4784-b046-d7b26ec68987	boolean	jsonType.label
6eff8a68-7e76-4f64-a925-a63672992039	formatted	user.attribute.formatted
6eff8a68-7e76-4f64-a925-a63672992039	country	user.attribute.country
6eff8a68-7e76-4f64-a925-a63672992039	postal_code	user.attribute.postal_code
6eff8a68-7e76-4f64-a925-a63672992039	true	userinfo.token.claim
6eff8a68-7e76-4f64-a925-a63672992039	street	user.attribute.street
6eff8a68-7e76-4f64-a925-a63672992039	true	id.token.claim
6eff8a68-7e76-4f64-a925-a63672992039	region	user.attribute.region
6eff8a68-7e76-4f64-a925-a63672992039	true	access.token.claim
6eff8a68-7e76-4f64-a925-a63672992039	locality	user.attribute.locality
96871f21-cfae-426b-b7e2-ae02c303f6cc	true	userinfo.token.claim
96871f21-cfae-426b-b7e2-ae02c303f6cc	phoneNumber	user.attribute
96871f21-cfae-426b-b7e2-ae02c303f6cc	true	id.token.claim
96871f21-cfae-426b-b7e2-ae02c303f6cc	true	access.token.claim
96871f21-cfae-426b-b7e2-ae02c303f6cc	phone_number	claim.name
96871f21-cfae-426b-b7e2-ae02c303f6cc	String	jsonType.label
ec047019-07de-4f08-b725-2bffdbce1e05	true	userinfo.token.claim
ec047019-07de-4f08-b725-2bffdbce1e05	phoneNumberVerified	user.attribute
ec047019-07de-4f08-b725-2bffdbce1e05	true	id.token.claim
ec047019-07de-4f08-b725-2bffdbce1e05	true	access.token.claim
ec047019-07de-4f08-b725-2bffdbce1e05	phone_number_verified	claim.name
ec047019-07de-4f08-b725-2bffdbce1e05	boolean	jsonType.label
475c2776-4c32-48bf-9ec4-4b1fdad66f37	true	multivalued
475c2776-4c32-48bf-9ec4-4b1fdad66f37	foo	user.attribute
475c2776-4c32-48bf-9ec4-4b1fdad66f37	true	access.token.claim
475c2776-4c32-48bf-9ec4-4b1fdad66f37	realm_access.roles	claim.name
475c2776-4c32-48bf-9ec4-4b1fdad66f37	String	jsonType.label
780c53da-19e4-4e79-8111-35fc1c05c70e	true	multivalued
780c53da-19e4-4e79-8111-35fc1c05c70e	foo	user.attribute
780c53da-19e4-4e79-8111-35fc1c05c70e	true	access.token.claim
780c53da-19e4-4e79-8111-35fc1c05c70e	resource_access.${client_id}.roles	claim.name
780c53da-19e4-4e79-8111-35fc1c05c70e	String	jsonType.label
aa03fbe4-9fbe-4566-9a74-d968834a0877	true	userinfo.token.claim
aa03fbe4-9fbe-4566-9a74-d968834a0877	username	user.attribute
aa03fbe4-9fbe-4566-9a74-d968834a0877	true	id.token.claim
aa03fbe4-9fbe-4566-9a74-d968834a0877	true	access.token.claim
aa03fbe4-9fbe-4566-9a74-d968834a0877	upn	claim.name
aa03fbe4-9fbe-4566-9a74-d968834a0877	String	jsonType.label
b91b4dad-da0a-455c-a757-bee39b45d3ed	true	multivalued
b91b4dad-da0a-455c-a757-bee39b45d3ed	foo	user.attribute
b91b4dad-da0a-455c-a757-bee39b45d3ed	true	id.token.claim
b91b4dad-da0a-455c-a757-bee39b45d3ed	true	access.token.claim
b91b4dad-da0a-455c-a757-bee39b45d3ed	groups	claim.name
b91b4dad-da0a-455c-a757-bee39b45d3ed	String	jsonType.label
2a3d0eda-416f-4a82-aa12-95270e1341b2	false	single
2a3d0eda-416f-4a82-aa12-95270e1341b2	Basic	attribute.nameformat
2a3d0eda-416f-4a82-aa12-95270e1341b2	Role	attribute.name
3e51fc62-556b-4492-baf6-4465d1c68fa0	true	userinfo.token.claim
3e51fc62-556b-4492-baf6-4465d1c68fa0	true	id.token.claim
3e51fc62-556b-4492-baf6-4465d1c68fa0	true	access.token.claim
8a743931-df96-4a84-bc62-369ddf63afe1	true	userinfo.token.claim
8a743931-df96-4a84-bc62-369ddf63afe1	lastName	user.attribute
8a743931-df96-4a84-bc62-369ddf63afe1	true	id.token.claim
8a743931-df96-4a84-bc62-369ddf63afe1	true	access.token.claim
8a743931-df96-4a84-bc62-369ddf63afe1	family_name	claim.name
8a743931-df96-4a84-bc62-369ddf63afe1	String	jsonType.label
83aa8d30-6162-43a4-8da1-2679d054f54f	true	userinfo.token.claim
83aa8d30-6162-43a4-8da1-2679d054f54f	firstName	user.attribute
83aa8d30-6162-43a4-8da1-2679d054f54f	true	id.token.claim
83aa8d30-6162-43a4-8da1-2679d054f54f	true	access.token.claim
83aa8d30-6162-43a4-8da1-2679d054f54f	given_name	claim.name
83aa8d30-6162-43a4-8da1-2679d054f54f	String	jsonType.label
8ec49f84-caae-478c-b1dd-e60e0594370b	true	userinfo.token.claim
8ec49f84-caae-478c-b1dd-e60e0594370b	middleName	user.attribute
8ec49f84-caae-478c-b1dd-e60e0594370b	true	id.token.claim
8ec49f84-caae-478c-b1dd-e60e0594370b	true	access.token.claim
8ec49f84-caae-478c-b1dd-e60e0594370b	middle_name	claim.name
8ec49f84-caae-478c-b1dd-e60e0594370b	String	jsonType.label
781cadae-f65a-4c09-b7c3-09adb6f79d72	true	userinfo.token.claim
781cadae-f65a-4c09-b7c3-09adb6f79d72	nickname	user.attribute
781cadae-f65a-4c09-b7c3-09adb6f79d72	true	id.token.claim
781cadae-f65a-4c09-b7c3-09adb6f79d72	true	access.token.claim
781cadae-f65a-4c09-b7c3-09adb6f79d72	nickname	claim.name
781cadae-f65a-4c09-b7c3-09adb6f79d72	String	jsonType.label
51451033-8b5d-4b84-b0ab-d4111df1e8dc	true	userinfo.token.claim
51451033-8b5d-4b84-b0ab-d4111df1e8dc	username	user.attribute
51451033-8b5d-4b84-b0ab-d4111df1e8dc	true	id.token.claim
51451033-8b5d-4b84-b0ab-d4111df1e8dc	true	access.token.claim
51451033-8b5d-4b84-b0ab-d4111df1e8dc	preferred_username	claim.name
51451033-8b5d-4b84-b0ab-d4111df1e8dc	String	jsonType.label
529cde45-aec6-4e78-9501-edcd3998e056	true	userinfo.token.claim
529cde45-aec6-4e78-9501-edcd3998e056	profile	user.attribute
529cde45-aec6-4e78-9501-edcd3998e056	true	id.token.claim
529cde45-aec6-4e78-9501-edcd3998e056	true	access.token.claim
529cde45-aec6-4e78-9501-edcd3998e056	profile	claim.name
529cde45-aec6-4e78-9501-edcd3998e056	String	jsonType.label
0182d970-8c59-4a59-9748-44384a004a16	true	userinfo.token.claim
0182d970-8c59-4a59-9748-44384a004a16	picture	user.attribute
0182d970-8c59-4a59-9748-44384a004a16	true	id.token.claim
0182d970-8c59-4a59-9748-44384a004a16	true	access.token.claim
0182d970-8c59-4a59-9748-44384a004a16	picture	claim.name
0182d970-8c59-4a59-9748-44384a004a16	String	jsonType.label
9e175716-2d66-4705-bcb7-08c75b2a1dc4	true	userinfo.token.claim
9e175716-2d66-4705-bcb7-08c75b2a1dc4	website	user.attribute
9e175716-2d66-4705-bcb7-08c75b2a1dc4	true	id.token.claim
9e175716-2d66-4705-bcb7-08c75b2a1dc4	true	access.token.claim
9e175716-2d66-4705-bcb7-08c75b2a1dc4	website	claim.name
9e175716-2d66-4705-bcb7-08c75b2a1dc4	String	jsonType.label
bafdee19-6c6f-481d-9aab-fbdcc904e7db	true	userinfo.token.claim
bafdee19-6c6f-481d-9aab-fbdcc904e7db	gender	user.attribute
bafdee19-6c6f-481d-9aab-fbdcc904e7db	true	id.token.claim
bafdee19-6c6f-481d-9aab-fbdcc904e7db	true	access.token.claim
bafdee19-6c6f-481d-9aab-fbdcc904e7db	gender	claim.name
bafdee19-6c6f-481d-9aab-fbdcc904e7db	String	jsonType.label
3b9dcff4-fda9-4690-86f7-8fc5ecb5e6eb	true	userinfo.token.claim
3b9dcff4-fda9-4690-86f7-8fc5ecb5e6eb	birthdate	user.attribute
3b9dcff4-fda9-4690-86f7-8fc5ecb5e6eb	true	id.token.claim
3b9dcff4-fda9-4690-86f7-8fc5ecb5e6eb	true	access.token.claim
3b9dcff4-fda9-4690-86f7-8fc5ecb5e6eb	birthdate	claim.name
3b9dcff4-fda9-4690-86f7-8fc5ecb5e6eb	String	jsonType.label
52d762e1-4c76-4707-b081-ad9bd79dc527	true	userinfo.token.claim
52d762e1-4c76-4707-b081-ad9bd79dc527	zoneinfo	user.attribute
52d762e1-4c76-4707-b081-ad9bd79dc527	true	id.token.claim
52d762e1-4c76-4707-b081-ad9bd79dc527	true	access.token.claim
52d762e1-4c76-4707-b081-ad9bd79dc527	zoneinfo	claim.name
52d762e1-4c76-4707-b081-ad9bd79dc527	String	jsonType.label
dd728ca5-5f4b-4a84-8e87-f18ebe47d2e3	true	userinfo.token.claim
dd728ca5-5f4b-4a84-8e87-f18ebe47d2e3	locale	user.attribute
dd728ca5-5f4b-4a84-8e87-f18ebe47d2e3	true	id.token.claim
dd728ca5-5f4b-4a84-8e87-f18ebe47d2e3	true	access.token.claim
dd728ca5-5f4b-4a84-8e87-f18ebe47d2e3	locale	claim.name
dd728ca5-5f4b-4a84-8e87-f18ebe47d2e3	String	jsonType.label
76f51975-0c2d-4709-9a02-c2462eb08bc9	true	userinfo.token.claim
76f51975-0c2d-4709-9a02-c2462eb08bc9	updatedAt	user.attribute
76f51975-0c2d-4709-9a02-c2462eb08bc9	true	id.token.claim
76f51975-0c2d-4709-9a02-c2462eb08bc9	true	access.token.claim
76f51975-0c2d-4709-9a02-c2462eb08bc9	updated_at	claim.name
76f51975-0c2d-4709-9a02-c2462eb08bc9	String	jsonType.label
1399e17a-83cc-4c5e-90be-01b2fa26fb14	true	userinfo.token.claim
1399e17a-83cc-4c5e-90be-01b2fa26fb14	email	user.attribute
1399e17a-83cc-4c5e-90be-01b2fa26fb14	true	id.token.claim
1399e17a-83cc-4c5e-90be-01b2fa26fb14	true	access.token.claim
1399e17a-83cc-4c5e-90be-01b2fa26fb14	email	claim.name
1399e17a-83cc-4c5e-90be-01b2fa26fb14	String	jsonType.label
174143fc-0bbd-4df9-9876-2799d4a6dbb4	true	userinfo.token.claim
174143fc-0bbd-4df9-9876-2799d4a6dbb4	emailVerified	user.attribute
174143fc-0bbd-4df9-9876-2799d4a6dbb4	true	id.token.claim
174143fc-0bbd-4df9-9876-2799d4a6dbb4	true	access.token.claim
174143fc-0bbd-4df9-9876-2799d4a6dbb4	email_verified	claim.name
174143fc-0bbd-4df9-9876-2799d4a6dbb4	boolean	jsonType.label
b52bb536-9d78-49ac-8a89-6f543a87b456	formatted	user.attribute.formatted
b52bb536-9d78-49ac-8a89-6f543a87b456	country	user.attribute.country
b52bb536-9d78-49ac-8a89-6f543a87b456	postal_code	user.attribute.postal_code
b52bb536-9d78-49ac-8a89-6f543a87b456	true	userinfo.token.claim
b52bb536-9d78-49ac-8a89-6f543a87b456	street	user.attribute.street
b52bb536-9d78-49ac-8a89-6f543a87b456	true	id.token.claim
b52bb536-9d78-49ac-8a89-6f543a87b456	region	user.attribute.region
b52bb536-9d78-49ac-8a89-6f543a87b456	true	access.token.claim
b52bb536-9d78-49ac-8a89-6f543a87b456	locality	user.attribute.locality
a2495845-ece9-422e-aca9-ec6e6fcde2de	true	userinfo.token.claim
a2495845-ece9-422e-aca9-ec6e6fcde2de	phoneNumber	user.attribute
a2495845-ece9-422e-aca9-ec6e6fcde2de	true	id.token.claim
a2495845-ece9-422e-aca9-ec6e6fcde2de	true	access.token.claim
a2495845-ece9-422e-aca9-ec6e6fcde2de	phone_number	claim.name
a2495845-ece9-422e-aca9-ec6e6fcde2de	String	jsonType.label
f804d9b1-4e67-4967-8735-929a1f85f672	true	userinfo.token.claim
f804d9b1-4e67-4967-8735-929a1f85f672	phoneNumberVerified	user.attribute
f804d9b1-4e67-4967-8735-929a1f85f672	true	id.token.claim
f804d9b1-4e67-4967-8735-929a1f85f672	true	access.token.claim
f804d9b1-4e67-4967-8735-929a1f85f672	phone_number_verified	claim.name
f804d9b1-4e67-4967-8735-929a1f85f672	boolean	jsonType.label
bd6e64d2-7efd-47de-a436-09eab2b1d6d9	true	multivalued
bd6e64d2-7efd-47de-a436-09eab2b1d6d9	foo	user.attribute
bd6e64d2-7efd-47de-a436-09eab2b1d6d9	true	access.token.claim
bd6e64d2-7efd-47de-a436-09eab2b1d6d9	realm_access.roles	claim.name
bd6e64d2-7efd-47de-a436-09eab2b1d6d9	String	jsonType.label
3acc404a-97af-448e-9d14-727b008b882a	true	multivalued
3acc404a-97af-448e-9d14-727b008b882a	foo	user.attribute
3acc404a-97af-448e-9d14-727b008b882a	true	access.token.claim
3acc404a-97af-448e-9d14-727b008b882a	resource_access.${client_id}.roles	claim.name
3acc404a-97af-448e-9d14-727b008b882a	String	jsonType.label
a7587510-4007-4775-a864-b3c2277aa4e4	true	userinfo.token.claim
a7587510-4007-4775-a864-b3c2277aa4e4	username	user.attribute
a7587510-4007-4775-a864-b3c2277aa4e4	true	id.token.claim
a7587510-4007-4775-a864-b3c2277aa4e4	true	access.token.claim
a7587510-4007-4775-a864-b3c2277aa4e4	upn	claim.name
a7587510-4007-4775-a864-b3c2277aa4e4	String	jsonType.label
02490472-a3e1-4d9f-90e3-e11c84efd0f3	true	multivalued
02490472-a3e1-4d9f-90e3-e11c84efd0f3	foo	user.attribute
02490472-a3e1-4d9f-90e3-e11c84efd0f3	true	id.token.claim
02490472-a3e1-4d9f-90e3-e11c84efd0f3	true	access.token.claim
02490472-a3e1-4d9f-90e3-e11c84efd0f3	groups	claim.name
02490472-a3e1-4d9f-90e3-e11c84efd0f3	String	jsonType.label
5767dfd4-c011-40b2-9fb3-230ea6666cec	true	userinfo.token.claim
5767dfd4-c011-40b2-9fb3-230ea6666cec	locale	user.attribute
5767dfd4-c011-40b2-9fb3-230ea6666cec	true	id.token.claim
5767dfd4-c011-40b2-9fb3-230ea6666cec	true	access.token.claim
5767dfd4-c011-40b2-9fb3-230ea6666cec	locale	claim.name
5767dfd4-c011-40b2-9fb3-230ea6666cec	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	f11a806c-81a6-4626-ab1b-59ecada89b17	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	d0761657-92f2-4533-b67c-59c2e2ab79e1	8f91b253-d1f6-4cf7-935a-fde883ea940a	37f5ff13-d759-4eee-a955-26c77953c96a	1a467493-827a-486f-b6a9-7fb63c602bd8	ca5a4e5c-4bbf-4746-822b-67b6bcde199c	2592000	f	900	t	f	96bf5ae3-8f9e-43cd-a629-76d48b41251c	0	f	0	0
ultrasound	60	300	300	\N	\N	\N	t	f	0	\N	ultrasound	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	78879382-f740-4c29-96ab-1d26dd48583a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f030f472-cd08-43d4-9828-b12392f48d05	db79cb90-7e25-4100-8fbe-35a782f888c9	c0814b52-44e9-4a34-a5f9-31c68e9c8f7f	076ee7e3-e8cb-4a65-862c-18f585aa0209	b81ecc35-9dbf-4135-a310-7ed67ca2c815	2592000	f	900	t	f	9ffa08b3-b49d-46b1-aff5-668490b92488	0	f	0	0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
_browser_header.contentSecurityPolicyReportOnly		ultrasound
_browser_header.xContentTypeOptions	nosniff	ultrasound
_browser_header.xRobotsTag	none	ultrasound
_browser_header.xFrameOptions	SAMEORIGIN	ultrasound
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	ultrasound
_browser_header.xXSSProtection	1; mode=block	ultrasound
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	ultrasound
bruteForceProtected	false	ultrasound
permanentLockout	false	ultrasound
maxFailureWaitSeconds	900	ultrasound
minimumQuickLoginWaitSeconds	60	ultrasound
waitIncrementSeconds	60	ultrasound
quickLoginCheckMilliSeconds	1000	ultrasound
maxDeltaTimeSeconds	43200	ultrasound
failureFactor	30	ultrasound
offlineSessionMaxLifespanEnabled	false	ultrasound
offlineSessionMaxLifespan	5184000	ultrasound
actionTokenGeneratedByAdminLifespan	43200	ultrasound
actionTokenGeneratedByUserLifespan	300	ultrasound
webAuthnPolicyRpEntityName	keycloak	ultrasound
webAuthnPolicySignatureAlgorithms	ES256	ultrasound
webAuthnPolicyRpId		ultrasound
webAuthnPolicyAttestationConveyancePreference	not specified	ultrasound
webAuthnPolicyAuthenticatorAttachment	not specified	ultrasound
webAuthnPolicyRequireResidentKey	not specified	ultrasound
webAuthnPolicyUserVerificationRequirement	not specified	ultrasound
webAuthnPolicyCreateTimeout	0	ultrasound
webAuthnPolicyAvoidSameAuthenticatorRegister	false	ultrasound
displayName	APM Ultrasound	ultrasound
displayNameHtml	<div class="kc-logo-text"><span>APM Ultrasound Server</span></div>	ultrasound
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	331c3eb9-de90-41d9-9fdb-955dafe55f60
master	62fc9f49-5d36-49f6-89c0-c0f201369f43
ultrasound	c8046c7f-6373-4bbc-9a7f-993b6573e14a
ultrasound	0b823a7c-6178-49ea-ba98-827feb70e24a
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
ultrasound	jboss-logging
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	ultrasound
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
99ec09f1-251e-4f3c-be53-251d59ab14bb	/realms/master/account/*
bfd0065b-9fea-480f-a93a-795bb345b5d5	/admin/master/console/*
4d4266e8-d4bb-4013-b75c-e0b83cbe24a3	/realms/ultrasound/account/*
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	/admin/ultrasound/console/*
ddea0ad0-022b-4e77-9b31-221b7facedce	http://localhost:10001/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
22ed56d8-91f2-4598-93ce-1fa0ccc1e200	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
417a81a7-49e0-4a96-a091-dcf06c28af2e	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
f943febc-c159-428a-8ccf-3274928237d4	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
57193436-4503-4792-ab59-85c09a6395dc	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
f0ff8338-e0e5-46ea-862a-7107fdb37fc8	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
d88d1112-a8b5-427b-8226-54c18efe0505	VERIFY_EMAIL	Verify Email	ultrasound	t	f	VERIFY_EMAIL	50
bf075080-f9a8-427a-a825-bb5dbc626165	UPDATE_PROFILE	Update Profile	ultrasound	t	f	UPDATE_PROFILE	40
a6fe3cf2-42af-4434-8b95-2ffa4fd5847f	CONFIGURE_TOTP	Configure OTP	ultrasound	t	f	CONFIGURE_TOTP	10
72637c90-2bc2-4374-9d2c-f4cceb592f3c	UPDATE_PASSWORD	Update Password	ultrasound	t	f	UPDATE_PASSWORD	30
01d391d9-b198-4610-9ec2-26f85c8f3b20	terms_and_conditions	Terms and Conditions	ultrasound	f	f	terms_and_conditions	20
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
20d60a50-b274-4fb7-a106-b0ae37304b72	\N	4a5879cd-7460-402b-a4ba-96028291bc5b	f	t	\N	\N	\N	master	admin	1588228643883	\N	0
3759993d-d3de-4eea-8d34-526e46484168	\N	8b7527e9-bc35-4d6b-9b6c-92b18051d94f	f	t	\N	\N	\N	ultrasound	root	1588231490422	\N	0
f23867df-662c-4959-a648-a4059881016c	\N	3b4b1859-a3fc-4275-ac53-8fb921bb1484	f	t	\N	\N	\N	ultrasound	admin	1588231641568	\N	0
32a8c53c-130c-456c-9163-9a3206528d60	\N	2512cb7b-a198-40bb-960b-5c35715cc46f	f	t	\N	\N	\N	ultrasound	room01	1588231695982	\N	0
5421e9ef-bf88-4744-9713-c263709ff7a9	\N	1134b4e3-1691-4da5-9381-1f0788f14766	f	t	\N	\N	\N	ultrasound	room02	1588231769867	\N	0
8dc4c492-ce8d-4368-9484-7a2e122b988e	\N	9e47cb06-6a70-49da-98ac-70087e3ad328	f	t	\N	\N	\N	ultrasound	room03	1588231846941	\N	0
6b27bda4-9237-4b87-b6a9-474e7e68a87a	\N	be0905bb-1432-4561-b726-8081b5905ba4	f	t	\N	\N	\N	ultrasound	room04	1588231895104	\N	0
6ac3a59a-8d32-4a7c-aa4d-6124179672aa	\N	1b537190-0f96-44e4-bf3b-0ec00c531f86	f	t	\N	\N	\N	ultrasound	room05	1588232093158	\N	0
1ade46d6-d1bd-4890-9d67-02782dd9dd41	\N	e701f5f1-1cd9-4268-acc9-25af53bca25f	f	t	\N	\N	\N	ultrasound	room06	1588232137229	\N	0
288a0b04-acd1-4452-8bde-13d4c01baae0	\N	d7ea938a-6b55-4e55-8fc5-e06e9898e034	f	t	\N	\N	\N	ultrasound	room07	1588232195305	\N	0
7bc53c30-bdb8-4bdb-82d3-d474733dfb82	\N	fb7e52ff-5a0e-49fe-a858-40a9733bdecd	f	t	\N	\N	\N	ultrasound	room08	1588232258016	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
8dc4c492-ce8d-4368-9484-7a2e122b988e	UPDATE_PASSWORD
6b27bda4-9237-4b87-b6a9-474e7e68a87a	UPDATE_PASSWORD
6ac3a59a-8d32-4a7c-aa4d-6124179672aa	UPDATE_PASSWORD
1ade46d6-d1bd-4890-9d67-02782dd9dd41	UPDATE_PASSWORD
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
436245c0-82c7-4c67-bb33-6c98db9dab61	20d60a50-b274-4fb7-a106-b0ae37304b72
ac9c92a4-7ff1-4d4a-91af-214fbf898838	20d60a50-b274-4fb7-a106-b0ae37304b72
62fc9f49-5d36-49f6-89c0-c0f201369f43	20d60a50-b274-4fb7-a106-b0ae37304b72
331c3eb9-de90-41d9-9fdb-955dafe55f60	20d60a50-b274-4fb7-a106-b0ae37304b72
130afcfe-7580-4e1e-ab62-83ddb0fa10db	20d60a50-b274-4fb7-a106-b0ae37304b72
c8046c7f-6373-4bbc-9a7f-993b6573e14a	3759993d-d3de-4eea-8d34-526e46484168
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	3759993d-d3de-4eea-8d34-526e46484168
e731afdd-5538-4051-b8a5-91c662942f56	3759993d-d3de-4eea-8d34-526e46484168
0b823a7c-6178-49ea-ba98-827feb70e24a	3759993d-d3de-4eea-8d34-526e46484168
0bf49efc-d31c-4a24-8536-2bfdaa09aa26	3759993d-d3de-4eea-8d34-526e46484168
c8046c7f-6373-4bbc-9a7f-993b6573e14a	f23867df-662c-4959-a648-a4059881016c
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	f23867df-662c-4959-a648-a4059881016c
e731afdd-5538-4051-b8a5-91c662942f56	f23867df-662c-4959-a648-a4059881016c
0b823a7c-6178-49ea-ba98-827feb70e24a	f23867df-662c-4959-a648-a4059881016c
9d32512b-5961-43fa-a3ef-910f997b662d	f23867df-662c-4959-a648-a4059881016c
c8046c7f-6373-4bbc-9a7f-993b6573e14a	32a8c53c-130c-456c-9163-9a3206528d60
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	32a8c53c-130c-456c-9163-9a3206528d60
e731afdd-5538-4051-b8a5-91c662942f56	32a8c53c-130c-456c-9163-9a3206528d60
0b823a7c-6178-49ea-ba98-827feb70e24a	32a8c53c-130c-456c-9163-9a3206528d60
71b96c25-955b-4b13-b549-cd0e7cef7f11	32a8c53c-130c-456c-9163-9a3206528d60
c8046c7f-6373-4bbc-9a7f-993b6573e14a	5421e9ef-bf88-4744-9713-c263709ff7a9
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	5421e9ef-bf88-4744-9713-c263709ff7a9
e731afdd-5538-4051-b8a5-91c662942f56	5421e9ef-bf88-4744-9713-c263709ff7a9
0b823a7c-6178-49ea-ba98-827feb70e24a	5421e9ef-bf88-4744-9713-c263709ff7a9
c8046c7f-6373-4bbc-9a7f-993b6573e14a	8dc4c492-ce8d-4368-9484-7a2e122b988e
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	8dc4c492-ce8d-4368-9484-7a2e122b988e
e731afdd-5538-4051-b8a5-91c662942f56	8dc4c492-ce8d-4368-9484-7a2e122b988e
0b823a7c-6178-49ea-ba98-827feb70e24a	8dc4c492-ce8d-4368-9484-7a2e122b988e
71b96c25-955b-4b13-b549-cd0e7cef7f11	8dc4c492-ce8d-4368-9484-7a2e122b988e
c8046c7f-6373-4bbc-9a7f-993b6573e14a	6b27bda4-9237-4b87-b6a9-474e7e68a87a
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	6b27bda4-9237-4b87-b6a9-474e7e68a87a
e731afdd-5538-4051-b8a5-91c662942f56	6b27bda4-9237-4b87-b6a9-474e7e68a87a
0b823a7c-6178-49ea-ba98-827feb70e24a	6b27bda4-9237-4b87-b6a9-474e7e68a87a
71b96c25-955b-4b13-b549-cd0e7cef7f11	6b27bda4-9237-4b87-b6a9-474e7e68a87a
c8046c7f-6373-4bbc-9a7f-993b6573e14a	6ac3a59a-8d32-4a7c-aa4d-6124179672aa
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	6ac3a59a-8d32-4a7c-aa4d-6124179672aa
e731afdd-5538-4051-b8a5-91c662942f56	6ac3a59a-8d32-4a7c-aa4d-6124179672aa
0b823a7c-6178-49ea-ba98-827feb70e24a	6ac3a59a-8d32-4a7c-aa4d-6124179672aa
71b96c25-955b-4b13-b549-cd0e7cef7f11	6ac3a59a-8d32-4a7c-aa4d-6124179672aa
c8046c7f-6373-4bbc-9a7f-993b6573e14a	1ade46d6-d1bd-4890-9d67-02782dd9dd41
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	1ade46d6-d1bd-4890-9d67-02782dd9dd41
e731afdd-5538-4051-b8a5-91c662942f56	1ade46d6-d1bd-4890-9d67-02782dd9dd41
0b823a7c-6178-49ea-ba98-827feb70e24a	1ade46d6-d1bd-4890-9d67-02782dd9dd41
71b96c25-955b-4b13-b549-cd0e7cef7f11	1ade46d6-d1bd-4890-9d67-02782dd9dd41
c8046c7f-6373-4bbc-9a7f-993b6573e14a	288a0b04-acd1-4452-8bde-13d4c01baae0
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	288a0b04-acd1-4452-8bde-13d4c01baae0
e731afdd-5538-4051-b8a5-91c662942f56	288a0b04-acd1-4452-8bde-13d4c01baae0
0b823a7c-6178-49ea-ba98-827feb70e24a	288a0b04-acd1-4452-8bde-13d4c01baae0
71b96c25-955b-4b13-b549-cd0e7cef7f11	288a0b04-acd1-4452-8bde-13d4c01baae0
c8046c7f-6373-4bbc-9a7f-993b6573e14a	7bc53c30-bdb8-4bdb-82d3-d474733dfb82
7f82cff4-a8d8-4221-8c8c-37d3dc870a18	7bc53c30-bdb8-4bdb-82d3-d474733dfb82
e731afdd-5538-4051-b8a5-91c662942f56	7bc53c30-bdb8-4bdb-82d3-d474733dfb82
0b823a7c-6178-49ea-ba98-827feb70e24a	7bc53c30-bdb8-4bdb-82d3-d474733dfb82
71b96c25-955b-4b13-b549-cd0e7cef7f11	7bc53c30-bdb8-4bdb-82d3-d474733dfb82
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
bfd0065b-9fea-480f-a93a-795bb345b5d5	+
0b8bd679-34a6-44d6-8728-a0217ab5a5bb	+
ddea0ad0-022b-4e77-9b31-221b7facedce	http://localhost:10001
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_token oauth_access_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_access_token
    ADD CONSTRAINT oauth_access_token_pkey PRIMARY KEY (authentication_id);


--
-- Name: oauth_client_details oauth_client_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_client_details
    ADD CONSTRAINT oauth_client_details_pkey PRIMARY KEY (client_id);


--
-- Name: oauth_client_token oauth_client_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth_client_token
    ADD CONSTRAINT oauth_client_token_pkey PRIMARY KEY (authentication_id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES public.client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES public.client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

