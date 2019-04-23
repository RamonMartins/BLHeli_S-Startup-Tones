@ECHO off
@ECHO ***** Batch file for BlHeli_S (from 4712)  v.2         *****
@ECHO ***** All Messages will be saved to MakeHex_Result.txt *****
@ECHO ***** Start compile with any key  - CTRL-C to abort    *****
Break ON
@pause
DEL MakeHex_Result.txt /Q

rem ***** Adapt settings to your enviroment ****
DEL Output\Hex\*.* /Q
RMDIR Output\Hex
DEL Output\*.* /Q
RMDIR Output
MKDIR Output
MKDIR Output\Hex
SET Revision=REV16_76
SET KeilPath=C:\SiliconLabs\SimplicityStudio\v3\developer\toolchains\keil_8051\9.53\BIN

@ECHO Revision: %Revision% >> MakeHex_Result.txt
@ECHO Path for Keil toolchain: %KeilPath% >> MakeHex_Result.txt
@ECHO Start compile ..... >> MakeHex_Result.txt


SET ESCNO=19
SET ESC=S_H_
SET MCU_48MHZ=1
call:compile


goto :end


:compile
SET FETON_DELAY=0
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=5
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=10
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=15
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=20
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=25
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=30
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=40
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=50
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=70
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
SET /A FETON_DELAY=90
SET ESCNAME=%ESC%%FETON_DELAY%
call :compile_code
goto :eof


:compile_code
@ECHO compiling %ESCNAME%  
@ECHO. >> MakeHex_Result.txt
@ECHO ********************************************************************  >> MakeHex_Result.txt
@ECHO %ESCNAME%  >> MakeHex_Result.txt
@ECHO ********************************************************************  >> MakeHex_Result.txt
%KeilPath%\AX51.exe "BLHeli_S.asm" DEFINE(ESCNO=%ESCNO%) DEFINE(MCU_48MHZ=%MCU_48MHZ%) DEFINE(FETON_DELAY=%FETON_DELAY%) OBJECT(Output\%ESCNAME%_%Revision%.OBJ) DEBUG MACRO NOMOD51 COND SYMBOLS PAGEWIDTH(120) PAGELENGTH(65) >> MakeHex_Result.txt
%KeilPath%\LX51.exe "Output\%ESCNAME%_%Revision%.OBJ" TO "Output\%ESCNAME%_%Revision%.OMF" PAGEWIDTH (120) PAGELENGTH (65) >> MakeHex_Result.txt
%KeilPath%\Ohx51 "Output\%ESCNAME%_%Revision%.OMF" "HEXFILE (Output\%ESCNAME%_%Revision%.HEX)" "H386" >> MakeHex_Result.txt
copy "Output\%ESCNAME%_%Revision%.HEX" "Output\Hex\%ESCNAME%_%Revision%.HEX" > nul
del "Output\%ESCNAME%_%Revision%.HEX" > nul
@ECHO. >> MakeHex_Result.txt
goto :eof

:end

@pause
exit