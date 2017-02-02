========
owncloud
========

Install and configure owncloud.

Available states
================

.. contents::
    :local:

``owncloud.server``
------------------

Setup owncloud server


Available metadata
==================

.. contents::
    :local:

``metadata.owncloud.server``
---------------------------

Setup owncloud server


Requirements
============

- linux
- mysql (for mysql backend)
- apache

Optional
--------

- memcached
- `glusterfs <https://github.com/tcpcloud/salt-glusterfs-formula>`_ (for clustered setup)

Configuration parameters
========================

For complete list of parameters, please check
``metadata/service/server.yml``

Example reclass
===============

.. code-block:: yaml

      classes:
        - system.linux.system.single
        - service.memcached.server.local
        - service.apache.server.single
        - service.mysql.server.single
        - service.owncloud.server
      params:
        salt_master_host: ${_param:reclass_config_master}
        mysql_admin_user: root
        mysql_admin_password: cloudlab
      parameters:
        owncloud:
          server:
            version: 8.1.5.2
            # pwgen -A 12 | head -1
            instanceid: iy5opia6chae
            # pwgen 31 | head -1
            passwordsalt: Een7riefohSahchaigh9ohcho6xoaFe
            # pwgen -y 49 | head -1
            secret: |
              "guth9kee1fe9hoo\g6oowei6er9aigohK=ieM4uvojaicha4a"
            url: "http://owncloud.lxc.eru"
            trusted_domains:
              - owncloud.lxc.eru
            mail:
              domain: lxc.eru
            database:
              password: eikaithiuka2iex1ChieYaGeiguqu0iw
            cache:
              enabled: true
              servers:
                - address: localhost
            admin:
              username: admin
              password: cloudlab
            users:
              test:
                enabled: true
                group: Users
                password: test
                name: Test user
            appstore:
              experimental: true
        mysql:
          server:
            ssl:
              enabled: false
            database:
              owncloud:
                encoding: UTF8
                locale: cs_CZ
                users:
                - name: owncloud
                  password: eikaithiuka2iex1ChieYaGeiguqu0iw
                  host: localhost
                  rights: all privileges
        apache:
          server:
            site:
              owncloud:
                enabled: true
                type: owncloud
                name: owncloud
                host:
                  Name: owncloud.lxc.eru


Read more
=========

- https://doc.owncloud.org/
- http://sabre.io/dav/service-discovery/

Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-owncloud/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-owncloud

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
