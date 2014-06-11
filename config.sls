{%- from "opencontrail/map.jinja" import config with context %}
{%- if config.enabled %}

include:
- opencontrail.common

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

/etc/contrail/api_server.conf:
  file.managed:
  - source: salt://opencontrail/conf/api_server.conf
  - template: jinja
  - require:
    - cmd: setup_api_venv

/etc/contrail/schema_transformer.conf:
  file.managed:
  - source: salt://opencontrail/conf/schema_transformer.conf
  - template: jinja
  - require:
    - cmd: setup_api_venv

/etc/contrail/svc_monitor.conf:
  file.managed:
  - source: salt://opencontrail/conf/svc_monitor.conf
  - template: jinja
  - require:
    - cmd: setup_api_venv

/etc/contrail/discovery.conf:
  file.managed:
  - source: salt://opencontrail/conf/discovery.conf
  - template: jinja
  - require:
    - cmd: setup_api_venv

/etc/contrail/supervisord_config_files:
  file.recurse:
  - source: salt://opencontrail/conf/config

/etc/init.d/contrail-api:
  file.managed:
  - source: salt://opencontrail/conf/contrail-api
  - mode: 755
  - require:
    - cmd: setup_api_venv

/etc/init.d/contrail-discovery:
  file.managed:
  - source: salt://opencontrail/conf/contrail-discovery
  - mode: 755
  - require:
    - cmd: setup_api_venv

{%- endif %}