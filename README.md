# OpenContrail

Contrail Controller is an open, standards-based software solution that delivers network virtualization and service automation for federated cloud networks. It provides self-service provisioning, improves network troubleshooting and diagnostics, and enables service chaining for dynamic application environments across enterprise virtual private cloud (VPC), managed Infrastructure as a Service (IaaS), and Networks Functions Virtualization (NFV) use cases. 

## Sample pillar

### Contrail Configuration node

    opencontrail:
      common:
        source:
          engine: pkg
          address: http://mirror.robotice.cz/contrail-havana/
      config:
        enabled: True
        cache:
          engine: redis
          host: 127.0.0.1
          port: 6379
        identity:
          engine: keystone
          host: 127.0.0.1
          port: 35357
          user: nova
          password: pwd
          token: service_token
          tenant: service

### Contrail Control node

    opencontrail:
      control:
        enabled: True

### Contrail Analytics node

    opencontrail:
      collector:
        enabled: True
      database:
        enabled: True
        
### Contrail Vrouter on compute node

    opencontrail:
      compute:
        enabled: True

## Read more

* http://opencontrail.org
* http://juniper.github.io/contrail-vnc/README.html
* http://www.juniper.net/techpubs/en_US/contrail1.0/information-products/topic-collections/release-notes/index.html
* http://www.juniper.net/support/downloads/?p=contrail#sw
