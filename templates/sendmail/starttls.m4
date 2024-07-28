dnl # To support shared keyfiles, we need them to be group readable
define(`confDONT_BLAME_SENDMAIL',dnl
	defn(`confDONT_BLAME_SENDMAIL')`,GroupReadableKeyFile')dnl

dnl # Set a more reasonable timeout on negotiation
define(`confTO_STARTTLS',     `2m')dnl

dnl # CA directory - CA certs should be herein
define(`confCACERT_PATH',     `/etc/ssl/certs')dnl

dnl # Server certificate/key
define(`confSERVER_CERT',     `{{ sendmail_ssl_cert }}')dnl
define(`confSERVER_KEY',      `{{ sendmail_ssl_key }}')dnl

dnl # Client certificate/key
define(`confCLIENT_CERT',     `{{ sendmail_ssl_cert }}')dnl
define(`confCLIENT_KEY',      `{{ sendmail_ssl_key }}')dnl

dnl # DH parameters
define(`confDH_PARAMETERS',   `/etc/mail/tls/sendmail-common.prm')dnl

dnl # Optional settings
define(`confTLS_SRV_OPTIONS', `V')dnl
