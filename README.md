# OpenContrail

Contrail Controller is an open, standards-based software solution that delivers network virtualization and service automation for federated cloud networks. It provides self-service provisioning, improves network troubleshooting and diagnostics, and enables service chaining for dynamic application environments across enterprise virtual private cloud (VPC), managed Infrastructure as a Service (IaaS), and Networks Functions Virtualization (NFV) use cases. 

## Sample pillar

### Contrail Configuration node

    opencontrail:
      configuration:
        enabled: True

### Contrail Control node

    opencontrail:
      control:
        enabled: True

### Contrail Analytics node

    opencontrail:
      analytics:
        enabled: True
        
### Contrail Vrouter

    opencontrail:
      vrouter:
        enabled: True

## Read more

* http://opencontrail.org
* http://juniper.github.io/contrail-vnc/README.html
* http://www.juniper.net/techpubs/en_US/contrail1.0/information-products/topic-collections/release-notes/index.html
* http://www.juniper.net/support/downloads/?p=contrail#sw
