#
# Cookbook Name:: krb5
# Attributes:: kdc-ldap
#
# Author:: Malte Swart (<chef@malteswart.de>)
#
# Copyright 2013, Malte Swart
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

openldap_ldapconf = default['krb5']['dbmodules']['openldap_ldapconf']

if node['domain'] && node['domain'].length > 0
  basedn = "dc=#{node['domain'].split('.').join(",dc=")}"
  openldap_ldapconf['ldap_servers'] = 'ldaps://ldap.' + node['domain']
else
  basedn = 'dc=domain,dc=local'
  openldap_ldapconf['ldap_servers'] = 'ldaps://ldap.domain.local'
end

default['krb5']['dbdefaults']['ldap_kerberos_container_dn'] = basedn
openldap_ldapconf['db_library'] = 'kldap'
openldap_ldapconf['ldap_service_password_file'] = '/etc/krb5kdc/service.keyfile'
openldap_ldapconf['ldap_kdc_dn'] = 'cn=kdc,' + basedn
openldap_ldapconf['ldap_kadmind_dn'] = 'cn=kadmind,' + basedn
