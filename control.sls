{%- from "opencontrail/map.jinja" import control with context %}
{%- if control.enabled %}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-analytics.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}