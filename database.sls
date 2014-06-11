{%- from "opencontrail/map.jinja" import database with context %}
{%- if database.enabled %}

include:
- opencontrail.common

opencontrail_database_packages:
  pkg.installed:
  - names: {{ database.pkgs }}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisord-contrail-database.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}