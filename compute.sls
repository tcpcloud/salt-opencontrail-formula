{%- from "opencontrail/map.jinja" import compute with context %}
{%- if compute.enabled %}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-analytics.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}