{%- from "opencontrail/map.jinja" import common with context %}

{%- if grains.os_family == 'Debian' %}

opencontrail_repo:
  pkgrepo.managed:
  - human_name: Contrail 
  - name: {{ common.source.address }}
  - file: /etc/apt/sources.list.d/contrail.list

{%- endif %}

{%- if grains.os_family == "RedHat" %}

opencontrail_repo:
  pkgrepo.managed:
  - name: contrail
  - humanname: Contrail
  - baseurl: {{ common.source.address }}
  - gpgcheck: 0

net.ipv4.ip_forward:
  sysctl.present:
  - value: 1

kernel.core_pattern:
  sysctl.present:
  - value: "/var/crashes/core.%e.%p.%h.%t"

sysconfig_init_conf_setup:
  cmd.run:
  - name: echo "DAEMON_COREFILE_LIMIT=\'unlimited\'" >> /etc/sysconfig/init
  - unless: grep DAEMON_COREFILE_LIMIT /etc/sysconfig/init

sysconfig_init_conf:
  cmd.run:
  - names:
    - sed -i "s/DAEMON_COREFILE_LIMIT=.*/DAEMON_COREFILE_LIMIT=\'unlimited\'/g" /etc/sysconfig/init
  - require:
    - cmd: sysconfig_init_conf_setup

/var/crashes:
  file.directory

iptables:
  service.dead:
  - enable: false
  - name: iptables

{%- endif %}

/etc/contrail:
  file.directory

/etc/contrail/service.token:
  file.managed:
  - contents: "{{ common.identity.token }}"
  - require:
    - file: /etc/contrail

/etc/contrail/ctrl-details:
  file.managed:
  - source: salt://opencontrail/conf/ctrl-details
  - template: jinja
  - require:
    - file: /etc/contrail