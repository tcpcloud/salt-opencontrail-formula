{%- from "opencontrail/map.jinja" import common with context %}

{%- if grains.os_family == "RedHat" %}


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

/etc/modprobe.d/contrail.conf:
  file.managed:
  - contents: "alias bridge off"

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