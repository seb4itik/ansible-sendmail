dnl # To support shared keyfiles, we need them to be group readable
define(`confDONT_BLAME_SENDMAIL',dnl
	defn(`confDONT_BLAME_SENDMAIL')`,GroupReadableKeyFile')dnl

define(`confTO_STARTTLS',     `2m')dnl
define(`confCACERT_PATH',     `/etc/ssl/certs')dnl
define(`confCACERT',          `{{ sendmail_ssl_cacert }}')
define(`confSERVER_CERT',     `{{ sendmail_ssl_cert }}')dnl
define(`confSERVER_KEY',      `{{ sendmail_ssl_key }}')dnl
define(`confCLIENT_CERT',     `{{ sendmail_ssl_cert }}')dnl
define(`confCLIENT_KEY',      `{{ sendmail_ssl_key }}')dnl
define(`confDH_PARAMETERS',   `/etc/mail/tls/sendmail-common.prm')dnl
define(`confTLS_SRV_OPTIONS', `V')dnl
