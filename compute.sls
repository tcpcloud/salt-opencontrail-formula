{%- from "opencontrail/map.jinja" import compute with context %}
{%- if compute.enabled %}

include:
- opencontrail.common

opencontrail_compute_packages:
  pkg.installed:
  - names: {{ compute.pkgs }}


{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-vrouter.override:
  file.managed:
  - contents: 'manual'

{% endif %}

setup_compute_venv:
  cmd.run:
  - name: cd /opt/contrail/vrouter-venv/archive; source ../bin/activate && pip install *
  - unless: test -e /opt/contrail/vrouter-venv/lib/python2.7/site-packages/xmltodict
  - require:
    - pkg: opencontrail_compute_packages

/etc/contrail/vrouter_nodemgr_param:
  file.managed:
  - source: salt://opencontrail/conf/vrouter_nodemgr_param
  - template: jinja
  - require:
    - cmd: setup_compute_venv
    - pkg: opencontrail_compute_packages

/etc/contrail/default_pmac:
  file.managed:
  - source: salt://opencontrail/conf/default_pmac
  - template: jinja
  - require:
    - cmd: setup_compute_venv
    - pkg: opencontrail_compute_packages

/etc/contrail/agent_param:
  file.managed:
  - source: salt://opencontrail/conf/agent_param
  - template: jinja
  - require:
    - cmd: setup_compute_venv
    - pkg: opencontrail_compute_packages

/etc/contrail/agent.conf:
  file.managed:
  - source: salt://opencontrail/conf/agent.conf
  - template: jinja
  - require:
    - cmd: setup_compute_venv
    - pkg: opencontrail_compute_packages
{#
/etc/sysconfig/network-scripts/ifcfg-{{ compute.interface.dev }}:
  file.managed:
  - source: salt://opencontrail/conf/ifcfg-dev
  - template: jinja
  - require:
    - cmd: setup_compute_venv
    - pkg: opencontrail_compute_packages
#}

/etc/sysconfig/network-scripts/ifcfg-vhost0:
  file.managed:
  - source: salt://opencontrail/conf/ifcfg-vhost0
  - template: jinja
  - require:
    - cmd: setup_compute_venv
    - pkg: opencontrail_compute_packages

opencontrail_compute_services:
  service.enabled:
  - names: {{ compute.services }}

{%- endif %}