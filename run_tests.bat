@echo off
setlocal enabledelayedexpansion

:: === Configuración ===
set COLLECTION=C:\NewmanTests\collections\Postman Library API v2.postman_collection.json
set REPORT_DIR=C:\NewmanTests\reports
set LOG_DIR=C:\NewmanTests\logs
set hour=%time:~0,2%
set hour=%hour: =0%
set DATESTAMP=%date:~10,4%-%date:~4,2%-%date:~7,2%_%hour%-%time:~3,2%

:: Crear carpetas si no existen
if not exist "%REPORT_DIR%" mkdir "%REPORT_DIR%"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

:: Rutas de salida con fecha/hora
set REPORT_FILE=%REPORT_DIR%\reporte_!DATESTAMP!.html
set LOG_FILE=%LOG_DIR%\newman_!DATESTAMP!.log

:: === Ejecución de Newman ===
echo Ejecutando pruebas con Newman...
"C:\Users\%USERNAME%\AppData\Roaming\npm\newman.cmd" run "%COLLECTION%" ^
    -r htmlextra,json ^
    --reporter-htmlextra-export "%REPORT_FILE%" ^
    --reporter-json-export "%REPORT_FILE:.html=.json%" ^
    > "%LOG_FILE%" 2>&1

echo.
echo ✅ Pruebas finalizadas. Reporte: %REPORT_FILE%
echo 📄 Log: %LOG_FILE%
