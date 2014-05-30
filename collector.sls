{%- from "opencontrail/map.jinja" import collector with context %}
{%- if collector.enabled %}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-analytics.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}