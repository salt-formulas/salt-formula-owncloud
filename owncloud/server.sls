{% from "owncloud/map.jinja" import server with context %}

{%- if server.enabled %}

include:
- apache
{%- if server.cache.enabled and server.cache.engine == 'memcache' %}
- memcached
{%- endif %}

owncloud_packages:
  pkg.installed:
  - names: {{ server.pkgs }}
  - watch_in:
    - service: apache_service

{# We are going to manage apache config on our own #}
owncloud_apache_purge:
  pkg.purged:
  - name: owncloud-config-apache
  - require:
    - pkg: owncloud_packages
  - watch_in:
    - service: apache_service

owncloud_config:
  file.managed:
  - name: /var/www/owncloud/config/config.php
  - source: salt://owncloud/files/config.php
  - template: jinja
  - require:
    - pkg: owncloud_packages
    {%- if server.cache.enabled and server.cache.engine == 'memcache' %}
    - service: memcached_service
    {%- endif %}
  - watch_in:
    - service: apache_service

{%- if server.logging.type == 'owncloud' %}
owncloud_log:
  file.managed:
    - name: {{ server.logging.file }}
    - owner: {{ server.user }}
    - group: adm
    - mode: 0640
{%- endif %}

{%- endif %}
