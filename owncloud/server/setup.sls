{%- from "owncloud/map.jinja" import server with context %}

{%- if server.users is defined %}
include:
- owncloud.server.users
{%- endif %}

owncloud_install:
  cmd.run:
  - name: "php occ maintenance:install --no-interaction --database {{ server.database.type }} --database-host {{ server.database.host }} --database-name {{ server.database.name }} --database-user {{ server.database.user }} --database-pass {{ server.database.password }} --admin-user {{ server.admin.username }} --admin-pass {{ server.admin.password }} --data-dir {{ server.data }}"
  - cwd: /var/www/owncloud
  - user: {{ server.user }}
  - shell: /bin/sh
  - creates: /var/www/owncloud/config/config.php
  - require:
    - pkg: owncloud_packages

owncloud_config:
  file.managed:
  - name: /var/www/owncloud/config/config.php
  - source: salt://owncloud/files/config.php
  - template: jinja
  - user: www-data
  - group: root
  - mode: 0640
  - require:
    - cmd: owncloud_install
    {%- if server.cache.enabled and server.cache.engine == 'memcache' %}
    - service: memcached_service
    {%- endif %}
  - watch_in:
    - service: apache_service

owncloud_cron:
  cron.present:
    - name: "php -f /var/www/owncloud/cron.php > /dev/null 2>&1"
    - user: {{ server.user }}
    - minute: "*/15"
    - require:
      - pkg: owncloud_packages

owncloud_cron_setup:
  cmd.run:
  - name: "php occ background:cron --no-interaction && touch /var/www/owncloud/config/.background_cron"
  - cwd: /var/www/owncloud
  - user: {{ server.user }}
  - shell: /bin/sh
  - creates: /var/www/owncloud/config/.background_cron
  - require:
    - service: apache_service
    - cron: owncloud_cron
