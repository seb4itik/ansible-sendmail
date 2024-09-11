dnl # Set a more reasonable timeout on negotiation
define(`confTO_AUTH', `sendmail_mc_sasl_to_auth')dnl

dnl # Define the REALM passed to sasl
define(`confAUTH_REALM', `{{ sendmail_mc_sasl_realm }}')dnl

dnl # Available Authentication methods
define(`confAUTH_MECHANISMS', `{{ sendmail_mc_sasl_mechs }}')dnl

dnl # These, we will trust for relaying
TRUST_AUTH_MECH(`{{ sendmail_mc_sasl_mechs }}')dnl

dnl # Add EXTERNAL as an available & trusted mech (w/STARTTLS)
dnl # and allow sharing of /etc/sasldb(2) file, allow group read/write
define(`confAUTH_MECHANISMS', `EXTERNAL 'defn(`confAUTH_MECHANISMS'))dnl
TRUST_AUTH_MECH(`EXTERNAL')

dnl # To support some SASL use, we need the DB to be group readable
define(`confDONT_BLAME_SENDMAIL', defn(`confDONT_BLAME_SENDMAIL')`,GroupReadableSASLDBFile,GroupWritableSASLDBFile')dnl
