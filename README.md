Description
===========

Installs/configurates kerberos version 5. This cookbook uses the original MIT
kerberos implementation.


Requirements
============

Platform
--------

* Ubuntu

Might work on Debian, too. Only tested on Ubuntu 12.04 LTS.


Recipes
=======

default
-------

This recipe installs the kerberos library files and creates and manages the
krb5.conf configuration. It is needed for all other recipes.

See the [Attributes section](#krb5conf) for more information about the krb5.conf

utils
-----

This cookbook installs the kerberos programs like `kinit`, `klist`.


Attributes
==========

krb5.conf
---------

The `krb5.conf` is generated from the node attributes. Currently only two
features are not supported: including other files or directories and loading of
profile modules.

Every section is covered by an own hash under `node['krb5']`:

  * `node['krb5']['libdefaults']`: Contains various default values used by the
     Kerberos V5 library.
  * `node['krb5']['login`: Contains default values used by the Kerberos V5 login
     program, `login.krb5(8)`.
  * `node['krb5']['appdefaults']`: Contains default values that can be used by
     Kerberos V5 applications.
  * `node['krb5']['realms']`: Contains subsections keyed by Kerberos realm names
     which describe where to find the Kerberos servers for a particular realm,
     and other realm-specific information.
  * `node['krb5']['domain_realm']`: Contains relations which map subdomains and
     domain names to Kerberos realm names.  This is used by programs to
     determine what realm a host should be in, given its fully qualified domain
     name.
  * `node['krb5']['logging']`: Contains relations which determine how Kerberos
     entities are to perform their logging.
  * `node['krb5']['capaths']`: Contains the authentication paths used with
     non-hierarchical cross-realm. Entries in the section are used by the client
     to determine the intermediate realms which may be used in cross-realm
     authentication. It is also used by the end-service when checking the
     transited field for trusted intermediate realms.
  * `node['krb5']['dbdefaults]']`: Contains default values for database specific
     parameters.
  * `node['krb5']['dbmodules']`: Contains database specific parameters used by
     the database library.
  * `node['krb5']['plugins']`: Contains plugin module registration and filtering
     parameters.

Use the tag as key inside the hash.

`true`, `false`, Integers and Strings as value are supported. To set multiple
values for a tag use an array (multiple lines will be generated). Use a subhash
to generate a subsection. All tags which have `nil` as value will be ignored. So
previous setted options can be removed (e.g. in overwrite_attributes).

Please read the `krb5.conf(5)` man page for more information about the syntax
and a list about a supported options.
