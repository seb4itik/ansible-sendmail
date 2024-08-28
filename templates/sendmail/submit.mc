define(`_USE_ETC_MAIL_')dnl
include(`/usr/share/sendmail/cf/m4/cf.m4')dnl
OSTYPE(`{{ sendmail_mc_ostype }}')dnl
{% if sendmail_mc_submit_domain != "" %}
DOMAIN(`{{ sendmail_mc_submit_domain }}')dnl
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

dnl #---------------------------------------------------------------------
dnl # The real reason we're here: the FEATURE(msp)
dnl # NOTE WELL:  MSA (587) should have M=Ea, so we need to use stock 25
dnl #---------------------------------------------------------------------
FEATURE(`msp', `[127.0.0.1]', `25')dnl
