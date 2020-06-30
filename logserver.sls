cmd.run:
- name: curl -sS -O http://10.0.6.55/nagioslogserver/scripts/setup-linux.sh
- cwd: /

addDataToLogserver:
cmd.run:
- name: sudo bash setup-linux.sh -s 10.0.6.55 -p 5544
- cwd: /
