{%- from "owncloud/map.jinja" import server with context -%}
<?php
$CONFIG = array (
  'instanceid' => '{{ server.instanceid }}',
  'passwordsalt' => '{{ server.passwordsalt }}',
  'secret' => '{{ server.secret }}',
  'trusted_domains' =>
  array (
    {%- if server.trusted_domains is defined %}
    {%- for domain in server.trusted_domains %}
    {{ loop.index0 }} => '{{ domain }}',
    {%- endfor %}
    {%- else %}
    0 => '{{ grains.fqdn }}'
    {%- endif %}
  ),
  'datadirectory' => '{{ server.data }}',
  'overwrite.cli.url' => '{{ server.url }}',
  'version' => '{{ server.version }}',
  'updatechecker' => {{ server.updatechecker }},
  'dbtype' => '{{ server.database.type }}',
  'dbname' => '{{ server.database.name }}',
  'dbhost' => '{{ server.database.host }}',
  'dbtableprefix' => 'oc_',
  'dbuser' => '{{ server.database.user }}',
  'dbpassword' => '{{ server.database.password }}',
  'installed' => true,
  {%- if server.cache.enabled %}
  {%- if server.cache.engine == 'memcache' %}
  'memcache.local' => '\\OC\\Memcache\\Memcached',
  'memcached_servers' =>
  array (
    {%- for cache_server in server.cache.servers %}
    {{ loop.index0 }} =>
    array (
      0 => '{{ cache_server.address }}',
      1 => {{ cache_server.get('port', 11211) }},
    ),
    {%- endfor %}
  ),
  {%- endif %}
  {%- endif %}
  'log_type' => '{{ server.logging.type }}',
  'loglevel' => {{ server.logging.level }},
  'logtimezone' => '{{ server.logging.timezone }}',
  {%- if server.logging.type == 'owncloud' %}
  'logfile' => '{{ server.logging.file }}',
  {%- endif %}
  {%- if server.mail.domain is defined %}
  'mail_domain' => '{{ server.mail.domain }}',
  {%- else %}
  'mail_domain' => '{{ grains.domain }}',
  {%- endif %}
  'mail_smtpmode' => '{{ server.mail.mode }}',
  'mail_from_address' => '{{ server.mail.from }}',
  'appstoreenabled' => {{ server.appstore.enabled }},
  'appstoreurl' => '{{ server.appstore.url }}',
  'appstore.experimental.enabled' => {{ server.appstore.experimental }},
  'asset-pipeline.enabled' => true,
  'config_is_read_only' => true,
);
