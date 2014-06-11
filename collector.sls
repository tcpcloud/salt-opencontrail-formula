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
  - onlyif: test -e /opt/contrail/analytics-venv/lib/python2.7/site-packages/cfgm_common

{%- endif %}