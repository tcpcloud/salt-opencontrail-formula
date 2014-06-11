{%- from "opencontrail/map.jinja" import database with context %}
{%- if database.enabled %}

include:
- opencontrail.common

opencontrail_database_packages:
  pkg.installed:
  - names: {{ database.pkgs }}
  - require:
    - pkgrepo: opencontrail_repo

{% if grains.os_family == 'Debian' %}

/etc/init/supervisord-contrail-database.override:
  file.managed:
  - contents: 'manual'

{% endif %}

/etc/cassandra/conf/cassandra.yaml:
  file.managed:
  - source: salt://opencontrail/conf/cassandra.yaml
  - template: jinja
  - require:
    - pkg: opencontrail_database_packages

opencontrail_database_services:
  service.running
  - enable: true
  - names: {{ database.services }}
  - watch: 
    - file: /etc/cassandra/conf/cassandra.yaml

{%- endif %}