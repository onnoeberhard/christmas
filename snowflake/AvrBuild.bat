@ECHO OFF
"C:\Program Files (x86)\Atmel\AVR Tools\AvrAssembler2\avrasm2.exe" -S "F:\christmas\snowflake\labels.tmp" -fI -W+ie -C V2 -o "F:\christmas\snowflake\snowflake.hex" -d "F:\christmas\snowflake\snowflake.obj" -e "F:\christmas\snowflake\snowflake.eep" -m "F:\christmas\snowflake\snowflake.map" "F:\christmas\snowflake\snowflake.asm"
