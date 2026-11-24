# PXLOS device tree — Samsung Galaxy A52s 5G (SM-A528B, `a52sxq`)

Device tree + common tree untuk membangun **PXLOS** (AOSP + GApps, Pixel-style) di Galaxy A52s 5G.

> **Status: WIP.** Tree ini diturunkan dari device tree LineageOS 24 (oleh Simon1511 dkk.) dan
> sedang dipindahkan ke basis **AOSP 17** (`android-17.0.0_r1`). Masih ada ketergantungan
> pada komponen Lineage (`lineage-sdk`, `LineageParts`, `lineage_health`) yang harus dicabut
> sebelum build AOSP murni berhasil. Lihat bagian *TODO*.

## Perangkat

| | |
|---|---|
| Model | Samsung Galaxy A52s 5G (SM-A528B) |
| SoC | Qualcomm Snapdragon 778G (SM7325) |
| Arsitektur | arm64-v8a + armeabi-v7a |
| Kernel | 5.4.x (samsung/sm7325) |
| Slot | A/B? tidak — dynamic partitions, single slot |
| Firmware basis | One UI 3.1 / Android 11 (RP1A.200720.012, A528BXXSBGYI4) |

## Isi repo

```
a52sxq/          device tree (device/samsung/a52sxq)
sm7325-common/   common tree untuk platform SM7325 (device/samsung/sm7325-common)
setup-tree.sh    menyalin kedua tree ke dalam source tree Android
```

## Cara pakai

```bash
# 1. siapkan AOSP 17
repo init -u https://android.googlesource.com/platform/manifest -b android-17.0.0_r1
repo sync -c -j8

# 2. ambil device tree ini
git clone https://github.com/gianmegantara/pxlos-device-samsung-a52sxq.git device/samsung/pxlos-device

# 3. pasang ke tree
./device/samsung/pxlos-device/setup-tree.sh /path/ke/aosp

# 4. kernel + blob proprietary (tidak ada di repo ini)
#    kernel : kernel/samsung/sm7325
#    blobs  : TheMuppets (vendor/samsung/a52sxq, vendor/samsung/sm7325-common)
```

## Yang TIDAK ada di repo ini

- **Vendor blobs Samsung** (`vendor/samsung/*`) — proprietary, tidak boleh dipublikasi.
  Gunakan [TheMuppets](https://github.com/TheMuppets) atau ekstrak sendiri dari firmware stok
  lewat `extract-files.py`.
- **Kunci signing** — jangan pernah dimasukkan ke repo.

## TODO (port ke AOSP)

- [ ] Ganti `PRODUCT_NAME := lineage_a52sxq` → `pxlos_a52sxq`
- [ ] Ganti inherit `vendor/lineage/config/common_full_phone.mk` → base AOSP + GApps
- [ ] Cabut `soong_config_set lineage_health` (battery/charge control) atau sediakan HAL pengganti
- [ ] Cabut dependensi `InstallGapps`/overlay yang mengacu resource Lineage
- [ ] Ganti `TARGET_KERNEL_CONFIG` bila memakai kernel AOSP
- [ ] Uji IMS/VoLTE di basis AOSP (bagian paling berisiko)
- [ ] Uji kamera (blob Android 11 butuh shim)

## Kredit

Tree ini berdiri di atas kerja **LineageOS** dan para maintainer `a52sxq`/`sm7325`:
Simon1511, bgcngm, Demon000, mikeNG, Linux4, webgeek1234, dan kontributor lain.
Lisensi mengikuti file aslinya (Apache-2.0 kecuali dinyatakan lain).
