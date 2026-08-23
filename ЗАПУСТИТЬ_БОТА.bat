@echo off
chcp 65001 > nul
title LZMarket Bot - Zapusk

echo ================================================
echo          LZMarket Telegram Bot
echo ================================================
echo.
echo [%date% %time%] Zapusk bota...
echo.

:start_bot

REM Proverka nalichiya Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [OSHIBKA] Python ne nayden!
    echo Ustanovite Python s python.org
    echo.
    pause
    exit /b 1
)

REM Proverka nalichiya app.py
if not exist "app.py" (
    echo [OSHIBKA] Fayl app.py ne nayden!
    echo Ubeditesi chto zapuskaete iz pravilnoy papki
    echo.
    pause
    exit /b 1
)

REM Zapusk bota
echo [INFO] Bot zapuskaetsya...
echo [INFO] Dlya ostanovki nazhite Ctrl+C
echo ================================================
echo.

python app.py

REM Esli bot zavershilsya s oshibkoy
if errorlevel 1 (
    echo.
    echo ================================================
    echo [OSHIBKA] Bot zavershilsya s oshibkoy!
    echo ================================================
    echo.
    echo Vozmozhnye prichiny:
    echo - Nepravilny BOT_TOKEN v config.py
    echo - Net internet-soedineniya
    echo - Oshibka v kode
    echo.
    echo Pereapuask cherez 10 sekund...
    timeout /t 10 /nobreak >nul
    goto start_bot
)

echo.
echo ================================================
echo [INFO] Bot ostanovlen
echo ================================================
pause
