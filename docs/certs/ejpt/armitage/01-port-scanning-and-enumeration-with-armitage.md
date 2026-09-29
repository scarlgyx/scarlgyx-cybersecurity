# Port Scanning and Enumeration with Armitage

**Armitage**

**Objective:** Enumerate the target machine and perform port scanning using Armitage.

Levantamos el servicio de *postgresql*
```bash
service postgresql start
service postgresql status
```

![](../../../assets/img/Pasted_image_20260917185234.png)

Corremos armitage con los parámetros default
```bash
armitage
```

Añadimos host en *Hosts*

![](../../../assets/img/Pasted_image_20260917185454.png)

Escaneamos el host

![](../../../assets/img/Pasted_image_20260917185612.png)

Nos muestra los puertos abiertos

Hacemos un scan con nmap

![](../../../assets/img/Pasted_image_20260917185832.png)

Añadimos el host demo1.ine.local

![](../../../assets/img/Pasted_image_20260917185801.png)
