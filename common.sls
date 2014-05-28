{%- if pillar.opencontrail.configuration is defined %}
{%- set neutron = pillar.opencontrail.configuration %}
{%- elif pillar.opencontrail.control is defined %}
{%- set neutron = pillar.opencontrail.control %}
{%- elif pillar.opencontrail.analytics is defined %}
{%- set neutron = pillar.opencontrail.analytics %}
{%- endif %}

{% if grains.os == 'Ubuntu' %}

{% endif %}

{% if grains.os_family == 'RedHat' %}

contrail_packages:
 pkg.installed:
 - names: 
   - wget

{% endif %}