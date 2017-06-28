#!/bin/bash
# This script generates a report of system data
# Script must run as superuser (sudo)
# For full output, you must install these utilities: lshw, lsscsi, smartmontools

current_date=$(date)
host_name=$(hostname)
kernel=$(cat /proc/version)
os=$(cat /etc/os-release)
disk1=$(lsscsi | grep disk | grep -v Generic | awk '{print $3,$4,$5,$6 }')
disk2=$(smartctl -a /dev/sda)
partitions1=$(parted -l)
partitions2=$(mount)
cpu_info1=$(cat /proc/cpuinfo | grep 'model name' | uniq)
cpu_info2=$(lscpu)
ram_total=$(grep -m1 MemTotal /proc/meminfo | sed "s/MemTotal://g")
ram_MB=$(free -m)
ram_hw=$(lshw | sed -n -e "/*-memory/,/*-pci/ p" | grep -v "*-pci")
network_hw=$(lspci | grep -i net)
bios=$(dmidecode | sed -n -e "/BIOS/,/Handle/p" | grep -v Handle)
dmidecode_data=$(dmidecode)

printf ">> DATE\n%s\n\n" "$current_date"
printf ">> HOSTNAME\n%s\n\n" "$host_name"
printf ">> KERNEL\n%s\n\n" "$kernel"
printf ">> OPERATING SYSTEM\n%s\n\n" "$os"
printf ">> DISK HARDWARE\n%s\n\n" "$disk1"
printf "%s\n\n" "$disk2"
printf ">> DISK PARTITIONS\n%s\n\n" "$partitions1"
printf "%s\n\n" "$partitions2"
printf ">> PROCESSOR\n%s" "$cpu_info1" 
printf "%s\n\n" "$cpu_info2"
printf ">> RAM TOTAL\n%s\n\n" "$ram_total"
printf ">> RAM MB\n%s\n\n" "$ram_MB"
printf ">> RAM HARDWARE\n%s\n\n" "$ram_hw"
printf ">> NETWORK ADAPTERS\n%s\n\n" "$network_hw"
printf ">> BIOS\n%s\n\n" "$bios"
printf ">> DMIDECODE\n%s\n\n" "$dmidecode_data"
