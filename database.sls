{%- from "opencontrail/map.jinja" import database with context %}
{%- if database.enabled %}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisord-contrail-database.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}