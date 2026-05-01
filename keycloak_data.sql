--
-- PostgreSQL database dump
--

-- Dumped from database version 15.12
-- Dumped by pg_dump version 15.12

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

ALTER TABLE ONLY public.identity_provider_config DROP CONSTRAINT fkdc4897cf864c4e43;
ALTER TABLE ONLY public.policy_config DROP CONSTRAINT fkdc34197cf864c4e43;
ALTER TABLE ONLY public.user_group_membership DROP CONSTRAINT fk_user_group_user;
ALTER TABLE ONLY public.user_federation_config DROP CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5;
ALTER TABLE ONLY public.realm_supported_locales DROP CONSTRAINT fk_supported_locales_realm;
ALTER TABLE ONLY public.role_attribute DROP CONSTRAINT fk_role_attribute_id;
ALTER TABLE ONLY public.resource_uris DROP CONSTRAINT fk_resource_server_uris;
ALTER TABLE ONLY public.required_action_provider DROP CONSTRAINT fk_req_act_realm;
ALTER TABLE ONLY public.default_client_scope DROP CONSTRAINT fk_r_def_cli_scope_realm;
ALTER TABLE ONLY public.protocol_mapper_config DROP CONSTRAINT fk_pmconfig;
ALTER TABLE ONLY public.credential DROP CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0;
ALTER TABLE ONLY public.protocol_mapper DROP CONSTRAINT fk_pcm_realm;
ALTER TABLE ONLY public.scope_mapping DROP CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1;
ALTER TABLE ONLY public.org_invitation DROP CONSTRAINT fk_org_invitation_org;
ALTER TABLE ONLY public.web_origins DROP CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.idp_mapper_config DROP CONSTRAINT fk_idpmconfig;
ALTER TABLE ONLY public.identity_provider_mapper DROP CONSTRAINT fk_idpm_realm;
ALTER TABLE ONLY public.realm_events_listeners DROP CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j;
ALTER TABLE ONLY public.realm_enabled_event_types DROP CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j;
ALTER TABLE ONLY public.group_role_mapping DROP CONSTRAINT fk_group_role_group;
ALTER TABLE ONLY public.group_attribute DROP CONSTRAINT fk_group_attribute_group;
ALTER TABLE ONLY public.user_consent DROP CONSTRAINT fk_grntcsnt_user;
ALTER TABLE ONLY public.user_consent_client_scope DROP CONSTRAINT fk_grntcsnt_clsc_usc;
ALTER TABLE ONLY public.composite_role DROP CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8;
ALTER TABLE ONLY public.resource_server_scope DROP CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.resource_scope DROP CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.resource_policy DROP CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.resource_policy DROP CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.resource_scope DROP CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.resource_server_policy DROP CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.resource_server_perm_ticket DROP CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy;
ALTER TABLE ONLY public.scope_policy DROP CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.associated_policy DROP CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.resource_server_perm_ticket DROP CONSTRAINT fk_frsrho213xcx4wnkog84sspmt;
ALTER TABLE ONLY public.resource_server_perm_ticket DROP CONSTRAINT fk_frsrho213xcx4wnkog83sspmt;
ALTER TABLE ONLY public.resource_server_resource DROP CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.resource_server_perm_ticket DROP CONSTRAINT fk_frsrho213xcx4wnkog82sspmt;
ALTER TABLE ONLY public.scope_policy DROP CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.associated_policy DROP CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy;
ALTER TABLE ONLY public.user_federation_mapper DROP CONSTRAINT fk_fedmapperpm_realm;
ALTER TABLE ONLY public.user_federation_mapper DROP CONSTRAINT fk_fedmapperpm_fedprv;
ALTER TABLE ONLY public.user_federation_mapper_config DROP CONSTRAINT fk_fedmapper_cfg;
ALTER TABLE ONLY public.realm_default_groups DROP CONSTRAINT fk_def_groups_realm;
ALTER TABLE ONLY public.component DROP CONSTRAINT fk_component_realm;
ALTER TABLE ONLY public.component_config DROP CONSTRAINT fk_component_config;
ALTER TABLE ONLY public.client_initial_access DROP CONSTRAINT fk_client_init_acc_realm;
ALTER TABLE ONLY public.protocol_mapper DROP CONSTRAINT fk_cli_scope_mapper;
ALTER TABLE ONLY public.client_scope_role_mapping DROP CONSTRAINT fk_cl_scope_rm_scope;
ALTER TABLE ONLY public.client_scope_attributes DROP CONSTRAINT fk_cl_scope_attr_scope;
ALTER TABLE ONLY public.user_role_mapping DROP CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l;
ALTER TABLE ONLY public.authenticator_config DROP CONSTRAINT fk_auth_realm;
ALTER TABLE ONLY public.authentication_flow DROP CONSTRAINT fk_auth_flow_realm;
ALTER TABLE ONLY public.authentication_execution DROP CONSTRAINT fk_auth_exec_realm;
ALTER TABLE ONLY public.authentication_execution DROP CONSTRAINT fk_auth_exec_flow;
ALTER TABLE ONLY public.composite_role DROP CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2;
ALTER TABLE ONLY public.realm_attribute DROP CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw;
ALTER TABLE ONLY public.realm_smtp_config DROP CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o;
ALTER TABLE ONLY public.keycloak_role DROP CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c;
ALTER TABLE ONLY public.user_required_action DROP CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd;
ALTER TABLE ONLY public.user_attribute DROP CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr;
ALTER TABLE ONLY public.resource_attribute DROP CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr;
ALTER TABLE ONLY public.realm_required_credential DROP CONSTRAINT fk_5hg65lybevavkqfki3kponh9v;
ALTER TABLE ONLY public.user_federation_provider DROP CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8;
ALTER TABLE ONLY public.redirect_uris DROP CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f;
ALTER TABLE ONLY public.client_node_registrations DROP CONSTRAINT fk4129723ba992f594;
ALTER TABLE ONLY public.federated_identity DROP CONSTRAINT fk404288b92ef007a6;
ALTER TABLE ONLY public.client_attributes DROP CONSTRAINT fk3c47c64beacca966;
ALTER TABLE ONLY public.identity_provider DROP CONSTRAINT fk2b4ebc52ae5c3b34;
DROP INDEX public.user_attr_long_values_lower_case;
DROP INDEX public.user_attr_long_values;
DROP INDEX public.idx_workflow_state_step;
DROP INDEX public.idx_workflow_state_provider;
DROP INDEX public.idx_web_orig_client;
DROP INDEX public.idx_usr_fed_prv_realm;
DROP INDEX public.idx_usr_fed_map_realm;
DROP INDEX public.idx_usr_fed_map_fed_prv;
DROP INDEX public.idx_user_session_expiration_last_refresh;
DROP INDEX public.idx_user_session_expiration_created;
DROP INDEX public.idx_user_service_account;
DROP INDEX public.idx_user_role_mapping;
DROP INDEX public.idx_user_reqactions;
DROP INDEX public.idx_user_group_mapping;
DROP INDEX public.idx_user_email;
DROP INDEX public.idx_user_credential;
DROP INDEX public.idx_user_consent;
DROP INDEX public.idx_user_attribute_name;
DROP INDEX public.idx_user_attribute;
DROP INDEX public.idx_usconsent_scope_id;
DROP INDEX public.idx_usconsent_clscope;
DROP INDEX public.idx_update_time;
DROP INDEX public.idx_scope_policy_policy;
DROP INDEX public.idx_scope_mapping_role;
DROP INDEX public.idx_role_clscope;
DROP INDEX public.idx_role_attribute;
DROP INDEX public.idx_rev_token_on_expire;
DROP INDEX public.idx_res_srv_scope_res_srv;
DROP INDEX public.idx_res_srv_res_res_srv;
DROP INDEX public.idx_res_serv_pol_res_serv;
DROP INDEX public.idx_res_scope_scope;
DROP INDEX public.idx_res_policy_policy;
DROP INDEX public.idx_req_act_prov_realm;
DROP INDEX public.idx_redir_uri_client;
DROP INDEX public.idx_realm_supp_local_realm;
DROP INDEX public.idx_realm_master_adm_cli;
DROP INDEX public.idx_realm_evt_types_realm;
DROP INDEX public.idx_realm_evt_list_realm;
DROP INDEX public.idx_realm_def_grp_realm;
DROP INDEX public.idx_realm_clscope;
DROP INDEX public.idx_realm_attr_realm;
DROP INDEX public.idx_protocol_mapper_client;
DROP INDEX public.idx_perm_ticket_requester;
DROP INDEX public.idx_perm_ticket_owner;
DROP INDEX public.idx_org_invitation_org_id;
DROP INDEX public.idx_org_invitation_expires;
DROP INDEX public.idx_org_invitation_email;
DROP INDEX public.idx_org_domain_org_id;
DROP INDEX public.idx_offline_uss_by_user;
DROP INDEX public.idx_offline_uss_by_broker_session_id;
DROP INDEX public.idx_offline_css_by_client_storage_provider;
DROP INDEX public.idx_offline_css_by_client;
DROP INDEX public.idx_keycloak_role_realm;
DROP INDEX public.idx_keycloak_role_client;
DROP INDEX public.idx_idp_realm_org;
DROP INDEX public.idx_idp_for_login;
DROP INDEX public.idx_ident_prov_realm;
DROP INDEX public.idx_id_prov_mapp_realm;
DROP INDEX public.idx_group_role_mapp_group;
DROP INDEX public.idx_group_attr_group;
DROP INDEX public.idx_group_att_by_name_value;
DROP INDEX public.idx_fu_role_mapping_ru;
DROP INDEX public.idx_fu_role_mapping;
DROP INDEX public.idx_fu_required_action_ru;
DROP INDEX public.idx_fu_required_action;
DROP INDEX public.idx_fu_group_membership_ru;
DROP INDEX public.idx_fu_group_membership;
DROP INDEX public.idx_fu_credential_ru;
DROP INDEX public.idx_fu_credential;
DROP INDEX public.idx_fu_consent_ru;
DROP INDEX public.idx_fu_consent;
DROP INDEX public.idx_fu_cnsnt_ext;
DROP INDEX public.idx_fu_attribute;
DROP INDEX public.idx_fedidentity_user;
DROP INDEX public.idx_fedidentity_feduser;
DROP INDEX public.idx_event_time;
DROP INDEX public.idx_event_entity_user_id_type;
DROP INDEX public.idx_defcls_scope;
DROP INDEX public.idx_defcls_realm;
DROP INDEX public.idx_composite_child;
DROP INDEX public.idx_composite;
DROP INDEX public.idx_component_realm;
DROP INDEX public.idx_component_provider_type;
DROP INDEX public.idx_compo_config_compo;
DROP INDEX public.idx_clscope_role;
DROP INDEX public.idx_clscope_protmap;
DROP INDEX public.idx_clscope_cl;
DROP INDEX public.idx_clscope_attrs;
DROP INDEX public.idx_client_init_acc_realm;
DROP INDEX public.idx_client_id;
DROP INDEX public.idx_client_att_by_name_value;
DROP INDEX public.idx_cl_clscope;
DROP INDEX public.idx_broker_link_user_id;
DROP INDEX public.idx_broker_link_identity_provider;
DROP INDEX public.idx_auth_flow_realm;
DROP INDEX public.idx_auth_exec_realm_flow;
DROP INDEX public.idx_auth_exec_flow;
DROP INDEX public.idx_auth_config_realm;
DROP INDEX public.idx_assoc_pol_assoc_pol_id;
DROP INDEX public.idx_admin_event_time;
DROP INDEX public.fed_user_attr_long_values_lower_case;
DROP INDEX public.fed_user_attr_long_values;
ALTER TABLE ONLY public.workflow_state DROP CONSTRAINT uq_workflow_resource;
ALTER TABLE ONLY public.user_entity DROP CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6;
ALTER TABLE ONLY public.realm DROP CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi;
ALTER TABLE ONLY public.org DROP CONSTRAINT uk_org_name;
ALTER TABLE ONLY public.org_invitation DROP CONSTRAINT uk_org_invitation_email;
ALTER TABLE ONLY public.org DROP CONSTRAINT uk_org_group;
ALTER TABLE ONLY public.org DROP CONSTRAINT uk_org_alias;
ALTER TABLE ONLY public.migration_model DROP CONSTRAINT uk_migration_version;
ALTER TABLE ONLY public.migration_model DROP CONSTRAINT uk_migration_update_time;
ALTER TABLE ONLY public.user_consent DROP CONSTRAINT uk_local_consent;
ALTER TABLE ONLY public.resource_server_scope DROP CONSTRAINT uk_frsrst700s9v50bu18ws5ha6;
ALTER TABLE ONLY public.resource_server_policy DROP CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6;
ALTER TABLE ONLY public.resource_server_perm_ticket DROP CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt;
ALTER TABLE ONLY public.resource_server_resource DROP CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6;
ALTER TABLE ONLY public.user_consent DROP CONSTRAINT uk_external_consent;
ALTER TABLE ONLY public.user_entity DROP CONSTRAINT uk_dykn684sl8up1crfei6eckhd7;
ALTER TABLE ONLY public.client_scope DROP CONSTRAINT uk_cli_scope;
ALTER TABLE ONLY public.client DROP CONSTRAINT uk_b71cjlbenv945rb6gcon438at;
ALTER TABLE ONLY public.identity_provider DROP CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33;
ALTER TABLE ONLY public.keycloak_group DROP CONSTRAINT sibling_names;
ALTER TABLE ONLY public.resource_attribute DROP CONSTRAINT res_attr_pk;
ALTER TABLE ONLY public.realm_localizations DROP CONSTRAINT realm_localizations_pkey;
ALTER TABLE ONLY public.default_client_scope DROP CONSTRAINT r_def_cli_scope_bind;
ALTER TABLE ONLY public.workflow_state DROP CONSTRAINT pk_workflow_state;
ALTER TABLE ONLY public.client_scope_role_mapping DROP CONSTRAINT pk_template_scope;
ALTER TABLE ONLY public.resource_server DROP CONSTRAINT pk_resource_server;
ALTER TABLE ONLY public.client_scope DROP CONSTRAINT pk_cli_template;
ALTER TABLE ONLY public.client_scope_attributes DROP CONSTRAINT pk_cl_tmpl_attr;
ALTER TABLE ONLY public.databasechangeloglock DROP CONSTRAINT databasechangeloglock_pkey;
ALTER TABLE ONLY public.web_origins DROP CONSTRAINT constraint_web_origins;
ALTER TABLE ONLY public.user_group_membership DROP CONSTRAINT constraint_user_group;
ALTER TABLE ONLY public.user_attribute DROP CONSTRAINT constraint_user_attribute_pk;
ALTER TABLE ONLY public.revoked_token DROP CONSTRAINT constraint_rt;
ALTER TABLE ONLY public.role_attribute DROP CONSTRAINT constraint_role_attribute_pk;
ALTER TABLE ONLY public.resource_uris DROP CONSTRAINT constraint_resour_uris_pk;
ALTER TABLE ONLY public.user_required_action DROP CONSTRAINT constraint_required_action;
ALTER TABLE ONLY public.required_action_provider DROP CONSTRAINT constraint_req_act_prv_pk;
ALTER TABLE ONLY public.required_action_config DROP CONSTRAINT constraint_req_act_cfg_pk;
ALTER TABLE ONLY public.redirect_uris DROP CONSTRAINT constraint_redirect_uris;
ALTER TABLE ONLY public.protocol_mapper_config DROP CONSTRAINT constraint_pmconfig;
ALTER TABLE ONLY public.protocol_mapper DROP CONSTRAINT constraint_pcm;
ALTER TABLE ONLY public.org_invitation DROP CONSTRAINT constraint_org_invitation;
ALTER TABLE ONLY public.offline_user_session DROP CONSTRAINT constraint_offl_us_ses_pk2;
ALTER TABLE ONLY public.offline_client_session DROP CONSTRAINT constraint_offl_cl_ses_pk3;
ALTER TABLE ONLY public.migration_model DROP CONSTRAINT constraint_migmod;
ALTER TABLE ONLY public.jgroups_ping DROP CONSTRAINT constraint_jgroups_ping;
ALTER TABLE ONLY public.idp_mapper_config DROP CONSTRAINT constraint_idpmconfig;
ALTER TABLE ONLY public.identity_provider_mapper DROP CONSTRAINT constraint_idpm;
ALTER TABLE ONLY public.group_role_mapping DROP CONSTRAINT constraint_group_role;
ALTER TABLE ONLY public.group_attribute DROP CONSTRAINT constraint_group_attribute_pk;
ALTER TABLE ONLY public.keycloak_group DROP CONSTRAINT constraint_group;
ALTER TABLE ONLY public.user_consent DROP CONSTRAINT constraint_grntcsnt_pm;
ALTER TABLE ONLY public.user_consent_client_scope DROP CONSTRAINT constraint_grntcsnt_clsc_pm;
ALTER TABLE ONLY public.fed_user_consent_cl_scope DROP CONSTRAINT constraint_fgrntcsnt_clsc_pm;
ALTER TABLE ONLY public.user_federation_mapper DROP CONSTRAINT constraint_fedmapperpm;
ALTER TABLE ONLY public.user_federation_mapper_config DROP CONSTRAINT constraint_fedmapper_cfg_pm;
ALTER TABLE ONLY public.user_entity DROP CONSTRAINT constraint_fb;
ALTER TABLE ONLY public.scope_policy DROP CONSTRAINT constraint_farsrsps;
ALTER TABLE ONLY public.resource_scope DROP CONSTRAINT constraint_farsrsp;
ALTER TABLE ONLY public.resource_server_scope DROP CONSTRAINT constraint_farsrs;
ALTER TABLE ONLY public.resource_policy DROP CONSTRAINT constraint_farsrpp;
ALTER TABLE ONLY public.associated_policy DROP CONSTRAINT constraint_farsrpap;
ALTER TABLE ONLY public.resource_server_policy DROP CONSTRAINT constraint_farsrp;
ALTER TABLE ONLY public.resource_server_resource DROP CONSTRAINT constraint_farsr;
ALTER TABLE ONLY public.resource_server_perm_ticket DROP CONSTRAINT constraint_fapmt;
ALTER TABLE ONLY public.user_federation_config DROP CONSTRAINT constraint_f9;
ALTER TABLE ONLY public.credential DROP CONSTRAINT constraint_f;
ALTER TABLE ONLY public.realm_smtp_config DROP CONSTRAINT constraint_e;
ALTER TABLE ONLY public.policy_config DROP CONSTRAINT constraint_dpc;
ALTER TABLE ONLY public.identity_provider_config DROP CONSTRAINT constraint_d;
ALTER TABLE ONLY public.composite_role DROP CONSTRAINT constraint_composite_role;
ALTER TABLE ONLY public.user_role_mapping DROP CONSTRAINT constraint_c;
ALTER TABLE ONLY public.authenticator_config DROP CONSTRAINT constraint_auth_pk;
ALTER TABLE ONLY public.authentication_flow DROP CONSTRAINT constraint_auth_flow_pk;
ALTER TABLE ONLY public.authentication_execution DROP CONSTRAINT constraint_auth_exec_pk;
ALTER TABLE ONLY public.authenticator_config_entry DROP CONSTRAINT constraint_auth_cfg_pk;
ALTER TABLE ONLY public.admin_event_entity DROP CONSTRAINT constraint_admin_event_entity;
ALTER TABLE ONLY public.keycloak_role DROP CONSTRAINT constraint_a;
ALTER TABLE ONLY public.realm_required_credential DROP CONSTRAINT constraint_92;
ALTER TABLE ONLY public.realm_attribute DROP CONSTRAINT constraint_9;
ALTER TABLE ONLY public.client_node_registrations DROP CONSTRAINT constraint_84;
ALTER TABLE ONLY public.scope_mapping DROP CONSTRAINT constraint_81;
ALTER TABLE ONLY public.client DROP CONSTRAINT constraint_7;
ALTER TABLE ONLY public.user_federation_provider DROP CONSTRAINT constraint_5c;
ALTER TABLE ONLY public.realm DROP CONSTRAINT constraint_4a;
ALTER TABLE ONLY public.federated_identity DROP CONSTRAINT constraint_40;
ALTER TABLE ONLY public.event_entity DROP CONSTRAINT constraint_4;
ALTER TABLE ONLY public.client_attributes DROP CONSTRAINT constraint_3c;
ALTER TABLE ONLY public.identity_provider DROP CONSTRAINT constraint_2b;
ALTER TABLE ONLY public.realm_supported_locales DROP CONSTRAINT constr_realm_supported_locales;
ALTER TABLE ONLY public.realm_events_listeners DROP CONSTRAINT constr_realm_events_listeners;
ALTER TABLE ONLY public.realm_enabled_event_types DROP CONSTRAINT constr_realm_enabl_event_types;
ALTER TABLE ONLY public.realm_default_groups DROP CONSTRAINT constr_realm_default_groups;
ALTER TABLE ONLY public.federated_user DROP CONSTRAINT constr_federated_user;
ALTER TABLE ONLY public.fed_user_role_mapping DROP CONSTRAINT constr_fed_user_role;
ALTER TABLE ONLY public.fed_user_group_membership DROP CONSTRAINT constr_fed_user_group;
ALTER TABLE ONLY public.fed_user_credential DROP CONSTRAINT constr_fed_user_cred_pk;
ALTER TABLE ONLY public.fed_user_consent DROP CONSTRAINT constr_fed_user_consent_pk;
ALTER TABLE ONLY public.fed_user_attribute DROP CONSTRAINT constr_fed_user_attr_pk;
ALTER TABLE ONLY public.fed_user_required_action DROP CONSTRAINT constr_fed_required_action;
ALTER TABLE ONLY public.component DROP CONSTRAINT constr_component_pk;
ALTER TABLE ONLY public.component_config DROP CONSTRAINT constr_component_config_pk;
ALTER TABLE ONLY public.broker_link DROP CONSTRAINT constr_broker_link_pk;
ALTER TABLE ONLY public.realm_default_groups DROP CONSTRAINT con_group_id_def_groups;
ALTER TABLE ONLY public.client_initial_access DROP CONSTRAINT cnstr_client_init_acc_pk;
ALTER TABLE ONLY public.client_scope_client DROP CONSTRAINT c_cli_scope_bind;
ALTER TABLE ONLY public.client_auth_flow_bindings DROP CONSTRAINT c_cli_flow_bind;
ALTER TABLE ONLY public.keycloak_role DROP CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2";
ALTER TABLE ONLY public.server_config DROP CONSTRAINT "SERVER_CONFIG_pkey";
ALTER TABLE ONLY public.org DROP CONSTRAINT "ORG_pkey";
ALTER TABLE ONLY public.org_domain DROP CONSTRAINT "ORG_DOMAIN_pkey";
DROP TABLE public.workflow_state;
DROP TABLE public.web_origins;
DROP TABLE public.user_role_mapping;
DROP TABLE public.user_required_action;
DROP TABLE public.user_group_membership;
DROP TABLE public.user_federation_provider;
DROP TABLE public.user_federation_mapper_config;
DROP TABLE public.user_federation_mapper;
DROP TABLE public.user_federation_config;
DROP TABLE public.user_entity;
DROP TABLE public.user_consent_client_scope;
DROP TABLE public.user_consent;
DROP TABLE public.user_attribute;
DROP TABLE public.server_config;
DROP TABLE public.scope_policy;
DROP TABLE public.scope_mapping;
DROP TABLE public.role_attribute;
DROP TABLE public.revoked_token;
DROP TABLE public.resource_uris;
DROP TABLE public.resource_server_scope;
DROP TABLE public.resource_server_resource;
DROP TABLE public.resource_server_policy;
DROP TABLE public.resource_server_perm_ticket;
DROP TABLE public.resource_server;
DROP TABLE public.resource_scope;
DROP TABLE public.resource_policy;
DROP TABLE public.resource_attribute;
DROP TABLE public.required_action_provider;
DROP TABLE public.required_action_config;
DROP TABLE public.redirect_uris;
DROP TABLE public.realm_supported_locales;
DROP TABLE public.realm_smtp_config;
DROP TABLE public.realm_required_credential;
DROP TABLE public.realm_localizations;
DROP TABLE public.realm_events_listeners;
DROP TABLE public.realm_enabled_event_types;
DROP TABLE public.realm_default_groups;
DROP TABLE public.realm_attribute;
DROP TABLE public.realm;
DROP TABLE public.protocol_mapper_config;
DROP TABLE public.protocol_mapper;
DROP TABLE public.policy_config;
DROP TABLE public.org_invitation;
DROP TABLE public.org_domain;
DROP TABLE public.org;
DROP TABLE public.offline_user_session;
DROP TABLE public.offline_client_session;
DROP TABLE public.migration_model;
DROP TABLE public.keycloak_role;
DROP TABLE public.keycloak_group;
DROP TABLE public.jgroups_ping;
DROP TABLE public.idp_mapper_config;
DROP TABLE public.identity_provider_mapper;
DROP TABLE public.identity_provider_config;
DROP TABLE public.identity_provider;
DROP TABLE public.group_role_mapping;
DROP TABLE public.group_attribute;
DROP TABLE public.federated_user;
DROP TABLE public.federated_identity;
DROP TABLE public.fed_user_role_mapping;
DROP TABLE public.fed_user_required_action;
DROP TABLE public.fed_user_group_membership;
DROP TABLE public.fed_user_credential;
DROP TABLE public.fed_user_consent_cl_scope;
DROP TABLE public.fed_user_consent;
DROP TABLE public.fed_user_attribute;
DROP TABLE public.event_entity;
DROP TABLE public.default_client_scope;
DROP TABLE public.databasechangeloglock;
DROP TABLE public.databasechangelog;
DROP TABLE public.credential;
DROP TABLE public.composite_role;
DROP TABLE public.component_config;
DROP TABLE public.component;
DROP TABLE public.client_scope_role_mapping;
DROP TABLE public.client_scope_client;
DROP TABLE public.client_scope_attributes;
DROP TABLE public.client_scope;
DROP TABLE public.client_node_registrations;
DROP TABLE public.client_initial_access;
DROP TABLE public.client_auth_flow_bindings;
DROP TABLE public.client_attributes;
DROP TABLE public.client;
DROP TABLE public.broker_link;
DROP TABLE public.authenticator_config_entry;
DROP TABLE public.authenticator_config;
DROP TABLE public.authentication_flow;
DROP TABLE public.authentication_execution;
DROP TABLE public.associated_policy;
DROP TABLE public.admin_event_entity;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
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
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
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
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
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
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
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
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean,
    authenticate_by_default boolean,
    realm_id character varying(36),
    add_token_role boolean,
    trust_email boolean,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean,
    organization_id character varying(255),
    hide_on_login boolean
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0,
    remember_me boolean
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak;

--
-- Name: org_invitation; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_invitation (
    id character varying(36) NOT NULL,
    organization_id character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    created_at integer NOT NULL,
    expires_at integer,
    invite_link character varying(2048)
);


ALTER TABLE public.org_invitation OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
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
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: server_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
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
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
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


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Name: workflow_state; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.workflow_state (
    execution_id character varying(255) NOT NULL,
    resource_id character varying(255) NOT NULL,
    workflow_id character varying(255) NOT NULL,
    resource_type character varying(255),
    scheduled_step_id character varying(255),
    scheduled_step_timestamp bigint
);


