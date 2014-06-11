{%- from "opencontrail/map.jinja" import web with context %}
{%- if web.enabled %}

include:
- opencontrail.common

opencontrail_web_packages:
  pkg.installed:
  - names: {{ web.pkgs }}
  - require:
    - pkgrepo: opencontrail_repo

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-webui.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{}

{%- endif %}