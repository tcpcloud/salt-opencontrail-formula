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

{%- endif %}

/etc/contrail:
  file.directory

/etc/contrail/service.token:
  file.managed:
  - contents: "{{ common.identity.token }}"
  - require:
  	- file: /etc/contrail