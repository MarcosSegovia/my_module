##my_module 

A Puppet Module

##What does this module provision to your Machine?

###Installs:

- Apache listening in port 80
- MySQL with a database 'mpwar_test' as example (root password 'vagrantpass')
- PHP 5.6.x, last version
- Memcached
- Yum repositories

###Sets:

- Hosts mysql1 and memcached1 to point localhost
- Apache VirtualHost centos.dev and project1.dev
- A couple of index.php files in centos.dev and project1.dev