# Class: add_rsa_keys
#
# This module manages add_rsa_keys
#
# Parameters: $user (user name)
#             $rsa_key_hash (hash array containing rsa keys)
#             hiera structure example
#
#             rsa_keys_array:
#                keylabel1:
#                    - key: <put your rsa pub key here>
#                 keylabel2:
#                    - key: <put your rsa pub key here>
#             $purge (purge existent rsa keys from user if true)
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage: class {'rsa_keys':
#                  user         => 'root',
#                  rsa_key_hash => hiera_hash('root_pub_key'),
#                  purge        => true,
#               }
#

class rsa_keys ($user='root', $rsa_key_hash='', $purge=true){
##
#
# Check user and purge ssh key if requested
#
##
if $user=='root' {
    user { $user:
                ensure         => present,
                home           => '/root',
                uid            => '0',
                purge_ssh_keys => $purge,
        }
} else {
  user { $user:
          ensure         => present,
          home           => '/home/$user',
          purge_ssh_keys => $purge,
  }
}
##
#
# Add all root rsa keys from hiera
#
##

$defaults = {
  ensure => 'present',
  user   => 'root',
  'type'   => 'ssh-rsa',
}
#create_resources(ssh_authorized_key, hiera_hash('root_pub_key'), $defaults)
create_resources(ssh_authorized_key, $rsa_key_hash, $defaults)
}
