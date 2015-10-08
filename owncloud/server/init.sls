{%- from "owncloud/map.jinja" import server with context %}

{%- if server.enabled %}

include:
- owncloud.server.setup
- apache
{%- if server.cache.enabled and server.cache.engine == 'memcache' %}
- memcached

owncloud_php5_memcached:
  pkg.installed:
    - name: php5-memcached
    - watch_in:
      - service: apache_service
{%- endif %}

{%- if server.addrepo and grains['os_family'] == 'Debian' %}

owncloud_repo:
  pkgrepo.managed:
    - name: {{ server.pkg_repo }}
    - file: {{ server.repo_file }}
    - key_url: {{ server.key_url }}
    - require_in:
      - pkg: owncloud_packages

{%- endif %}

owncloud_data:
  file.managed:
    - name: {{ server.data }}
    - owner: {{ server.user }}
    - group: {{ server.user }}
    - mode: 770
    - require:
      - pkg: owncloud_packages

owncloud_packages:
  pkg.installed:
  - names: {{ server.pkgs }}
  - watch_in:
    - service: apache_service

{# We are going to manage apache config on our own #}
owncloud_apache_remove:
  file.absent:
  - name: /etc/apache2/conf-enabled/owncloud.conf
  - require:
    - pkg: owncloud_packages
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
