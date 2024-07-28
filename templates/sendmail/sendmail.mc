define(`_USE_ETC_MAIL_')dnl
include(`/usr/share/sendmail/cf/m4/cf.m4')dnl
OSTYPE(`{{ sendmail_mc_ostype }}')dnl
{% if sendmail_mc_domain != "" %}
DOMAIN(`{{ sendmail_mc_domain }}')dnl
{% endif %}

dnl # Items controlled by /etc/mail/sendmail.conf - DO NOT TOUCH HERE
undefine(`confHOST_STATUS_DIRECTORY')dnl        #DAEMON_HOSTSTATS=
dnl # Items controlled by /etc/mail/sendmail.conf - DO NOT TOUCH HERE

dnl # Daemon options
FEATURE(`no_default_msa')dnl
{% for d in sendmail_mc_daemons %}
DAEMON_OPTIONS(`Family={{ d.family }}, Name={{ d.name }}, Port={{ d.port }}{% if d.modifiers is not none %}, M={{ d.modifiers }}{% endif %}{% if d.addr is not none %}, Addr={{ d.addr}}{% endif %}')dnl
{% endfor %}

dnl # MILTER Configurations
{% if sendmail_clamav %}
include(`/etc/mail/m4/clamav-milter.m4')
{% endif %}
{% if sendmail_opendkim %}
INPUT_MAIL_FILTER(`opendkim', `S=inet:8891@127.0.0.1')dnl
{% endif %}

dnl # Host name configuration
define(`confSMTP_LOGIN_MSG', `{{ ansible_fqdn }}')dnl
Dw{{ ansible_hostname }}
Dj{{ ansible_fqdn }}

dnl # Be somewhat anal in what we allow
define(`confPRIVACY_FLAGS',dnl
`needmailhelo,needexpnhelo,needvrfyhelo,restrictqrun,restrictexpand,nobodyreturn,authwarnings')dnl

{% if sendmail_mc_sasl %}
include(`/etc/mail/sasl/sasl.m4')dnl
{% endif %}
{% if sendmail_mc_sasl %}
include(`/etc/mail/tls/starttls.m4')dnl
{% endif %}
{% if sendmail_mc_auth_options is not none %}
define(`confAUTH_OPTIONS',`p')dnl
{% endif %}

{% if sendmail_mc_refuse_la is not none %}
define( `confREFUSE_LA', `{{ sendmail_mc_refuse_la }}')dnl
{% endif %}

{% if sendmail_mc_smart_host is not none %}
define(`SMART_HOST', `{{ sendmail_mc_smart_host }}')dnl
{% endif %}

{% if sendmail_mc_ldap %}
define(`confLDAP_DEFAULT_SPEC', `{{ sendmail_mc_ldap_default_spec }}')dnl
{% if sendmail_mc_ldap_cluster is not none %}
define(`confLDAP_CLUSTER', `{{ sendmail_mc_ldap_cluster }}')dnl
{% endif %}
{% if sendmail_mc_ldap_alias %}
define(`ALIAS_FILE', `ldap:')dnl
{% endif %}
{% if sendmail_mc_ldap_virtusertable %}
FEATURE(`virtusertable', `ldap:-1 -v "{{ sendmail_mc_ldap_virtusertable_v }}" -k "{{ sendmail_mc_ldap_virtusertable_k }}"')dnl
{% endif %}
{% endif %}

{% if sendmail_mc_max_message_size is not none %}
define(`SMTP_MAILER_MAX', `{{ sendmail_mc_max_message_size }}')dnl
define(`confMAX_MESSAGE_SIZE', `{{ sendmail_mc_max_message_size }}')dnl
{% endif %}

{% if sendmail_mc_to_ident is not none %}
define(`confTO_IDENT', `{{ sendmail_mc_to_ident }}')dnl
{% endif %}

dnl # Define connection throttling and window length
define(`confCONNECTION_RATE_THROTTLE', `{{ sendmail_mc_connection_rate_throttle }}')dnl
define(`confCONNECTION_RATE_WINDOW_SIZE',`{{ sendmail_mc_connection_rate_window_size }}')dnl

dnl # Features

dnl # use /etc/mail/local-host-names
FEATURE(`use_cw_file')dnl

dnl # The access db is the basis for most of sendmail's checking
FEATURE(`access_db', , `skip')dnl

dnl # The greet_pause feature stops some automail bots - but check the
dnl # provided access db for details on excluding localhosts...
FEATURE(`greet_pause', `{{ sendmail_mc_greet_pause }}')dnl 1 seconds

dnl # Delay_checks allows sender<->recipient checking
FEATURE(`delay_checks', `friend', `n')dnl

dnl # If we get too many bad recipients, slow things down...
define(`confBAD_RCPT_THROTTLE',`{{ sendmail_mc_bad_rcpt_throttle }}')dnl

dnl # Stop connections that overflow our concurrent and time connection rates
FEATURE(`conncontrol', `nodelay', `terminate')dnl
FEATURE(`ratecontrol', `nodelay', `terminate')dnl

{% if sendmail_mc_mailertable %}
FEATURE(`mailertable', `hash -o /usr/lib/mailertable')dnl
{% endif %}

{% if sendmail_mc_masquerade_as != "" %}
dnl # Masquerading options
{% if sendmail_mc_masquerade_always_add_domain %}
FEATURE(`always_add_domain')dnl
{% endif %}
MASQUERADE_AS(`sendmail_mc_masquerade_as')dnl
{% if sendmail_mc_masquerade_all %}
FEATURE(`allmasquerade')dnl
{% endif %}
{% if sendmail_mc_masquerade_envelope %}
FEATURE(`masquerade_envelope')dnl
{% endif %}
{% for e in sendmail_mc_masquerade_exceptions %}
MASQUERADE_EXCEPTION(`{{ e }}')dnl
{% endfor %}
{% endif %}

{% if sendmail_mc_generics %}
FEATURE(`genericstable', `hash -o /etc/mail/genericstable')dnl
{% if sendmail_mc_generics_entire_domain %}
FEATURE(`generics_entire_domain')dnl
{% endif %}
GENERICS_DOMAIN_FILE(`/etc/mail/domains')dnl
{% endif %}

define(`confLOCAL_MAILER', `{{ sendmail_mc_local_mailer }}')dnl

dnl # Default Mailer setup
MAILER_DEFINITIONS
{% for mailer in sendmail_mc_mailers %}
MAILER(`{{ mailer }}')dnl
{% endfor %}
