# == Class: shinken::defaults::method_acl
#
# This class exists to provide some default settings that can be merged into
# other hashes within the shinken class.
#
# == Authors
#
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class shinken::defaults {
  $method_acl = {
    'method' => {
      'file' => {
        'enable'    => false,
        'user_file' => '/etc/httpd/conf.d/shinken/.htdigest'
      },
      'ldap' => {
        'enable'      => false,
        'url'         => hiera('ldap::uri'),
        'security'    => 'STARTTLS',
        'binddn'      => hiera('ldap::bind_dn'),
        'bindpw'      => hiera('ldap::bind_pw'),
        'search'      => inline_template('ou=People,<%= scope.function_hiera(["basedn"]) %>"'),
        'posix_group' => true
      }
    },
    'limits' => {
      'defaults'  => [ 'GET', 'POST', 'PUT' ],
      'hosts'     => {
        '127.0.0.1' => 'defaults',
        "${::fqdn}" => 'defaults'
      }
    }
  }
}
