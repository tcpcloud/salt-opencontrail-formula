{%- from "opencontrail/map.jinja" import collector with context %}
{%- if collector.enabled %}

include:
- opencontrail.common

opencontrail_collector_packages:
  pkg.installed:
  - names: {{ collector.pkgs }}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-analytics.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}