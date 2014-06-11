{%- from "opencontrail/map.jinja" import control with context %}
{%- if control.enabled %}

include:
- opencontrail.common

fs.file-max:
  sysctl.present:
  - value: 65535

net.ipv4.ip_forward:
  sysctl.present:
  - value: 1

kernel.core_pattern:
  sysctl.present:
  - value: "/var/crashes/core.%e.%p.%h.%t"

/var/crashes:
  file.directory

security_limits_conf:
  cmd.run:
  - names:
    - sed -i '/^root\s*soft\s*nproc\s*.*/d' /etc/security/limits.conf && printf "root soft nproc 65535\n" >> /etc/security/limits.conf
    - sed -i '/^*\s*hard\s*nofile\s*.*/d' /etc/security/limits.conf && printf "* hard nofile 65535\n" >> /etc/security/limits.conf
    - sed -i '/^*\s*soft\s*nofile\s*.*/d' /etc/security/limits.conf && printf "* soft nofile 65535\n" >> /etc/security/limits.conf
    - sed -i '/^*\s*hard\s*nproc\s*.*/d' /etc/security/limits.conf && printf "* hard nproc 65535\n" >> /etc/security/limits.conf
    - sed -i '/^*\s*soft\s*nproc\s*.*/d' /etc/security/limits.conf && printf "* soft nofile 65535\n" >> /etc/security/limits.conf
  - onlyif: test -e /etc/security/limits.conf

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

opencontrail_control_packages:
  pkg.installed:
  - names: {{ control.pkgs }}
  - require:
    - pkgrepo: opencontrail_repo

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-control.override:
  file.managed:
  - contents: 'manual'

/etc/init/supervisor-dns.override:
  file.managed:
  - contents: 'manual'

{% endif %}

{%- endif %}