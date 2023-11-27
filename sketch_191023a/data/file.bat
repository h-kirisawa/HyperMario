set i=1

:loop
copy map_0.txt map_%i%.txt
set /a i+=1
if not %i% == 31 goto loop 
pause
