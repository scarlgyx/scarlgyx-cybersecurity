# Legacy

```bash
nmap -p- -sCV --open --min-rate=5000 -n 10.129.17.182 -oN nmapScan.txt
```

![](../../assets/img/Pasted_image_20260305175841.png)

- Ejecutamos reconocimiento de scripts de vulnerabilidades
```bash
nmap --script vuln -sV 10.129.17.182
```

![](../../assets/img/Pasted_image_20260305180506.png)

- Explotando el exploit *windows/smb/ms08_067_netapi*

![](../../assets/img/Pasted_image_20260305182951.png)

NT AUTHORITY\SYSTEM

**ESCALADA**

Ya tenemos permisos privilegiados
