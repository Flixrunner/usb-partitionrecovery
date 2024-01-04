@echo off
setlocal enabledelayedexpansion

REM Prompt user for the drive letter
set /p "driveLetter=Enter the drive letter of your USB drive (e.g., E): "

REM Validate and convert the drive letter to uppercase
set "driveLetter=!driveLetter:~0,1!"
if not exist !driveLetter!: (
    echo Drive !driveLetter!: does not exist.
    pause
    exit /b 1
)

REM Perform disk cleanup and format
echo Cleaning and formatting !driveLetter!:...
echo.
echo list disk > "%temp%\diskpart_script.txt"
echo select disk !driveLetter:~0,1! >> "%temp%\diskpart_script.txt"
echo clean >> "%temp%\diskpart_script.txt"
echo create partition primary >> "%temp%\diskpart_script.txt"
echo format fs=ntfs quick >> "%temp%\diskpart_script.txt"
echo exit >> "%temp%\diskpart_script.txt"

diskpart /s "%temp%\diskpart_script.txt"

REM Remove the temporary script file
del "%temp%\diskpart_script.txt"

echo.
echo Cleaning and formatting completed.

REM Pause to keep the command prompt window open
pause

endlocal
