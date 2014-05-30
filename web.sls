{%- from "opencontrail/map.jinja" import web with context %}
{%- if web.enabled %}

opencontrail_web_packages:
  pkg.installed:
  - names: {{ web.pkgs }}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-webui.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}