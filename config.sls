{%- from "opencontrail/map.jinja" import config with context %}
{%- if config.enabled %}

opencontrail_config_packages:
  pkg.installed:
  - names: {{ config.pkgs }}
  - require:
    - pkgrepo: opencontrail_repo

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-config.override:
  file.managed:
  - contents: 'manual'

/etc/init/neutron-server.override:
  file.managed:
  - contents: 'manual'

{% endif %}

setup_api_venv:
  cmd.run:
  - name: cd /opt/contrail/api-venv/archive; source ../bin/activate && pip install *
  - onlyif: test -e /opt/contrail/api-venv/lib/python2.7/site-packages/cfgm_common

{%- endif %}