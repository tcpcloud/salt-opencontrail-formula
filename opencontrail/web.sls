{%- from "opencontrail/map.jinja" import web with context %}
{%- if web.enabled %}

include:
- opencontrail.common

opencontrail_web_packages:
  pkg.installed:
  - names: {{ web.pkgs }}
  - require:
    - pkgrepo: opencontrail_repo

/etc/contrail/config.global.js:
  file.managed:
  - source: salt://opencontrail/conf/config.global.js
  - template: jinja
  - require:
    - pkg: opencontrail_web_packages

opencontrail_web_services:
  service.running:
  - enable: true
  - names: {{ web.services }}
  - watch: 
    - file: /etc/contrail/config.global.js

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-webui.override:
  file.managed:
  - contents: 'manual'

{% endif %}


{%- endif %}