# Host Discovery

```bash
#!/bin/bash

for i in $(seq 1 254); do
    timeout 1 bash -c "ping -c 1 192.168.1.$i" &> /dev/null && echo "[+] HOST 192.168.1.$i - ACTIVE" &
done; wait
```
Ajustar la IP en cada caso!!
Dependiendo de como sea vuestra IP y situación.
