# Rsync

Herramienta rápida de copia de ficheros local y remota, usa un algoritmo *delta-transfer* (solo transfiere las diferencias entre origen y destino). Común en backups y mirroring. A veces accesible **sin autenticación**.

Puerto **873 TCP** → Rsync

## Footprinting

* Escaneo de versión
```bash
sudo nmap -sV -p873 target
```

* Listar los *shares* disponibles con netcat
```bash
nc -nv target 873
# luego escribir: #list
```

* Enumerar el contenido de un share
```bash
rsync -av --list-only rsync://target/dev
```

* Descargar todos los ficheros del share
```bash
rsync -av rsync://target/dev
```

Si usa SSH para transferir, añadir `-e ssh` (o `-e "ssh -p2222"` si el puerto es otro). Buscar ficheros jugosos: claves SSH (`.ssh`), `secrets.yaml`, etc. Probar siempre **reutilización de credenciales**.
