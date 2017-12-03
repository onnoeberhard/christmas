@ECHO OFF
"C:\Program Files (x86)\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "F:\christmas\tree\labels.tmp" -fI -W+ie -C V2 -o "F:\christmas\tree\tree.hex" -d "F:\christmas\tree\tree.obj" -e "F:\christmas\tree\tree.eep" -m "F:\christmas\tree\tree.map" "F:\christmas\tree\tree.asm"
