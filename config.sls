{%- from "opencontrail/map.jinja" import config with context %}
{%- if config.enabled %}

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-config.override:
  file.managed:
  - contents: 'manual'

/etc/init/neutron-server.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}