# Installing dependencies #

## Install bundler and recipes ##

    gem install bundler
    bundle install
    librarian-chef install

## Install VirtualBox ##
Installer can be download from <https://www.virtualbox.org/wiki/Downloads>

## Install vagrant  ##
Install vagrant from this link:
<http://www.vagrantup.com/downloads.html>. Then install plugin:

    vagrant plugin install vagrant-omnibus

# Running #

    vagrant up

It will take a while for the first time - it downloads Ubuntu image,
builds Ruby, installs all required libraries etc. Now you can use the
VM:

    > vagrant ssh
    Last login: Tue May 20 13:52:38 2014 from 10.0.2.2
    mongo vagrant@vagrant:~$ mongo --version
    MongoDB shell version: 2.4.9
    vagrant@vagrant:~$ node -v
    v0.10.28
    vagrant@vagrant:~$ npm -v
    1.4.9
    vagrant@vagrant:~$ ruby -v
    ruby 2.0.0p481 (2014-05-08 revision 45883) [x86_64-linux]
    vagrant@vagrant:~$ nginx  -v
    nginx version: nginx/1.4.6 (Ubuntu)

Now you can use that machine to deploy
