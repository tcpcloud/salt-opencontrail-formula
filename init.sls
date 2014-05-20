
include:
- opencontrail.common
{% if pillar.opencontrail.configuration is defined %}
- opencontrail.configuration
{% endif %}
{% if pillar.opencontrail.control is defined %}
- opencontrail.control
{% endif %}
{% if pillar.opencontrail.analytics is defined %}
- opencontrail.analytics
{% endif %}