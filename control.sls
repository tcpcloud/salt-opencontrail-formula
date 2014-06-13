{%- from "opencontrail/map.jinja" import control with context %}
{%- if control.enabled %}

include:
- opencontrail.common

fs.file-max:
  sysctl.present:
  - value: 65535

security_limits_conf:
  cmd.run:
  - names:
    - sed -i '/^root\s*soft\s*nproc\s*.*/d' /etc/security/limits.conf && printf "root soft nproc 65535\n" >> /etc/security/limits.conf
    - sed -i '/^*\s*hard\s*nofile\s*.*/d' /etc/security/limits.conf && printf "* hard nofile 65535\n" >> /etc/security/limits.conf
    - sed -i '/^*\s*soft\s*nofile\s*.*/d' /etc/security/limits.conf && printf "* soft nofile 65535\n" >> /etc/security/limits.conf
    - sed -i '/^*\s*hard\s*nproc\s*.*/d' /etc/security/limits.conf && printf "* hard nproc 65535\n" >> /etc/security/limits.conf
    - sed -i '/^*\s*soft\s*nproc\s*.*/d' /etc/security/limits.conf && printf "* soft nofile 65535\n" >> /etc/security/limits.conf
  - onlyif: test -e /etc/security/limits.conf

opencontrail_control_packages:
  pkg.installed:
  - names: {{ control.pkgs }}
  - require:
    - pkgrepo: opencontrail_repo

setup_control_venv:
  cmd.run:
  - name: cd /opt/contrail/control-venv/archive; source ../bin/activate && pip install *
  - unless: test -e /opt/contrail/control-venv/lib/python2.7/site-packages/xmltodict

/etc/irond/basicauthusers.properties:
  file.managed:
  - source: salt://opencontrail/conf/basicauthusers.properties
  - template: jinja
  - require:
    - cmd: setup_control_venv

/etc/contrail/control_param:
  file.managed:
  - source: salt://opencontrail/conf/control_param
  - template: jinja
  - require:
    - cmd: setup_control_venv

/etc/contrail/dns_param:
  file.managed:
  - source: salt://opencontrail/conf/dns_param
  - template: jinja
  - require:
    - cmd: setup_control_venv

/etc/contrail/provision_vrouter.py:
  file.managed:
  - source: salt://opencontrail/conf/provision_vrouter.py
  - mode: 755
  - require:
    - cmd: setup_api_venv

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-control.override:
  file.managed:
  - contents: 'manual'

/etc/init/supervisor-dns.override:
  file.managed:
  - contents: 'manual'

{% endif %}

opencontrail_control_services:
  service.running:
  - enable: true
  - names: {{ control.services }}

{%- endif %}