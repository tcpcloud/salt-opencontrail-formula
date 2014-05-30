{%- from "opencontrail/map.jinja" import control with context %}
{%- if control.enabled %}

{% if grains.os_family == 'Debian' %}

opencontrail_control_packages:
  pkg.installed:
  - names: {{ control.pkgs }}

/etc/init/supervisor-control.override:
  file.managed:
  - contents: 'manual'

/etc/init/supervisor-dns.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}