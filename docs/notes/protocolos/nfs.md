# NFS

*Network File System*

Sistema de ficheros en red de Sun Microsystems. Mismo propósito que SMB (acceder a ficheros por red como si fueran locales) pero protocolo distinto, usado entre sistemas Linux/Unix. Se basa en ONC-RPC.  

Puerto **111 TCP/UDP** → rpcbind / portmapper  
Puerto **2049 TCP/UDP** → NFS (desde NFSv4 solo se usa este)

## Versiones
- NFSv2 → antigua, sobre UDP
- NFSv3 → tamaño de fichero variable, mejor reporte de errores
- NFSv4 → Kerberos, atraviesa firewalls, ACLs, stateful, sin portmapper

## Autenticación  
NFS no autentica por sí mismo; lo delega en RPC y autoriza por UID/GID UNIX. Cliente y servidor no comparten mapeo de UID/GID → solo usar en redes de confianza. Se explota creando un usuario local con el mismo UID que el dueño del fichero.

## Configuración  
El fichero `/etc/exports` lista qué carpetas se comparten, a qué host/subred y con qué opciones.
```bash
cat /etc/exports
```

*Opciones
- `rw` / `ro` → lectura-escritura / solo lectura
- `sync` / `async` → transferencia síncrona (lenta) / asíncrona (rápida)
- `secure` / `insecure` → no usar / usar puertos >1024
- `no_subtree_check` → desactiva comprobación de subdirectorios
- `root_squash` → mapea root (UID 0) a anónimo, impide a root acceder a los ficheros

*Opciones peligrosas*
- `rw` → escritura
- `insecure` → permite puertos >1024 (usuarios normales interactúan con el servicio)
- `nohide` → exporta ficheros montados bajo un directorio exportado
- `no_root_squash` → ficheros de root mantienen UID/GID 0 → escalada

## Footprinting

- Escaneo con versión y scripts
```bash
sudo nmap target -p111,2049 -sV -sC
```

- Lanzar todos los scripts NFS (nfs-ls, nfs-showmount, nfs-statfs, rpcinfo)
```bash
sudo nmap --script nfs* target -sV -p111,2049
```

## Enumerar y montar

- Listar exports disponibles
```bash
showmount -e target
```

- Montar el share en local
```bash
mkdir target-NFS
sudo mount -t nfs target:/ ./target-NFS/ -o nolock
```

- Listar con usuarios/grupos y con UIDs/GIDs
```bash
ls -l mnt/nfs/
ls -n mnt/nfs/
```

Nota: con `root_squash` no se editan ficheros de root ni siendo root local.  
Escalada: subir al share una shell con SUID del usuario objetivo y ejecutarla vía SSH.

- Desmontar
```bash
sudo umount ./target-NFS
```

