# Port Discovery

```bash
#!/bin/bash

function ctrl_c(){
    echo -e "\n\n[!] Saliendo...\n"
    tput cnorm; exit 1
}

# Ctrl+C
trap ctrl_c INT

# Pide al usuario ingresar la IP
read -p "Introduce la IP a escanear: " ip

# Oculta el cursor
tput civis

# Número total de puertos a escanear
total_ports=65535

# Contador de puertos escaneados
scanned_ports=0

# Barra de progreso
progress_bar() {
    local progress=$(($scanned_ports * 100 / $total_ports))
    local filled=$((progress / 2))
    local empty=$((50 - filled))
    local bar=$(printf "%0.s#" $(seq 1 $filled))
    local spaces=$(printf "%0.s " $(seq 1 $empty))
    echo -ne "\rProgress: [${bar}${spaces}] $scanned_ports/$total_ports ports scanned"
}

for port in $(seq 1 $total_ports); do
    if timeout 1 bash -c "echo '' > /dev/tcp/$ip/$port" 2>/dev/null; then
        echo -e "\n\033[32m[+] Port $port - OPEN\033[0m"  # Mostrar el puerto en verde
    fi
    scanned_ports=$((scanned_ports + 1))
    progress_bar
done; wait

# Restaura el cursor
tput cnorm

echo -e "\n\n[+] Escaneo completado"
```
