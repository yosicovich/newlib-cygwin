MEMORY
{
  /* Define each memory region */
  MFlash (rx) : ORIGIN = 0x0, LENGTH = 0x8000 /* 32k */
  RamLoc (rwx) : ORIGIN = 0x10000000, LENGTH = 0x8000 /* 32k */
  RamAHB (rwx) : ORIGIN = 0x2007c000, LENGTH = 0x8000 /* 32k */

}
REGION_ALIAS("flash", MFlash)
REGION_ALIAS("ram", RamLoc)

INCLUDE lpc17xx-boot.ld
