{%- from "opencontrail/map.jinja" import web with context %}
{%- if web.enabled %}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-webui.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}