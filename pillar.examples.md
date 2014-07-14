
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
        bind:
          address: 192.168.0.1
        master:
          host: 192.168.0.1
        cache:
          engine: redis
          host: 127.0.0.1
          port: 6379
        members:
        - host: 192.168.0.1
          id: 1
        - host: 192.168.0.2
          id: 2
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
        bind:
          address: 192.168.0.1
        master:
          host: 192.168.0.1
        database:
          members:
          - host: 192.168.1.1
            port: 9160
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
       - host: 192.168.1.1
         port: 9160
        
### Contrail Vrouter on compute node

    opencontrail:
      compute:
        enabled: True
        discovery:
          host: 192.168.0.1
        interface:
          dev: p0p0p0 
          default_pmac: fa:16:3e:8c:89:8f
          address: 192.168.0.101
          gateway: 192.168.0.254
          mask: 24
          dns: 8.8.8.8
        control_instances: 3