ALTER TABLE public.workflow_state OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
8a90da48-3ace-4b9c-92c0-e7f7c509dc50	\N	auth-cookie	bea316d6-8ac9-446e-9f23-1404bb74ebb9	1c2d7d02-2895-4939-b8da-8ac0e1556ffb	2	10	f	\N	\N
f73ca935-0817-4f0e-94f5-4edd26ea936a	\N	auth-spnego	bea316d6-8ac9-446e-9f23-1404bb74ebb9	1c2d7d02-2895-4939-b8da-8ac0e1556ffb	3	20	f	\N	\N
e57edf99-3347-42ff-95ca-84d608d4f1ac	\N	identity-provider-redirector	bea316d6-8ac9-446e-9f23-1404bb74ebb9	1c2d7d02-2895-4939-b8da-8ac0e1556ffb	2	25	f	\N	\N
8779973f-4591-4d07-aa8c-05492f007488	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	1c2d7d02-2895-4939-b8da-8ac0e1556ffb	2	30	t	270196a8-92dd-4938-b1e0-c2830a96f4e3	\N
4c941cab-3640-4a8b-90a8-d28492b92f66	\N	auth-username-password-form	bea316d6-8ac9-446e-9f23-1404bb74ebb9	270196a8-92dd-4938-b1e0-c2830a96f4e3	0	10	f	\N	\N
e563aae9-adb9-4512-ad00-8271b367386d	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	270196a8-92dd-4938-b1e0-c2830a96f4e3	1	20	t	24dcc8c2-7803-4201-b6e9-497e3d68fe3b	\N
e20984c0-4904-47ca-a464-362bfbbda165	\N	conditional-user-configured	bea316d6-8ac9-446e-9f23-1404bb74ebb9	24dcc8c2-7803-4201-b6e9-497e3d68fe3b	0	10	f	\N	\N
ad404436-dc37-4c68-bdb6-9e165dbec564	\N	conditional-credential	bea316d6-8ac9-446e-9f23-1404bb74ebb9	24dcc8c2-7803-4201-b6e9-497e3d68fe3b	0	20	f	\N	ad643a5a-98a0-4744-bfe1-140c408f40d1
01f940bd-2536-4223-a653-5acc0ebd7a76	\N	auth-otp-form	bea316d6-8ac9-446e-9f23-1404bb74ebb9	24dcc8c2-7803-4201-b6e9-497e3d68fe3b	2	30	f	\N	\N
38ecc35c-b3d5-4bd9-88b3-16859cdecf6b	\N	webauthn-authenticator	bea316d6-8ac9-446e-9f23-1404bb74ebb9	24dcc8c2-7803-4201-b6e9-497e3d68fe3b	3	40	f	\N	\N
8cb953a7-705e-41e6-b331-5e44342b1c66	\N	auth-recovery-authn-code-form	bea316d6-8ac9-446e-9f23-1404bb74ebb9	24dcc8c2-7803-4201-b6e9-497e3d68fe3b	3	50	f	\N	\N
3249f344-5664-465e-8d82-a2c16ff99856	\N	direct-grant-validate-username	bea316d6-8ac9-446e-9f23-1404bb74ebb9	c8633cd2-938d-4a61-b5ae-128516072f5d	0	10	f	\N	\N
dd863ea3-809b-420f-b5de-e26e9d6dc627	\N	direct-grant-validate-password	bea316d6-8ac9-446e-9f23-1404bb74ebb9	c8633cd2-938d-4a61-b5ae-128516072f5d	0	20	f	\N	\N
e35dd419-a6cb-483a-b214-b2041fbd5e07	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	c8633cd2-938d-4a61-b5ae-128516072f5d	1	30	t	49f1937c-0a44-4df7-bcf3-082f7f531064	\N
18753914-1fba-426b-94b7-2d62e4d9d961	\N	conditional-user-configured	bea316d6-8ac9-446e-9f23-1404bb74ebb9	49f1937c-0a44-4df7-bcf3-082f7f531064	0	10	f	\N	\N
28807624-1c9b-452a-acbd-c48580026079	\N	direct-grant-validate-otp	bea316d6-8ac9-446e-9f23-1404bb74ebb9	49f1937c-0a44-4df7-bcf3-082f7f531064	0	20	f	\N	\N
0b46b98a-ecf8-41f9-8d86-413d852a77a1	\N	registration-page-form	bea316d6-8ac9-446e-9f23-1404bb74ebb9	06808a33-0a1d-40c9-8905-dba1f4a887de	0	10	t	dd9a1f50-3b4e-45b4-bd44-d84e74e2fa7d	\N
f4225df9-6835-4337-867e-67040ebee949	\N	registration-user-creation	bea316d6-8ac9-446e-9f23-1404bb74ebb9	dd9a1f50-3b4e-45b4-bd44-d84e74e2fa7d	0	20	f	\N	\N
a8cdb2f2-9b13-4ed7-97b9-f7b63bab3edd	\N	registration-password-action	bea316d6-8ac9-446e-9f23-1404bb74ebb9	dd9a1f50-3b4e-45b4-bd44-d84e74e2fa7d	0	50	f	\N	\N
c9fe32bb-9eda-4ba2-9841-81132b22b8aa	\N	registration-recaptcha-action	bea316d6-8ac9-446e-9f23-1404bb74ebb9	dd9a1f50-3b4e-45b4-bd44-d84e74e2fa7d	3	60	f	\N	\N
5e986b66-8665-47c0-af72-519d5bc3d1e5	\N	registration-terms-and-conditions	bea316d6-8ac9-446e-9f23-1404bb74ebb9	dd9a1f50-3b4e-45b4-bd44-d84e74e2fa7d	3	70	f	\N	\N
41c4d532-9a91-456d-ac5f-a51e3db9732c	\N	reset-credentials-choose-user	bea316d6-8ac9-446e-9f23-1404bb74ebb9	35c6e783-a8c8-4500-bc48-b5fde32b0db5	0	10	f	\N	\N
7a838f1a-5b71-4885-97e8-1ad6aa6d41f9	\N	reset-credential-email	bea316d6-8ac9-446e-9f23-1404bb74ebb9	35c6e783-a8c8-4500-bc48-b5fde32b0db5	0	20	f	\N	\N
69c32989-7a92-46e2-b999-692a62ee642b	\N	reset-password	bea316d6-8ac9-446e-9f23-1404bb74ebb9	35c6e783-a8c8-4500-bc48-b5fde32b0db5	0	30	f	\N	\N
380f80a7-f8dc-4979-bd24-fc7549860f4b	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	35c6e783-a8c8-4500-bc48-b5fde32b0db5	1	40	t	ae43a818-d7be-4b14-b46b-f60eda52a358	\N
efd7f318-67be-4013-8213-b80ee71cb675	\N	conditional-user-configured	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ae43a818-d7be-4b14-b46b-f60eda52a358	0	10	f	\N	\N
cd705736-87bf-447e-a04c-51bdf538be26	\N	reset-otp	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ae43a818-d7be-4b14-b46b-f60eda52a358	0	20	f	\N	\N
d792d472-3d71-419f-86ae-58c52b1c324c	\N	client-secret	bea316d6-8ac9-446e-9f23-1404bb74ebb9	b06f0eab-5faa-4728-baa0-fe40703ac4db	2	10	f	\N	\N
0553b8f5-24a0-4bdb-be99-8c2e0ac5d129	\N	client-jwt	bea316d6-8ac9-446e-9f23-1404bb74ebb9	b06f0eab-5faa-4728-baa0-fe40703ac4db	2	20	f	\N	\N
8cef7987-a9ab-4abf-a018-cfdc3c1f7b8c	\N	client-secret-jwt	bea316d6-8ac9-446e-9f23-1404bb74ebb9	b06f0eab-5faa-4728-baa0-fe40703ac4db	2	30	f	\N	\N
16411eb6-1a45-4877-b6b8-bde40b52076c	\N	client-x509	bea316d6-8ac9-446e-9f23-1404bb74ebb9	b06f0eab-5faa-4728-baa0-fe40703ac4db	2	40	f	\N	\N
b0edc3a0-ab88-49bf-8165-de92be0869a1	\N	idp-review-profile	bea316d6-8ac9-446e-9f23-1404bb74ebb9	93807b61-b8a8-4030-a1d7-3ecdccdff64b	0	10	f	\N	07cb7363-e64a-4746-bfbd-3ad52a681e21
3b3d420b-e80f-483b-80d2-682c4ad021d3	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	93807b61-b8a8-4030-a1d7-3ecdccdff64b	0	20	t	60281a9b-cd46-476a-9de8-f42a18a16403	\N
cc7d7a58-9c23-498c-92bc-57b3d9c9da25	\N	idp-create-user-if-unique	bea316d6-8ac9-446e-9f23-1404bb74ebb9	60281a9b-cd46-476a-9de8-f42a18a16403	2	10	f	\N	cc478ec4-d683-42c3-8afa-f77990380f04
bcb2314e-2dad-4b0b-af9f-bbbe637d2df4	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	60281a9b-cd46-476a-9de8-f42a18a16403	2	20	t	3869f662-c5b2-411a-8220-ba25eaee6991	\N
81027aa2-e855-4f11-9509-185f9009aee6	\N	idp-confirm-link	bea316d6-8ac9-446e-9f23-1404bb74ebb9	3869f662-c5b2-411a-8220-ba25eaee6991	0	10	f	\N	\N
24743932-f7b1-4a9f-83ed-ce5cd57a9d56	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	3869f662-c5b2-411a-8220-ba25eaee6991	0	20	t	558d4098-4641-473b-b5de-a74e9dde4cfb	\N
82546a7c-ce9b-4f27-9577-2a34cb1786b5	\N	idp-email-verification	bea316d6-8ac9-446e-9f23-1404bb74ebb9	558d4098-4641-473b-b5de-a74e9dde4cfb	2	10	f	\N	\N
e3a5b1a2-822a-43b4-8c04-17302bae7893	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	558d4098-4641-473b-b5de-a74e9dde4cfb	2	20	t	7f68faa1-d3df-4ec0-800a-1a590160ce63	\N
309b60b7-7c8b-4f6a-8359-c64a96190c0f	\N	idp-username-password-form	bea316d6-8ac9-446e-9f23-1404bb74ebb9	7f68faa1-d3df-4ec0-800a-1a590160ce63	0	10	f	\N	\N
1ab79c69-b78e-4526-8648-e6aee69fbf1d	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	7f68faa1-d3df-4ec0-800a-1a590160ce63	1	20	t	cc34f2de-6afd-4ce8-ab17-4eb5e0e5a17a	\N
75fea214-be5f-40b3-abbc-b2fa51c78c8a	\N	conditional-user-configured	bea316d6-8ac9-446e-9f23-1404bb74ebb9	cc34f2de-6afd-4ce8-ab17-4eb5e0e5a17a	0	10	f	\N	\N
2ea15253-09c4-4006-8f33-4cb9c58e1311	\N	conditional-credential	bea316d6-8ac9-446e-9f23-1404bb74ebb9	cc34f2de-6afd-4ce8-ab17-4eb5e0e5a17a	0	20	f	\N	4dd0e759-97d5-4a96-b1d6-e79726db9b94
6e2fcc8a-bef9-4a00-85a2-e236e5acfd2e	\N	auth-otp-form	bea316d6-8ac9-446e-9f23-1404bb74ebb9	cc34f2de-6afd-4ce8-ab17-4eb5e0e5a17a	2	30	f	\N	\N
d82d700e-0ad8-4b71-8ae6-5a23a1b68d3b	\N	webauthn-authenticator	bea316d6-8ac9-446e-9f23-1404bb74ebb9	cc34f2de-6afd-4ce8-ab17-4eb5e0e5a17a	3	40	f	\N	\N
2a961f20-d0f4-4bc9-825e-49ea528b2d56	\N	auth-recovery-authn-code-form	bea316d6-8ac9-446e-9f23-1404bb74ebb9	cc34f2de-6afd-4ce8-ab17-4eb5e0e5a17a	3	50	f	\N	\N
4759c01e-749a-42c2-b083-a71037915e68	\N	http-basic-authenticator	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a76a8466-cae5-436b-9f37-0fa40e22ebf4	0	10	f	\N	\N
aef4149b-ed8d-4cdb-bde0-bcf0eb2b2e79	\N	docker-http-basic-authenticator	bea316d6-8ac9-446e-9f23-1404bb74ebb9	50096e31-8d69-480e-9aef-2a740b51f734	0	10	f	\N	\N
78cfa281-ff11-4daf-9575-03dcde79d1c6	\N	idp-email-verification	2744037b-1841-4221-9433-43ebf4bd227e	fa2cc62c-8684-47ac-a4ad-89564a92aa82	2	10	f	\N	\N
e3b4db6f-462f-48f3-bb99-ffbf5fc6d22f	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	fa2cc62c-8684-47ac-a4ad-89564a92aa82	2	20	t	ce41284d-498d-4d01-88c0-91421df1241b	\N
d11b7d4f-fd24-4f74-94f2-8e9becba87d7	\N	conditional-user-configured	2744037b-1841-4221-9433-43ebf4bd227e	5f670e4c-5c94-45b5-895e-9a5a32200902	0	10	f	\N	\N
ea3bff1c-b4a7-4215-8f0d-40f985ebe939	\N	conditional-credential	2744037b-1841-4221-9433-43ebf4bd227e	5f670e4c-5c94-45b5-895e-9a5a32200902	0	20	f	\N	02717430-639c-49fe-acaa-3e79ac494e16
7438a941-549e-411d-9a4c-f1e8193b27fa	\N	auth-otp-form	2744037b-1841-4221-9433-43ebf4bd227e	5f670e4c-5c94-45b5-895e-9a5a32200902	2	30	f	\N	\N
724667d0-26db-49e0-ae94-e09e53d842a9	\N	webauthn-authenticator	2744037b-1841-4221-9433-43ebf4bd227e	5f670e4c-5c94-45b5-895e-9a5a32200902	3	40	f	\N	\N
35d3fb11-8ab7-4dec-9bca-28c85b76534e	\N	auth-recovery-authn-code-form	2744037b-1841-4221-9433-43ebf4bd227e	5f670e4c-5c94-45b5-895e-9a5a32200902	3	50	f	\N	\N
1a359f3f-7b4b-47e2-b030-8bc810f6a8ad	\N	conditional-user-configured	2744037b-1841-4221-9433-43ebf4bd227e	5bc6722f-0a50-485f-81e4-16b36658e167	0	10	f	\N	\N
6af5d7d8-49e4-431e-abc6-f730cdacb0e7	\N	organization	2744037b-1841-4221-9433-43ebf4bd227e	5bc6722f-0a50-485f-81e4-16b36658e167	2	20	f	\N	\N
e265c453-7f20-4f62-b974-5039576a99a1	\N	conditional-user-configured	2744037b-1841-4221-9433-43ebf4bd227e	f755c607-507b-4356-b1a5-5ef138ec81c0	0	10	f	\N	\N
0c5481f1-daba-4c3b-aa74-3e9a0fbc0a53	\N	direct-grant-validate-otp	2744037b-1841-4221-9433-43ebf4bd227e	f755c607-507b-4356-b1a5-5ef138ec81c0	0	20	f	\N	\N
9e6a7f7f-a285-4bbc-8607-3d4575365f9e	\N	conditional-user-configured	2744037b-1841-4221-9433-43ebf4bd227e	38116194-22d3-446b-9a61-e743b7a64257	0	10	f	\N	\N
5b9e668e-5c58-40d4-8fa5-0119a7320af7	\N	idp-add-organization-member	2744037b-1841-4221-9433-43ebf4bd227e	38116194-22d3-446b-9a61-e743b7a64257	0	20	f	\N	\N
00aed778-c0d2-48ec-8288-900f4e212e89	\N	conditional-user-configured	2744037b-1841-4221-9433-43ebf4bd227e	eb06055e-75f8-4539-8066-2fb94c16bb67	0	10	f	\N	\N
1176a51c-a418-455a-a5f9-28f42865e0d3	\N	conditional-credential	2744037b-1841-4221-9433-43ebf4bd227e	eb06055e-75f8-4539-8066-2fb94c16bb67	0	20	f	\N	883a8ba2-5567-407e-b1db-61749fe44e65
70539539-1332-41b1-8888-ce6ec1444c2b	\N	auth-otp-form	2744037b-1841-4221-9433-43ebf4bd227e	eb06055e-75f8-4539-8066-2fb94c16bb67	2	30	f	\N	\N
2dbf5b83-0fd5-489d-8921-e55e58ff9f61	\N	webauthn-authenticator	2744037b-1841-4221-9433-43ebf4bd227e	eb06055e-75f8-4539-8066-2fb94c16bb67	3	40	f	\N	\N
15679f76-a57a-46b1-b034-9f070ae16992	\N	auth-recovery-authn-code-form	2744037b-1841-4221-9433-43ebf4bd227e	eb06055e-75f8-4539-8066-2fb94c16bb67	3	50	f	\N	\N
fa6a2fc4-5cf9-46ba-8291-bf287bd25e66	\N	idp-confirm-link	2744037b-1841-4221-9433-43ebf4bd227e	541c890b-0edb-47ca-aaa3-8c5a6ca989c6	0	10	f	\N	\N
16fe202f-7bdd-4452-839a-0d97ad9e3d69	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	541c890b-0edb-47ca-aaa3-8c5a6ca989c6	0	20	t	fa2cc62c-8684-47ac-a4ad-89564a92aa82	\N
e96cb5c3-d200-407f-ba0a-d07bf43ff0e5	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	86f56b82-cae5-4efb-8c7e-c75eb68f8f85	1	10	t	5bc6722f-0a50-485f-81e4-16b36658e167	\N
e84352f8-72a1-402f-ba3a-ca8467bc7216	\N	conditional-user-configured	2744037b-1841-4221-9433-43ebf4bd227e	8f11ae6a-6922-4c13-b34b-8ba063cb4752	0	10	f	\N	\N
e9a1e185-4f44-45c2-8189-eaf28d377a4b	\N	reset-otp	2744037b-1841-4221-9433-43ebf4bd227e	8f11ae6a-6922-4c13-b34b-8ba063cb4752	0	20	f	\N	\N
c07422f5-a5f7-4742-bcae-05713d4f7da8	\N	idp-create-user-if-unique	2744037b-1841-4221-9433-43ebf4bd227e	fccb4624-98c5-4083-97cb-cbed252cbf8b	2	10	f	\N	665191bb-aee8-4906-9f02-e4afd8a05465
9a87e4cd-42e8-416f-b353-d1258426fab4	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	fccb4624-98c5-4083-97cb-cbed252cbf8b	2	20	t	541c890b-0edb-47ca-aaa3-8c5a6ca989c6	\N
888f6187-c497-462b-839c-2f1c978c88ee	\N	idp-username-password-form	2744037b-1841-4221-9433-43ebf4bd227e	ce41284d-498d-4d01-88c0-91421df1241b	0	10	f	\N	\N
211f51c9-e868-431c-b37c-022301992377	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	ce41284d-498d-4d01-88c0-91421df1241b	1	20	t	eb06055e-75f8-4539-8066-2fb94c16bb67	\N
3c895b1a-fc4c-4a36-a093-79d3ff43bbe6	\N	auth-cookie	2744037b-1841-4221-9433-43ebf4bd227e	c0bf971c-8067-4640-95a7-25cf5770d9ef	2	10	f	\N	\N
6dfd52ef-2e13-4a88-95c4-edc2f3b2af2d	\N	auth-spnego	2744037b-1841-4221-9433-43ebf4bd227e	c0bf971c-8067-4640-95a7-25cf5770d9ef	3	20	f	\N	\N
f06eee94-34f9-4e0d-b4e7-f771dedd919d	\N	identity-provider-redirector	2744037b-1841-4221-9433-43ebf4bd227e	c0bf971c-8067-4640-95a7-25cf5770d9ef	2	25	f	\N	\N
463874fd-be7d-4b41-9f70-2613335d9fd9	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	c0bf971c-8067-4640-95a7-25cf5770d9ef	2	26	t	86f56b82-cae5-4efb-8c7e-c75eb68f8f85	\N
d5133321-e552-4b49-bb23-5f2dba9b3d6b	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	c0bf971c-8067-4640-95a7-25cf5770d9ef	2	30	t	39cc0501-37a4-4817-a05f-3d49dc6d8e9e	\N
5f3f450b-36fa-4156-b5af-044f225d4f74	\N	client-secret	2744037b-1841-4221-9433-43ebf4bd227e	39010a52-48b6-45c1-846c-dad544d8f3be	2	10	f	\N	\N
cca0f7d7-1d64-4ab6-a5e0-88af08e7c92d	\N	client-jwt	2744037b-1841-4221-9433-43ebf4bd227e	39010a52-48b6-45c1-846c-dad544d8f3be	2	20	f	\N	\N
fdfca5f4-5ace-49ed-9947-e42290faefa9	\N	client-secret-jwt	2744037b-1841-4221-9433-43ebf4bd227e	39010a52-48b6-45c1-846c-dad544d8f3be	2	30	f	\N	\N
aaad1f46-e6ae-4155-8052-5e4187d68efa	\N	client-x509	2744037b-1841-4221-9433-43ebf4bd227e	39010a52-48b6-45c1-846c-dad544d8f3be	2	40	f	\N	\N
12f2a9fc-5951-4ba5-8f5d-e4324208d662	\N	direct-grant-validate-username	2744037b-1841-4221-9433-43ebf4bd227e	3d5cf55f-7eca-46c2-8031-fc796f3b049f	0	10	f	\N	\N
de57f7ef-8aff-4157-a60b-668e93af97c7	\N	direct-grant-validate-password	2744037b-1841-4221-9433-43ebf4bd227e	3d5cf55f-7eca-46c2-8031-fc796f3b049f	0	20	f	\N	\N
75fc6702-a0d6-462b-a743-c4eea97ef2e9	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	3d5cf55f-7eca-46c2-8031-fc796f3b049f	1	30	t	f755c607-507b-4356-b1a5-5ef138ec81c0	\N
7a374390-ba89-422c-89bf-401c131bf1ee	\N	docker-http-basic-authenticator	2744037b-1841-4221-9433-43ebf4bd227e	2a81da9e-79cf-4f9d-98a8-d0b1f953e3f0	0	10	f	\N	\N
690ba34e-e3ba-47c3-a24c-50db2afca0cd	\N	idp-review-profile	2744037b-1841-4221-9433-43ebf4bd227e	53345b4e-a450-455b-b8b9-3bae8032c15f	0	10	f	\N	fd833b3a-6d75-431e-ac9b-51cfcedc593b
65fa8e23-d376-4165-bf58-88864060527a	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	53345b4e-a450-455b-b8b9-3bae8032c15f	0	20	t	fccb4624-98c5-4083-97cb-cbed252cbf8b	\N
427f923a-556a-4b04-8fac-3dfea58259f0	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	53345b4e-a450-455b-b8b9-3bae8032c15f	1	60	t	38116194-22d3-446b-9a61-e743b7a64257	\N
6bcddc33-cdb1-42e0-b4ed-fd314a217a3e	\N	auth-username-password-form	2744037b-1841-4221-9433-43ebf4bd227e	39cc0501-37a4-4817-a05f-3d49dc6d8e9e	0	10	f	\N	\N
1265d06c-4d6d-4f53-ad9d-20fc79aba2c3	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	39cc0501-37a4-4817-a05f-3d49dc6d8e9e	1	20	t	5f670e4c-5c94-45b5-895e-9a5a32200902	\N
a8e61177-f39a-44b1-b033-5c059d3a9e7e	\N	registration-page-form	2744037b-1841-4221-9433-43ebf4bd227e	825dcc25-39a6-49ad-90f6-928d4761660f	0	10	t	6a0b4ae3-3871-4d63-a10a-ffd01362d9aa	\N
5ea19fb4-be2b-4ad4-84d6-62e95444553c	\N	registration-user-creation	2744037b-1841-4221-9433-43ebf4bd227e	6a0b4ae3-3871-4d63-a10a-ffd01362d9aa	0	20	f	\N	\N
683cb603-a542-4f16-9550-8c5285908751	\N	registration-password-action	2744037b-1841-4221-9433-43ebf4bd227e	6a0b4ae3-3871-4d63-a10a-ffd01362d9aa	0	50	f	\N	\N
bd469b2a-b96e-489c-ac52-9505fb5c37eb	\N	registration-recaptcha-action	2744037b-1841-4221-9433-43ebf4bd227e	6a0b4ae3-3871-4d63-a10a-ffd01362d9aa	3	60	f	\N	\N
95682e70-f5eb-43ef-bd55-79d8134f06f5	\N	registration-terms-and-conditions	2744037b-1841-4221-9433-43ebf4bd227e	6a0b4ae3-3871-4d63-a10a-ffd01362d9aa	3	70	f	\N	\N
7bd25046-a02e-4926-a4a4-7cc6d700e2c5	\N	reset-credentials-choose-user	2744037b-1841-4221-9433-43ebf4bd227e	e04dd418-2cd8-4955-b9f1-60fac1e0b7a7	0	10	f	\N	\N
862bd325-a683-422d-a548-19afda23a71f	\N	reset-credential-email	2744037b-1841-4221-9433-43ebf4bd227e	e04dd418-2cd8-4955-b9f1-60fac1e0b7a7	0	20	f	\N	\N
9b0727a4-1fa9-451c-8f61-d5c098aaad3f	\N	reset-password	2744037b-1841-4221-9433-43ebf4bd227e	e04dd418-2cd8-4955-b9f1-60fac1e0b7a7	0	30	f	\N	\N
66f6662c-9ac7-4d9e-95a9-f4170a93972a	\N	\N	2744037b-1841-4221-9433-43ebf4bd227e	e04dd418-2cd8-4955-b9f1-60fac1e0b7a7	1	40	t	8f11ae6a-6922-4c13-b34b-8ba063cb4752	\N
3da6e414-3a6b-45d0-91d1-f80125297769	\N	http-basic-authenticator	2744037b-1841-4221-9433-43ebf4bd227e	28a68f3c-1777-4e4c-adbd-8412bce15102	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
1c2d7d02-2895-4939-b8da-8ac0e1556ffb	browser	Browser based authentication	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	t	t
270196a8-92dd-4938-b1e0-c2830a96f4e3	forms	Username, password, otp and other auth forms.	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
24dcc8c2-7803-4201-b6e9-497e3d68fe3b	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
c8633cd2-938d-4a61-b5ae-128516072f5d	direct grant	OpenID Connect Resource Owner Grant	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	t	t
49f1937c-0a44-4df7-bcf3-082f7f531064	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
06808a33-0a1d-40c9-8905-dba1f4a887de	registration	Registration flow	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	t	t
dd9a1f50-3b4e-45b4-bd44-d84e74e2fa7d	registration form	Registration form	bea316d6-8ac9-446e-9f23-1404bb74ebb9	form-flow	f	t
35c6e783-a8c8-4500-bc48-b5fde32b0db5	reset credentials	Reset credentials for a user if they forgot their password or something	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	t	t
ae43a818-d7be-4b14-b46b-f60eda52a358	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
b06f0eab-5faa-4728-baa0-fe40703ac4db	clients	Base authentication for clients	bea316d6-8ac9-446e-9f23-1404bb74ebb9	client-flow	t	t
93807b61-b8a8-4030-a1d7-3ecdccdff64b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	t	t
60281a9b-cd46-476a-9de8-f42a18a16403	User creation or linking	Flow for the existing/non-existing user alternatives	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
3869f662-c5b2-411a-8220-ba25eaee6991	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
558d4098-4641-473b-b5de-a74e9dde4cfb	Account verification options	Method with which to verify the existing account	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
7f68faa1-d3df-4ec0-800a-1a590160ce63	Verify Existing Account by Re-authentication	Reauthentication of existing account	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
cc34f2de-6afd-4ce8-ab17-4eb5e0e5a17a	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	f	t
a76a8466-cae5-436b-9f37-0fa40e22ebf4	saml ecp	SAML ECP Profile Authentication Flow	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	t	t
50096e31-8d69-480e-9aef-2a740b51f734	docker auth	Used by Docker clients to authenticate against the IDP	bea316d6-8ac9-446e-9f23-1404bb74ebb9	basic-flow	t	t
fa2cc62c-8684-47ac-a4ad-89564a92aa82	Account verification options	Method with which to verify the existing account	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
5f670e4c-5c94-45b5-895e-9a5a32200902	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
5bc6722f-0a50-485f-81e4-16b36658e167	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
f755c607-507b-4356-b1a5-5ef138ec81c0	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
38116194-22d3-446b-9a61-e743b7a64257	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
eb06055e-75f8-4539-8066-2fb94c16bb67	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
541c890b-0edb-47ca-aaa3-8c5a6ca989c6	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
86f56b82-cae5-4efb-8c7e-c75eb68f8f85	Organization	\N	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
8f11ae6a-6922-4c13-b34b-8ba063cb4752	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
fccb4624-98c5-4083-97cb-cbed252cbf8b	User creation or linking	Flow for the existing/non-existing user alternatives	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
ce41284d-498d-4d01-88c0-91421df1241b	Verify Existing Account by Re-authentication	Reauthentication of existing account	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
c0bf971c-8067-4640-95a7-25cf5770d9ef	browser	Browser based authentication	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	t	t
39010a52-48b6-45c1-846c-dad544d8f3be	clients	Base authentication for clients	2744037b-1841-4221-9433-43ebf4bd227e	client-flow	t	t
3d5cf55f-7eca-46c2-8031-fc796f3b049f	direct grant	OpenID Connect Resource Owner Grant	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	t	t
2a81da9e-79cf-4f9d-98a8-d0b1f953e3f0	docker auth	Used by Docker clients to authenticate against the IDP	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	t	t
53345b4e-a450-455b-b8b9-3bae8032c15f	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	t	t
39cc0501-37a4-4817-a05f-3d49dc6d8e9e	forms	Username, password, otp and other auth forms.	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	f	t
825dcc25-39a6-49ad-90f6-928d4761660f	registration	Registration flow	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	t	t
6a0b4ae3-3871-4d63-a10a-ffd01362d9aa	registration form	Registration form	2744037b-1841-4221-9433-43ebf4bd227e	form-flow	f	t
e04dd418-2cd8-4955-b9f1-60fac1e0b7a7	reset credentials	Reset credentials for a user if they forgot their password or something	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	t	t
28a68f3c-1777-4e4c-adbd-8412bce15102	saml ecp	SAML ECP Profile Authentication Flow	2744037b-1841-4221-9433-43ebf4bd227e	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
ad643a5a-98a0-4744-bfe1-140c408f40d1	browser-conditional-credential	bea316d6-8ac9-446e-9f23-1404bb74ebb9
07cb7363-e64a-4746-bfbd-3ad52a681e21	review profile config	bea316d6-8ac9-446e-9f23-1404bb74ebb9
cc478ec4-d683-42c3-8afa-f77990380f04	create unique user config	bea316d6-8ac9-446e-9f23-1404bb74ebb9
4dd0e759-97d5-4a96-b1d6-e79726db9b94	first-broker-login-conditional-credential	bea316d6-8ac9-446e-9f23-1404bb74ebb9
02717430-639c-49fe-acaa-3e79ac494e16	browser-conditional-credential	2744037b-1841-4221-9433-43ebf4bd227e
665191bb-aee8-4906-9f02-e4afd8a05465	create unique user config	2744037b-1841-4221-9433-43ebf4bd227e
883a8ba2-5567-407e-b1db-61749fe44e65	first-broker-login-conditional-credential	2744037b-1841-4221-9433-43ebf4bd227e
fd833b3a-6d75-431e-ac9b-51cfcedc593b	review profile config	2744037b-1841-4221-9433-43ebf4bd227e
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
07cb7363-e64a-4746-bfbd-3ad52a681e21	missing	update.profile.on.first.login
4dd0e759-97d5-4a96-b1d6-e79726db9b94	webauthn-passwordless	credentials
ad643a5a-98a0-4744-bfe1-140c408f40d1	webauthn-passwordless	credentials
cc478ec4-d683-42c3-8afa-f77990380f04	false	require.password.update.after.registration
02717430-639c-49fe-acaa-3e79ac494e16	webauthn-passwordless	credentials
665191bb-aee8-4906-9f02-e4afd8a05465	false	require.password.update.after.registration
883a8ba2-5567-407e-b1db-61749fe44e65	webauthn-passwordless	credentials
fd833b3a-6d75-431e-ac9b-51cfcedc593b	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	f	master-realm	0	f	\N	\N	t	\N	f	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
a36f1367-a594-4c22-809e-83224efcb50d	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	bea316d6-8ac9-446e-9f23-1404bb74ebb9	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
826d092e-efbb-4201-be09-098a546e5a8a	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	bea316d6-8ac9-446e-9f23-1404bb74ebb9	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9c893a44-379b-403a-afac-3dff84abb810	t	f	broker	0	f	\N	\N	t	\N	f	bea316d6-8ac9-446e-9f23-1404bb74ebb9	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	bea316d6-8ac9-446e-9f23-1404bb74ebb9	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
c802e15f-15d6-4fa2-8583-1274fbded47a	t	t	admin-cli	0	t	\N	\N	f	\N	f	bea316d6-8ac9-446e-9f23-1404bb74ebb9	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	f	newRealm-realm	0	f	\N	\N	t	\N	f	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N	0	f	f	newRealm Realm	f	client-secret	\N	\N	\N	t	f	f	f
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	f	account	0	t	\N	/realms/newRealm/account/	f	\N	f	2744037b-1841-4221-9433-43ebf4bd227e	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d6d27cdd-ba07-44b2-9804-a86ec1eead93	t	f	account-console	0	t	\N	/realms/newRealm/account/	f	\N	f	2744037b-1841-4221-9433-43ebf4bd227e	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f1b8661b-ef96-480d-82c1-f999585f6ccd	t	t	admin-cli	0	t	\N	\N	f	\N	f	2744037b-1841-4221-9433-43ebf4bd227e	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	t	f	broker	0	f	\N	\N	t	\N	f	2744037b-1841-4221-9433-43ebf4bd227e	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
3f620058-4974-4328-b5d8-06c087bd0f71	t	t	myclient	0	t	\N		f		f	2744037b-1841-4221-9433-43ebf4bd227e	openid-connect	-1	t	f	myclient	f	none			\N	t	f	t	f
68c69036-b8e9-4dac-b426-6c2478544578	t	f	realm-management	0	f	\N	\N	t	\N	f	2744037b-1841-4221-9433-43ebf4bd227e	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
6c49d412-381a-4191-866d-2df99a6c0f7b	t	t	security-admin-console	0	t	\N	/admin/newRealm/console/	f	\N	f	2744037b-1841-4221-9433-43ebf4bd227e	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
a36f1367-a594-4c22-809e-83224efcb50d	post.logout.redirect.uris	+
826d092e-efbb-4201-be09-098a546e5a8a	post.logout.redirect.uris	+
826d092e-efbb-4201-be09-098a546e5a8a	pkce.code.challenge.method	S256
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	post.logout.redirect.uris	+
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	pkce.code.challenge.method	S256
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	client.use.lightweight.access.token.enabled	true
c802e15f-15d6-4fa2-8583-1274fbded47a	client.use.lightweight.access.token.enabled	true
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	realm_client	false
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	post.logout.redirect.uris	+
d6d27cdd-ba07-44b2-9804-a86ec1eead93	realm_client	false
d6d27cdd-ba07-44b2-9804-a86ec1eead93	post.logout.redirect.uris	+
d6d27cdd-ba07-44b2-9804-a86ec1eead93	pkce.code.challenge.method	S256
f1b8661b-ef96-480d-82c1-f999585f6ccd	realm_client	false
f1b8661b-ef96-480d-82c1-f999585f6ccd	client.use.lightweight.access.token.enabled	true
f1b8661b-ef96-480d-82c1-f999585f6ccd	post.logout.redirect.uris	+
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	realm_client	true
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	post.logout.redirect.uris	+
3f620058-4974-4328-b5d8-06c087bd0f71	oauth2.jwt.authorization.grant.enabled	false
3f620058-4974-4328-b5d8-06c087bd0f71	frontchannel.logout.session.required	true
3f620058-4974-4328-b5d8-06c087bd0f71	post.logout.redirect.uris	*
3f620058-4974-4328-b5d8-06c087bd0f71	oauth2.device.authorization.grant.enabled	false
3f620058-4974-4328-b5d8-06c087bd0f71	backchannel.logout.revoke.offline.tokens	false
3f620058-4974-4328-b5d8-06c087bd0f71	use.refresh.tokens	true
3f620058-4974-4328-b5d8-06c087bd0f71	realm_client	false
3f620058-4974-4328-b5d8-06c087bd0f71	oidc.ciba.grant.enabled	false
3f620058-4974-4328-b5d8-06c087bd0f71	backchannel.logout.session.required	true
3f620058-4974-4328-b5d8-06c087bd0f71	client_credentials.use_refresh_token	false
3f620058-4974-4328-b5d8-06c087bd0f71	require.pushed.authorization.requests	false
3f620058-4974-4328-b5d8-06c087bd0f71	pkce.code.challenge.method	S256
3f620058-4974-4328-b5d8-06c087bd0f71	dpop.bound.access.tokens	false
3f620058-4974-4328-b5d8-06c087bd0f71	id.token.as.detached.signature	false
3f620058-4974-4328-b5d8-06c087bd0f71	logout.confirmation.enabled	true
3f620058-4974-4328-b5d8-06c087bd0f71	client.introspection.response.allow.jwt.claim.enabled	false
3f620058-4974-4328-b5d8-06c087bd0f71	standard.token.exchange.enabled	false
3f620058-4974-4328-b5d8-06c087bd0f71	login_theme	keycloak.v2
3f620058-4974-4328-b5d8-06c087bd0f71	client.use.lightweight.access.token.enabled	false
3f620058-4974-4328-b5d8-06c087bd0f71	request.object.required	not required
3f620058-4974-4328-b5d8-06c087bd0f71	access.token.header.type.rfc9068	false
3f620058-4974-4328-b5d8-06c087bd0f71	acr.loa.map	{}
3f620058-4974-4328-b5d8-06c087bd0f71	tls.client.certificate.bound.access.tokens	false
3f620058-4974-4328-b5d8-06c087bd0f71	display.on.consent.screen	false
3f620058-4974-4328-b5d8-06c087bd0f71	token.response.type.bearer.lower-case	false
68c69036-b8e9-4dac-b426-6c2478544578	realm_client	true
68c69036-b8e9-4dac-b426-6c2478544578	post.logout.redirect.uris	+
6c49d412-381a-4191-866d-2df99a6c0f7b	realm_client	false
6c49d412-381a-4191-866d-2df99a6c0f7b	client.use.lightweight.access.token.enabled	true
6c49d412-381a-4191-866d-2df99a6c0f7b	post.logout.redirect.uris	+
6c49d412-381a-4191-866d-2df99a6c0f7b	pkce.code.challenge.method	S256
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
7db70245-1500-45ad-9c4d-8c36061f88a8	offline_access	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect built-in scope: offline_access	openid-connect
b5738b07-8a34-47ce-a2dd-16dd113e1bf8	role_list	bea316d6-8ac9-446e-9f23-1404bb74ebb9	SAML role list	saml
e58a3bcf-5051-4b42-b876-31935cc99ea8	saml_organization	bea316d6-8ac9-446e-9f23-1404bb74ebb9	Organization Membership	saml
bfc1f429-a708-4e76-aa78-a04ae22d8b1a	profile	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect built-in scope: profile	openid-connect
0863872d-8bdc-4430-b8d0-ed886d7f6468	email	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect built-in scope: email	openid-connect
190966c3-87d5-4977-b0d8-9b17379a927f	address	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect built-in scope: address	openid-connect
b22b8009-09a6-41ff-82ff-089695e29a3d	phone	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect built-in scope: phone	openid-connect
0b8e687e-2e15-4450-93d3-890431f2b08f	roles	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect scope for add user roles to the access token	openid-connect
a7597da6-4965-4e10-a224-340767a97fac	web-origins	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect scope for add allowed web origins to the access token	openid-connect
2907bd3c-3a0a-4c10-a315-de4855914bc0	microprofile-jwt	bea316d6-8ac9-446e-9f23-1404bb74ebb9	Microprofile - JWT built-in scope	openid-connect
f7aa1d95-99a0-4393-a086-695384ab430d	acr	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
de455754-bc15-48f0-9904-be42d942ed45	basic	bea316d6-8ac9-446e-9f23-1404bb74ebb9	OpenID Connect scope for add all basic claims to the token	openid-connect
b2950fcd-b8f1-44ac-b18a-54a75b997fee	service_account	bea316d6-8ac9-446e-9f23-1404bb74ebb9	Specific scope for a client enabled for service accounts	openid-connect
971ad32d-d973-4bc7-b0b7-ef680e12650e	organization	bea316d6-8ac9-446e-9f23-1404bb74ebb9	Additional claims about the organization a subject belongs to	openid-connect
78f94949-9851-4744-8c3a-de5340324b4f	address	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect built-in scope: address	openid-connect
5bf35843-8c14-4e89-9b48-9b2859a02a1e	email	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect built-in scope: email	openid-connect
8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	organization	2744037b-1841-4221-9433-43ebf4bd227e	Additional claims about the organization a subject belongs to	openid-connect
c2c76379-021e-48e4-8f73-58540d6971fc	profile	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect built-in scope: profile	openid-connect
c2c48045-e884-48b7-95fd-339e1c837548	role_list	2744037b-1841-4221-9433-43ebf4bd227e	SAML role list	saml
6758852d-3f68-470a-bc7d-61ec60eefecd	basic	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect scope for add all basic claims to the token	openid-connect
8d554b0d-1877-47a5-8bb4-4ceb48e767a7	phone	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect built-in scope: phone	openid-connect
7f2c97f3-74f5-4ecb-910d-b621a2164f23	offline_access	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect built-in scope: offline_access	openid-connect
906da9f7-306e-434c-82eb-26b050a36fdf	microprofile-jwt	2744037b-1841-4221-9433-43ebf4bd227e	Microprofile - JWT built-in scope	openid-connect
62d26fd4-86f8-4cff-b86c-eca10cf21fc0	roles	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect scope for add user roles to the access token	openid-connect
06094407-b4f1-4182-94d4-3f751063bec9	web-origins	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect scope for add allowed web origins to the access token	openid-connect
91c62640-2d2e-49ef-9275-9e79781e0825	saml_organization	2744037b-1841-4221-9433-43ebf4bd227e	Organization Membership	saml
d343a500-37da-45a0-affe-4adf1ea6810f	service_account	2744037b-1841-4221-9433-43ebf4bd227e	Specific scope for a client enabled for service accounts	openid-connect
67718965-76f6-4560-9830-9ca9b1acd21a	acr	2744037b-1841-4221-9433-43ebf4bd227e	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
7db70245-1500-45ad-9c4d-8c36061f88a8	true	display.on.consent.screen
7db70245-1500-45ad-9c4d-8c36061f88a8	${offlineAccessScopeConsentText}	consent.screen.text
b5738b07-8a34-47ce-a2dd-16dd113e1bf8	true	display.on.consent.screen
b5738b07-8a34-47ce-a2dd-16dd113e1bf8	${samlRoleListScopeConsentText}	consent.screen.text
e58a3bcf-5051-4b42-b876-31935cc99ea8	false	display.on.consent.screen
bfc1f429-a708-4e76-aa78-a04ae22d8b1a	true	display.on.consent.screen
bfc1f429-a708-4e76-aa78-a04ae22d8b1a	${profileScopeConsentText}	consent.screen.text
bfc1f429-a708-4e76-aa78-a04ae22d8b1a	true	include.in.token.scope
0863872d-8bdc-4430-b8d0-ed886d7f6468	true	display.on.consent.screen
0863872d-8bdc-4430-b8d0-ed886d7f6468	${emailScopeConsentText}	consent.screen.text
0863872d-8bdc-4430-b8d0-ed886d7f6468	true	include.in.token.scope
190966c3-87d5-4977-b0d8-9b17379a927f	true	display.on.consent.screen
190966c3-87d5-4977-b0d8-9b17379a927f	${addressScopeConsentText}	consent.screen.text
190966c3-87d5-4977-b0d8-9b17379a927f	true	include.in.token.scope
b22b8009-09a6-41ff-82ff-089695e29a3d	true	display.on.consent.screen
b22b8009-09a6-41ff-82ff-089695e29a3d	${phoneScopeConsentText}	consent.screen.text
b22b8009-09a6-41ff-82ff-089695e29a3d	true	include.in.token.scope
0b8e687e-2e15-4450-93d3-890431f2b08f	true	display.on.consent.screen
0b8e687e-2e15-4450-93d3-890431f2b08f	${rolesScopeConsentText}	consent.screen.text
0b8e687e-2e15-4450-93d3-890431f2b08f	false	include.in.token.scope
a7597da6-4965-4e10-a224-340767a97fac	false	display.on.consent.screen
a7597da6-4965-4e10-a224-340767a97fac		consent.screen.text
a7597da6-4965-4e10-a224-340767a97fac	false	include.in.token.scope
2907bd3c-3a0a-4c10-a315-de4855914bc0	false	display.on.consent.screen
2907bd3c-3a0a-4c10-a315-de4855914bc0	true	include.in.token.scope
f7aa1d95-99a0-4393-a086-695384ab430d	false	display.on.consent.screen
f7aa1d95-99a0-4393-a086-695384ab430d	false	include.in.token.scope
de455754-bc15-48f0-9904-be42d942ed45	false	display.on.consent.screen
de455754-bc15-48f0-9904-be42d942ed45	false	include.in.token.scope
b2950fcd-b8f1-44ac-b18a-54a75b997fee	false	display.on.consent.screen
b2950fcd-b8f1-44ac-b18a-54a75b997fee	false	include.in.token.scope
971ad32d-d973-4bc7-b0b7-ef680e12650e	true	display.on.consent.screen
971ad32d-d973-4bc7-b0b7-ef680e12650e	${organizationScopeConsentText}	consent.screen.text
971ad32d-d973-4bc7-b0b7-ef680e12650e	true	include.in.token.scope
78f94949-9851-4744-8c3a-de5340324b4f	true	include.in.token.scope
78f94949-9851-4744-8c3a-de5340324b4f	${addressScopeConsentText}	consent.screen.text
78f94949-9851-4744-8c3a-de5340324b4f	true	display.on.consent.screen
5bf35843-8c14-4e89-9b48-9b2859a02a1e	true	include.in.token.scope
5bf35843-8c14-4e89-9b48-9b2859a02a1e	${emailScopeConsentText}	consent.screen.text
5bf35843-8c14-4e89-9b48-9b2859a02a1e	true	display.on.consent.screen
8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	true	include.in.token.scope
8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	${organizationScopeConsentText}	consent.screen.text
8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	true	display.on.consent.screen
c2c76379-021e-48e4-8f73-58540d6971fc	true	include.in.token.scope
c2c76379-021e-48e4-8f73-58540d6971fc	${profileScopeConsentText}	consent.screen.text
c2c76379-021e-48e4-8f73-58540d6971fc	true	display.on.consent.screen
c2c48045-e884-48b7-95fd-339e1c837548	${samlRoleListScopeConsentText}	consent.screen.text
c2c48045-e884-48b7-95fd-339e1c837548	true	display.on.consent.screen
6758852d-3f68-470a-bc7d-61ec60eefecd	false	include.in.token.scope
6758852d-3f68-470a-bc7d-61ec60eefecd	false	display.on.consent.screen
8d554b0d-1877-47a5-8bb4-4ceb48e767a7	true	include.in.token.scope
8d554b0d-1877-47a5-8bb4-4ceb48e767a7	${phoneScopeConsentText}	consent.screen.text
8d554b0d-1877-47a5-8bb4-4ceb48e767a7	true	display.on.consent.screen
7f2c97f3-74f5-4ecb-910d-b621a2164f23	${offlineAccessScopeConsentText}	consent.screen.text
7f2c97f3-74f5-4ecb-910d-b621a2164f23	true	display.on.consent.screen
906da9f7-306e-434c-82eb-26b050a36fdf	true	include.in.token.scope
906da9f7-306e-434c-82eb-26b050a36fdf	false	display.on.consent.screen
62d26fd4-86f8-4cff-b86c-eca10cf21fc0	false	include.in.token.scope
62d26fd4-86f8-4cff-b86c-eca10cf21fc0	${rolesScopeConsentText}	consent.screen.text
62d26fd4-86f8-4cff-b86c-eca10cf21fc0	true	display.on.consent.screen
06094407-b4f1-4182-94d4-3f751063bec9	false	include.in.token.scope
06094407-b4f1-4182-94d4-3f751063bec9		consent.screen.text
06094407-b4f1-4182-94d4-3f751063bec9	false	display.on.consent.screen
91c62640-2d2e-49ef-9275-9e79781e0825	false	display.on.consent.screen
d343a500-37da-45a0-affe-4adf1ea6810f	false	include.in.token.scope
d343a500-37da-45a0-affe-4adf1ea6810f	false	display.on.consent.screen
67718965-76f6-4560-9830-9ca9b1acd21a	false	include.in.token.scope
67718965-76f6-4560-9830-9ca9b1acd21a	false	display.on.consent.screen
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
a36f1367-a594-4c22-809e-83224efcb50d	0b8e687e-2e15-4450-93d3-890431f2b08f	t
a36f1367-a594-4c22-809e-83224efcb50d	0863872d-8bdc-4430-b8d0-ed886d7f6468	t
a36f1367-a594-4c22-809e-83224efcb50d	a7597da6-4965-4e10-a224-340767a97fac	t
a36f1367-a594-4c22-809e-83224efcb50d	f7aa1d95-99a0-4393-a086-695384ab430d	t
a36f1367-a594-4c22-809e-83224efcb50d	de455754-bc15-48f0-9904-be42d942ed45	t
a36f1367-a594-4c22-809e-83224efcb50d	bfc1f429-a708-4e76-aa78-a04ae22d8b1a	t
a36f1367-a594-4c22-809e-83224efcb50d	b22b8009-09a6-41ff-82ff-089695e29a3d	f
a36f1367-a594-4c22-809e-83224efcb50d	2907bd3c-3a0a-4c10-a315-de4855914bc0	f
a36f1367-a594-4c22-809e-83224efcb50d	971ad32d-d973-4bc7-b0b7-ef680e12650e	f
a36f1367-a594-4c22-809e-83224efcb50d	7db70245-1500-45ad-9c4d-8c36061f88a8	f
a36f1367-a594-4c22-809e-83224efcb50d	190966c3-87d5-4977-b0d8-9b17379a927f	f
826d092e-efbb-4201-be09-098a546e5a8a	0b8e687e-2e15-4450-93d3-890431f2b08f	t
826d092e-efbb-4201-be09-098a546e5a8a	0863872d-8bdc-4430-b8d0-ed886d7f6468	t
826d092e-efbb-4201-be09-098a546e5a8a	a7597da6-4965-4e10-a224-340767a97fac	t
826d092e-efbb-4201-be09-098a546e5a8a	f7aa1d95-99a0-4393-a086-695384ab430d	t
826d092e-efbb-4201-be09-098a546e5a8a	de455754-bc15-48f0-9904-be42d942ed45	t
826d092e-efbb-4201-be09-098a546e5a8a	bfc1f429-a708-4e76-aa78-a04ae22d8b1a	t
826d092e-efbb-4201-be09-098a546e5a8a	b22b8009-09a6-41ff-82ff-089695e29a3d	f
826d092e-efbb-4201-be09-098a546e5a8a	2907bd3c-3a0a-4c10-a315-de4855914bc0	f
826d092e-efbb-4201-be09-098a546e5a8a	971ad32d-d973-4bc7-b0b7-ef680e12650e	f
826d092e-efbb-4201-be09-098a546e5a8a	7db70245-1500-45ad-9c4d-8c36061f88a8	f
826d092e-efbb-4201-be09-098a546e5a8a	190966c3-87d5-4977-b0d8-9b17379a927f	f
c802e15f-15d6-4fa2-8583-1274fbded47a	0b8e687e-2e15-4450-93d3-890431f2b08f	t
c802e15f-15d6-4fa2-8583-1274fbded47a	0863872d-8bdc-4430-b8d0-ed886d7f6468	t
c802e15f-15d6-4fa2-8583-1274fbded47a	a7597da6-4965-4e10-a224-340767a97fac	t
c802e15f-15d6-4fa2-8583-1274fbded47a	f7aa1d95-99a0-4393-a086-695384ab430d	t
c802e15f-15d6-4fa2-8583-1274fbded47a	de455754-bc15-48f0-9904-be42d942ed45	t
c802e15f-15d6-4fa2-8583-1274fbded47a	bfc1f429-a708-4e76-aa78-a04ae22d8b1a	t
c802e15f-15d6-4fa2-8583-1274fbded47a	b22b8009-09a6-41ff-82ff-089695e29a3d	f
c802e15f-15d6-4fa2-8583-1274fbded47a	2907bd3c-3a0a-4c10-a315-de4855914bc0	f
c802e15f-15d6-4fa2-8583-1274fbded47a	971ad32d-d973-4bc7-b0b7-ef680e12650e	f
c802e15f-15d6-4fa2-8583-1274fbded47a	7db70245-1500-45ad-9c4d-8c36061f88a8	f
c802e15f-15d6-4fa2-8583-1274fbded47a	190966c3-87d5-4977-b0d8-9b17379a927f	f
9c893a44-379b-403a-afac-3dff84abb810	0b8e687e-2e15-4450-93d3-890431f2b08f	t
9c893a44-379b-403a-afac-3dff84abb810	0863872d-8bdc-4430-b8d0-ed886d7f6468	t
9c893a44-379b-403a-afac-3dff84abb810	a7597da6-4965-4e10-a224-340767a97fac	t
9c893a44-379b-403a-afac-3dff84abb810	f7aa1d95-99a0-4393-a086-695384ab430d	t
9c893a44-379b-403a-afac-3dff84abb810	de455754-bc15-48f0-9904-be42d942ed45	t
9c893a44-379b-403a-afac-3dff84abb810	bfc1f429-a708-4e76-aa78-a04ae22d8b1a	t
9c893a44-379b-403a-afac-3dff84abb810	b22b8009-09a6-41ff-82ff-089695e29a3d	f
9c893a44-379b-403a-afac-3dff84abb810	2907bd3c-3a0a-4c10-a315-de4855914bc0	f
9c893a44-379b-403a-afac-3dff84abb810	971ad32d-d973-4bc7-b0b7-ef680e12650e	f
9c893a44-379b-403a-afac-3dff84abb810	7db70245-1500-45ad-9c4d-8c36061f88a8	f
9c893a44-379b-403a-afac-3dff84abb810	190966c3-87d5-4977-b0d8-9b17379a927f	f
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	0b8e687e-2e15-4450-93d3-890431f2b08f	t
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	0863872d-8bdc-4430-b8d0-ed886d7f6468	t
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	a7597da6-4965-4e10-a224-340767a97fac	t
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	f7aa1d95-99a0-4393-a086-695384ab430d	t
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	de455754-bc15-48f0-9904-be42d942ed45	t
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	bfc1f429-a708-4e76-aa78-a04ae22d8b1a	t
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	b22b8009-09a6-41ff-82ff-089695e29a3d	f
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	2907bd3c-3a0a-4c10-a315-de4855914bc0	f
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	971ad32d-d973-4bc7-b0b7-ef680e12650e	f
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	7db70245-1500-45ad-9c4d-8c36061f88a8	f
0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	190966c3-87d5-4977-b0d8-9b17379a927f	f
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	0b8e687e-2e15-4450-93d3-890431f2b08f	t
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	0863872d-8bdc-4430-b8d0-ed886d7f6468	t
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	a7597da6-4965-4e10-a224-340767a97fac	t
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	f7aa1d95-99a0-4393-a086-695384ab430d	t
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	de455754-bc15-48f0-9904-be42d942ed45	t
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	bfc1f429-a708-4e76-aa78-a04ae22d8b1a	t
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	b22b8009-09a6-41ff-82ff-089695e29a3d	f
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	2907bd3c-3a0a-4c10-a315-de4855914bc0	f
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	971ad32d-d973-4bc7-b0b7-ef680e12650e	f
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	7db70245-1500-45ad-9c4d-8c36061f88a8	f
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	190966c3-87d5-4977-b0d8-9b17379a927f	f
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	5bf35843-8c14-4e89-9b48-9b2859a02a1e	t
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	62d26fd4-86f8-4cff-b86c-eca10cf21fc0	t
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	c2c76379-021e-48e4-8f73-58540d6971fc	t
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	06094407-b4f1-4182-94d4-3f751063bec9	t
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	6758852d-3f68-470a-bc7d-61ec60eefecd	t
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	67718965-76f6-4560-9830-9ca9b1acd21a	t
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	7f2c97f3-74f5-4ecb-910d-b621a2164f23	f
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	78f94949-9851-4744-8c3a-de5340324b4f	f
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	906da9f7-306e-434c-82eb-26b050a36fdf	f
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	f
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	8d554b0d-1877-47a5-8bb4-4ceb48e767a7	f
d6d27cdd-ba07-44b2-9804-a86ec1eead93	5bf35843-8c14-4e89-9b48-9b2859a02a1e	t
d6d27cdd-ba07-44b2-9804-a86ec1eead93	62d26fd4-86f8-4cff-b86c-eca10cf21fc0	t
d6d27cdd-ba07-44b2-9804-a86ec1eead93	c2c76379-021e-48e4-8f73-58540d6971fc	t
d6d27cdd-ba07-44b2-9804-a86ec1eead93	06094407-b4f1-4182-94d4-3f751063bec9	t
d6d27cdd-ba07-44b2-9804-a86ec1eead93	6758852d-3f68-470a-bc7d-61ec60eefecd	t
d6d27cdd-ba07-44b2-9804-a86ec1eead93	67718965-76f6-4560-9830-9ca9b1acd21a	t
d6d27cdd-ba07-44b2-9804-a86ec1eead93	7f2c97f3-74f5-4ecb-910d-b621a2164f23	f
d6d27cdd-ba07-44b2-9804-a86ec1eead93	78f94949-9851-4744-8c3a-de5340324b4f	f
d6d27cdd-ba07-44b2-9804-a86ec1eead93	906da9f7-306e-434c-82eb-26b050a36fdf	f
d6d27cdd-ba07-44b2-9804-a86ec1eead93	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	f
d6d27cdd-ba07-44b2-9804-a86ec1eead93	8d554b0d-1877-47a5-8bb4-4ceb48e767a7	f
f1b8661b-ef96-480d-82c1-f999585f6ccd	5bf35843-8c14-4e89-9b48-9b2859a02a1e	t
f1b8661b-ef96-480d-82c1-f999585f6ccd	62d26fd4-86f8-4cff-b86c-eca10cf21fc0	t
f1b8661b-ef96-480d-82c1-f999585f6ccd	c2c76379-021e-48e4-8f73-58540d6971fc	t
f1b8661b-ef96-480d-82c1-f999585f6ccd	06094407-b4f1-4182-94d4-3f751063bec9	t
f1b8661b-ef96-480d-82c1-f999585f6ccd	6758852d-3f68-470a-bc7d-61ec60eefecd	t
f1b8661b-ef96-480d-82c1-f999585f6ccd	67718965-76f6-4560-9830-9ca9b1acd21a	t
f1b8661b-ef96-480d-82c1-f999585f6ccd	7f2c97f3-74f5-4ecb-910d-b621a2164f23	f
f1b8661b-ef96-480d-82c1-f999585f6ccd	78f94949-9851-4744-8c3a-de5340324b4f	f
f1b8661b-ef96-480d-82c1-f999585f6ccd	906da9f7-306e-434c-82eb-26b050a36fdf	f
f1b8661b-ef96-480d-82c1-f999585f6ccd	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	f
f1b8661b-ef96-480d-82c1-f999585f6ccd	8d554b0d-1877-47a5-8bb4-4ceb48e767a7	f
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	5bf35843-8c14-4e89-9b48-9b2859a02a1e	t
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	62d26fd4-86f8-4cff-b86c-eca10cf21fc0	t
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	c2c76379-021e-48e4-8f73-58540d6971fc	t
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	06094407-b4f1-4182-94d4-3f751063bec9	t
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	6758852d-3f68-470a-bc7d-61ec60eefecd	t
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	67718965-76f6-4560-9830-9ca9b1acd21a	t
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	7f2c97f3-74f5-4ecb-910d-b621a2164f23	f
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	78f94949-9851-4744-8c3a-de5340324b4f	f
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	906da9f7-306e-434c-82eb-26b050a36fdf	f
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	f
3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	8d554b0d-1877-47a5-8bb4-4ceb48e767a7	f
3f620058-4974-4328-b5d8-06c087bd0f71	5bf35843-8c14-4e89-9b48-9b2859a02a1e	t
3f620058-4974-4328-b5d8-06c087bd0f71	62d26fd4-86f8-4cff-b86c-eca10cf21fc0	t
3f620058-4974-4328-b5d8-06c087bd0f71	c2c76379-021e-48e4-8f73-58540d6971fc	t
3f620058-4974-4328-b5d8-06c087bd0f71	06094407-b4f1-4182-94d4-3f751063bec9	t
3f620058-4974-4328-b5d8-06c087bd0f71	6758852d-3f68-470a-bc7d-61ec60eefecd	t
3f620058-4974-4328-b5d8-06c087bd0f71	67718965-76f6-4560-9830-9ca9b1acd21a	t
3f620058-4974-4328-b5d8-06c087bd0f71	7f2c97f3-74f5-4ecb-910d-b621a2164f23	f
3f620058-4974-4328-b5d8-06c087bd0f71	78f94949-9851-4744-8c3a-de5340324b4f	f
3f620058-4974-4328-b5d8-06c087bd0f71	906da9f7-306e-434c-82eb-26b050a36fdf	f
3f620058-4974-4328-b5d8-06c087bd0f71	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	f
3f620058-4974-4328-b5d8-06c087bd0f71	8d554b0d-1877-47a5-8bb4-4ceb48e767a7	f
68c69036-b8e9-4dac-b426-6c2478544578	5bf35843-8c14-4e89-9b48-9b2859a02a1e	t
68c69036-b8e9-4dac-b426-6c2478544578	62d26fd4-86f8-4cff-b86c-eca10cf21fc0	t
68c69036-b8e9-4dac-b426-6c2478544578	c2c76379-021e-48e4-8f73-58540d6971fc	t
68c69036-b8e9-4dac-b426-6c2478544578	06094407-b4f1-4182-94d4-3f751063bec9	t
68c69036-b8e9-4dac-b426-6c2478544578	6758852d-3f68-470a-bc7d-61ec60eefecd	t
68c69036-b8e9-4dac-b426-6c2478544578	67718965-76f6-4560-9830-9ca9b1acd21a	t
68c69036-b8e9-4dac-b426-6c2478544578	7f2c97f3-74f5-4ecb-910d-b621a2164f23	f
68c69036-b8e9-4dac-b426-6c2478544578	78f94949-9851-4744-8c3a-de5340324b4f	f
68c69036-b8e9-4dac-b426-6c2478544578	906da9f7-306e-434c-82eb-26b050a36fdf	f
68c69036-b8e9-4dac-b426-6c2478544578	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	f
68c69036-b8e9-4dac-b426-6c2478544578	8d554b0d-1877-47a5-8bb4-4ceb48e767a7	f
6c49d412-381a-4191-866d-2df99a6c0f7b	5bf35843-8c14-4e89-9b48-9b2859a02a1e	t
6c49d412-381a-4191-866d-2df99a6c0f7b	62d26fd4-86f8-4cff-b86c-eca10cf21fc0	t
6c49d412-381a-4191-866d-2df99a6c0f7b	c2c76379-021e-48e4-8f73-58540d6971fc	t
6c49d412-381a-4191-866d-2df99a6c0f7b	06094407-b4f1-4182-94d4-3f751063bec9	t
6c49d412-381a-4191-866d-2df99a6c0f7b	6758852d-3f68-470a-bc7d-61ec60eefecd	t
6c49d412-381a-4191-866d-2df99a6c0f7b	67718965-76f6-4560-9830-9ca9b1acd21a	t
6c49d412-381a-4191-866d-2df99a6c0f7b	7f2c97f3-74f5-4ecb-910d-b621a2164f23	f
6c49d412-381a-4191-866d-2df99a6c0f7b	78f94949-9851-4744-8c3a-de5340324b4f	f
6c49d412-381a-4191-866d-2df99a6c0f7b	906da9f7-306e-434c-82eb-26b050a36fdf	f
6c49d412-381a-4191-866d-2df99a6c0f7b	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	f
6c49d412-381a-4191-866d-2df99a6c0f7b	8d554b0d-1877-47a5-8bb4-4ceb48e767a7	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
7db70245-1500-45ad-9c4d-8c36061f88a8	65106016-c03f-4baa-9742-b43f56e46672
7f2c97f3-74f5-4ecb-910d-b621a2164f23	5950f615-d936-42ed-8dd8-0d8b4ca47bc7
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
a3672f54-f64f-4a01-a018-63543384477d	Trusted Hosts	bea316d6-8ac9-446e-9f23-1404bb74ebb9	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	anonymous
7d259353-ee75-4ffd-ae99-07d605380ee8	Consent Required	bea316d6-8ac9-446e-9f23-1404bb74ebb9	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	anonymous
f5e7d12c-6649-4115-bd95-260c49d70c6b	Full Scope Disabled	bea316d6-8ac9-446e-9f23-1404bb74ebb9	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	anonymous
b6cd2a09-7dc1-477f-9219-55af35758ac6	Max Clients Limit	bea316d6-8ac9-446e-9f23-1404bb74ebb9	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	anonymous
b87378bc-33ff-457f-af31-b4c9a70ed7f2	Allowed Protocol Mapper Types	bea316d6-8ac9-446e-9f23-1404bb74ebb9	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	anonymous
31fdc1da-36a5-4d13-bdca-ea77f8b01b94	Allowed Client Scopes	bea316d6-8ac9-446e-9f23-1404bb74ebb9	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	anonymous
7a079d89-bc36-42fa-8b2b-a25c579983e1	Allowed Registration Web Origins	bea316d6-8ac9-446e-9f23-1404bb74ebb9	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	anonymous
de6f8a74-0502-4899-bba9-1befb014a9b5	Allowed Protocol Mapper Types	bea316d6-8ac9-446e-9f23-1404bb74ebb9	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	authenticated
da1a9eb7-e07b-4153-906c-c91109c4474d	Allowed Client Scopes	bea316d6-8ac9-446e-9f23-1404bb74ebb9	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	authenticated
bbd6689c-4de7-421f-af25-48849cf0e9ad	Allowed Registration Web Origins	bea316d6-8ac9-446e-9f23-1404bb74ebb9	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	authenticated
12e60a29-8c0a-4616-a0e1-41205cf8c476	rsa-generated	bea316d6-8ac9-446e-9f23-1404bb74ebb9	rsa-generated	org.keycloak.keys.KeyProvider	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N
5ecdf936-1ab2-4352-adca-8b379e026960	rsa-enc-generated	bea316d6-8ac9-446e-9f23-1404bb74ebb9	rsa-enc-generated	org.keycloak.keys.KeyProvider	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N
b3395a09-d6c0-4d9d-9589-4ac91f545cab	hmac-generated-hs512	bea316d6-8ac9-446e-9f23-1404bb74ebb9	hmac-generated	org.keycloak.keys.KeyProvider	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N
5f763e3d-338c-4f3e-a781-fe4c0100f77d	aes-generated	bea316d6-8ac9-446e-9f23-1404bb74ebb9	aes-generated	org.keycloak.keys.KeyProvider	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N
db291a83-ed75-42e0-9781-1a2f8f961aab	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N
cfcd8560-ca01-405e-b5a3-b7db6f66839a	Max Clients Limit	2744037b-1841-4221-9433-43ebf4bd227e	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	anonymous
42917843-325b-4a15-abf3-52037109f433	Allowed Registration Web Origins	2744037b-1841-4221-9433-43ebf4bd227e	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	anonymous
b3d61ff7-42fc-4495-ab37-f1ee6774cacf	Full Scope Disabled	2744037b-1841-4221-9433-43ebf4bd227e	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	anonymous
af893798-ee11-4510-b629-45c4a91af8c7	Allowed Registration Web Origins	2744037b-1841-4221-9433-43ebf4bd227e	registration-web-origins	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	authenticated
6e2c90dc-b956-483c-b15a-291ca814baaf	Trusted Hosts	2744037b-1841-4221-9433-43ebf4bd227e	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	anonymous
0f6f642b-f5ef-4228-9cea-9a63a0fc1358	Allowed Protocol Mapper Types	2744037b-1841-4221-9433-43ebf4bd227e	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	anonymous
4caa60b1-e002-48e4-a902-8cd17368e517	Allowed Client Scopes	2744037b-1841-4221-9433-43ebf4bd227e	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	anonymous
32355ecb-734b-4589-865a-ac451759071c	Consent Required	2744037b-1841-4221-9433-43ebf4bd227e	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	anonymous
1f3fc3b5-406a-41bb-8602-1046413eb860	Allowed Protocol Mapper Types	2744037b-1841-4221-9433-43ebf4bd227e	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	authenticated
4a61c7d8-55fe-41a0-b867-13f4651f6070	Allowed Client Scopes	2744037b-1841-4221-9433-43ebf4bd227e	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2744037b-1841-4221-9433-43ebf4bd227e	authenticated
99948f8b-dbcf-48d6-a38f-060798726bf0	\N	2744037b-1841-4221-9433-43ebf4bd227e	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	2744037b-1841-4221-9433-43ebf4bd227e	\N
f73c72e0-5a84-42b1-9553-831865fa88ae	rsa-generated	2744037b-1841-4221-9433-43ebf4bd227e	rsa-generated	org.keycloak.keys.KeyProvider	2744037b-1841-4221-9433-43ebf4bd227e	\N
bc31a70e-761d-4a00-abbd-24d07b778c8e	rsa-enc-generated	2744037b-1841-4221-9433-43ebf4bd227e	rsa-enc-generated	org.keycloak.keys.KeyProvider	2744037b-1841-4221-9433-43ebf4bd227e	\N
0faada75-9a44-4ca5-a172-d813a12eadea	hmac-generated-hs512	2744037b-1841-4221-9433-43ebf4bd227e	hmac-generated	org.keycloak.keys.KeyProvider	2744037b-1841-4221-9433-43ebf4bd227e	\N
b7b2966a-e8ad-4b1c-b5a6-fb29bd497004	aes-generated	2744037b-1841-4221-9433-43ebf4bd227e	aes-generated	org.keycloak.keys.KeyProvider	2744037b-1841-4221-9433-43ebf4bd227e	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
6644caca-75c9-489a-a490-523555bfd9b3	b87378bc-33ff-457f-af31-b4c9a70ed7f2	allowed-protocol-mapper-types	saml-role-list-mapper
0e2de8e9-0c63-4c6f-bcf4-d548fdf3ab73	b87378bc-33ff-457f-af31-b4c9a70ed7f2	allowed-protocol-mapper-types	oidc-full-name-mapper
34bb9767-496a-4917-9f93-3b1524b25707	b87378bc-33ff-457f-af31-b4c9a70ed7f2	allowed-protocol-mapper-types	saml-user-property-mapper
e81f791a-abe9-451b-a9ff-fb03dd102967	b87378bc-33ff-457f-af31-b4c9a70ed7f2	allowed-protocol-mapper-types	oidc-address-mapper
a50bf450-0dcd-43db-b1cb-db797303ffac	b87378bc-33ff-457f-af31-b4c9a70ed7f2	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
bbcbd500-5b09-4cb8-ac57-961c9351d74f	b87378bc-33ff-457f-af31-b4c9a70ed7f2	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2836b70b-83a8-4abd-a158-bb1f5c701f4b	b87378bc-33ff-457f-af31-b4c9a70ed7f2	allowed-protocol-mapper-types	saml-user-attribute-mapper
5e9e4ea4-54f8-43a4-9d51-90996b881207	b87378bc-33ff-457f-af31-b4c9a70ed7f2	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
2257a117-d333-418d-a581-4fe871959e11	de6f8a74-0502-4899-bba9-1befb014a9b5	allowed-protocol-mapper-types	oidc-full-name-mapper
70e7c93b-81b7-407d-8acf-11eff146190c	de6f8a74-0502-4899-bba9-1befb014a9b5	allowed-protocol-mapper-types	oidc-address-mapper
b1f7bd42-4b7c-4bde-9810-419035b25198	de6f8a74-0502-4899-bba9-1befb014a9b5	allowed-protocol-mapper-types	saml-user-property-mapper
fc583102-ed39-4677-9588-98a66478ed8f	de6f8a74-0502-4899-bba9-1befb014a9b5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5ff73207-8c74-400d-b9b7-a331b9ef7ed7	de6f8a74-0502-4899-bba9-1befb014a9b5	allowed-protocol-mapper-types	saml-role-list-mapper
469c49ec-978f-42e8-b8df-33e516a1b760	de6f8a74-0502-4899-bba9-1befb014a9b5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
99c14bd1-21e4-468e-8ecc-a62b327c5e85	de6f8a74-0502-4899-bba9-1befb014a9b5	allowed-protocol-mapper-types	saml-user-attribute-mapper
9508c229-9b83-4296-b60e-d46f022e9f41	de6f8a74-0502-4899-bba9-1befb014a9b5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ca363542-c0d4-4cba-9806-387e3e8866cf	31fdc1da-36a5-4d13-bdca-ea77f8b01b94	allow-default-scopes	true
bdfe6777-ae01-4bd1-a76a-fb68e8677279	da1a9eb7-e07b-4153-906c-c91109c4474d	allow-default-scopes	true
91d69d1a-85b4-400e-808a-e99ff2e1ec1a	b6cd2a09-7dc1-477f-9219-55af35758ac6	max-clients	200
66eaab92-c02e-4b2e-b7b4-a84b4538e412	a3672f54-f64f-4a01-a018-63543384477d	client-uris-must-match	true
50507dc6-9c6d-4ad0-835b-65cfc8a149bf	a3672f54-f64f-4a01-a018-63543384477d	host-sending-registration-request-must-match	true
2d47d58e-6594-4eaa-8f1a-49da98404acf	db291a83-ed75-42e0-9781-1a2f8f961aab	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
f8620f71-f150-44a2-8751-5325a0b70f89	12e60a29-8c0a-4616-a0e1-41205cf8c476	keyUse	SIG
9eb144b3-92d3-4579-b9bf-ed4050a5a012	12e60a29-8c0a-4616-a0e1-41205cf8c476	priority	100
782c216f-17c7-4085-af1b-a8159b3091b5	12e60a29-8c0a-4616-a0e1-41205cf8c476	privateKey	MIIEowIBAAKCAQEApcJXjkPajnpCc0nD9nExDEqqBXvXM2Vk37fgDjnoJGl8PQjJA+UtJgS50aPvbI5V+7mE2HYHoT8F2eRQcYhVI1cntZy0LBXSiS0ZOTe8BXO4xl54Fx/4cfoJAXtkyBCh0pDM74vdFgcYoTgfrHjtATfVDM9c81UAxJ+I8JomuzQDFh9ivyUZyeTYpxDgtc+GdfMDRMEYXZEd0r1gqDQSsq72OPIHRXAXUEosxYn6DKTar5uczi6eOWiMCeVhQr8WaDuAkLxhsYtlmJJtV3Vwcjpb5+AkHPFMABtZluBauuPP6+dLxq/LcCP+tW+/T4jhM+cNx2RCfpAxPSyow8NZFQIDAQABAoIBACEnQcPepnQg1/GfK2a7NQg0VtVJ87z/5rEoYdP2mQvPXV4Hx8zTpbgY8eGQXG7l+SSj8oIo+VWy+USfecd7cSvkXrjgYtj+dGGjd4wOLbkZcDec5YAakOKbE/oL6Bhr2zH2bEbtPocNXEvCofMpLJ41wJMTVpAEzGaHUihtbJm8dvLeOtecldxI+Fg2LhhkkBVgTGkjsK1Yt5Qe/0J5oU4wT/6z39WY6ZNRNB4tQgZGI/KEfpjylXduvYNaLUmCsbZ2ybOfuz4UlmTeHuH/QpdSm4B3gSMQNZ9vvCBMHJ6SG4/L3pkTJWGNhTpx/dgQlLdFDnrD76J15I5Oe11e+3ECgYEA1+95ZZOuqQS8ExZB09kSUtrkxEwepbm4NXXze0ea2sj5MaLtubjt+AkIPPa8pmPh2XeaYWF2MTqJUVmV4R90LWNzliQJbTBudb6RJD3XnpqfD3RbisXDKuU6MU2j7cVKsJSDZefP2Xkvw6L7enik9D/VF5eV3vWdVnWeCwgaLnMCgYEAxIOWpNuijLhe0ZK2ZbZ8gjwh0bsm53zWi8YLX3NUehWU/i4KlMQJhUyD9ZnPRp9OU+9sKC3PgJB764MVwdfULsHmdR55AxPTfqB/nF+6AnXu1QYDR1efY+ebK5EGHTlubVimuNrbScIWjKFZ783v8NzBdrKwRAF1Vaij6Qs4MFcCgYBbsH/ntdHQSwZhRG4nOmEhdXj2MSxCSp4BdVgx3LHQfM3zWa9/0Rqa25r35/0q2faolLSk7PF27dgpBtUxhl2aeEQ4WIz4JDyDGqweq3PHEPjBYzMLtfWtXTBchw84gzG30RgKSWhke6TgeXA3DMteO0yMe/1Tcw+gCslU/dfAKQKBgGJave4bI3ss2AAqXvH/aMfCEucmtW0M1VC1uYF3dqN3489n+dHFYEKALlehONXO6+Qko8xkSUO+jNcuD5iqTj9susyJiOWaabMp31TDsJSEtBmYXdG6MENPayFd/2JnGTbPNPq2RyTeaGzQYPQd7WZvBsFC4+fVlwVdV1RPUjsXAoGBAICc8IhzOsLXXV5kMG3U0hU1E9bEaO6GNHnu+o3Io3cCngKQsd8Q+wCVMH4J6sjN8osroVlx4SINjnx6+Cwsh1dbwzvpqJFSjVtUjbbbeE0Tw0R70V0SFwk0piWNP6s/ta89bzANB/D35J4k1rqokbG3RieibHDYrhlm9yiN055A
079467f0-61ac-41b9-8ca0-36ebdd153c60	12e60a29-8c0a-4616-a0e1-41205cf8c476	certificate	MIICmzCCAYMCBgGd1kttijANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNDI4MjI1MTAwWhcNMzYwNDI4MjI1MjQwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQClwleOQ9qOekJzScP2cTEMSqoFe9czZWTft+AOOegkaXw9CMkD5S0mBLnRo+9sjlX7uYTYdgehPwXZ5FBxiFUjVye1nLQsFdKJLRk5N7wFc7jGXngXH/hx+gkBe2TIEKHSkMzvi90WBxihOB+seO0BN9UMz1zzVQDEn4jwmia7NAMWH2K/JRnJ5NinEOC1z4Z18wNEwRhdkR3SvWCoNBKyrvY48gdFcBdQSizFifoMpNqvm5zOLp45aIwJ5WFCvxZoO4CQvGGxi2WYkm1XdXByOlvn4CQc8UwAG1mW4Fq648/r50vGr8twI/61b79PiOEz5w3HZEJ+kDE9LKjDw1kVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJHlmzJ/aTxIlQG4FlyBSfm2tfDwMJDb6wXad5tjl/cHlKSzhQ7E3b8qXEEQ0SWBmHlAng2jvKM5EzXyCizOqpisFXoLb69dm5CLCEs4c1bT3LpORIaWZO9FX+fxItKIsP2P4mmRI9z9tBNJtJbpi+hD2iJYGGfY5IG4P+uZyJP71yBlj/44kX4FEWD8CWeeei0XKYnWSQE39VzKaw3HMSgLb41rub2o6KL5m4Vhp/MkoDBgc0wysVmF2j9VqwN1/ZEe37VF3i6Kp3cSKi/pLWAY/s+A1lp+K3weWqgnHpXtpPZaUybIBOd2MhJvD+1OuCMtZFDHscBbhWZMQT7kFsM=
1eb28f78-32a5-4258-a60f-d3d67771e64b	b3395a09-d6c0-4d9d-9589-4ac91f545cab	algorithm	HS512
ca07a8dc-427c-40cd-95b7-4639066baef4	b3395a09-d6c0-4d9d-9589-4ac91f545cab	secret	iJLKRUDkIKis_AmKxinSrpTHkCNYpVUTVJs0OwZfenjzkxqiXtghwkIoMRO8AyjJ72D1na7skc-TlfEOvbwwnfQZTwlukT7h1Y2hNZ0RNJMmSOpuRWcwMU37fNDBtQxTkqpDZHOmji2QaCkdAZryl88Z1ciA9k6td4ibwRIzsUo
ad19aa39-3c20-4437-ab8a-1d23b9d407f7	b3395a09-d6c0-4d9d-9589-4ac91f545cab	priority	100
827ae8f9-d9f4-4363-b5dc-da25ca02b62b	b3395a09-d6c0-4d9d-9589-4ac91f545cab	kid	94a61a84-2df3-46cb-b15c-fdfe6fb86b37
14ab3743-5bbc-4116-bcd1-345f6c8b5618	5f763e3d-338c-4f3e-a781-fe4c0100f77d	priority	100
8974069f-da24-4706-8798-649a189af7c7	5f763e3d-338c-4f3e-a781-fe4c0100f77d	kid	7fe85ae2-0668-4313-82e2-1b153263ecae
b2e1171b-3bcd-4a2a-b2c8-f5e9cd7ec79f	5f763e3d-338c-4f3e-a781-fe4c0100f77d	secret	d3BWJ-YDYnJOqZ50lU1m1A
1fcead55-20c2-46dc-8b02-07480ca8850e	5ecdf936-1ab2-4352-adca-8b379e026960	algorithm	RSA-OAEP
632ea65f-e73c-4eaf-ad1c-71206a203d74	5ecdf936-1ab2-4352-adca-8b379e026960	priority	100
ec50f02e-f714-4ee2-92df-abc6e47f41a3	5ecdf936-1ab2-4352-adca-8b379e026960	certificate	MIICmzCCAYMCBgGd1ktuTTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNDI4MjI1MTAwWhcNMzYwNDI4MjI1MjQwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCunJrvKgKAlkZJKbr/vkDSOVj/E4rTKxOLGKcrDkZDkXcJHxiVDvho6RIrj82BwMp80jOJ5Sw0ig0Ybqv7ytCQLER6aFZqBHkcWBrQNNbSP+WmrgmQkrzTGIcAlK8oVrvt78t6wOGi3KDxdppApqKTXfjKT2MU/L98T4qfkDhs7cLwhDGuURjQCvLPOrWPu/4MJB193ixwVIL+RWExsMPBx8dbrjLuzMW3djygkiBKwwPHV5X5Ln0NCt2vAJQVCujyCzRYOKuzgjrkYssjAQduIx8HPWm5H9sPw0bZVLhx5nixWKDfpcGvrr5oLFDP9L7PyuHCjhGFG5lbj2RRf8FhAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABGgTzfjpoQwNcrzN7HRSL+vs+ooR/JzFnpI73jUGIoXsdbTRcJ5jXvqNr2RVnqDTYKVeS+6hWLeZaRvT7i0kCMKwC9v6z0QXmWt6RWttvvHl8XzSb05/CAFqe0bsilONmSFPRvo6axyK0ib6JYuTrAvKmyJxg2ijwUbiae2DVsEJxTbEmA3gDmAW8De9pLrm6oRhwdh2gIxAhcYbkhvRp0FNFqdIcPpmSKNi/fAe57z2UPjbFjj1KU41llOw2u7B5mqEGCPAQ+1nK4Rl4lIw8fPqokfrz0QHKqP0R1QsJjHWAfgPne8gZSqUM80NVr/92MmXKFYuDU2vZsd1kyI3v4=
d1eee28e-c565-4dd1-993e-4cb44ec5611b	5ecdf936-1ab2-4352-adca-8b379e026960	privateKey	MIIEogIBAAKCAQEArpya7yoCgJZGSSm6/75A0jlY/xOK0ysTixinKw5GQ5F3CR8YlQ74aOkSK4/NgcDKfNIzieUsNIoNGG6r+8rQkCxEemhWagR5HFga0DTW0j/lpq4JkJK80xiHAJSvKFa77e/LesDhotyg8XaaQKaik134yk9jFPy/fE+Kn5A4bO3C8IQxrlEY0Aryzzq1j7v+DCQdfd4scFSC/kVhMbDDwcfHW64y7szFt3Y8oJIgSsMDx1eV+S59DQrdrwCUFQro8gs0WDirs4I65GLLIwEHbiMfBz1puR/bD8NG2VS4ceZ4sVig36XBr66+aCxQz/S+z8rhwo4RhRuZW49kUX/BYQIDAQABAoIBAEZx1+/1Ot01w1VxCIh08SHfERCXicJ39oJ/h7HPKHnKDgQYD4rTZ1Sr8zCv63EVnpuNEk3nr1Xi/DWHMMt8n3gK4/Wecn6DH3lX8jldl+1q6fO88w7opFVl59FMKv5TP65Wt/jmKCHUcPn5p3G9yIk7uEumi4rEDVzRmlOVk64d85Aw8kOjrwzzoElUJ0NgsPJ0l8YmOUNe7thqF0kYu0VM27yvSTt5rarSI2PKigzLFjDXfe0Y/nfdbca2qToKCQmX8KTPDq/h6q93hKZabq4cYCvAYa+qq4KsjedBR2J0xw350XvPro2GQWR6uSE+UbwFPLDvPUVBgId0QOt4OyECgYEA1zp+bdmBCzVgMlNWfchOAtd8oFKO66Iv4YoKXqOPJYFFkg6FUcB1dlrpFKhU5z0Jd0zFFj90b5T/IGV+B53jsIlApFzfZGlAeHB75kYKDjFRzFUk6CL1qgBzS0tvKyR50h3MvUme15qz3f2mbROoDt+0M3oMSm1nw9mzhn4EfO8CgYEAz7Bm37/XYrmMBxP6DjA7NEMV2HdQztk3vc9j1V24O4L3eF2NNVn/2TGkLbi+ShnWBkhm0wa7Gj3CaL1sFhor6l+kRrzXu/PiidE3zFRWRrDSHT+Hh2U/ExvwAY8k2UDCJm76Rb+wNy4bf0G9c04U42zOe5DQpdHE+Uil86wLRq8CgYBQ0wuVbv+x2NqGK5uoYqdBE/EeN8KqJF78wJ0CS0O/XttkbQWN3Mt/pcYv1sMDj31VisPchfnQyVBBtztr2tQdgH2A+8t8ZrYqRHuSzyyJheXk6PiSIEbHD6I8XVijB/CjgkNXtiTrbJItRErSXXZYF5QRXLzu2kUEXGW5lOtUiwKBgEEPb4qUHDLPETB+b4zWSxWaFlPTPLsvjKinOQzz6OyroD5SgBPAd8dgJ6AzCVlJMqSRNbTRnPchda8994gM9sja4SlPqv0z7zlhEuutV8GZTpje9+PQMawYylySrOZpxOgpR7llzRvcE70PqPtf8Gc2BJDs0o+/YMb+nQ3yTS39AoGAONczh4vjPpRhiSLKD0zrc+xem+pSf9TsZ5+Bmpz64kUymbUrPc2TR+TlaENKVoJM2fBOZPFW3UzzXXUuT6exWcYK2WZEXfRwPRPDzW4MvdPmF+CB2CUOD+8Z8xjkK4b7NDhAmswlOJZRxlP55anhR2A77k1n//bV3llWNDz0FWY=
5c75126b-863a-4f0a-9389-62f63a82a08f	5ecdf936-1ab2-4352-adca-8b379e026960	keyUse	ENC
cd0d564d-adb0-4c35-acd5-9fab771f8529	6e2c90dc-b956-483c-b15a-291ca814baaf	host-sending-registration-request-must-match	true
d95d8fc7-fff8-40c7-b44f-f2d2f731eae4	6e2c90dc-b956-483c-b15a-291ca814baaf	client-uris-must-match	true
098f5ce8-0f80-4673-914f-80be82e2fbba	0f6f642b-f5ef-4228-9cea-9a63a0fc1358	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
86b44537-bb74-4a7c-b875-024efdec3a0d	0f6f642b-f5ef-4228-9cea-9a63a0fc1358	allowed-protocol-mapper-types	saml-user-property-mapper
5f8697ab-8ef5-4bea-a0b7-79568d7989f8	0f6f642b-f5ef-4228-9cea-9a63a0fc1358	allowed-protocol-mapper-types	oidc-address-mapper
e6f5368b-b55d-4611-9709-a78b1a4dd8bb	0f6f642b-f5ef-4228-9cea-9a63a0fc1358	allowed-protocol-mapper-types	saml-user-attribute-mapper
ca5bc422-8d07-450a-bae0-f141e1888306	0f6f642b-f5ef-4228-9cea-9a63a0fc1358	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ffb1a875-4044-45e0-a26c-172fab91104a	0f6f642b-f5ef-4228-9cea-9a63a0fc1358	allowed-protocol-mapper-types	oidc-full-name-mapper
f6406c7a-4ddf-4655-ab79-834115bf0841	0f6f642b-f5ef-4228-9cea-9a63a0fc1358	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c9a933b6-831f-4295-acd0-daf7fa9727fe	0f6f642b-f5ef-4228-9cea-9a63a0fc1358	allowed-protocol-mapper-types	saml-role-list-mapper
9c7edb60-9d89-47c4-a90a-143bba28328c	cfcd8560-ca01-405e-b5a3-b7db6f66839a	max-clients	200
a27fe975-181f-4daf-b40a-33ca8abee22c	4caa60b1-e002-48e4-a902-8cd17368e517	allow-default-scopes	true
e0187d5d-033f-41c5-9f9b-71d0a03b94d8	1f3fc3b5-406a-41bb-8602-1046413eb860	allowed-protocol-mapper-types	saml-user-property-mapper
411b3d73-285d-40cf-922e-4c5d30c6a4d2	1f3fc3b5-406a-41bb-8602-1046413eb860	allowed-protocol-mapper-types	saml-role-list-mapper
c785e26f-66d7-40cd-8856-93c006697465	1f3fc3b5-406a-41bb-8602-1046413eb860	allowed-protocol-mapper-types	saml-user-attribute-mapper
c73c8348-4077-424b-abe9-0e42a1dfebc5	1f3fc3b5-406a-41bb-8602-1046413eb860	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0bda3afc-416b-4035-82fe-4573e95d6760	1f3fc3b5-406a-41bb-8602-1046413eb860	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
656e2df3-d99b-4e3b-abb8-49cfd800a2c9	1f3fc3b5-406a-41bb-8602-1046413eb860	allowed-protocol-mapper-types	oidc-address-mapper
3123c76d-f13d-4ea4-8cf5-73078f2df38c	1f3fc3b5-406a-41bb-8602-1046413eb860	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a272ae91-938a-4763-ae8c-8063ac6dc432	1f3fc3b5-406a-41bb-8602-1046413eb860	allowed-protocol-mapper-types	oidc-full-name-mapper
59f11f17-ebf1-4d26-9ef8-d5a86f0af41b	f73c72e0-5a84-42b1-9553-831865fa88ae	priority	100
6be92c6e-fe7e-47da-9bd8-4d7fdfbc6996	f73c72e0-5a84-42b1-9553-831865fa88ae	certificate	MIICnzCCAYcCBgGcRBQ/tTANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhuZXdSZWFsbTAeFw0yNjAyMDkyMDIzMjNaFw0zNjAyMDkyMDI1MDNaMBMxETAPBgNVBAMMCG5ld1JlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAx4UEg4cqxnAM8WDll58WZEshROaNW2WafVqHk1XE7a2d4/l70fhCrgncjzMfIj4DnHBTO1EBvNPXwjYIE1yk+VtZ+Aukd6ji78K7Se/1aRtG7mnSOaTjhPAw2qSM7xLP/tK54Zc07MeX3m17yhohYzacQQDxOl5GANGuH8zXaIZr2w3qRPDjrhPT7LB0SzRQQJ9MlufhA053pisEnAKe/D1LRDBp2mlczSO5d1DH/goLmxyw7azAcdCm0ZGz+sxeaYKj0JExpCT2EFt746PPlDntXXGD46M/rpeTcrIz+4QquuHa4/elZH5Ib3iZg+n/l9VlO8bupDQN8UBiK/ZmzQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCvIWU72895umXDFb1br4zyHRZiss1u31/F/vJ891j3t97jdXPTI6YZpE3DoT4wP75+IeIjDfI+624AzU72PyM7pSPf/OnUGq8Q04RMUeZeRMETRDlz3//0j5+JOKv92q8by9K79ViOBATT6eFHomBUmcpE/Tev5jod542GISpJcu4kozPnWU5N7lrKJ/tbQrjBdfz+hpm+Oyo9+064qXYM8tkrTOeRSZa2kiftx8HCf7o9Cf1MxKD96Yk1PxSvah6kISRDzcIzjvtM/VUMM2W8h8K9N5EI+nzwhks1CUzz6r2yQjlnJxSLBiot5xEIQun9fLv1/jAPOFak6V5JH4yF
523b3595-be09-48dd-b2e9-4760bafad890	f73c72e0-5a84-42b1-9553-831865fa88ae	privateKey	MIIEogIBAAKCAQEAx4UEg4cqxnAM8WDll58WZEshROaNW2WafVqHk1XE7a2d4/l70fhCrgncjzMfIj4DnHBTO1EBvNPXwjYIE1yk+VtZ+Aukd6ji78K7Se/1aRtG7mnSOaTjhPAw2qSM7xLP/tK54Zc07MeX3m17yhohYzacQQDxOl5GANGuH8zXaIZr2w3qRPDjrhPT7LB0SzRQQJ9MlufhA053pisEnAKe/D1LRDBp2mlczSO5d1DH/goLmxyw7azAcdCm0ZGz+sxeaYKj0JExpCT2EFt746PPlDntXXGD46M/rpeTcrIz+4QquuHa4/elZH5Ib3iZg+n/l9VlO8bupDQN8UBiK/ZmzQIDAQABAoIBABO4UH1lhzNM0OKsppSpWy+3g0bJmNAfRzk7kOndkNTDE7d8KaJTrNeBzwRyU5HxWi8EpR1YQNk2gP1HlN3BCudAgbB0CiHvldqHvzYsGu/0C7s1x1r+MqSpjtKVb/6TN+6iSlADP25lvdt0q8cKdSFWvPPp0W3o8ndTQigPeXzxm5tO+QLFhXPiDvNFctGQpTeG9nro5OJUzWRb7qKizwkXducr9htZQcvUoeMeH8xW+Bvq5S6gmVFLhBgG74fwaByvW8b16E373TxhYPOdkq8NoKPaY2Avsho2O5VjHOFmLyXQZKBd5/8spFZsMC+p/V1Qdg36H/Hk+6Rt8Yi/g7ECgYEA40PFch9Hv2F+JlAb707FY+x12+qRmNfD01YMQLGru2nufn69Rj20hIS5yrqSzeEq/iyHLh5Bunr9AXjiNya0Peba4XqC5fni7Rrtr15BvsBYzyMlf+/pD9FCss3OvdI+Ym7HN6JzKEdbrkzyLFxZ56iIFMLLZmWfJSdSNeQshmUCgYEA4L8tRBZ2pPH2LSJdObeMg3i7Wlk/i6Tdbi6X2/EUfHbNCBFbI3s3p7AU0Ih0blOyWxOGyQn1O1ye6LBxD6zfJ6Pu+myYc7ReZxbM2sTLUbeCrIuNRqlJLw7bwKCDfjQPM5QIC5ULdbNKk9kxLKRECIyGbZATYu97ft/1zVKYhEkCgYAUev0GJc9/bbfCmCGMVVrwgFS2ttLcJUWee/iqs9g4EXnOqHlCJTlpX9Smcl3cc9g+A6FDBLMDrSWzxkMMmU5Q7cb33uSA+R38JBsbXLEsEYVvVUmB2Ar2w/Lwzh89d/7rO/R0DQ23qYaXlJOWb9QiTkvFIzDVT38iCAMenCtvCQKBgA04UaJSq/Hx5agsAE3X1SUaofKjk1BUh03m4bnnSWw01MSnuLOymMh9XAwUKr0eoTwoPuJueoVeYl6PmmbwpUPAqdsDLkiIEJGBztUDhG4vHDmoD8xbQtnIxvZiurleuJIxH/QGdWEcBcQCn5jfpLzX/0RMmEdWjO4eoGfOdvg5AoGASsc6pZPXNb3B3k5DFAxvm3Hk9ophnChLlfVhpy7Xt3o60pxt1+snhYuaOLIV+5rHGq75THevGPf8NuiY9di1cr5tXNwDh6BzRntysX8nowg2K4XT4kT212Kq/VuxT9dLOgfSSmx8F1wemfgF0bESwpLCJZWhXf6vuWmiYk5nn1A=
ef0990bf-4c07-4664-b1ac-795ac187d3f0	bc31a70e-761d-4a00-abbd-24d07b778c8e	algorithm	RSA-OAEP
0ce5ae94-ae47-4a3f-9430-11c6b2c7fadf	bc31a70e-761d-4a00-abbd-24d07b778c8e	certificate	MIICnzCCAYcCBgGcRBRA1DANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhuZXdSZWFsbTAeFw0yNjAyMDkyMDIzMjNaFw0zNjAyMDkyMDI1MDNaMBMxETAPBgNVBAMMCG5ld1JlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7ZdSi0KRw/EQTelDCeZnnwNMto0O1RFP9x7wQJ1jD2eiKX7gWSr4YZXdM2i/XQRCS6kclgp4Mt+teaRsNw/VviF6Ys4inP08wZ2aFpLSAG+oTNDC3TOqNvbw89MNLkNmRObsKBe9n+/gxmLc05U1qgNvUQF+YDhgE6f41Q5Ub6r62ugpzf3vK8/+hN6neO90cTUWj+EJs0Yem3GrQz7dI7tRtQfAioDAaFt3crzx6ZW59Yq6tdjWYl0K8RAI4MNHCjl+w2upHg/prD1EHo+6L+KU5ULclY7VCVVCc3QNkPp+Cv6fpkEOYIpAni2CUynl2r4u9bhdi+PK0obdVDKGNwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQDM9+ID092eHZREOOZs6PdWvTo2k2LchcenDwBr/txVe992hHbYBhgLtymzt0pX4hvz8qYK2hMcQilaW27F2FQLhsgMx+Pn08PP5mdIwVwqJdO0f8hv0c0OG7ZAZBCCDDGD2uUIJZmlm2Asob51XcWDErQu5cDcwbgJuhqMFkBMo4Fckg0f98ijyptNMlyMR/USpp3KK7rms/cPC39aqYPBK61q+dgQRTRd7UfVtZlUKKqzYCD+SOAqpU6jomCIyV6+l3f+ikTRXOJNPPGZ8+00Gal/sHR/mpYYNSdiCjrPpfNil1KwLGXW3aP7MLAeiPAYG6bpQLJHhisgtYqjnXHb
52412086-f923-4c6a-a657-cb74ea2fcedb	bc31a70e-761d-4a00-abbd-24d07b778c8e	priority	100
6e53e0c7-d833-4b9f-a3c6-e8848ccda0fc	bc31a70e-761d-4a00-abbd-24d07b778c8e	privateKey	MIIEowIBAAKCAQEA7ZdSi0KRw/EQTelDCeZnnwNMto0O1RFP9x7wQJ1jD2eiKX7gWSr4YZXdM2i/XQRCS6kclgp4Mt+teaRsNw/VviF6Ys4inP08wZ2aFpLSAG+oTNDC3TOqNvbw89MNLkNmRObsKBe9n+/gxmLc05U1qgNvUQF+YDhgE6f41Q5Ub6r62ugpzf3vK8/+hN6neO90cTUWj+EJs0Yem3GrQz7dI7tRtQfAioDAaFt3crzx6ZW59Yq6tdjWYl0K8RAI4MNHCjl+w2upHg/prD1EHo+6L+KU5ULclY7VCVVCc3QNkPp+Cv6fpkEOYIpAni2CUynl2r4u9bhdi+PK0obdVDKGNwIDAQABAoIBAB5xNaaEnI2zx7Lb5kw7RTVReb+oL5QrAt53NzG9mMbisJtK15nFO4xcDzrPkI7CsBs8ALQphOuBJRvsGTYtkBBWVMqafpfei1gu2+Ke5EvMWA747rGOCvYTn52g11RWrCC8SoT76b7iQErbDvqzPcGEwtC+dWqvE9cLk4KlB+TuDxZcViSI4yz3CYAX5r0DzYU9LGrAs8/wgOht6ilCHLBc/qb2gNmGxyDZbnxBttXbqjtVpgiNCmDjR1zNilJnY7/FEOCByCqzMeFL2+fGARbL9Fx2GxxZD6/kJITPZtI+iMUpFjHWjTaO0yfKKeUUaN33bQjvZSHWeEFerKhLrYUCgYEA+GnVnNcyl/ridw4IGXPtyCtEO9joVXJAiY6GMDZruEGow2fy3zuFmhg9sb0XgZDeIx75Na5p3IKURgPzVnhrLtxL/ddM2umIhIqltbJVgVbIKgsfhDYUadenTtYrwzFBWf8PHIsEPo1D8jsv/Jc+kCrGiNR7TMw5gyuzY0MKF2sCgYEA9NjgSyhnsGtb3afZHZ0H+jxrBi43OEBCmwXVAmZR1QzIlHiHu8N1/XzZKZZxPPWbCTAXLSaZPNCBeA/viZ0CFRXS2+l+YBLHjSe3tAixHQPQO+FNqxwNV5ZurLL/CvKLnnWI8d8CU7jAEAseWxTF4jqMyeo/hxcPyruvoQT9G2UCgYAuOWthYv3sH+gyJS9GpTbS75Ij3Mnm1HrD3fyETiwfPkCME/Syq13B/c7FGx2bo3xiZqoS3iCewsGagbOvHHs9XgrZ8k0/0wLvPul09PlKNv7KLAWyUWndBB8C4YGFMc4qU/bY5dllVl4VXgQg6Xff1cXZwkgrUzlEekZIKzpefwKBgCooPVYzesbxdTvQ7p0esITxaiwCQRe6WL2AX5CuNWDNdqu5pQU7PlGK8YkrkgvA7hTC5vqrLq8950zY0ZGMKxOeUlPy/ANmuF0hfYvOA1DPm0b0H/9aMSHnkN7DYw5rfIaoDhA3KZtosAkTIQLlrLyrABqz7oRAAEQT1MWQqlPRAoGBANe6AKXkGpLHuIecQJBkWMOl1cnZRjFrJgb7GcZQmsY9/fc3hAioV7tRYLOvymM5Fx2kPObgOaK28kUAbIgSoEVICexcYCFULpnSKgmzNdzP6j5FoE4uV3twrSTo1XZiQopVCq33uWxJYGTLxl+IE3m03Tb6DAYWtPDiTQgg5e24
58e47b43-79d3-40cb-b9e5-8ed793dc41e0	0faada75-9a44-4ca5-a172-d813a12eadea	kid	bb42e748-2c9e-4d1c-ae3b-f17bb242955f
fef2787f-f7f7-408a-91c2-d90225a2fa83	0faada75-9a44-4ca5-a172-d813a12eadea	priority	100
8fccce41-7e43-4b42-ab9e-66b57a855a83	0faada75-9a44-4ca5-a172-d813a12eadea	secret	Laf2XyoY7IPd7Afy5vVbqReB7UtJpJ_OnCJjJs6NEPKao6ioexxamnVJjV2Gx1Ldf1BRXRV8ihS2xL6DRYzGF8HwuAAKgdNfbTTUkg1wjjNkvGvi7Piy1SgcPvuL_W0Qyq6OekeKo60nL9zSWmtS2ZTgdzL0IR8Nvljg4SAvIGo
8a53aaaf-27a1-43ab-8ba9-a841b65a9412	0faada75-9a44-4ca5-a172-d813a12eadea	algorithm	HS512
474f3fbe-6bfb-4cc0-8109-a050deb501e5	99948f8b-dbcf-48d6-a38f-060798726bf0	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
1418af15-a286-46d3-b3cd-146047a9d515	b7b2966a-e8ad-4b1c-b5a6-fb29bd497004	secret	-2Pgx2tgMz3rb5Ewg_elrw
ce7b2f01-12b3-4c48-8efa-5c2aef8c998b	b7b2966a-e8ad-4b1c-b5a6-fb29bd497004	priority	100
5230e290-165e-4492-9e76-93f3cc54df6a	b7b2966a-e8ad-4b1c-b5a6-fb29bd497004	kid	7e42136f-2c8b-4347-acb3-bbab0fc4526e
b6635491-2674-44a7-acc7-e579304e3055	4a61c7d8-55fe-41a0-b867-13f4651f6070	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	7f057d7b-cc45-4326-9f1a-5b8f2f905e68
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	f5b47955-df1c-4440-b45b-2dc30d60d92c
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	24caa214-2e69-4eab-ad78-31de153a9f85
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	3a059f46-1960-4c01-8bb2-ffbab94f3401
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	66aa0131-7b1d-45a2-8e84-60ccdab2fa85
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	56e93a73-ff86-4a72-b9c1-0e0df26ca59c
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	d2605681-1636-4a46-9d1d-4a2bb306cf0e
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	d29e79e0-5353-4249-91f6-792ab7bc3a92
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	1376005b-a44f-4d95-aba5-3990c73f5985
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	07b8afd0-8da3-4af5-9f69-e12cea88ecef
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	0139b5c3-cc13-45eb-b8c7-a1c29128b80e
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	c748ad31-c5ab-490e-adc8-ef406c403399
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	a258b531-36c1-4144-99b5-e5b5f33e8027
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	7747c023-6fbc-49c7-a744-a1bf00023434
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	503ae383-7726-42f9-b93a-13efac91931f
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	72fe13ee-1ce1-4d1e-a89b-0e32d1f7cb94
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	46539539-5a24-4923-b61e-243e6847a1c2
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	03b98ddb-f190-4696-8b7d-a0f55bf269ed
66aa0131-7b1d-45a2-8e84-60ccdab2fa85	72fe13ee-1ce1-4d1e-a89b-0e32d1f7cb94
3a059f46-1960-4c01-8bb2-ffbab94f3401	503ae383-7726-42f9-b93a-13efac91931f
3a059f46-1960-4c01-8bb2-ffbab94f3401	03b98ddb-f190-4696-8b7d-a0f55bf269ed
65dd23fc-3d23-4fdf-b26f-e4cbca5f4f8d	bf96e807-f370-44c2-9057-07d0f26cc365
65dd23fc-3d23-4fdf-b26f-e4cbca5f4f8d	bea8bfda-4241-42a9-b584-9fb26aa479a2
bea8bfda-4241-42a9-b584-9fb26aa479a2	a51eb964-8d71-402d-bb5d-a533222076d1
2c831fe3-3ba6-4918-9e97-697ca4a3d70d	bb582754-3ac2-4038-ac6a-ce6f50a8644c
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	3127585a-1470-4ccc-9461-ec1cd9ae4218
65dd23fc-3d23-4fdf-b26f-e4cbca5f4f8d	65106016-c03f-4baa-9742-b43f56e46672
65dd23fc-3d23-4fdf-b26f-e4cbca5f4f8d	d635a59c-ea60-448f-8501-31d31c672ee2
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	fd739284-eef0-4c47-ad6d-c4ee5dcd5a13
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	fdc3d315-6c7c-43d4-950e-5232bead21bb
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	647afc76-e642-447b-a301-217cea23bfde
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	c1782e4f-7632-4734-8e74-75240220846d
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	df573741-bfc6-461c-89f5-109ed54f3f14
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	b71ed37b-6254-45fc-94dc-1e3618647327
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	4b42c32e-5c79-4a40-85d9-529b75f85d44
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	80f2a093-ea57-4022-9612-f32ff1818232
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	b794174c-f47c-4d5d-b524-be2402849f9e
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	daba6d7a-8cc1-4184-b853-07232cbc4419
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	f43835a4-22e9-4149-997d-2db1bd69601a
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	aec3b20d-4511-430b-bb0b-9dc6f478e090
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	9baffcc6-df76-49d2-8603-9f7dd5ff3502
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	1ca45108-f9bd-4810-bc00-0b2dba1ab101
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	b164c1ec-812a-421a-aa6e-741d614ae4c9
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	41a562b6-7bc2-49e7-b4a6-178d33123185
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	d1e3ab4b-578a-403c-bed3-da183cf8ee2c
c1782e4f-7632-4734-8e74-75240220846d	b164c1ec-812a-421a-aa6e-741d614ae4c9
647afc76-e642-447b-a301-217cea23bfde	1ca45108-f9bd-4810-bc00-0b2dba1ab101
647afc76-e642-447b-a301-217cea23bfde	d1e3ab4b-578a-403c-bed3-da183cf8ee2c
f589643c-6ab1-462d-8e73-2441b25642a4	5950f615-d936-42ed-8dd8-0d8b4ca47bc7
f589643c-6ab1-462d-8e73-2441b25642a4	d42cc3d5-5743-47e4-a17f-de4fba113e9d
f589643c-6ab1-462d-8e73-2441b25642a4	8338138b-8326-44c7-8a4c-dd14c7c89610
f589643c-6ab1-462d-8e73-2441b25642a4	ff7d85fc-e431-4391-80ee-f8d6b5222c5f
721d9daa-122f-4d85-af47-b85e30f4f22b	370f976f-5a54-4095-be0e-145a500688a5
c7129392-e0b9-4cf0-b205-8599e80fa87a	14ca54de-6bd6-4f8d-ad02-f076c43ea955
c7129392-e0b9-4cf0-b205-8599e80fa87a	da7082a3-074b-4007-bd31-88a5133ff169
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	14ca54de-6bd6-4f8d-ad02-f076c43ea955
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	fb0942b0-b4eb-4a64-a5ba-59da5a111faf
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	f4ef5e03-1e49-44a3-a52e-50bc48ff0fda
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	5606b062-1de5-42a3-b280-90fab20c362b
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	b18f8bc0-e0b0-437b-9452-f55c6b6465a2
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	926e1396-122f-42ae-9d5a-945837fd4928
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	356f4bbd-c4dc-480d-bfc8-20065eecd855
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	721d9daa-122f-4d85-af47-b85e30f4f22b
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	370f976f-5a54-4095-be0e-145a500688a5
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	10d74e36-91b9-4774-bd0f-b05a78cfc082
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	5ce75942-22cb-441e-831a-22ef052b60a6
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	7ebeebb7-bc26-4238-abbc-478bef2f4b46
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	c7129392-e0b9-4cf0-b205-8599e80fa87a
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	da7082a3-074b-4007-bd31-88a5133ff169
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	f5d5bcb6-8659-4909-90a7-e9d213cfe5ab
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	879445bc-0524-43d6-886f-657e65d47596
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	805d0d1d-aad3-4ef7-81b0-35b9abe9049e
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	331a3b72-77d4-460c-9644-1c7fa076da44
3e318029-cffe-410a-af80-8e7d1fcdc8c6	310d73fe-5066-4bdd-832b-321cc51602c3
ff7d85fc-e431-4391-80ee-f8d6b5222c5f	0d3e3f91-0192-4b9f-945a-3c3d64f49abc
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	0b7004f7-a162-4a3d-b335-f3942772eeca
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
3921ab08-c8de-4317-b14f-841934ad95c9	\N	password	b01035c9-ecd4-49d8-93d8-909688cd54c3	1773056854414	\N	{"value":"sNwRKeFn7qrMrN5hjEigXu0khkq/PFMcsRJN3vIr+OQ=","salt":"IDHBlv8z2xVy2cdCCBteFQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
43d11223-76cd-4fbe-8bdd-4aecc88894c2	\N	password	ac2e20ce-a2ca-4bf6-9eb5-f98c24278fa6	1773750943053	\N	{"value":"3e6pBH074IXaOqnJXfkZdCqRbSziHu8rhWDTF3mpNdY=","salt":"ERKzHt51TO/AgTsJkdJbvA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
ec0a9146-76bd-4f64-a350-e6d7872229e5	\N	password	984e1170-40bc-4dd5-acb8-e9f36d633228	1770672151984	My password	{"value":"sXWUIo74StPr3N/bAkgMRN4p1Ya3YFFPrycT/3I3GP4=","salt":"/oWwXnd0xZlWoFECG3s9gA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
7af877d9-51fe-4894-8ac2-388f12eacd81	\N	password	5d35a7b4-8143-4260-b0e5-81d04b4edb62	1777416762986	\N	{"value":"yN0XUPrburJUKxcC5LByxXh9nLi/HfrkiJZDdoB0okI=","salt":"e57E1yMaHMZCIp3JHDdw5w==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-04-28 22:52:26.534566	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.33.0	\N	\N	7416739735
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-04-28 22:52:26.552286	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.33.0	\N	\N	7416739735
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-04-28 22:52:26.624403	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.33.0	\N	\N	7416739735
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-04-28 22:52:26.638688	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	7416739735
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-04-28 22:52:26.943906	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.33.0	\N	\N	7416739735
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-04-28 22:52:26.956776	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.33.0	\N	\N	7416739735
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-04-28 22:52:27.198017	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.33.0	\N	\N	7416739735
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-04-28 22:52:27.211147	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.33.0	\N	\N	7416739735
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-04-28 22:52:27.234001	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.33.0	\N	\N	7416739735
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-04-28 22:52:27.514586	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.33.0	\N	\N	7416739735
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-04-28 22:52:27.67376	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	7416739735
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-04-28 22:52:27.677981	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	7416739735
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-04-28 22:52:27.71225	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.33.0	\N	\N	7416739735
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-04-28 22:52:27.760505	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.33.0	\N	\N	7416739735
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-04-28 22:52:27.773415	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-04-28 22:52:27.786332	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.33.0	\N	\N	7416739735
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-04-28 22:52:27.799007	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.33.0	\N	\N	7416739735
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-04-28 22:52:27.955256	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.33.0	\N	\N	7416739735
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-04-28 22:52:28.09856	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.33.0	\N	\N	7416739735
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-04-28 22:52:28.120041	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.33.0	\N	\N	7416739735
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-04-28 22:52:34.461259	119	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.33.0	\N	\N	7416739735
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-04-28 22:52:28.132459	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.33.0	\N	\N	7416739735
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-04-28 22:52:28.142729	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.33.0	\N	\N	7416739735
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-04-28 22:52:28.22082	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.33.0	\N	\N	7416739735
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-04-28 22:52:28.242346	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.33.0	\N	\N	7416739735
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-04-28 22:52:28.253358	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.33.0	\N	\N	7416739735
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-04-28 22:52:28.670782	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.33.0	\N	\N	7416739735
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-04-28 22:52:28.873327	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.33.0	\N	\N	7416739735
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-04-28 22:52:28.88613	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.33.0	\N	\N	7416739735
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-04-28 22:52:29.073707	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.33.0	\N	\N	7416739735
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-04-28 22:52:29.122101	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.33.0	\N	\N	7416739735
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-04-28 22:52:29.203614	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.33.0	\N	\N	7416739735
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-04-28 22:52:29.21963	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.33.0	\N	\N	7416739735
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-04-28 22:52:29.23769	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-04-28 22:52:29.257761	34	MARK_RAN	9:f9753208029f582525ed12011a19d054	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.33.0	\N	\N	7416739735
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-04-28 22:52:29.339679	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.33.0	\N	\N	7416739735
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-04-28 22:52:29.361844	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.33.0	\N	\N	7416739735
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-04-28 22:52:29.389132	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	7416739735
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-04-28 22:52:29.411055	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.33.0	\N	\N	7416739735
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-04-28 22:52:29.433051	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	7416739735
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-04-28 22:52:29.444146	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.33.0	\N	\N	7416739735
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-04-28 22:52:29.455976	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.33.0	\N	\N	7416739735
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-04-28 22:52:29.468706	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.33.0	\N	\N	7416739735
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-04-28 22:52:31.050726	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.33.0	\N	\N	7416739735
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-04-28 22:52:31.072483	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.33.0	\N	\N	7416739735
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-28 22:52:31.094988	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.33.0	\N	\N	7416739735
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-28 22:52:31.110344	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.33.0	\N	\N	7416739735
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-28 22:52:31.117234	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.33.0	\N	\N	7416739735
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-28 22:52:31.263812	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.33.0	\N	\N	7416739735
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-28 22:52:31.284873	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.33.0	\N	\N	7416739735
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-04-28 22:52:31.463294	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.33.0	\N	\N	7416739735
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-04-28 22:52:31.798815	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.33.0	\N	\N	7416739735
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-04-28 22:52:31.82136	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-04-28 22:52:31.834874	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.33.0	\N	\N	7416739735
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-04-28 22:52:31.8478	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.33.0	\N	\N	7416739735
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-04-28 22:52:31.874906	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.33.0	\N	\N	7416739735
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-04-28 22:52:31.905353	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.33.0	\N	\N	7416739735
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-04-28 22:52:31.989491	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.33.0	\N	\N	7416739735
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-04-28 22:52:32.487691	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.33.0	\N	\N	7416739735
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-04-28 22:52:32.5684	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.33.0	\N	\N	7416739735
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-04-28 22:52:32.590583	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.33.0	\N	\N	7416739735
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-04-28 22:52:32.623517	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.33.0	\N	\N	7416739735
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-04-28 22:52:32.659531	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.33.0	\N	\N	7416739735
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-04-28 22:52:32.68435	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.33.0	\N	\N	7416739735
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-04-28 22:52:32.688705	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.33.0	\N	\N	7416739735
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-04-28 22:52:32.699721	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.33.0	\N	\N	7416739735
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-04-28 22:52:32.808861	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.33.0	\N	\N	7416739735
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-04-28 22:52:32.867012	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.33.0	\N	\N	7416739735
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-04-28 22:52:32.890312	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.33.0	\N	\N	7416739735
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-04-28 22:52:32.971246	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.33.0	\N	\N	7416739735
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-04-28 22:52:32.995135	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.33.0	\N	\N	7416739735
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-04-28 22:52:33.027391	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.33.0	\N	\N	7416739735
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-28 22:52:33.061294	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	7416739735
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-28 22:52:33.084118	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	7416739735
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-28 22:52:33.089764	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.33.0	\N	\N	7416739735
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-28 22:52:33.164429	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.33.0	\N	\N	7416739735
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-28 22:52:33.214363	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	7416739735
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-04-28 22:52:33.235559	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.33.0	\N	\N	7416739735
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-04-28 22:52:33.246277	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.33.0	\N	\N	7416739735
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-04-28 22:52:33.280305	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.33.0	\N	\N	7416739735
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-04-28 22:52:33.282692	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.33.0	\N	\N	7416739735
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-28 22:52:33.333994	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.33.0	\N	\N	7416739735
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-28 22:52:33.341145	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	7416739735
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-28 22:52:33.368666	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	7416739735
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-28 22:52:33.378008	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	7416739735
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-28 22:52:33.468966	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	7416739735
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-04-28 22:52:33.490737	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.33.0	\N	\N	7416739735
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-04-28 22:52:33.51209	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.33.0	\N	\N	7416739735
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-04-28 22:52:33.538752	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.33.0	\N	\N	7416739735
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-28 22:52:33.559406	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.33.0	\N	\N	7416739735
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-28 22:52:33.580324	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.33.0	\N	\N	7416739735
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-28 22:52:33.633534	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-28 22:52:33.654896	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.33.0	\N	\N	7416739735
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-28 22:52:33.664836	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.33.0	\N	\N	7416739735
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-28 22:52:33.697134	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.33.0	\N	\N	7416739735
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-28 22:52:33.708152	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.33.0	\N	\N	7416739735
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-28 22:52:33.72829	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.33.0	\N	\N	7416739735
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-28 22:52:33.837949	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-28 22:52:33.848405	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-28 22:52:33.865443	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-28 22:52:33.895315	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-28 22:52:33.906112	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-28 22:52:33.949514	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.33.0	\N	\N	7416739735
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-28 22:52:33.963944	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.33.0	\N	\N	7416739735
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-04-28 22:52:33.981981	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.33.0	\N	\N	7416739735
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-04-28 22:52:34.030169	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.33.0	\N	\N	7416739735
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-04-28 22:52:34.074541	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.33.0	\N	\N	7416739735
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2026-04-28 22:52:34.122641	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.33.0	\N	\N	7416739735
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-04-28 22:52:34.13483	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.33.0	\N	\N	7416739735
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-28 22:52:34.178721	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	7416739735
20.0.0-12964-supported-dbs-edb-migration	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-28 22:52:34.232909	110	EXECUTED	9:a6b18a8e38062df5793edbe064f4aecd	dropIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE; createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	7416739735
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-28 22:52:34.235938	111	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.33.0	\N	\N	7416739735
client-attributes-string-accomodation-fixed-pre-drop-index	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-28 22:52:34.250255	112	EXECUTED	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-28 22:52:34.263581	113	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
client-attributes-string-accomodation-fixed-post-create-index	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-28 22:52:34.274072	114	MARK_RAN	9:bd2bd0fc7768cf0845ac96a8786fa735	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-04-28 22:52:34.287298	115	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.33.0	\N	\N	7416739735
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-04-28 22:52:34.421641	116	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.33.0	\N	\N	7416739735
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-04-28 22:52:34.433139	117	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.33.0	\N	\N	7416739735
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-04-28 22:52:34.444892	118	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.33.0	\N	\N	7416739735
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-04-28 22:52:34.491487	120	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.33.0	\N	\N	7416739735
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-04-28 22:52:34.512588	121	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	7416739735
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-28 22:52:34.685801	122	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.33.0	\N	\N	7416739735
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-28 22:52:34.6982	123	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.33.0	\N	\N	7416739735
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-28 22:52:34.710284	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-28 22:52:34.774841	125	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
24.0.0-26618-edb-migration	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-28 22:52:34.843891	126	EXECUTED	9:2f684b29d414cd47efe3a3599f390741	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES; createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-04-28 22:52:34.857922	127	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.33.0	\N	\N	7416739735
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-04-28 22:52:34.874173	128	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-04-28 22:52:34.884696	129	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.33.0	\N	\N	7416739735
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:34.905032	130	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	7416739735
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:34.958854	131	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:34.988912	132	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.01873	133	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.040237	134	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.051524	135	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	7416739735
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.053887	136	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.10581	137	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.185212	138	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.33.0	\N	\N	7416739735
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.219229	139	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	7416739735
unique-consentuser-edb-migration	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.236062	140	MARK_RAN	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	7416739735
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.248807	141	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.33.0	\N	\N	7416739735
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-04-28 22:52:35.331713	142	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.33.0	\N	\N	7416739735
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.362212	143	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.33.0	\N	\N	7416739735
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.371717	144	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.33.0	\N	\N	7416739735
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.402031	145	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.33.0	\N	\N	7416739735
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.408833	146	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.33.0	\N	\N	7416739735
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.42164	147	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.33.0	\N	\N	7416739735
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.452035	148	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.33.0	\N	\N	7416739735
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.503568	149	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.33.0	\N	\N	7416739735
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.513023	150	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	7416739735
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.523111	151	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.33.0	\N	\N	7416739735
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-04-28 22:52:35.528412	152	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.33.0	\N	\N	7416739735
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-04-28 22:52:35.54616	153	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.33.0	\N	\N	7416739735
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-04-28 22:52:35.553338	154	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.33.0	\N	\N	7416739735
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-04-28 22:52:35.564268	155	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.33.0	\N	\N	7416739735
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2026-04-28 22:52:35.609401	156	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.33.0	\N	\N	7416739735
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2026-04-28 22:52:35.620144	157	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.33.0	\N	\N	7416739735
26.2.6-39866-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-04-28 22:52:35.630417	158	EXECUTED	9:1dc67ccee24f30331db2cba4f372e40e	customChange		\N	4.33.0	\N	\N	7416739735
26.2.6-39866-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-04-28 22:52:35.646708	159	EXECUTED	9:b70b76f47210cf0a5f4ef0e219eac7cd	addUniqueConstraint constraintName=UK_MIGRATION_VERSION, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	7416739735
26.2.6-40088-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-04-28 22:52:35.655283	160	EXECUTED	9:cc7e02ed69ab31979afb1982f9670e8f	customChange		\N	4.33.0	\N	\N	7416739735
26.2.6-40088-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2026-04-28 22:52:35.668724	161	EXECUTED	9:5bb848128da7bc4595cc507383325241	addUniqueConstraint constraintName=UK_MIGRATION_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.33.0	\N	\N	7416739735
26.3.0-groups-description	keycloak	META-INF/jpa-changelog-26.3.0.xml	2026-04-28 22:52:35.682272	162	EXECUTED	9:e1a3c05574326fb5b246b73b9a4c4d49	addColumn tableName=KEYCLOAK_GROUP		\N	4.33.0	\N	\N	7416739735
26.4.0-40933-saml-encryption-attributes	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-04-28 22:52:35.690482	163	EXECUTED	9:7e9eaba362ca105efdda202303a4fe49	customChange		\N	4.33.0	\N	\N	7416739735
26.4.0-51321	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-04-28 22:52:35.725149	164	EXECUTED	9:34bab2bc56f75ffd7e347c580874e306	createIndex indexName=IDX_EVENT_ENTITY_USER_ID_TYPE, tableName=EVENT_ENTITY		\N	4.33.0	\N	\N	7416739735
40343-workflow-state-table	keycloak	META-INF/jpa-changelog-26.4.0.xml	2026-04-28 22:52:36.063987	165	EXECUTED	9:ed3ab4723ceed210e5b5e60ac4562106	createTable tableName=WORKFLOW_STATE; addPrimaryKey constraintName=PK_WORKFLOW_STATE, tableName=WORKFLOW_STATE; addUniqueConstraint constraintName=UQ_WORKFLOW_RESOURCE, tableName=WORKFLOW_STATE; createIndex indexName=IDX_WORKFLOW_STATE_STEP, table...		\N	4.33.0	\N	\N	7416739735
26.5.0-index-offline-css-by-client	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.099983	166	EXECUTED	9:383e981ce95d16e32af757b7998820f7	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	7416739735
26.5.0-index-offline-css-by-client-storage-provider	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.151013	167	EXECUTED	9:f5bc200e6fa7d7e483854dee535ca425	createIndex indexName=IDX_OFFLINE_CSS_BY_CLIENT_STORAGE_PROVIDER, tableName=OFFLINE_CLIENT_SESSION		\N	4.33.0	\N	\N	7416739735
26.5.0-idp-config-allow-null-fixed-drop-mssql-index	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.155005	168	MARK_RAN	9:50c51d2c98cd1d624eb1c485c3cf1f75	dropIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	7416739735
26.5.0-idp-config-allow-null	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.164395	169	EXECUTED	9:b667fb087874303b324c1af7fae4f606	dropDefaultValue columnName=TRUST_EMAIL, tableName=IDENTITY_PROVIDER; dropNotNullConstraint columnName=TRUST_EMAIL, tableName=IDENTITY_PROVIDER; dropNotNullConstraint columnName=STORE_TOKEN, tableName=IDENTITY_PROVIDER; dropDefaultValue columnName...		\N	4.33.0	\N	\N	7416739735
26.5.0-idp-config-allow-null-fixed-create-mssql-index	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.168854	170	MARK_RAN	9:dcbbb24c151c3b0b59f12fede23cc94d	createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER		\N	4.33.0	\N	\N	7416739735
26.5.0-remove-workflow-provider-id-column	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.204954	171	EXECUTED	9:d8eeb324484d45e946d03b953e168b21	dropIndex indexName=IDX_WORKFLOW_STATE_PROVIDER, tableName=WORKFLOW_STATE; createIndex indexName=IDX_WORKFLOW_STATE_PROVIDER, tableName=WORKFLOW_STATE; dropColumn columnName=WORKFLOW_PROVIDER_ID, tableName=WORKFLOW_STATE		\N	4.33.0	\N	\N	7416739735
26.5.0-add-remember-me	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.213915	172	EXECUTED	9:a7273ea8b21bd2f674c9c49141999f05	addColumn tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
26.5.0-add-sess-refresh-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.251367	173	EXECUTED	9:ce49383d317ccbcd3434d1f21172b0b7	createIndex indexName=IDX_USER_SESSION_EXPIRATION_CREATED, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
26.5.0-add-sess-create-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.29019	174	EXECUTED	9:aaee09e23a4d8468fbc5c51b7b314c58	createIndex indexName=IDX_USER_SESSION_EXPIRATION_LAST_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
26.5.0-drop-sess-refresh-idx	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.301314	175	EXECUTED	9:f0082210b6ccbbaf81287c27aa23753c	dropIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.33.0	\N	\N	7416739735
26.5.0-mysql-mariadb-default-charset-collation	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.305801	176	MARK_RAN	9:1b383fa60d2db0a8952b365e725f9d16	customChange		\N	4.33.0	\N	\N	7416739735
26.5.0-invitations-table-fixed2	keycloak	META-INF/jpa-changelog-26.5.0.xml	2026-04-28 22:52:36.486832	177	EXECUTED	9:322cb11fc03181903dcd67a54f8b3cf0	createTable tableName=ORG_INVITATION; addForeignKeyConstraint baseTableName=ORG_INVITATION, constraintName=FK_ORG_INVITATION_ORG, referencedTableName=ORG; createIndex indexName=IDX_ORG_INVITATION_ORG_ID, tableName=ORG_INVITATION; createIndex index...		\N	4.33.0	\N	\N	7416739735
26.6.0-45009-broker-link-user-id	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-04-28 22:52:36.521236	178	EXECUTED	9:05026bbbc8d2ead5afcbda2f5fdf3a2b	createIndex indexName=IDX_BROKER_LINK_USER_ID, tableName=BROKER_LINK		\N	4.33.0	\N	\N	7416739735
26.6.0-45009-broker-link-identity-provider	keycloak	META-INF/jpa-changelog-26.6.0.xml	2026-04-28 22:52:36.55802	179	EXECUTED	9:7d9a0253c9de7be754efef8bba4265bd	createIndex indexName=IDX_BROKER_LINK_IDENTITY_PROVIDER, tableName=BROKER_LINK		\N	4.33.0	\N	\N	7416739735
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
bea316d6-8ac9-446e-9f23-1404bb74ebb9	7db70245-1500-45ad-9c4d-8c36061f88a8	f
bea316d6-8ac9-446e-9f23-1404bb74ebb9	b5738b07-8a34-47ce-a2dd-16dd113e1bf8	t
bea316d6-8ac9-446e-9f23-1404bb74ebb9	e58a3bcf-5051-4b42-b876-31935cc99ea8	t
bea316d6-8ac9-446e-9f23-1404bb74ebb9	bfc1f429-a708-4e76-aa78-a04ae22d8b1a	t
bea316d6-8ac9-446e-9f23-1404bb74ebb9	0863872d-8bdc-4430-b8d0-ed886d7f6468	t
bea316d6-8ac9-446e-9f23-1404bb74ebb9	190966c3-87d5-4977-b0d8-9b17379a927f	f
bea316d6-8ac9-446e-9f23-1404bb74ebb9	b22b8009-09a6-41ff-82ff-089695e29a3d	f
bea316d6-8ac9-446e-9f23-1404bb74ebb9	0b8e687e-2e15-4450-93d3-890431f2b08f	t
bea316d6-8ac9-446e-9f23-1404bb74ebb9	a7597da6-4965-4e10-a224-340767a97fac	t
bea316d6-8ac9-446e-9f23-1404bb74ebb9	2907bd3c-3a0a-4c10-a315-de4855914bc0	f
bea316d6-8ac9-446e-9f23-1404bb74ebb9	f7aa1d95-99a0-4393-a086-695384ab430d	t
bea316d6-8ac9-446e-9f23-1404bb74ebb9	de455754-bc15-48f0-9904-be42d942ed45	t
bea316d6-8ac9-446e-9f23-1404bb74ebb9	971ad32d-d973-4bc7-b0b7-ef680e12650e	f
2744037b-1841-4221-9433-43ebf4bd227e	c2c48045-e884-48b7-95fd-339e1c837548	t
2744037b-1841-4221-9433-43ebf4bd227e	91c62640-2d2e-49ef-9275-9e79781e0825	t
2744037b-1841-4221-9433-43ebf4bd227e	c2c76379-021e-48e4-8f73-58540d6971fc	t
2744037b-1841-4221-9433-43ebf4bd227e	5bf35843-8c14-4e89-9b48-9b2859a02a1e	t
2744037b-1841-4221-9433-43ebf4bd227e	62d26fd4-86f8-4cff-b86c-eca10cf21fc0	t
2744037b-1841-4221-9433-43ebf4bd227e	06094407-b4f1-4182-94d4-3f751063bec9	t
2744037b-1841-4221-9433-43ebf4bd227e	67718965-76f6-4560-9830-9ca9b1acd21a	t
2744037b-1841-4221-9433-43ebf4bd227e	6758852d-3f68-470a-bc7d-61ec60eefecd	t
2744037b-1841-4221-9433-43ebf4bd227e	7f2c97f3-74f5-4ecb-910d-b621a2164f23	f
2744037b-1841-4221-9433-43ebf4bd227e	78f94949-9851-4744-8c3a-de5340324b4f	f
2744037b-1841-4221-9433-43ebf4bd227e	8d554b0d-1877-47a5-8bb4-4ceb48e767a7	f
2744037b-1841-4221-9433-43ebf4bd227e	906da9f7-306e-434c-82eb-26b050a36fdf	f
2744037b-1841-4221-9433-43ebf4bd227e	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type, description) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
65dd23fc-3d23-4fdf-b26f-e4cbca5f4f8d	bea316d6-8ac9-446e-9f23-1404bb74ebb9	f	${role_default-roles}	default-roles-master	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N	\N
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	bea316d6-8ac9-446e-9f23-1404bb74ebb9	f	${role_admin}	admin	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N	\N
7f057d7b-cc45-4326-9f1a-5b8f2f905e68	bea316d6-8ac9-446e-9f23-1404bb74ebb9	f	${role_create-realm}	create-realm	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N	\N
f5b47955-df1c-4440-b45b-2dc30d60d92c	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_create-client}	create-client	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
24caa214-2e69-4eab-ad78-31de153a9f85	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_view-realm}	view-realm	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
3a059f46-1960-4c01-8bb2-ffbab94f3401	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_view-users}	view-users	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
66aa0131-7b1d-45a2-8e84-60ccdab2fa85	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_view-clients}	view-clients	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
56e93a73-ff86-4a72-b9c1-0e0df26ca59c	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_view-events}	view-events	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
d2605681-1636-4a46-9d1d-4a2bb306cf0e	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_view-identity-providers}	view-identity-providers	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
d29e79e0-5353-4249-91f6-792ab7bc3a92	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_view-authorization}	view-authorization	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
1376005b-a44f-4d95-aba5-3990c73f5985	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_manage-realm}	manage-realm	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
07b8afd0-8da3-4af5-9f69-e12cea88ecef	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_manage-users}	manage-users	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
0139b5c3-cc13-45eb-b8c7-a1c29128b80e	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_manage-clients}	manage-clients	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
c748ad31-c5ab-490e-adc8-ef406c403399	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_manage-events}	manage-events	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
a258b531-36c1-4144-99b5-e5b5f33e8027	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_manage-identity-providers}	manage-identity-providers	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
7747c023-6fbc-49c7-a744-a1bf00023434	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_manage-authorization}	manage-authorization	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
503ae383-7726-42f9-b93a-13efac91931f	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_query-users}	query-users	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
72fe13ee-1ce1-4d1e-a89b-0e32d1f7cb94	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_query-clients}	query-clients	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
46539539-5a24-4923-b61e-243e6847a1c2	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_query-realms}	query-realms	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
03b98ddb-f190-4696-8b7d-a0f55bf269ed	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_query-groups}	query-groups	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
bf96e807-f370-44c2-9057-07d0f26cc365	a36f1367-a594-4c22-809e-83224efcb50d	t	${role_view-profile}	view-profile	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a36f1367-a594-4c22-809e-83224efcb50d	\N
bea8bfda-4241-42a9-b584-9fb26aa479a2	a36f1367-a594-4c22-809e-83224efcb50d	t	${role_manage-account}	manage-account	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a36f1367-a594-4c22-809e-83224efcb50d	\N
a51eb964-8d71-402d-bb5d-a533222076d1	a36f1367-a594-4c22-809e-83224efcb50d	t	${role_manage-account-links}	manage-account-links	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a36f1367-a594-4c22-809e-83224efcb50d	\N
5ef6d88a-2fcb-41f0-910d-42cf50693562	a36f1367-a594-4c22-809e-83224efcb50d	t	${role_view-applications}	view-applications	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a36f1367-a594-4c22-809e-83224efcb50d	\N
bb582754-3ac2-4038-ac6a-ce6f50a8644c	a36f1367-a594-4c22-809e-83224efcb50d	t	${role_view-consent}	view-consent	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a36f1367-a594-4c22-809e-83224efcb50d	\N
2c831fe3-3ba6-4918-9e97-697ca4a3d70d	a36f1367-a594-4c22-809e-83224efcb50d	t	${role_manage-consent}	manage-consent	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a36f1367-a594-4c22-809e-83224efcb50d	\N
a05c89a3-4fc5-4ae4-bb99-0fd0721e5a1e	a36f1367-a594-4c22-809e-83224efcb50d	t	${role_view-groups}	view-groups	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a36f1367-a594-4c22-809e-83224efcb50d	\N
fbc9a3f4-7ad5-4c7a-b0ce-10a6af5ff585	a36f1367-a594-4c22-809e-83224efcb50d	t	${role_delete-account}	delete-account	bea316d6-8ac9-446e-9f23-1404bb74ebb9	a36f1367-a594-4c22-809e-83224efcb50d	\N
c317eb6e-6a1b-43b2-b588-e75986910274	9c893a44-379b-403a-afac-3dff84abb810	t	${role_read-token}	read-token	bea316d6-8ac9-446e-9f23-1404bb74ebb9	9c893a44-379b-403a-afac-3dff84abb810	\N
3127585a-1470-4ccc-9461-ec1cd9ae4218	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	t	${role_impersonation}	impersonation	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	\N
65106016-c03f-4baa-9742-b43f56e46672	bea316d6-8ac9-446e-9f23-1404bb74ebb9	f	${role_offline-access}	offline_access	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N	\N
d635a59c-ea60-448f-8501-31d31c672ee2	bea316d6-8ac9-446e-9f23-1404bb74ebb9	f	${role_uma_authorization}	uma_authorization	bea316d6-8ac9-446e-9f23-1404bb74ebb9	\N	\N
f589643c-6ab1-462d-8e73-2441b25642a4	2744037b-1841-4221-9433-43ebf4bd227e	f	${role_default-roles}	default-roles-newrealm	2744037b-1841-4221-9433-43ebf4bd227e	\N	\N
fd739284-eef0-4c47-ad6d-c4ee5dcd5a13	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_create-client}	create-client	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
fdc3d315-6c7c-43d4-950e-5232bead21bb	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_view-realm}	view-realm	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
647afc76-e642-447b-a301-217cea23bfde	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_view-users}	view-users	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
c1782e4f-7632-4734-8e74-75240220846d	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_view-clients}	view-clients	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
df573741-bfc6-461c-89f5-109ed54f3f14	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_view-events}	view-events	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
b71ed37b-6254-45fc-94dc-1e3618647327	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_view-identity-providers}	view-identity-providers	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
4b42c32e-5c79-4a40-85d9-529b75f85d44	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_view-authorization}	view-authorization	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
80f2a093-ea57-4022-9612-f32ff1818232	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_manage-realm}	manage-realm	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
b794174c-f47c-4d5d-b524-be2402849f9e	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_manage-users}	manage-users	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
daba6d7a-8cc1-4184-b853-07232cbc4419	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_manage-clients}	manage-clients	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
f43835a4-22e9-4149-997d-2db1bd69601a	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_manage-events}	manage-events	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
aec3b20d-4511-430b-bb0b-9dc6f478e090	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_manage-identity-providers}	manage-identity-providers	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
9baffcc6-df76-49d2-8603-9f7dd5ff3502	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_manage-authorization}	manage-authorization	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
1ca45108-f9bd-4810-bc00-0b2dba1ab101	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_query-users}	query-users	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
b164c1ec-812a-421a-aa6e-741d614ae4c9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_query-clients}	query-clients	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
41a562b6-7bc2-49e7-b4a6-178d33123185	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_query-realms}	query-realms	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
d1e3ab4b-578a-403c-bed3-da183cf8ee2c	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_query-groups}	query-groups	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
4fe72f61-87f6-443e-9be6-1318c4467c8b	2744037b-1841-4221-9433-43ebf4bd227e	f		client	2744037b-1841-4221-9433-43ebf4bd227e	\N	\N
09447906-9dfc-4d2d-9bac-4807472f6fd3	2744037b-1841-4221-9433-43ebf4bd227e	f		admin	2744037b-1841-4221-9433-43ebf4bd227e	\N	\N
d42cc3d5-5743-47e4-a17f-de4fba113e9d	2744037b-1841-4221-9433-43ebf4bd227e	f	${role_uma_authorization}	uma_authorization	2744037b-1841-4221-9433-43ebf4bd227e	\N	\N
5950f615-d936-42ed-8dd8-0d8b4ca47bc7	2744037b-1841-4221-9433-43ebf4bd227e	f	${role_offline-access}	offline_access	2744037b-1841-4221-9433-43ebf4bd227e	\N	\N
14ca54de-6bd6-4f8d-ad02-f076c43ea955	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_query-users}	query-users	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
fb0942b0-b4eb-4a64-a5ba-59da5a111faf	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_view-authorization}	view-authorization	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
f4ef5e03-1e49-44a3-a52e-50bc48ff0fda	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_impersonation}	impersonation	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
5606b062-1de5-42a3-b280-90fab20c362b	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_view-events}	view-events	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
926e1396-122f-42ae-9d5a-945837fd4928	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_manage-identity-providers}	manage-identity-providers	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
b18f8bc0-e0b0-437b-9452-f55c6b6465a2	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_view-realm}	view-realm	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
356f4bbd-c4dc-480d-bfc8-20065eecd855	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_manage-realm}	manage-realm	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
721d9daa-122f-4d85-af47-b85e30f4f22b	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_view-clients}	view-clients	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
370f976f-5a54-4095-be0e-145a500688a5	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_query-clients}	query-clients	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
10d74e36-91b9-4774-bd0f-b05a78cfc082	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_view-identity-providers}	view-identity-providers	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
5ce75942-22cb-441e-831a-22ef052b60a6	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_manage-clients}	manage-clients	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
7ebeebb7-bc26-4238-abbc-478bef2f4b46	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_manage-users}	manage-users	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
c7129392-e0b9-4cf0-b205-8599e80fa87a	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_view-users}	view-users	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
da7082a3-074b-4007-bd31-88a5133ff169	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_query-groups}	query-groups	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
f5d5bcb6-8659-4909-90a7-e9d213cfe5ab	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_create-client}	create-client	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
879445bc-0524-43d6-886f-657e65d47596	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_manage-events}	manage-events	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
805d0d1d-aad3-4ef7-81b0-35b9abe9049e	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_query-realms}	query-realms	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
331a3b72-77d4-460c-9644-1c7fa076da44	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_manage-authorization}	manage-authorization	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
c6b78cef-ed3b-43c9-b1cb-b9c190d302e7	68c69036-b8e9-4dac-b426-6c2478544578	t	${role_realm-admin}	realm-admin	2744037b-1841-4221-9433-43ebf4bd227e	68c69036-b8e9-4dac-b426-6c2478544578	\N
6a400366-4d51-421d-b77a-c56d10746878	3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	t	${role_read-token}	read-token	2744037b-1841-4221-9433-43ebf4bd227e	3e37fa65-78fe-4bb8-8fee-e8474a0dc05e	\N
3e318029-cffe-410a-af80-8e7d1fcdc8c6	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	${role_manage-consent}	manage-consent	2744037b-1841-4221-9433-43ebf4bd227e	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	\N
d0daf188-2fe0-40ab-87ea-5c0a133d9a35	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	${role_view-applications}	view-applications	2744037b-1841-4221-9433-43ebf4bd227e	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	\N
83bb281e-7a0b-4a03-ac21-361f125a9191	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	${role_view-groups}	view-groups	2744037b-1841-4221-9433-43ebf4bd227e	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	\N
0d3e3f91-0192-4b9f-945a-3c3d64f49abc	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	${role_manage-account-links}	manage-account-links	2744037b-1841-4221-9433-43ebf4bd227e	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	\N
8338138b-8326-44c7-8a4c-dd14c7c89610	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	${role_view-profile}	view-profile	2744037b-1841-4221-9433-43ebf4bd227e	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	\N
ff7d85fc-e431-4391-80ee-f8d6b5222c5f	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	${role_manage-account}	manage-account	2744037b-1841-4221-9433-43ebf4bd227e	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	\N
310d73fe-5066-4bdd-832b-321cc51602c3	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	${role_view-consent}	view-consent	2744037b-1841-4221-9433-43ebf4bd227e	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	\N
1ee3fec4-b72c-4ad1-8257-7fd605a77768	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	t	${role_delete-account}	delete-account	2744037b-1841-4221-9433-43ebf4bd227e	ab5462e8-d123-476c-a2a7-3b3fa2101cd5	\N
0b7004f7-a162-4a3d-b335-f3942772eeca	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	t	${role_impersonation}	impersonation	bea316d6-8ac9-446e-9f23-1404bb74ebb9	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
2k4gr	26.5.6	1777416758
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version, remember_me) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: org_invitation; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_invitation (id, organization_id, email, first_name, last_name, created_at, expires_at, invite_link) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
0da2a5c6-2e9d-4358-9bb8-b525a2733211	audience resolve	openid-connect	oidc-audience-resolve-mapper	826d092e-efbb-4201-be09-098a546e5a8a	\N
46c8e1ae-e05b-4749-b93b-8bcb14b0a251	locale	openid-connect	oidc-usermodel-attribute-mapper	c87bb537-0c9c-4fb4-bf92-2777b975e2fa	\N
fa437eb5-fcc7-419e-9388-77ab1ab4b5c0	role list	saml	saml-role-list-mapper	\N	b5738b07-8a34-47ce-a2dd-16dd113e1bf8
82986820-b145-4606-815b-885526e8bfe1	organization	saml	saml-organization-membership-mapper	\N	e58a3bcf-5051-4b42-b876-31935cc99ea8
e58605e2-b16e-4e4d-b801-f6cfdacad04e	full name	openid-connect	oidc-full-name-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
9177d76d-e165-457c-99a6-c75a593d88e3	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
94979152-36ec-4c84-ae4e-217d030fdd26	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
0e3eee32-375c-4b4c-a7bd-440842626589	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
7731085b-ab45-42ba-be2f-da716107c1f6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
3a51b517-9976-4fc4-8ca3-b0208ee5f84b	username	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
ab405686-eb1c-4858-9503-4d8b33360e1f	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
e6603c77-2ae2-4eec-9890-03238c2cccf9	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
29dd852e-4c6e-4421-949f-2da020dec6a5	website	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
b9491146-4b1b-4f68-99fd-4a91ff66f7fa	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
9a6ec8a3-39f9-489c-9349-d3eece5d2589	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
75df3983-cdac-4c84-a16c-662ec8e329c5	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
2243ce90-65cc-44a5-a72c-88f91019aff1	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
8115a6b9-7630-4391-b9fb-e48d2ecd8cdb	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	bfc1f429-a708-4e76-aa78-a04ae22d8b1a
a6fdc51e-85dd-422d-bae6-e26e24d5bab4	email	openid-connect	oidc-usermodel-attribute-mapper	\N	0863872d-8bdc-4430-b8d0-ed886d7f6468
53c544b5-85e5-40d8-ac99-d92003c59079	email verified	openid-connect	oidc-usermodel-property-mapper	\N	0863872d-8bdc-4430-b8d0-ed886d7f6468
5849c8d8-3a8f-41bd-9295-2de6caa9953c	address	openid-connect	oidc-address-mapper	\N	190966c3-87d5-4977-b0d8-9b17379a927f
eac92888-3def-453a-8fef-87419a5eda6e	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	b22b8009-09a6-41ff-82ff-089695e29a3d
c27c2504-b70c-4ad3-b58b-a26d3c4ef89d	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	b22b8009-09a6-41ff-82ff-089695e29a3d
cfc30945-8732-47a9-8c41-dfec50753cc2	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	0b8e687e-2e15-4450-93d3-890431f2b08f
2a1211ea-a1ec-42d7-ab9a-5b0e0e8f3b23	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	0b8e687e-2e15-4450-93d3-890431f2b08f
4db7a832-2d76-4785-8b31-b2284eafe00d	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	0b8e687e-2e15-4450-93d3-890431f2b08f
bd466f43-cdc6-4630-a819-ce8905af4472	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	a7597da6-4965-4e10-a224-340767a97fac
322d3410-fcfd-43a2-b89d-002c9eef6da7	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	2907bd3c-3a0a-4c10-a315-de4855914bc0
561e9508-dbe6-4a43-883b-f8eb1e9f754d	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	2907bd3c-3a0a-4c10-a315-de4855914bc0
c3375a01-0eb0-4c62-adb1-fd581484d7a4	acr loa level	openid-connect	oidc-acr-mapper	\N	f7aa1d95-99a0-4393-a086-695384ab430d
ae408b0c-d4b8-4a5a-82f4-26218ff7fb89	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	de455754-bc15-48f0-9904-be42d942ed45
e128a4f9-ba17-4093-a269-d6fb8685597f	sub	openid-connect	oidc-sub-mapper	\N	de455754-bc15-48f0-9904-be42d942ed45
d562a4af-ecd9-4874-9a8f-197ad4a23f29	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	b2950fcd-b8f1-44ac-b18a-54a75b997fee
40f3ad8c-f67d-433a-be04-552a9acc46aa	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	b2950fcd-b8f1-44ac-b18a-54a75b997fee
c9f1d247-08bb-49c4-af35-ee32c6228d10	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	b2950fcd-b8f1-44ac-b18a-54a75b997fee
920cc693-ff11-411f-ab5e-676bfa63a774	organization	openid-connect	oidc-organization-membership-mapper	\N	971ad32d-d973-4bc7-b0b7-ef680e12650e
38178b95-72e7-4ac8-81f9-31f6d34acc3a	address	openid-connect	oidc-address-mapper	\N	78f94949-9851-4744-8c3a-de5340324b4f
4552f6f4-4fbc-4035-9652-d1fa10a5c439	email	openid-connect	oidc-usermodel-attribute-mapper	\N	5bf35843-8c14-4e89-9b48-9b2859a02a1e
7f9f10b2-aa06-4943-8e71-d2b726d1e0d6	email verified	openid-connect	oidc-usermodel-property-mapper	\N	5bf35843-8c14-4e89-9b48-9b2859a02a1e
b448bbc3-ce13-42ee-a675-3b5ad1a3963b	organization	openid-connect	oidc-organization-membership-mapper	\N	8bfcf6a7-9a36-4469-9e07-5fcd30de4b5b
9280365e-3bda-4ee2-a87e-59a23b114575	username	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
6b50d2ba-bded-45b7-bec5-b892745b6369	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
77a1b2f9-a068-4010-b5b9-85d43f2e98bf	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
40e33db7-c5bd-472c-8421-6f515fa5cc4b	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
b564c909-ffc0-4136-b96c-9f050fd2da17	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
7fa2c562-7c64-42c3-8513-a3c8ace6e812	full name	openid-connect	oidc-full-name-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
86035690-b5d4-4af0-bc50-c9fd9ee2c938	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
9968ea58-f706-40ad-b018-7248867e42e7	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
6dec64bb-8322-4ef2-8cce-588481780e2f	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
99ec3c25-2b79-4819-802a-a26c268b8d96	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
52d420af-bd56-41de-8d6f-d23da1eb42b1	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
4004a228-f30f-43d3-8a79-1ecc73384427	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
d5f67792-52a4-4ffe-9a55-f8b5b6a7e0c9	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
037c7b84-4858-4b67-bf6a-045ed4a2d062	website	openid-connect	oidc-usermodel-attribute-mapper	\N	c2c76379-021e-48e4-8f73-58540d6971fc
32ab182e-7b17-429d-9917-c817cc579c67	role list	saml	saml-role-list-mapper	\N	c2c48045-e884-48b7-95fd-339e1c837548
d9602e10-e2ac-47cd-875d-b7c101a4c97f	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	6758852d-3f68-470a-bc7d-61ec60eefecd
01278882-0d87-486a-94bd-2fcad38d8f94	sub	openid-connect	oidc-sub-mapper	\N	6758852d-3f68-470a-bc7d-61ec60eefecd
f16672cb-f2fe-4a67-ab20-e2934911449d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8d554b0d-1877-47a5-8bb4-4ceb48e767a7
c960b360-417f-4516-a436-ca788b1f4946	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8d554b0d-1877-47a5-8bb4-4ceb48e767a7
09eea37d-c79d-42fb-b978-689e5a9e62ea	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	906da9f7-306e-434c-82eb-26b050a36fdf
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	906da9f7-306e-434c-82eb-26b050a36fdf
bb0f1f3d-f147-4cfb-ba9c-336f2d9661bb	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	62d26fd4-86f8-4cff-b86c-eca10cf21fc0
216bad71-ee26-4398-8aad-cf4f8d349f11	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	62d26fd4-86f8-4cff-b86c-eca10cf21fc0
5c674fc3-9c00-4931-899f-974994b5e9c8	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	62d26fd4-86f8-4cff-b86c-eca10cf21fc0
7daba877-e4c1-459e-a290-04940adf8236	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	06094407-b4f1-4182-94d4-3f751063bec9
135153fd-1ed1-45d8-a520-0c782f21a56b	organization	saml	saml-organization-membership-mapper	\N	91c62640-2d2e-49ef-9275-9e79781e0825
89310e0e-6dae-4636-bd72-b18e51ae261f	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	d343a500-37da-45a0-affe-4adf1ea6810f
3f77ed09-209e-4eb8-8cc7-6a69758b98a9	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	d343a500-37da-45a0-affe-4adf1ea6810f
51e21d91-da45-488b-9b80-dd78c1d16e58	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	d343a500-37da-45a0-affe-4adf1ea6810f
932dcf86-1b30-4a69-bd43-edade61c5ac7	acr loa level	openid-connect	oidc-acr-mapper	\N	67718965-76f6-4560-9830-9ca9b1acd21a
bd71e1a4-6e2f-4430-a98d-4fe2566a62a3	audience resolve	openid-connect	oidc-audience-resolve-mapper	d6d27cdd-ba07-44b2-9804-a86ec1eead93	\N
21d151f2-0d3b-45a3-9260-62ce308e52a3	tenant_id	openid-connect	oidc-usermodel-attribute-mapper	3f620058-4974-4328-b5d8-06c087bd0f71	\N
734219b5-a9e8-42a7-8c9c-aa8bab9aa2f5	locale	openid-connect	oidc-usermodel-attribute-mapper	6c49d412-381a-4191-866d-2df99a6c0f7b	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
46c8e1ae-e05b-4749-b93b-8bcb14b0a251	true	introspection.token.claim
46c8e1ae-e05b-4749-b93b-8bcb14b0a251	true	userinfo.token.claim
46c8e1ae-e05b-4749-b93b-8bcb14b0a251	locale	user.attribute
46c8e1ae-e05b-4749-b93b-8bcb14b0a251	true	id.token.claim
46c8e1ae-e05b-4749-b93b-8bcb14b0a251	true	access.token.claim
46c8e1ae-e05b-4749-b93b-8bcb14b0a251	locale	claim.name
46c8e1ae-e05b-4749-b93b-8bcb14b0a251	String	jsonType.label
fa437eb5-fcc7-419e-9388-77ab1ab4b5c0	false	single
fa437eb5-fcc7-419e-9388-77ab1ab4b5c0	Basic	attribute.nameformat
fa437eb5-fcc7-419e-9388-77ab1ab4b5c0	Role	attribute.name
0e3eee32-375c-4b4c-a7bd-440842626589	true	introspection.token.claim
0e3eee32-375c-4b4c-a7bd-440842626589	true	userinfo.token.claim
0e3eee32-375c-4b4c-a7bd-440842626589	middleName	user.attribute
0e3eee32-375c-4b4c-a7bd-440842626589	true	id.token.claim
0e3eee32-375c-4b4c-a7bd-440842626589	true	access.token.claim
0e3eee32-375c-4b4c-a7bd-440842626589	middle_name	claim.name
0e3eee32-375c-4b4c-a7bd-440842626589	String	jsonType.label
2243ce90-65cc-44a5-a72c-88f91019aff1	true	introspection.token.claim
2243ce90-65cc-44a5-a72c-88f91019aff1	true	userinfo.token.claim
2243ce90-65cc-44a5-a72c-88f91019aff1	locale	user.attribute
2243ce90-65cc-44a5-a72c-88f91019aff1	true	id.token.claim
2243ce90-65cc-44a5-a72c-88f91019aff1	true	access.token.claim
2243ce90-65cc-44a5-a72c-88f91019aff1	locale	claim.name
2243ce90-65cc-44a5-a72c-88f91019aff1	String	jsonType.label
29dd852e-4c6e-4421-949f-2da020dec6a5	true	introspection.token.claim
29dd852e-4c6e-4421-949f-2da020dec6a5	true	userinfo.token.claim
29dd852e-4c6e-4421-949f-2da020dec6a5	website	user.attribute
29dd852e-4c6e-4421-949f-2da020dec6a5	true	id.token.claim
29dd852e-4c6e-4421-949f-2da020dec6a5	true	access.token.claim
29dd852e-4c6e-4421-949f-2da020dec6a5	website	claim.name
29dd852e-4c6e-4421-949f-2da020dec6a5	String	jsonType.label
3a51b517-9976-4fc4-8ca3-b0208ee5f84b	true	introspection.token.claim
3a51b517-9976-4fc4-8ca3-b0208ee5f84b	true	userinfo.token.claim
3a51b517-9976-4fc4-8ca3-b0208ee5f84b	username	user.attribute
3a51b517-9976-4fc4-8ca3-b0208ee5f84b	true	id.token.claim
3a51b517-9976-4fc4-8ca3-b0208ee5f84b	true	access.token.claim
3a51b517-9976-4fc4-8ca3-b0208ee5f84b	preferred_username	claim.name
3a51b517-9976-4fc4-8ca3-b0208ee5f84b	String	jsonType.label
75df3983-cdac-4c84-a16c-662ec8e329c5	true	introspection.token.claim
75df3983-cdac-4c84-a16c-662ec8e329c5	true	userinfo.token.claim
75df3983-cdac-4c84-a16c-662ec8e329c5	zoneinfo	user.attribute
75df3983-cdac-4c84-a16c-662ec8e329c5	true	id.token.claim
75df3983-cdac-4c84-a16c-662ec8e329c5	true	access.token.claim
75df3983-cdac-4c84-a16c-662ec8e329c5	zoneinfo	claim.name
75df3983-cdac-4c84-a16c-662ec8e329c5	String	jsonType.label
7731085b-ab45-42ba-be2f-da716107c1f6	true	introspection.token.claim
7731085b-ab45-42ba-be2f-da716107c1f6	true	userinfo.token.claim
7731085b-ab45-42ba-be2f-da716107c1f6	nickname	user.attribute
7731085b-ab45-42ba-be2f-da716107c1f6	true	id.token.claim
7731085b-ab45-42ba-be2f-da716107c1f6	true	access.token.claim
7731085b-ab45-42ba-be2f-da716107c1f6	nickname	claim.name
7731085b-ab45-42ba-be2f-da716107c1f6	String	jsonType.label
8115a6b9-7630-4391-b9fb-e48d2ecd8cdb	true	introspection.token.claim
8115a6b9-7630-4391-b9fb-e48d2ecd8cdb	true	userinfo.token.claim
8115a6b9-7630-4391-b9fb-e48d2ecd8cdb	updatedAt	user.attribute
8115a6b9-7630-4391-b9fb-e48d2ecd8cdb	true	id.token.claim
8115a6b9-7630-4391-b9fb-e48d2ecd8cdb	true	access.token.claim
8115a6b9-7630-4391-b9fb-e48d2ecd8cdb	updated_at	claim.name
8115a6b9-7630-4391-b9fb-e48d2ecd8cdb	long	jsonType.label
9177d76d-e165-457c-99a6-c75a593d88e3	true	introspection.token.claim
9177d76d-e165-457c-99a6-c75a593d88e3	true	userinfo.token.claim
9177d76d-e165-457c-99a6-c75a593d88e3	lastName	user.attribute
9177d76d-e165-457c-99a6-c75a593d88e3	true	id.token.claim
9177d76d-e165-457c-99a6-c75a593d88e3	true	access.token.claim
9177d76d-e165-457c-99a6-c75a593d88e3	family_name	claim.name
9177d76d-e165-457c-99a6-c75a593d88e3	String	jsonType.label
94979152-36ec-4c84-ae4e-217d030fdd26	true	introspection.token.claim
94979152-36ec-4c84-ae4e-217d030fdd26	true	userinfo.token.claim
94979152-36ec-4c84-ae4e-217d030fdd26	firstName	user.attribute
94979152-36ec-4c84-ae4e-217d030fdd26	true	id.token.claim
94979152-36ec-4c84-ae4e-217d030fdd26	true	access.token.claim
94979152-36ec-4c84-ae4e-217d030fdd26	given_name	claim.name
94979152-36ec-4c84-ae4e-217d030fdd26	String	jsonType.label
9a6ec8a3-39f9-489c-9349-d3eece5d2589	true	introspection.token.claim
9a6ec8a3-39f9-489c-9349-d3eece5d2589	true	userinfo.token.claim
9a6ec8a3-39f9-489c-9349-d3eece5d2589	birthdate	user.attribute
9a6ec8a3-39f9-489c-9349-d3eece5d2589	true	id.token.claim
9a6ec8a3-39f9-489c-9349-d3eece5d2589	true	access.token.claim
9a6ec8a3-39f9-489c-9349-d3eece5d2589	birthdate	claim.name
9a6ec8a3-39f9-489c-9349-d3eece5d2589	String	jsonType.label
ab405686-eb1c-4858-9503-4d8b33360e1f	true	introspection.token.claim
ab405686-eb1c-4858-9503-4d8b33360e1f	true	userinfo.token.claim
ab405686-eb1c-4858-9503-4d8b33360e1f	profile	user.attribute
ab405686-eb1c-4858-9503-4d8b33360e1f	true	id.token.claim
ab405686-eb1c-4858-9503-4d8b33360e1f	true	access.token.claim
ab405686-eb1c-4858-9503-4d8b33360e1f	profile	claim.name
ab405686-eb1c-4858-9503-4d8b33360e1f	String	jsonType.label
b9491146-4b1b-4f68-99fd-4a91ff66f7fa	true	introspection.token.claim
b9491146-4b1b-4f68-99fd-4a91ff66f7fa	true	userinfo.token.claim
b9491146-4b1b-4f68-99fd-4a91ff66f7fa	gender	user.attribute
b9491146-4b1b-4f68-99fd-4a91ff66f7fa	true	id.token.claim
b9491146-4b1b-4f68-99fd-4a91ff66f7fa	true	access.token.claim
b9491146-4b1b-4f68-99fd-4a91ff66f7fa	gender	claim.name
b9491146-4b1b-4f68-99fd-4a91ff66f7fa	String	jsonType.label
e58605e2-b16e-4e4d-b801-f6cfdacad04e	true	introspection.token.claim
e58605e2-b16e-4e4d-b801-f6cfdacad04e	true	userinfo.token.claim
e58605e2-b16e-4e4d-b801-f6cfdacad04e	true	id.token.claim
e58605e2-b16e-4e4d-b801-f6cfdacad04e	true	access.token.claim
e6603c77-2ae2-4eec-9890-03238c2cccf9	true	introspection.token.claim
e6603c77-2ae2-4eec-9890-03238c2cccf9	true	userinfo.token.claim
e6603c77-2ae2-4eec-9890-03238c2cccf9	picture	user.attribute
e6603c77-2ae2-4eec-9890-03238c2cccf9	true	id.token.claim
e6603c77-2ae2-4eec-9890-03238c2cccf9	true	access.token.claim
e6603c77-2ae2-4eec-9890-03238c2cccf9	picture	claim.name
e6603c77-2ae2-4eec-9890-03238c2cccf9	String	jsonType.label
53c544b5-85e5-40d8-ac99-d92003c59079	true	introspection.token.claim
53c544b5-85e5-40d8-ac99-d92003c59079	true	userinfo.token.claim
53c544b5-85e5-40d8-ac99-d92003c59079	emailVerified	user.attribute
53c544b5-85e5-40d8-ac99-d92003c59079	true	id.token.claim
53c544b5-85e5-40d8-ac99-d92003c59079	true	access.token.claim
53c544b5-85e5-40d8-ac99-d92003c59079	email_verified	claim.name
53c544b5-85e5-40d8-ac99-d92003c59079	boolean	jsonType.label
a6fdc51e-85dd-422d-bae6-e26e24d5bab4	true	introspection.token.claim
a6fdc51e-85dd-422d-bae6-e26e24d5bab4	true	userinfo.token.claim
a6fdc51e-85dd-422d-bae6-e26e24d5bab4	email	user.attribute
a6fdc51e-85dd-422d-bae6-e26e24d5bab4	true	id.token.claim
a6fdc51e-85dd-422d-bae6-e26e24d5bab4	true	access.token.claim
a6fdc51e-85dd-422d-bae6-e26e24d5bab4	email	claim.name
a6fdc51e-85dd-422d-bae6-e26e24d5bab4	String	jsonType.label
5849c8d8-3a8f-41bd-9295-2de6caa9953c	formatted	user.attribute.formatted
5849c8d8-3a8f-41bd-9295-2de6caa9953c	country	user.attribute.country
5849c8d8-3a8f-41bd-9295-2de6caa9953c	true	introspection.token.claim
5849c8d8-3a8f-41bd-9295-2de6caa9953c	postal_code	user.attribute.postal_code
5849c8d8-3a8f-41bd-9295-2de6caa9953c	true	userinfo.token.claim
5849c8d8-3a8f-41bd-9295-2de6caa9953c	street	user.attribute.street
5849c8d8-3a8f-41bd-9295-2de6caa9953c	true	id.token.claim
5849c8d8-3a8f-41bd-9295-2de6caa9953c	region	user.attribute.region
5849c8d8-3a8f-41bd-9295-2de6caa9953c	true	access.token.claim
5849c8d8-3a8f-41bd-9295-2de6caa9953c	locality	user.attribute.locality
c27c2504-b70c-4ad3-b58b-a26d3c4ef89d	true	introspection.token.claim
c27c2504-b70c-4ad3-b58b-a26d3c4ef89d	true	userinfo.token.claim
c27c2504-b70c-4ad3-b58b-a26d3c4ef89d	phoneNumberVerified	user.attribute
c27c2504-b70c-4ad3-b58b-a26d3c4ef89d	true	id.token.claim
c27c2504-b70c-4ad3-b58b-a26d3c4ef89d	true	access.token.claim
c27c2504-b70c-4ad3-b58b-a26d3c4ef89d	phone_number_verified	claim.name
c27c2504-b70c-4ad3-b58b-a26d3c4ef89d	boolean	jsonType.label
eac92888-3def-453a-8fef-87419a5eda6e	true	introspection.token.claim
eac92888-3def-453a-8fef-87419a5eda6e	true	userinfo.token.claim
eac92888-3def-453a-8fef-87419a5eda6e	phoneNumber	user.attribute
eac92888-3def-453a-8fef-87419a5eda6e	true	id.token.claim
eac92888-3def-453a-8fef-87419a5eda6e	true	access.token.claim
eac92888-3def-453a-8fef-87419a5eda6e	phone_number	claim.name
eac92888-3def-453a-8fef-87419a5eda6e	String	jsonType.label
2a1211ea-a1ec-42d7-ab9a-5b0e0e8f3b23	true	introspection.token.claim
2a1211ea-a1ec-42d7-ab9a-5b0e0e8f3b23	true	multivalued
2a1211ea-a1ec-42d7-ab9a-5b0e0e8f3b23	foo	user.attribute
2a1211ea-a1ec-42d7-ab9a-5b0e0e8f3b23	true	access.token.claim
2a1211ea-a1ec-42d7-ab9a-5b0e0e8f3b23	resource_access.${client_id}.roles	claim.name
2a1211ea-a1ec-42d7-ab9a-5b0e0e8f3b23	String	jsonType.label
4db7a832-2d76-4785-8b31-b2284eafe00d	true	introspection.token.claim
4db7a832-2d76-4785-8b31-b2284eafe00d	true	access.token.claim
cfc30945-8732-47a9-8c41-dfec50753cc2	true	introspection.token.claim
cfc30945-8732-47a9-8c41-dfec50753cc2	true	multivalued
cfc30945-8732-47a9-8c41-dfec50753cc2	foo	user.attribute
cfc30945-8732-47a9-8c41-dfec50753cc2	true	access.token.claim
cfc30945-8732-47a9-8c41-dfec50753cc2	realm_access.roles	claim.name
cfc30945-8732-47a9-8c41-dfec50753cc2	String	jsonType.label
bd466f43-cdc6-4630-a819-ce8905af4472	true	introspection.token.claim
bd466f43-cdc6-4630-a819-ce8905af4472	true	access.token.claim
322d3410-fcfd-43a2-b89d-002c9eef6da7	true	introspection.token.claim
322d3410-fcfd-43a2-b89d-002c9eef6da7	true	userinfo.token.claim
322d3410-fcfd-43a2-b89d-002c9eef6da7	username	user.attribute
322d3410-fcfd-43a2-b89d-002c9eef6da7	true	id.token.claim
322d3410-fcfd-43a2-b89d-002c9eef6da7	true	access.token.claim
322d3410-fcfd-43a2-b89d-002c9eef6da7	upn	claim.name
322d3410-fcfd-43a2-b89d-002c9eef6da7	String	jsonType.label
561e9508-dbe6-4a43-883b-f8eb1e9f754d	true	introspection.token.claim
561e9508-dbe6-4a43-883b-f8eb1e9f754d	true	multivalued
561e9508-dbe6-4a43-883b-f8eb1e9f754d	foo	user.attribute
561e9508-dbe6-4a43-883b-f8eb1e9f754d	true	id.token.claim
561e9508-dbe6-4a43-883b-f8eb1e9f754d	true	access.token.claim
561e9508-dbe6-4a43-883b-f8eb1e9f754d	groups	claim.name
561e9508-dbe6-4a43-883b-f8eb1e9f754d	String	jsonType.label
c3375a01-0eb0-4c62-adb1-fd581484d7a4	true	introspection.token.claim
c3375a01-0eb0-4c62-adb1-fd581484d7a4	true	id.token.claim
c3375a01-0eb0-4c62-adb1-fd581484d7a4	true	access.token.claim
ae408b0c-d4b8-4a5a-82f4-26218ff7fb89	AUTH_TIME	user.session.note
ae408b0c-d4b8-4a5a-82f4-26218ff7fb89	true	introspection.token.claim
ae408b0c-d4b8-4a5a-82f4-26218ff7fb89	true	id.token.claim
ae408b0c-d4b8-4a5a-82f4-26218ff7fb89	true	access.token.claim
ae408b0c-d4b8-4a5a-82f4-26218ff7fb89	auth_time	claim.name
ae408b0c-d4b8-4a5a-82f4-26218ff7fb89	long	jsonType.label
e128a4f9-ba17-4093-a269-d6fb8685597f	true	introspection.token.claim
e128a4f9-ba17-4093-a269-d6fb8685597f	true	access.token.claim
40f3ad8c-f67d-433a-be04-552a9acc46aa	clientHost	user.session.note
40f3ad8c-f67d-433a-be04-552a9acc46aa	true	introspection.token.claim
40f3ad8c-f67d-433a-be04-552a9acc46aa	true	id.token.claim
40f3ad8c-f67d-433a-be04-552a9acc46aa	true	access.token.claim
40f3ad8c-f67d-433a-be04-552a9acc46aa	clientHost	claim.name
40f3ad8c-f67d-433a-be04-552a9acc46aa	String	jsonType.label
c9f1d247-08bb-49c4-af35-ee32c6228d10	clientAddress	user.session.note
c9f1d247-08bb-49c4-af35-ee32c6228d10	true	introspection.token.claim
c9f1d247-08bb-49c4-af35-ee32c6228d10	true	id.token.claim
c9f1d247-08bb-49c4-af35-ee32c6228d10	true	access.token.claim
c9f1d247-08bb-49c4-af35-ee32c6228d10	clientAddress	claim.name
c9f1d247-08bb-49c4-af35-ee32c6228d10	String	jsonType.label
d562a4af-ecd9-4874-9a8f-197ad4a23f29	client_id	user.session.note
d562a4af-ecd9-4874-9a8f-197ad4a23f29	true	introspection.token.claim
d562a4af-ecd9-4874-9a8f-197ad4a23f29	true	id.token.claim
d562a4af-ecd9-4874-9a8f-197ad4a23f29	true	access.token.claim
d562a4af-ecd9-4874-9a8f-197ad4a23f29	client_id	claim.name
d562a4af-ecd9-4874-9a8f-197ad4a23f29	String	jsonType.label
920cc693-ff11-411f-ab5e-676bfa63a774	true	introspection.token.claim
920cc693-ff11-411f-ab5e-676bfa63a774	true	multivalued
920cc693-ff11-411f-ab5e-676bfa63a774	true	id.token.claim
920cc693-ff11-411f-ab5e-676bfa63a774	true	access.token.claim
920cc693-ff11-411f-ab5e-676bfa63a774	organization	claim.name
920cc693-ff11-411f-ab5e-676bfa63a774	String	jsonType.label
38178b95-72e7-4ac8-81f9-31f6d34acc3a	formatted	user.attribute.formatted
38178b95-72e7-4ac8-81f9-31f6d34acc3a	country	user.attribute.country
38178b95-72e7-4ac8-81f9-31f6d34acc3a	true	introspection.token.claim
38178b95-72e7-4ac8-81f9-31f6d34acc3a	postal_code	user.attribute.postal_code
38178b95-72e7-4ac8-81f9-31f6d34acc3a	true	userinfo.token.claim
38178b95-72e7-4ac8-81f9-31f6d34acc3a	street	user.attribute.street
38178b95-72e7-4ac8-81f9-31f6d34acc3a	true	id.token.claim
38178b95-72e7-4ac8-81f9-31f6d34acc3a	region	user.attribute.region
38178b95-72e7-4ac8-81f9-31f6d34acc3a	true	access.token.claim
38178b95-72e7-4ac8-81f9-31f6d34acc3a	locality	user.attribute.locality
4552f6f4-4fbc-4035-9652-d1fa10a5c439	true	introspection.token.claim
4552f6f4-4fbc-4035-9652-d1fa10a5c439	true	userinfo.token.claim
4552f6f4-4fbc-4035-9652-d1fa10a5c439	email	user.attribute
4552f6f4-4fbc-4035-9652-d1fa10a5c439	true	id.token.claim
4552f6f4-4fbc-4035-9652-d1fa10a5c439	true	access.token.claim
4552f6f4-4fbc-4035-9652-d1fa10a5c439	email	claim.name
4552f6f4-4fbc-4035-9652-d1fa10a5c439	String	jsonType.label
7f9f10b2-aa06-4943-8e71-d2b726d1e0d6	true	introspection.token.claim
7f9f10b2-aa06-4943-8e71-d2b726d1e0d6	true	userinfo.token.claim
7f9f10b2-aa06-4943-8e71-d2b726d1e0d6	emailVerified	user.attribute
7f9f10b2-aa06-4943-8e71-d2b726d1e0d6	true	id.token.claim
7f9f10b2-aa06-4943-8e71-d2b726d1e0d6	true	access.token.claim
7f9f10b2-aa06-4943-8e71-d2b726d1e0d6	email_verified	claim.name
7f9f10b2-aa06-4943-8e71-d2b726d1e0d6	boolean	jsonType.label
b448bbc3-ce13-42ee-a675-3b5ad1a3963b	true	introspection.token.claim
b448bbc3-ce13-42ee-a675-3b5ad1a3963b	true	multivalued
b448bbc3-ce13-42ee-a675-3b5ad1a3963b	true	userinfo.token.claim
b448bbc3-ce13-42ee-a675-3b5ad1a3963b	true	id.token.claim
b448bbc3-ce13-42ee-a675-3b5ad1a3963b	true	access.token.claim
b448bbc3-ce13-42ee-a675-3b5ad1a3963b	organization	claim.name
b448bbc3-ce13-42ee-a675-3b5ad1a3963b	String	jsonType.label
037c7b84-4858-4b67-bf6a-045ed4a2d062	true	introspection.token.claim
037c7b84-4858-4b67-bf6a-045ed4a2d062	true	userinfo.token.claim
037c7b84-4858-4b67-bf6a-045ed4a2d062	website	user.attribute
037c7b84-4858-4b67-bf6a-045ed4a2d062	true	id.token.claim
037c7b84-4858-4b67-bf6a-045ed4a2d062	true	access.token.claim
037c7b84-4858-4b67-bf6a-045ed4a2d062	website	claim.name
037c7b84-4858-4b67-bf6a-045ed4a2d062	String	jsonType.label
4004a228-f30f-43d3-8a79-1ecc73384427	true	introspection.token.claim
4004a228-f30f-43d3-8a79-1ecc73384427	true	userinfo.token.claim
4004a228-f30f-43d3-8a79-1ecc73384427	updatedAt	user.attribute
4004a228-f30f-43d3-8a79-1ecc73384427	true	id.token.claim
4004a228-f30f-43d3-8a79-1ecc73384427	true	access.token.claim
4004a228-f30f-43d3-8a79-1ecc73384427	updated_at	claim.name
4004a228-f30f-43d3-8a79-1ecc73384427	long	jsonType.label
40e33db7-c5bd-472c-8421-6f515fa5cc4b	true	introspection.token.claim
40e33db7-c5bd-472c-8421-6f515fa5cc4b	true	userinfo.token.claim
40e33db7-c5bd-472c-8421-6f515fa5cc4b	nickname	user.attribute
40e33db7-c5bd-472c-8421-6f515fa5cc4b	true	id.token.claim
40e33db7-c5bd-472c-8421-6f515fa5cc4b	true	access.token.claim
40e33db7-c5bd-472c-8421-6f515fa5cc4b	nickname	claim.name
40e33db7-c5bd-472c-8421-6f515fa5cc4b	String	jsonType.label
52d420af-bd56-41de-8d6f-d23da1eb42b1	true	introspection.token.claim
52d420af-bd56-41de-8d6f-d23da1eb42b1	true	userinfo.token.claim
52d420af-bd56-41de-8d6f-d23da1eb42b1	lastName	user.attribute
52d420af-bd56-41de-8d6f-d23da1eb42b1	true	id.token.claim
52d420af-bd56-41de-8d6f-d23da1eb42b1	true	access.token.claim
52d420af-bd56-41de-8d6f-d23da1eb42b1	family_name	claim.name
52d420af-bd56-41de-8d6f-d23da1eb42b1	String	jsonType.label
6b50d2ba-bded-45b7-bec5-b892745b6369	true	introspection.token.claim
6b50d2ba-bded-45b7-bec5-b892745b6369	true	userinfo.token.claim
6b50d2ba-bded-45b7-bec5-b892745b6369	gender	user.attribute
6b50d2ba-bded-45b7-bec5-b892745b6369	true	id.token.claim
6b50d2ba-bded-45b7-bec5-b892745b6369	true	access.token.claim
6b50d2ba-bded-45b7-bec5-b892745b6369	gender	claim.name
6b50d2ba-bded-45b7-bec5-b892745b6369	String	jsonType.label
6dec64bb-8322-4ef2-8cce-588481780e2f	true	introspection.token.claim
6dec64bb-8322-4ef2-8cce-588481780e2f	true	userinfo.token.claim
6dec64bb-8322-4ef2-8cce-588481780e2f	birthdate	user.attribute
6dec64bb-8322-4ef2-8cce-588481780e2f	true	id.token.claim
6dec64bb-8322-4ef2-8cce-588481780e2f	true	access.token.claim
6dec64bb-8322-4ef2-8cce-588481780e2f	birthdate	claim.name
6dec64bb-8322-4ef2-8cce-588481780e2f	String	jsonType.label
77a1b2f9-a068-4010-b5b9-85d43f2e98bf	true	introspection.token.claim
77a1b2f9-a068-4010-b5b9-85d43f2e98bf	true	userinfo.token.claim
77a1b2f9-a068-4010-b5b9-85d43f2e98bf	profile	user.attribute
77a1b2f9-a068-4010-b5b9-85d43f2e98bf	true	id.token.claim
77a1b2f9-a068-4010-b5b9-85d43f2e98bf	true	access.token.claim
77a1b2f9-a068-4010-b5b9-85d43f2e98bf	profile	claim.name
77a1b2f9-a068-4010-b5b9-85d43f2e98bf	String	jsonType.label
7fa2c562-7c64-42c3-8513-a3c8ace6e812	true	id.token.claim
7fa2c562-7c64-42c3-8513-a3c8ace6e812	true	introspection.token.claim
7fa2c562-7c64-42c3-8513-a3c8ace6e812	true	access.token.claim
7fa2c562-7c64-42c3-8513-a3c8ace6e812	true	userinfo.token.claim
86035690-b5d4-4af0-bc50-c9fd9ee2c938	true	introspection.token.claim
86035690-b5d4-4af0-bc50-c9fd9ee2c938	true	userinfo.token.claim
86035690-b5d4-4af0-bc50-c9fd9ee2c938	middleName	user.attribute
86035690-b5d4-4af0-bc50-c9fd9ee2c938	true	id.token.claim
86035690-b5d4-4af0-bc50-c9fd9ee2c938	true	access.token.claim
86035690-b5d4-4af0-bc50-c9fd9ee2c938	middle_name	claim.name
86035690-b5d4-4af0-bc50-c9fd9ee2c938	String	jsonType.label
9280365e-3bda-4ee2-a87e-59a23b114575	true	introspection.token.claim
9280365e-3bda-4ee2-a87e-59a23b114575	true	userinfo.token.claim
9280365e-3bda-4ee2-a87e-59a23b114575	username	user.attribute
9280365e-3bda-4ee2-a87e-59a23b114575	true	id.token.claim
9280365e-3bda-4ee2-a87e-59a23b114575	true	access.token.claim
9280365e-3bda-4ee2-a87e-59a23b114575	preferred_username	claim.name
9280365e-3bda-4ee2-a87e-59a23b114575	String	jsonType.label
9968ea58-f706-40ad-b018-7248867e42e7	true	introspection.token.claim
9968ea58-f706-40ad-b018-7248867e42e7	true	userinfo.token.claim
9968ea58-f706-40ad-b018-7248867e42e7	locale	user.attribute
9968ea58-f706-40ad-b018-7248867e42e7	true	id.token.claim
9968ea58-f706-40ad-b018-7248867e42e7	true	access.token.claim
9968ea58-f706-40ad-b018-7248867e42e7	locale	claim.name
9968ea58-f706-40ad-b018-7248867e42e7	String	jsonType.label
99ec3c25-2b79-4819-802a-a26c268b8d96	true	introspection.token.claim
99ec3c25-2b79-4819-802a-a26c268b8d96	true	userinfo.token.claim
99ec3c25-2b79-4819-802a-a26c268b8d96	firstName	user.attribute
99ec3c25-2b79-4819-802a-a26c268b8d96	true	id.token.claim
99ec3c25-2b79-4819-802a-a26c268b8d96	true	access.token.claim
99ec3c25-2b79-4819-802a-a26c268b8d96	given_name	claim.name
99ec3c25-2b79-4819-802a-a26c268b8d96	String	jsonType.label
b564c909-ffc0-4136-b96c-9f050fd2da17	true	introspection.token.claim
b564c909-ffc0-4136-b96c-9f050fd2da17	true	userinfo.token.claim
b564c909-ffc0-4136-b96c-9f050fd2da17	zoneinfo	user.attribute
b564c909-ffc0-4136-b96c-9f050fd2da17	true	id.token.claim
b564c909-ffc0-4136-b96c-9f050fd2da17	true	access.token.claim
b564c909-ffc0-4136-b96c-9f050fd2da17	zoneinfo	claim.name
b564c909-ffc0-4136-b96c-9f050fd2da17	String	jsonType.label
d5f67792-52a4-4ffe-9a55-f8b5b6a7e0c9	true	introspection.token.claim
d5f67792-52a4-4ffe-9a55-f8b5b6a7e0c9	true	userinfo.token.claim
d5f67792-52a4-4ffe-9a55-f8b5b6a7e0c9	picture	user.attribute
d5f67792-52a4-4ffe-9a55-f8b5b6a7e0c9	true	id.token.claim
d5f67792-52a4-4ffe-9a55-f8b5b6a7e0c9	true	access.token.claim
d5f67792-52a4-4ffe-9a55-f8b5b6a7e0c9	picture	claim.name
d5f67792-52a4-4ffe-9a55-f8b5b6a7e0c9	String	jsonType.label
32ab182e-7b17-429d-9917-c817cc579c67	false	single
32ab182e-7b17-429d-9917-c817cc579c67	Basic	attribute.nameformat
32ab182e-7b17-429d-9917-c817cc579c67	Role	attribute.name
01278882-0d87-486a-94bd-2fcad38d8f94	true	introspection.token.claim
01278882-0d87-486a-94bd-2fcad38d8f94	true	access.token.claim
d9602e10-e2ac-47cd-875d-b7c101a4c97f	AUTH_TIME	user.session.note
d9602e10-e2ac-47cd-875d-b7c101a4c97f	true	introspection.token.claim
d9602e10-e2ac-47cd-875d-b7c101a4c97f	true	userinfo.token.claim
d9602e10-e2ac-47cd-875d-b7c101a4c97f	true	id.token.claim
d9602e10-e2ac-47cd-875d-b7c101a4c97f	true	access.token.claim
d9602e10-e2ac-47cd-875d-b7c101a4c97f	auth_time	claim.name
d9602e10-e2ac-47cd-875d-b7c101a4c97f	long	jsonType.label
c960b360-417f-4516-a436-ca788b1f4946	true	introspection.token.claim
c960b360-417f-4516-a436-ca788b1f4946	true	userinfo.token.claim
c960b360-417f-4516-a436-ca788b1f4946	phoneNumberVerified	user.attribute
c960b360-417f-4516-a436-ca788b1f4946	true	id.token.claim
c960b360-417f-4516-a436-ca788b1f4946	true	access.token.claim
c960b360-417f-4516-a436-ca788b1f4946	phone_number_verified	claim.name
c960b360-417f-4516-a436-ca788b1f4946	boolean	jsonType.label
f16672cb-f2fe-4a67-ab20-e2934911449d	true	introspection.token.claim
f16672cb-f2fe-4a67-ab20-e2934911449d	true	userinfo.token.claim
f16672cb-f2fe-4a67-ab20-e2934911449d	phoneNumber	user.attribute
f16672cb-f2fe-4a67-ab20-e2934911449d	true	id.token.claim
f16672cb-f2fe-4a67-ab20-e2934911449d	true	access.token.claim
f16672cb-f2fe-4a67-ab20-e2934911449d	phone_number	claim.name
f16672cb-f2fe-4a67-ab20-e2934911449d	String	jsonType.label
09eea37d-c79d-42fb-b978-689e5a9e62ea	true	introspection.token.claim
09eea37d-c79d-42fb-b978-689e5a9e62ea	true	userinfo.token.claim
09eea37d-c79d-42fb-b978-689e5a9e62ea	username	user.attribute
09eea37d-c79d-42fb-b978-689e5a9e62ea	true	id.token.claim
09eea37d-c79d-42fb-b978-689e5a9e62ea	true	access.token.claim
09eea37d-c79d-42fb-b978-689e5a9e62ea	upn	claim.name
09eea37d-c79d-42fb-b978-689e5a9e62ea	String	jsonType.label
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	true	introspection.token.claim
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	true	multivalued
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	true	userinfo.token.claim
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	foo	user.attribute
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	true	id.token.claim
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	true	access.token.claim
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	groups	claim.name
a8588c5d-8bc9-4cc0-aff8-e31f67acef14	String	jsonType.label
216bad71-ee26-4398-8aad-cf4f8d349f11	foo	user.attribute
216bad71-ee26-4398-8aad-cf4f8d349f11	true	introspection.token.claim
216bad71-ee26-4398-8aad-cf4f8d349f11	true	access.token.claim
216bad71-ee26-4398-8aad-cf4f8d349f11	realm_access.roles	claim.name
216bad71-ee26-4398-8aad-cf4f8d349f11	String	jsonType.label
216bad71-ee26-4398-8aad-cf4f8d349f11	true	multivalued
5c674fc3-9c00-4931-899f-974994b5e9c8	true	introspection.token.claim
5c674fc3-9c00-4931-899f-974994b5e9c8	true	access.token.claim
bb0f1f3d-f147-4cfb-ba9c-336f2d9661bb	foo	user.attribute
bb0f1f3d-f147-4cfb-ba9c-336f2d9661bb	true	introspection.token.claim
bb0f1f3d-f147-4cfb-ba9c-336f2d9661bb	true	access.token.claim
bb0f1f3d-f147-4cfb-ba9c-336f2d9661bb	resource_access.${client_id}.roles	claim.name
bb0f1f3d-f147-4cfb-ba9c-336f2d9661bb	String	jsonType.label
bb0f1f3d-f147-4cfb-ba9c-336f2d9661bb	true	multivalued
7daba877-e4c1-459e-a290-04940adf8236	true	introspection.token.claim
7daba877-e4c1-459e-a290-04940adf8236	true	access.token.claim
3f77ed09-209e-4eb8-8cc7-6a69758b98a9	client_id	user.session.note
3f77ed09-209e-4eb8-8cc7-6a69758b98a9	true	introspection.token.claim
3f77ed09-209e-4eb8-8cc7-6a69758b98a9	true	userinfo.token.claim
3f77ed09-209e-4eb8-8cc7-6a69758b98a9	true	id.token.claim
3f77ed09-209e-4eb8-8cc7-6a69758b98a9	true	access.token.claim
3f77ed09-209e-4eb8-8cc7-6a69758b98a9	client_id	claim.name
3f77ed09-209e-4eb8-8cc7-6a69758b98a9	String	jsonType.label
51e21d91-da45-488b-9b80-dd78c1d16e58	clientAddress	user.session.note
51e21d91-da45-488b-9b80-dd78c1d16e58	true	introspection.token.claim
51e21d91-da45-488b-9b80-dd78c1d16e58	true	userinfo.token.claim
51e21d91-da45-488b-9b80-dd78c1d16e58	true	id.token.claim
51e21d91-da45-488b-9b80-dd78c1d16e58	true	access.token.claim
51e21d91-da45-488b-9b80-dd78c1d16e58	clientAddress	claim.name
51e21d91-da45-488b-9b80-dd78c1d16e58	String	jsonType.label
89310e0e-6dae-4636-bd72-b18e51ae261f	clientHost	user.session.note
89310e0e-6dae-4636-bd72-b18e51ae261f	true	introspection.token.claim
89310e0e-6dae-4636-bd72-b18e51ae261f	true	userinfo.token.claim
89310e0e-6dae-4636-bd72-b18e51ae261f	true	id.token.claim
89310e0e-6dae-4636-bd72-b18e51ae261f	true	access.token.claim
89310e0e-6dae-4636-bd72-b18e51ae261f	clientHost	claim.name
89310e0e-6dae-4636-bd72-b18e51ae261f	String	jsonType.label
932dcf86-1b30-4a69-bd43-edade61c5ac7	true	id.token.claim
932dcf86-1b30-4a69-bd43-edade61c5ac7	true	introspection.token.claim
932dcf86-1b30-4a69-bd43-edade61c5ac7	true	access.token.claim
932dcf86-1b30-4a69-bd43-edade61c5ac7	true	userinfo.token.claim
21d151f2-0d3b-45a3-9260-62ce308e52a3	false	aggregate.attrs
21d151f2-0d3b-45a3-9260-62ce308e52a3	true	introspection.token.claim
21d151f2-0d3b-45a3-9260-62ce308e52a3	false	multivalued
21d151f2-0d3b-45a3-9260-62ce308e52a3	true	userinfo.token.claim
21d151f2-0d3b-45a3-9260-62ce308e52a3	tenant_id	user.attribute
21d151f2-0d3b-45a3-9260-62ce308e52a3	true	id.token.claim
21d151f2-0d3b-45a3-9260-62ce308e52a3	true	lightweight.claim
21d151f2-0d3b-45a3-9260-62ce308e52a3	true	access.token.claim
21d151f2-0d3b-45a3-9260-62ce308e52a3	tenant_id	claim.name
21d151f2-0d3b-45a3-9260-62ce308e52a3	String	jsonType.label
734219b5-a9e8-42a7-8c9c-aa8bab9aa2f5	true	introspection.token.claim
734219b5-a9e8-42a7-8c9c-aa8bab9aa2f5	true	userinfo.token.claim
734219b5-a9e8-42a7-8c9c-aa8bab9aa2f5	locale	user.attribute
734219b5-a9e8-42a7-8c9c-aa8bab9aa2f5	true	id.token.claim
734219b5-a9e8-42a7-8c9c-aa8bab9aa2f5	true	access.token.claim
734219b5-a9e8-42a7-8c9c-aa8bab9aa2f5	locale	claim.name
734219b5-a9e8-42a7-8c9c-aa8bab9aa2f5	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
bea316d6-8ac9-446e-9f23-1404bb74ebb9	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	0fcb71a0-acbe-4c1b-a6b9-f56cab14448a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	1c2d7d02-2895-4939-b8da-8ac0e1556ffb	06808a33-0a1d-40c9-8905-dba1f4a887de	c8633cd2-938d-4a61-b5ae-128516072f5d	35c6e783-a8c8-4500-bc48-b5fde32b0db5	b06f0eab-5faa-4728-baa0-fe40703ac4db	2592000	f	900	t	f	50096e31-8d69-480e-9aef-2a740b51f734	0	f	0	0	65dd23fc-3d23-4fdf-b26f-e4cbca5f4f8d
2744037b-1841-4221-9433-43ebf4bd227e	60	300	600	\N	\N	\N	t	f	0	\N	newRealm	0	\N	t	f	f	f	EXTERNAL	1200	36000	f	f	ee6a8d31-5280-4dbd-9b33-2b3a6c5345c2	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	c0bf971c-8067-4640-95a7-25cf5770d9ef	825dcc25-39a6-49ad-90f6-928d4761660f	3d5cf55f-7eca-46c2-8031-fc796f3b049f	e04dd418-2cd8-4955-b9f1-60fac1e0b7a7	39010a52-48b6-45c1-846c-dad544d8f3be	2592000	f	900	f	f	2a81da9e-79cf-4f9d-98a8-d0b1f953e3f0	0	f	0	0	f589643c-6ab1-462d-8e73-2441b25642a4
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	bea316d6-8ac9-446e-9f23-1404bb74ebb9	
_browser_header.xContentTypeOptions	bea316d6-8ac9-446e-9f23-1404bb74ebb9	nosniff
_browser_header.referrerPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	no-referrer
_browser_header.xRobotsTag	bea316d6-8ac9-446e-9f23-1404bb74ebb9	none
_browser_header.xFrameOptions	bea316d6-8ac9-446e-9f23-1404bb74ebb9	SAMEORIGIN
_browser_header.contentSecurityPolicy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	bea316d6-8ac9-446e-9f23-1404bb74ebb9	max-age=31536000; includeSubDomains
bruteForceProtected	bea316d6-8ac9-446e-9f23-1404bb74ebb9	false
permanentLockout	bea316d6-8ac9-446e-9f23-1404bb74ebb9	false
maxTemporaryLockouts	bea316d6-8ac9-446e-9f23-1404bb74ebb9	0
bruteForceStrategy	bea316d6-8ac9-446e-9f23-1404bb74ebb9	MULTIPLE
maxFailureWaitSeconds	bea316d6-8ac9-446e-9f23-1404bb74ebb9	900
minimumQuickLoginWaitSeconds	bea316d6-8ac9-446e-9f23-1404bb74ebb9	60
waitIncrementSeconds	bea316d6-8ac9-446e-9f23-1404bb74ebb9	60
quickLoginCheckMilliSeconds	bea316d6-8ac9-446e-9f23-1404bb74ebb9	1000
maxDeltaTimeSeconds	bea316d6-8ac9-446e-9f23-1404bb74ebb9	43200
failureFactor	bea316d6-8ac9-446e-9f23-1404bb74ebb9	30
realmReusableOtpCode	bea316d6-8ac9-446e-9f23-1404bb74ebb9	false
firstBrokerLoginFlowId	bea316d6-8ac9-446e-9f23-1404bb74ebb9	93807b61-b8a8-4030-a1d7-3ecdccdff64b
displayName	bea316d6-8ac9-446e-9f23-1404bb74ebb9	Keycloak
displayNameHtml	bea316d6-8ac9-446e-9f23-1404bb74ebb9	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	bea316d6-8ac9-446e-9f23-1404bb74ebb9	RS256
offlineSessionMaxLifespanEnabled	bea316d6-8ac9-446e-9f23-1404bb74ebb9	false
offlineSessionMaxLifespan	bea316d6-8ac9-446e-9f23-1404bb74ebb9	5184000
_browser_header.contentSecurityPolicyReportOnly	2744037b-1841-4221-9433-43ebf4bd227e	
_browser_header.xContentTypeOptions	2744037b-1841-4221-9433-43ebf4bd227e	nosniff
_browser_header.referrerPolicy	2744037b-1841-4221-9433-43ebf4bd227e	no-referrer
_browser_header.xRobotsTag	2744037b-1841-4221-9433-43ebf4bd227e	none
_browser_header.xFrameOptions	2744037b-1841-4221-9433-43ebf4bd227e	SAMEORIGIN
_browser_header.contentSecurityPolicy	2744037b-1841-4221-9433-43ebf4bd227e	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	2744037b-1841-4221-9433-43ebf4bd227e	max-age=31536000; includeSubDomains
bruteForceProtected	2744037b-1841-4221-9433-43ebf4bd227e	false
permanentLockout	2744037b-1841-4221-9433-43ebf4bd227e	false
maxTemporaryLockouts	2744037b-1841-4221-9433-43ebf4bd227e	0
bruteForceStrategy	2744037b-1841-4221-9433-43ebf4bd227e	MULTIPLE
maxFailureWaitSeconds	2744037b-1841-4221-9433-43ebf4bd227e	900
minimumQuickLoginWaitSeconds	2744037b-1841-4221-9433-43ebf4bd227e	60
waitIncrementSeconds	2744037b-1841-4221-9433-43ebf4bd227e	60
quickLoginCheckMilliSeconds	2744037b-1841-4221-9433-43ebf4bd227e	1000
maxDeltaTimeSeconds	2744037b-1841-4221-9433-43ebf4bd227e	43200
failureFactor	2744037b-1841-4221-9433-43ebf4bd227e	30
realmReusableOtpCode	2744037b-1841-4221-9433-43ebf4bd227e	false
displayName	2744037b-1841-4221-9433-43ebf4bd227e	
displayNameHtml	2744037b-1841-4221-9433-43ebf4bd227e	Tutorial
defaultSignatureAlgorithm	2744037b-1841-4221-9433-43ebf4bd227e	RS256
offlineSessionMaxLifespanEnabled	2744037b-1841-4221-9433-43ebf4bd227e	false
offlineSessionMaxLifespan	2744037b-1841-4221-9433-43ebf4bd227e	5184000
clientSessionIdleTimeout	2744037b-1841-4221-9433-43ebf4bd227e	0
clientSessionMaxLifespan	2744037b-1841-4221-9433-43ebf4bd227e	0
clientOfflineSessionIdleTimeout	2744037b-1841-4221-9433-43ebf4bd227e	0
clientOfflineSessionMaxLifespan	2744037b-1841-4221-9433-43ebf4bd227e	0
actionTokenGeneratedByAdminLifespan	2744037b-1841-4221-9433-43ebf4bd227e	43200
actionTokenGeneratedByUserLifespan	2744037b-1841-4221-9433-43ebf4bd227e	300
oauth2DeviceCodeLifespan	2744037b-1841-4221-9433-43ebf4bd227e	600
oauth2DevicePollingInterval	2744037b-1841-4221-9433-43ebf4bd227e	5
organizationsEnabled	2744037b-1841-4221-9433-43ebf4bd227e	false
adminPermissionsEnabled	2744037b-1841-4221-9433-43ebf4bd227e	false
webAuthnPolicyRpEntityName	2744037b-1841-4221-9433-43ebf4bd227e	keycloak
webAuthnPolicySignatureAlgorithms	2744037b-1841-4221-9433-43ebf4bd227e	ES256,RS256
webAuthnPolicyRpId	2744037b-1841-4221-9433-43ebf4bd227e	
webAuthnPolicyAttestationConveyancePreference	2744037b-1841-4221-9433-43ebf4bd227e	not specified
webAuthnPolicyAuthenticatorAttachment	2744037b-1841-4221-9433-43ebf4bd227e	not specified
webAuthnPolicyRequireResidentKey	2744037b-1841-4221-9433-43ebf4bd227e	not specified
webAuthnPolicyUserVerificationRequirement	2744037b-1841-4221-9433-43ebf4bd227e	not specified
webAuthnPolicyCreateTimeout	2744037b-1841-4221-9433-43ebf4bd227e	0
webAuthnPolicyAvoidSameAuthenticatorRegister	2744037b-1841-4221-9433-43ebf4bd227e	false
webAuthnPolicyRpEntityNamePasswordless	2744037b-1841-4221-9433-43ebf4bd227e	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	2744037b-1841-4221-9433-43ebf4bd227e	ES256,RS256
webAuthnPolicyRpIdPasswordless	2744037b-1841-4221-9433-43ebf4bd227e	
webAuthnPolicyAttestationConveyancePreferencePasswordless	2744037b-1841-4221-9433-43ebf4bd227e	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	2744037b-1841-4221-9433-43ebf4bd227e	not specified
webAuthnPolicyRequireResidentKeyPasswordless	2744037b-1841-4221-9433-43ebf4bd227e	Yes
webAuthnPolicyUserVerificationRequirementPasswordless	2744037b-1841-4221-9433-43ebf4bd227e	required
webAuthnPolicyCreateTimeoutPasswordless	2744037b-1841-4221-9433-43ebf4bd227e	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	2744037b-1841-4221-9433-43ebf4bd227e	false
cibaBackchannelTokenDeliveryMode	2744037b-1841-4221-9433-43ebf4bd227e	poll
cibaExpiresIn	2744037b-1841-4221-9433-43ebf4bd227e	120
cibaInterval	2744037b-1841-4221-9433-43ebf4bd227e	5
cibaAuthRequestedUserHint	2744037b-1841-4221-9433-43ebf4bd227e	login_hint
parRequestUriLifespan	2744037b-1841-4221-9433-43ebf4bd227e	60
firstBrokerLoginFlowId	2744037b-1841-4221-9433-43ebf4bd227e	53345b4e-a450-455b-b8b9-3bae8032c15f
saml.signature.algorithm	2744037b-1841-4221-9433-43ebf4bd227e	
frontendUrl	2744037b-1841-4221-9433-43ebf4bd227e	
acr.loa.map	2744037b-1841-4221-9433-43ebf4bd227e	{}
verifiableCredentialsEnabled	2744037b-1841-4221-9433-43ebf4bd227e	false
client-policies.profiles	2744037b-1841-4221-9433-43ebf4bd227e	{"profiles":[]}
client-policies.policies	2744037b-1841-4221-9433-43ebf4bd227e	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
bea316d6-8ac9-446e-9f23-1404bb74ebb9	jboss-logging
2744037b-1841-4221-9433-43ebf4bd227e	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	bea316d6-8ac9-446e-9f23-1404bb74ebb9
password	password	t	t	2744037b-1841-4221-9433-43ebf4bd227e
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
a36f1367-a594-4c22-809e-83224efcb50d	/realms/master/account/*
826d092e-efbb-4201-be09-098a546e5a8a	/realms/master/account/*
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	/admin/master/console/*
ab5462e8-d123-476c-a2a7-3b3fa2101cd5	/realms/newRealm/account/*
d6d27cdd-ba07-44b2-9804-a86ec1eead93	/realms/newRealm/account/*
3f620058-4974-4328-b5d8-06c087bd0f71	*
6c49d412-381a-4191-866d-2df99a6c0f7b	/admin/newRealm/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
5b18027d-2c87-46ae-b88b-4a655a605494	VERIFY_EMAIL	Verify Email	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	VERIFY_EMAIL	50
ffcd935a-980f-4b63-923f-172cb4e365fe	UPDATE_PROFILE	Update Profile	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	UPDATE_PROFILE	40
8abef4bc-2242-47ca-8117-b539077af93d	CONFIGURE_TOTP	Configure OTP	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	CONFIGURE_TOTP	10
d5992c5a-69c9-4ae9-8531-5301f4d97600	UPDATE_PASSWORD	Update Password	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	UPDATE_PASSWORD	30
764cc03a-d861-46d2-86e1-01974655be3b	TERMS_AND_CONDITIONS	Terms and Conditions	bea316d6-8ac9-446e-9f23-1404bb74ebb9	f	f	TERMS_AND_CONDITIONS	20
06d746c1-9dae-4dd4-8a23-5c9724e8b54d	delete_account	Delete Account	bea316d6-8ac9-446e-9f23-1404bb74ebb9	f	f	delete_account	60
53b5e1fc-ea3b-4ab9-8cd7-f143f83b7cfb	delete_credential	Delete Credential	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	delete_credential	110
512dc3b2-f958-417a-8cac-73951880a01e	update_user_locale	Update User Locale	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	update_user_locale	1000
f49be212-1921-4ac8-a29d-03c25692c96a	UPDATE_EMAIL	Update Email	bea316d6-8ac9-446e-9f23-1404bb74ebb9	f	f	UPDATE_EMAIL	70
2a306ddb-ed73-4565-b6c9-f9219ab2950e	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	130
e4083a00-a643-48d3-ba2e-06685960debe	webauthn-register	Webauthn Register	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	webauthn-register	80
5ec367b8-1118-4db5-bc3c-4bd12c7ccc7a	webauthn-register-passwordless	Webauthn Register Passwordless	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	webauthn-register-passwordless	90
b51bc63a-5bb2-4ae0-a9df-1e3eca617421	VERIFY_PROFILE	Verify Profile	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	VERIFY_PROFILE	100
cb90ed1a-c3a2-4653-b718-baab8c22ca83	idp_link	Linking Identity Provider	bea316d6-8ac9-446e-9f23-1404bb74ebb9	t	f	idp_link	120
32a273c4-9d74-4903-937e-87027bcba98a	CONFIGURE_TOTP	Configure OTP	2744037b-1841-4221-9433-43ebf4bd227e	t	f	CONFIGURE_TOTP	10
7aaf836c-22c6-462f-8915-7e059e3044bb	TERMS_AND_CONDITIONS	Terms and Conditions	2744037b-1841-4221-9433-43ebf4bd227e	f	f	TERMS_AND_CONDITIONS	20
f701cffd-ad6f-4440-a62d-445f5ad73bb8	UPDATE_PASSWORD	Update Password	2744037b-1841-4221-9433-43ebf4bd227e	t	f	UPDATE_PASSWORD	30
a305b44d-aef5-4297-aa2c-274b2a06cd50	UPDATE_PROFILE	Update Profile	2744037b-1841-4221-9433-43ebf4bd227e	t	f	UPDATE_PROFILE	40
c977a21d-5e4f-425d-a2e1-9a071aa0a389	VERIFY_EMAIL	Verify Email	2744037b-1841-4221-9433-43ebf4bd227e	t	f	VERIFY_EMAIL	50
e211307b-421d-4c14-a880-9a41a288ebd8	delete_account	Delete Account	2744037b-1841-4221-9433-43ebf4bd227e	f	f	delete_account	60
28786664-bcc6-4f98-8199-20e1e6062ef0	UPDATE_EMAIL	Update Email	2744037b-1841-4221-9433-43ebf4bd227e	f	f	UPDATE_EMAIL	70
1305287e-6403-4694-a5cf-ffcd4a30bf2d	webauthn-register	Webauthn Register	2744037b-1841-4221-9433-43ebf4bd227e	t	f	webauthn-register	80
9d1d2b32-8696-48d0-9d72-03731278b721	webauthn-register-passwordless	Webauthn Register Passwordless	2744037b-1841-4221-9433-43ebf4bd227e	t	f	webauthn-register-passwordless	90
e761c601-9f32-4ceb-9f82-0a305f7e9274	VERIFY_PROFILE	Verify Profile	2744037b-1841-4221-9433-43ebf4bd227e	t	f	VERIFY_PROFILE	100
ec164c2b-d72a-4ab7-816e-c10d46f184b5	delete_credential	Delete Credential	2744037b-1841-4221-9433-43ebf4bd227e	t	f	delete_credential	110
e3a36738-4cdb-4fe5-a446-1cb7c6014699	idp_link	Linking Identity Provider	2744037b-1841-4221-9433-43ebf4bd227e	t	f	idp_link	120
5c5ec910-a80a-49be-951b-d5665ffcbfcf	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	2744037b-1841-4221-9433-43ebf4bd227e	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	130
0623ad2d-afc1-423a-a2ef-1ecacab2f327	update_user_locale	Update User Locale	2744037b-1841-4221-9433-43ebf4bd227e	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
826d092e-efbb-4201-be09-098a546e5a8a	bea8bfda-4241-42a9-b584-9fb26aa479a2
826d092e-efbb-4201-be09-098a546e5a8a	a05c89a3-4fc5-4ae4-bb99-0fd0721e5a1e
d6d27cdd-ba07-44b2-9804-a86ec1eead93	83bb281e-7a0b-4a03-ac21-361f125a9191
d6d27cdd-ba07-44b2-9804-a86ec1eead93	ff7d85fc-e431-4391-80ee-f8d6b5222c5f
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
tenant_id	globex	b01035c9-ecd4-49d8-93d8-909688cd54c3	e6b9ef99-8a26-47a3-9bf8-8f71ffae43c9	\N	\N	\N
tenant_id	globex	ac2e20ce-a2ca-4bf6-9eb5-f98c24278fa6	95b5d0db-3834-4b4a-b470-59488e92b766	\N	\N	\N
tenant_id	acme-corp	984e1170-40bc-4dd5-acb8-e9f36d633228	bafc50cc-ca10-47d8-858e-3f5ab94684a4	\N	\N	\N
is_temporary_admin	true	5d35a7b4-8143-4260-b0e5-81d04b4edb62	496e2c2f-6f80-457c-a1ae-2498b4a5b72d	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
984e1170-40bc-4dd5-acb8-e9f36d633228	test@gmail.com	test@gmail.com	t	t	\N	test	test	2744037b-1841-4221-9433-43ebf4bd227e	test	1770672141726	\N	0
ac2e20ce-a2ca-4bf6-9eb5-f98c24278fa6	tenant_test@gmail.com	tenant_test@gmail.com	f	t	\N	firstname	lastname	2744037b-1841-4221-9433-43ebf4bd227e	tenant_test	1773750942984	\N	0
b01035c9-ecd4-49d8-93d8-909688cd54c3	ilovelatinas@gmail.com	ilovelatinas@gmail.com	f	t	\N	i love 	latinas	2744037b-1841-4221-9433-43ebf4bd227e	ilovelatinas	1773056854353	\N	0
5d35a7b4-8143-4260-b0e5-81d04b4edb62	\N	ac1e8a23-9f04-4bf3-93fb-323dc60f7617	f	t	\N	\N	\N	bea316d6-8ac9-446e-9f23-1404bb74ebb9	admin	1777416762892	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
f589643c-6ab1-462d-8e73-2441b25642a4	b01035c9-ecd4-49d8-93d8-909688cd54c3
f589643c-6ab1-462d-8e73-2441b25642a4	ac2e20ce-a2ca-4bf6-9eb5-f98c24278fa6
4fe72f61-87f6-443e-9be6-1318c4467c8b	984e1170-40bc-4dd5-acb8-e9f36d633228
f589643c-6ab1-462d-8e73-2441b25642a4	984e1170-40bc-4dd5-acb8-e9f36d633228
09447906-9dfc-4d2d-9bac-4807472f6fd3	984e1170-40bc-4dd5-acb8-e9f36d633228
65dd23fc-3d23-4fdf-b26f-e4cbca5f4f8d	5d35a7b4-8143-4260-b0e5-81d04b4edb62
326f4fb5-e21c-4a4d-beb3-ecc31deb57d2	5d35a7b4-8143-4260-b0e5-81d04b4edb62
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
c87bb537-0c9c-4fb4-bf92-2777b975e2fa	+
3f620058-4974-4328-b5d8-06c087bd0f71	*
6c49d412-381a-4191-866d-2df99a6c0f7b	+
\.


--
-- Data for Name: workflow_state; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.workflow_state (execution_id, resource_id, workflow_id, resource_type, scheduled_step_id, scheduled_step_timestamp) FROM stdin;
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: org_invitation constraint_org_invitation; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT constraint_org_invitation PRIMARY KEY (id);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: workflow_state pk_workflow_state; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.workflow_state
    ADD CONSTRAINT pk_workflow_state PRIMARY KEY (execution_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org_invitation uk_org_invitation_email; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT uk_org_invitation_email UNIQUE (organization_id, email);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: workflow_state uq_workflow_resource; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.workflow_state
    ADD CONSTRAINT uq_workflow_resource UNIQUE (workflow_id, resource_id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_broker_link_identity_provider; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_broker_link_identity_provider ON public.broker_link USING btree (realm_id, identity_provider, broker_user_id);


--
-- Name: idx_broker_link_user_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_broker_link_user_id ON public.broker_link USING btree (user_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_entity_user_id_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_entity_user_id_type ON public.event_entity USING btree (user_id, type, event_time);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_by_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_by_client ON public.offline_client_session USING btree (client_id, offline_flag) WHERE ((client_id)::text <> 'external'::text);


--
-- Name: idx_offline_css_by_client_storage_provider; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_by_client_storage_provider ON public.offline_client_session USING btree (client_storage_provider, external_client_id, offline_flag) WHERE ((client_storage_provider)::text <> 'internal'::text);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_org_invitation_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_org_invitation_email ON public.org_invitation USING btree (email);


--
-- Name: idx_org_invitation_expires; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_org_invitation_expires ON public.org_invitation USING btree (expires_at);


--
-- Name: idx_org_invitation_org_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_org_invitation_org_id ON public.org_invitation USING btree (organization_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_user_session_expiration_created; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_session_expiration_created ON public.offline_user_session USING btree (realm_id, offline_flag, remember_me, created_on, user_session_id, user_id);


--
-- Name: idx_user_session_expiration_last_refresh; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_session_expiration_last_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, remember_me, last_session_refresh, user_session_id, user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: idx_workflow_state_provider; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_workflow_state_provider ON public.workflow_state USING btree (resource_id);


--
-- Name: idx_workflow_state_step; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_workflow_state_step ON public.workflow_state USING btree (workflow_id, scheduled_step_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: org_invitation fk_org_invitation_org; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_invitation
    ADD CONSTRAINT fk_org_invitation_org FOREIGN KEY (organization_id) REFERENCES public.org(id) ON DELETE CASCADE;


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

