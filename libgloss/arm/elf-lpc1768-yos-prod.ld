MEMORY
{
  /* Define each memory region */
  MFlash (rx) : ORIGIN = 0x5000, LENGTH = 0x7B000 /* 512k */
  RamLoc (rwx) : ORIGIN = 0x10000000, LENGTH = 0x8000 /* 32k */
  RamAHB (rwx) : ORIGIN = 0x2007c000, LENGTH = 0x8000 /* 32k */

}
REGION_ALIAS("flash", MFlash)
REGION_ALIAS("ram", RamLoc)
REGION_ALIAS("yos_ram", RamAHB)

INCLUDE lpc17xx-yos-prod.ld
