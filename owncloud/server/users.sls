{%- from "owncloud/map.jinja" import server with context %}

{%- for name, user in server.users.iteritems() %}

{%- if user.enabled %}

owncloud_user_{{ name }}:
  cmd.run:
  - name: "php occ user:add --no-interaction --password-from-env --display-name '{{ user.name }}' {% if user.group is defined %}-g '{{ user.group }}'{% endif %} {{ name }}"
  - cwd: /var/www/owncloud
  - user: {{ server.user }}
  - shell: /bin/sh
  - onlyif: "php occ user:lastseen {{ name }} | grep 'User does not exist'"
  - env:
    - OC_PASS: "{{ user.password }}"
  - require:
    - service: apache_service

{% else %}

owncloud_user_{{ name }}:
  cmd.run:
  - name: "php occ user:delete --no-interaction '{{ user.name }}'"
  - cwd: /var/www/owncloud
  - user: {{ server.user }}
  - shell: /bin/sh
  - unless: "php occ user:lastseen {{ name }} | grep 'User does not exist'"
  - require:
    - service: apache_service

{% endif %}

{%- endfor %}
