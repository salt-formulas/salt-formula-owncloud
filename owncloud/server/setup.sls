{% from "owncloud/map.jinja" import server with context %}

owncloud_install:
  cmd.run:
  - name: "php occ maintenance:install --no-interaction --database {{ server.database.type }} --database-host {{ server.database.host }} --database-name {{ server.database.name }} --database-user {{ server.database.user }} --database-pass {{ server.database.password }} --admin-user {{ server.admin.username }} --admin-pass {{ server.admin.password }} --data-dir {{ server.data }}"
  - cwd: /var/www/owncloud
  - user: {{ server.user }}
  - shell: /bin/sh
  - creates: /var/www/owncloud/config/config.php
  - require:
    - pkg: owncloud_packages

owncloud_cron:
  cron.present:
    - name: "php -f /var/www/owncloud/cron.php > /dev/null 2>&1"
    - user: {{ server.user }}
    - minute: "*/15"
    - require:
      - pkg: owncloud_packages

owncloud_cron_setup:
  cmd.run:
  - name: "php occ background:cron && touch /var/www/owncloud/config/.background_cron"
  - cwd: /var/www/owncloud
  - user: {{ server.user }}
  - shell: /bin/sh
  - creates: /var/www/owncloud/config/.background_cron
  - require:
    - service: apache_service
    - cron: owncloud_cron
