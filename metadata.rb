maintainer        "Malte Swart"
maintainer_email  "chef@malteswart.de"
license           "Apache 2.0"
description       "Installs/configurates kerberos v5 (krb5)"
version           "1.0.0"

recipe "krb5", "Installs krb5-library and configurates /etc/krb5.conf"
recipe "krb5::utils", "Install kerberos user tools, such as kinit and kdestroy"

%w{ ubuntu }.each do |os|
  supports os
end
