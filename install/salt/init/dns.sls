# add records to /etc/hosts file

# get master(manage01) ip address
{% if "manage" in grains['id'] %}
{% set hostip = pillar['vip'] %}
rbd-repo-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - lang.goodrain.me
      - maven.goodrain.me

kube-apiserver-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - kubeapi.goodrain.me

rbd-api-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - region.goodrain.me

rbd-registry-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - goodrain.me

rbd-app-ui-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - console.goodrain.me

{% else %}
# Todo:support VIP
{% set hostip = pillar['vip'] %}
{% set localip = grains['mip'][0] %}

rbd-repo-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - lang.goodrain.me
      - maven.goodrain.me

kube-apiserver-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - kubeapi.goodrain.me

rbd-api-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - region.goodrain.me

rbd-registry-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - goodrain.me

rbd-app-ui-domain:
  host.present:
    - ip: {{ hostip }}
    - names:
      - console.goodrain.me


hostname-domain:
  host.present:
    - ip: {{ localip }}
    - names:
      - {{ grains['id'] }}

uuid-domain:
  host.present:
    - ip: {{ localip }}
    - names:
      - {{ grains['uuid'] }}


{% endif %}

# Modify /etc/resolv.conf
/etc/resolv.conf:
  file.append:
    - text:
      - "nameserver {{ pillar.dns.master }}"

# 注释domain search
domain-resolv:
  file.replace:
    - name: /etc/resolv.conf
    - pattern: "^domain"
    - repl: "# domain"

search-resolv:
  file.replace:
    - name: /etc/resolv.conf
    - pattern: "^search"
    - repl: "# search"