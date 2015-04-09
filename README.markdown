# rsa_keys  #

This module let provide a wrapper for user rsa_keys management.
If user is present check its rsa keys and if passed array differ add missing keys.
If purge flag is on and actual keys differ from the ones passed via rsa_key_hash, installed keys missing will be removed.

install
--
> puppet module install siliconfrog-rsa_keys

Simple usage:
----------------
declare class in your manifests
> class {'rsa_keys': 
>				user         => 'root',
>				rsa_key_hash => hiera_hash('root_pub_key'),
>				purge        => true,
>            }

and put your keys data in an associative array or in a hiera structure like this:

> root_pub_key:
>  keylabel1:
>   - key: <put your rsa pub key here>
>  keylabel2:
>   - key: <put your rsa pub key here>
