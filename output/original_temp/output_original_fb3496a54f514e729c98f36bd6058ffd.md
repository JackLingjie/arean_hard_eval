**Tailscale ACL Configuration**

The following configuration defines three groups: `nill`, `family`, and `servers`. Each group has specific permissions:

### Group Definitions

```yml
# Define groups
groups:
  - name: nill
    description: Full access to all servers

  - name: family
    description: Exit-node access only

  - name: servers
    description: Limited access to specific ports
```

### Group Permissions

```yml
# Define permissions for each group
permissions:
  - group: nill
    allow:
      - rule: allow all
        from: all
        to: all
        ports: all

  - group: family
    allow:
      - rule: allow exit-node
        from: all
        to: all
        ports: all

  - group: servers
    allow:
      - rule: allow tcp 22,80,443
        from: all
        to: all
        ports: 22,80,443

  - group: servers
    deny:
      - rule: deny all
        from: all
        to: all
        ports: all
        except: tcp 22,80,443
```

### Explanation

- **`nill` Group**: Has full access to all servers on all ports.
- **`family` Group**: Can use any server as an exit node but does not have access to services on network servers.
- **`servers` Group**: Can access ports 22/tcp, 80/tcp, and 443/tcp on all servers. All other ports and protocols are denied.