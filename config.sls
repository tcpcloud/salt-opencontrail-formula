{%- from "opencontrail/map.jinja" import config with context %}
{%- if config.enabled %}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisord-contrail-database.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}