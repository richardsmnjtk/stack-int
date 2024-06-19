#!/bin/sh
eth_addr=$(cat /sys/class/net/*/address | tr '\n' ',')
mkdir -p /etc/os-net-config

# needed to handle where python lives
function get_python() {
  command -v python3 || command -v python2 || command -v python || exit 1
}

# Create an os-net-config mapping file, note this defaults to
# /etc/os-net-config/mapping.yaml, so we use that name despite
# rendering the result as json
echo '$node_lookup' | $(get_python) -c "
import json
import sys
import copy
from subprocess import PIPE, Popen
import yaml

def write_mapping_file(interface_mapping):
  with open('/etc/os-net-config/mapping.yaml', 'w') as f:
    yaml.safe_dump(interface_mapping, f,  default_flow_style=False)

# cast to lower case for MAC address match
eth_addr='$eth_addr'.lower()

input = sys.stdin.readline() or '{}'
data = json.loads(input)
for node in data:
  interface_mapping = {'interface_mapping':
                          copy.deepcopy(data[node])}
  if 'dmiString' in interface_mapping['interface_mapping']:
    del interface_mapping['interface_mapping']['dmiString']
  if 'id' in interface_mapping['interface_mapping']:
    del interface_mapping['interface_mapping']['id']

  # Match on mac addresses first - cast all to lower case
  lc_interface_mapping = copy.deepcopy(interface_mapping)
  for key,x in lc_interface_mapping['interface_mapping'].items():
    lc_interface_mapping['interface_mapping'][key] = x.lower()
  if any(x in eth_addr.split(',') for x in lc_interface_mapping['interface_mapping'].values()):
    write_mapping_file(lc_interface_mapping)
    break

  # If data contain dmiString and id keys, try to match node(group)
  if 'dmiString' in data[node] and 'id' in data[node]:
    ps = Popen([ 'dmidecode',
                 '--string', data[node].get('dmiString') ],
                 stdout=PIPE, universal_newlines=True)
    out, err = ps.communicate()
    # See LP#1816652
    if data[node].get('id').lower() == out.rstrip().lower():
      write_mapping_file(lc_interface_mapping)
      break
"
params:
  $node_lookup: {get_param: NetConfigDataLookup}




