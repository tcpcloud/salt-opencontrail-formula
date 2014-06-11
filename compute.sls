{%- from "opencontrail/map.jinja" import compute with context %}
{%- if compute.enabled %}

include:
- opencontrail.common

opencontrail_compute_packages:
  pkg.installed:
  - names: {{ compute.pkgs }}
  - require:
    - pkgrepo: opencontrail_repo

{% if grains.os_family == 'Debian' %}

/etc/init/supervisor-vrouter.override:
  file.managed:
  - contents: 'manual'

{% endif %}

setup_compute_venv:
  cmd.run:
  - name: cd /opt/contrail/vrouter-venv/archive; source ../bin/activate && pip install *
  - onlyif: test -e /opt/contrail/vrouter-venv/lib/python2.7/site-packages/xmltodict

{%- endif %}