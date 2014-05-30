
include:
{% if pillar.opencontrail.collector is defined %}
- opencontrail.collector
{% endif %}
{% if pillar.opencontrail.compute is defined %}
- opencontrail.compute
{% endif %}
{% if pillar.opencontrail.config is defined %}
- opencontrail.config
{% endif %}
{% if pillar.opencontrail.control is defined %}
- opencontrail.control
{% endif %}
{% if pillar.opencontrail.database is defined %}
- opencontrail.database
{% endif %}