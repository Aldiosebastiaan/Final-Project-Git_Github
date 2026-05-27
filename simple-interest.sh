#!/bin/bash

# ==============================================================================
# Nama Skrip : simple-interest.sh
# Deskripsi  : Kalkulator Bunga Sederhana (Simple Interest Calculator)
# Author     : Aldio Sebastiansyah
# ==============================================================================

# Warna untuk output Terminal agar lebih menarik
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}====================================================${NC}"
echo -e "${YELLOW}       KALKULATOR BUNGA SEDERHANA (BUNGA TUNGGAL)   ${NC}"
echo -e "${CYAN}====================================================${NC}"
echo ""

# Fungsi untuk memvalidasi apakah input berupa angka valid (bisa desimal)
validate_input() {
    local input=$1
    if [[ ! $input =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo -e "${RED}[Error] Input harus berupa angka positif yang valid!${NC}"
        exit 1
    fi
}

# 1. Input Jumlah Pokok (Principal)
read -p "Masukkan jumlah modal/pokok awal (P): Rp " principal
validate_input "$principal"

# 2. Input Suku Bunga per Tahun (Rate)
read -p "Masukkan suku bunga per tahun (%): " rate_percent
validate_input "$rate_percent"

# 3. Input Periode Waktu dalam Tahun (Time)
read -p "Masukkan periode waktu (dalam tahun): " time_years
validate_input "$time_years"

# --- Proses Perhitungan Menggunakan bc (An Option for Decimal Math in Bash) ---
# Mengubah persentase bunga menjadi bentuk desimal (rate = rate_percent / 100)
rate=$(echo "scale=4; $rate_percent / 100" | bc -l)

# Menghitung Nilai Bunga (Interest = P * r * t)
interest=$(echo "scale=2; $principal * $rate * $time_years" | bc -l)

# Menghitung Total Saldo Akhir (Total Amount = P + Interest)
total_amount=$(echo "scale=2; $principal + $interest" | bc -l)

# --- Menampilkan Hasil ---
echo ""
echo -e "${CYAN}----------------------------------------------------${NC}"
echo -e "${GREEN}                  HASIL PERHITUNGAN                 ${NC}"
echo -e "${CYAN}----------------------------------------------------${NC}"
printf "${YELLOW}%-30s:${NC} Rp %'.2f\n" "Modal/Pokok Awal (P)" "$principal"
printf "${YELLOW}%-30s:${NC} %s%% per tahun\n" "Suku Bunga (r)" "$rate_percent"
printf "${YELLOW}%-30s:${NC} %s tahun\n" "Periode Waktu (t)" "$time_years"
echo -e "${CYAN}----------------------------------------------------${NC}"
printf "${GREEN}%-30s:${NC} Rp %'.2f\n" "Total Keuntungan Bunga" "$interest"
printf "${GREEN}%-30s:${NC} Rp %'.2f\n" "Total Saldo Akhir (A)" "$total_amount"
echo -e "${CYAN}====================================================${NC}"
echo ""
