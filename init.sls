
include:
{% if pillar.opencontrail.configuration is defined %}
- opencontrail.configuration
{% endif %}
{% if pillar.opencontrail.control is defined %}
- opencontrail.control
{% endif %}
{% if pillar.opencontrail.analytics is defined %}
- opencontrail.analytics
{% endif %}
{% if pillar.opencontrail.vrouter is defined %}
- opencontrail.vrouter
{% endif %}