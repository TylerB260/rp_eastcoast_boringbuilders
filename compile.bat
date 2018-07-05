@echo off
if "%vproject%"=="" (
	echo vproject not set! aborting
	goto exit
)
set /a "compile_cores=%NUMBER_OF_PROCESSORS%-1"
echo running with %compile_cores% cores
@echo on

"%vproject%\..\bin\vbsp.exe" -notjunc -game "%vproject%" "rp_eastcoast_boringbuilders"

@if exist rp_eastcoast_boringbuilders.lin (
@echo leak!!!!
@goto exit
)

"%vproject%\..\bin\vvis.exe" -game "%vproject%" -threads %compile_cores% "rp_eastcoast_boringbuilders"

"%vproject%\..\bin\vrad.exe" -game "%vproject%" -threads %compile_cores% "rp_eastcoast_boringbuilders"

@echo off
:exit
pause