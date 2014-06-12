{%- from "opencontrail/map.jinja" import collector with context %}
{%- if collector.enabled %}

include:
- opencontrail.common

opencontrail_collector_packages:
  pkg.installed:
  - names: {{ collector.pkgs }}
  - require:
    - pkgrepo: opencontrail_repo

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-analytics.override:
  file.managed:
  - contents: 'manual'

{% endif %}

setup_analytics_venv:
  cmd.run:
  - name: cd /opt/contrail/analytics-venv/archive; source ../bin/activate && pip install *
  - unless: test -e /opt/contrail/analytics-venv/lib/python2.7/site-packages/cfgm_common

/etc/contrail/vizd_param:
  file.managed:
  - source: salt://opencontrail/conf/vizd_param
  - template: jinja
  - require:
    - cmd: setup_analytics_venv

/etc/contrail/qe_param:
  file.managed:
  - source: salt://opencontrail/conf/qe_param
  - template: jinja
  - require:
    - cmd: setup_analytics_venv

/etc/contrail/opserver_param:
  file.managed:
  - source: salt://opencontrail/conf/opserver_param
  - template: jinja
  - require:
    - cmd: setup_analytics_venv

opencontrail_collector_services:
  service.running:
  - enable: true
  - names: {{ collector.services }}

{%- endif %}