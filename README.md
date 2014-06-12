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
        enabled: true
        id: 1
        identity:
          engine: keystone
          host: 127.0.0.1
          port: 35357
          token: service_token
          password: admin_password
        network:
          engine: neutron
          host: 127.0.0.1
          port: 9697
        bind:
          address: 192.168.0.1
        database:
          members:
          - host: 192.168.1.1
            port: 9160
        cache:
          host: 192.168.0.1
        identity:
          engine: keystone
          region: RegionOne
          host: 127.0.0.1
          port: 35357
          user: admin
          password: adminpwd
          token: service_token
          tenant: admin
        members:
        - host: 192.168.0.1
          id: 1
        - host: 192.168.0.2
          id: 2


### Contrail Config node

    opencontrail:
      common:
        source:
          engine: pkg
          address: http://mirror.robotice.cz/contrail-havana/
      control:
        enabled: true
        bind:
          address: 192.168.0.1
        master:
          host: 192.168.0.1
        members:
        - host: 192.168.0.1
          id: 1
        - host: 192.168.0.2
          id: 2


### Contrail WebUI node

    opencontrail:
      web:
        enabled: True
        cache:
          engine: redis
          host: 127.0.0.1
          port: 6379
        identity:
          engine: keystone
          host: 127.0.0.1
          port: 35357
          user: admin
          password: adminpwd
          token: service_token
          tenant: admin

### Contrail Analytics node

    opencontrail:
      collector:
        enabled: true
      database:
        enabled: true
        original_token: 0
        data_dirs:
        - /srv/cassandra/data
        bind:
          host: 0.0.0.0
          port: 9160
          rpc_port: 9300
        members:
        - host: 192.168.0.1
        
### Contrail Vrouter on compute node

    opencontrail:
      compute:
        enabled: True

## Read more

* http://opencontrail.org
* http://juniper.github.io/contrail-vnc/README.html
* http://www.juniper.net/techpubs/en_US/contrail1.0/information-products/topic-collections/release-notes/index.html
* http://www.juniper.net/support/downloads/?p=contrail#sw
