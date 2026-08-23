@echo off
chcp 65001 > nul
title LZMarket - Glavnoe Menu

:menu
cls
echo ================================================
echo            LZMarket Control Panel
echo ================================================
echo.
echo   Vyberte deystvie:
echo.
echo   [1] Zapustit Telegram Bota
echo   [2] Zapustit Bota s Avtoperezapuskom
echo   [3] Zapustit Mini-Prilozhenie (Site)
echo   [4] Proverit Trebovaniya (Python, zavisimosti)
echo   [5] Ustanovit Zavisimosti
echo   [6] Prosmotr Logov
echo   [0] Vyhod
echo.
echo ================================================
echo.

set /p choice="Vvedite nomer (0-6): "

if "%choice%"=="1" goto start_bot
if "%choice%"=="2" goto start_bot_auto
if "%choice%"=="3" goto start_site
if "%choice%"=="4" goto check_requirements
if "%choice%"=="5" goto install_deps
if "%choice%"=="6" goto view_logs
if "%choice%"=="0" goto exit
goto menu

:start_bot
cls
echo ================================================
echo        Zapusk Telegram Bota
echo ================================================
echo.
python app.py
pause
goto menu

:start_bot_auto
cls
echo ================================================
echo   Zapusk Bota s Avtoperezapuskom
echo ================================================
echo.
echo [INFO] Bot budet avtomaticheski perezapuskatsa
echo [INFO] Zakroyte okno dlya ostanovki
echo.
:loop_auto
echo [%date% %time%] Zapusk...
python app.py
echo.
echo [VNIMANIE] Bot ostanovilsya! Perezapusk cherez 5 sek...
timeout /t 5 /nobreak >nul
goto loop_auto

:start_site
cls
echo ================================================
echo      Zapusk Mini-Prilozheniya (Site)
echo ================================================
echo.
if not exist "start_site.py" (
    echo [OSHIBKA] start_site.py ne nayden!
    pause
    goto menu
)
python start_site.py
pause
goto menu

:check_requirements
cls
echo ================================================
echo       Proverka Trebovaniy
echo ================================================
echo.

echo [1/4] Proverka Python...
python --version 2>nul
if errorlevel 1 (
    echo    [OSHIBKA] Python ne nayden!
) else (
    echo    [OK] Python ustanovlen
)
echo.

echo [2/4] Proverka app.py...
if exist "app.py" (
    echo    [OK] app.py nayden
) else (
    echo    [OSHIBKA] app.py ne nayden!
)
echo.

echo [3/4] Proverka config.py...
if exist "config.py" (
    echo    [OK] config.py nayden
) else (
    echo    [OSHIBKA] config.py ne nayden!
)
echo.

echo [4/4] Proverka zavisimostey...
python -c "import aiogram" 2>nul
if errorlevel 1 (
    echo    [OSHIBKA] aiogram ne ustanovlen!
    echo    Zapustite "Ustanovit Zavisimosti" (punkt 5)
) else (
    echo    [OK] aiogram ustanovlen
)
echo.

echo ================================================
pause
goto menu

:install_deps
cls
echo ================================================
echo       Ustanovka Zavisimostey
echo ================================================
echo.

if not exist "requirements.txt" (
    echo [OSHIBKA] requirements.txt ne nayden!
    pause
    goto menu
)

echo Ustanavlivayu zavisimosti iz requirements.txt...
echo.
python -m pip install -r requirements.txt
echo.
echo ================================================
echo Ustanovka zavershena!
echo ================================================
pause
goto menu

:view_logs
cls
echo ================================================
echo           Prosmotr Logov
echo ================================================
echo.
echo [INFO] Poslednie sobytiya bota:
echo.
if exist "bot.log" (
    type bot.log
) else (
    echo Fayl logov ne nayden
)
echo.
echo ================================================
pause
goto menu

:exit
cls
echo.
echo Spasibo za ispolzovanie LZMarket!
echo.
timeout /t 2 /nobreak >nul
exit
