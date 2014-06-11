{%- from "opencontrail/map.jinja" import control with context %}
{%- if control.enabled %}

include:
- opencontrail.common

fs.file-max:
  sysctl.present:
  - value: 65535

opencontrail_control_packages:
  pkg.installed:
  - names: {{ control.pkgs }}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-control.override:
  file.managed:
  - contents: 'manual'

/etc/init/supervisor-dns.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}