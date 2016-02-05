owncloud:
  server:
    enabled: true
    pkg_repo: "deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/Debian_8.0/ /"
    key_url: "http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_8.0/Release.key"
    addrepo: true
    updatechecker: false
    # XXX: fix here on every update to generate correct config.php
    version: 8.1.5.2
    # pwgen -A 12 | head -1
    instanceid: do9axoifei6j
    # pwgen 31 | head -1
    passwordsalt: ohC5quohW5bahPhaeghie9Aireiweis
    # pwgen -y 49 | head -1
    secret: |
      "phe9aid1leithog2nu!d?oo6shehaep6zum/ei4ISh%a0ohha"
    url: "http://localhost"
    data: /var/www/owncloud/data
    trusted_domains:
        - localhost
    mail:
      domain: localdomain
      mode: php
      from: owncloud
    logging:
      level: 1
      type: owncloud
      file: /var/log/owncloud.log
      timezone: UTC
    database:
      type: mysql
      name: owncloud
      host: localhost
      user: owncloud
      password: password
    cache:
      enabled: false
      engine: memcache
      servers:
        - address: localhost
    admin:
      username: admin
      password: password
    users:
      test:
        enabled: true
        password: password
        name: John Doe
    appstore:
      enabled: true
      url: "https://api.owncloud.com/v1"
      experimental: true
apache:
  server:
    enabled: true
    modules:
      - xsendfile
      - php
