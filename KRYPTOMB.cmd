@echo off
:: FORCE UTF-8 ENCODING FOR CLEAN ASCII ART AND ANCIENT GLYPH GRAPHICS
chcp 65001 >nul
cd /d "E:\"
title KRYPTOMB ENGINE V3 - SOVEREIGN PROFILE
set TARGET_DIR=E:\Kryptomb_Workspace
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

:menu
cls
color 0C
echo.
echo    ╦╔═╦═╗╦ ╦╔═╗╔╦╗╔═╗╔╦╗╔═╗
echo    ╠╩╗╠╦╝╚╦╝╠═╝ ║ ║ ║║║║╠╩╗
echo    ╩ ╩╩╚═ ╩ ╩   ╩ ╚═╝╩ ╩╚═╝
echo ===================================================
echo   [!] SOVEREIGN CRYPTOGRAPHIC CORE ONLINE [!]     
echo ===================================================
".\secure_engine.exe" --sync-status
echo ===================================================
echo   [1] FILE OPERATION CENTER (Auto-Selection Matrix)
echo   [2] View Stored PGP Keys Matrix (.key / .asc)
echo   [3] Monitor Real-Time Rolling Transmission [Live]
echo   [4] Verify Workspace Payload Status
echo   [5] Network Crypto Tunnel (WiFi/IP Wrap Module)
echo   [6] Purge Asset Repositories (Nuke / Delete Option)
echo   [7] Exit Terminal
echo ===================================================
echo.
echo Select an option [1-7] (Recommended: 1): 
choice /c 1234567 /n
if errorlevel 7 goto exit_menu
if errorlevel 6 goto nuke_center
if errorlevel 5 goto network_tunnel
if errorlevel 4 goto inspect_payload
if errorlevel 3 goto live_scramble
if errorlevel 2 goto view_pgp_keys
if errorlevel 1 goto file_ops_center

:file_ops_center
cls
echo.
echo ===================================================
echo   KRYPTOMB // FILE OPERATION CENTER (DYNAMIC)
echo ===================================================
".\secure_engine.exe" --sync-status
echo ===================================================
echo   [1] Encrypt standard file or PGP keys
echo   [2] Decrypt a Stored Candidate File
echo   [3] Provision a Brand New Cryptographic Profile
echo   [4] Return to Main Menu
echo ===================================================
echo.
echo Choose action matrix [1-4] (Recommended: 1):
choice /c 1234 /n
if errorlevel 4 goto menu
if errorlevel 3 goto provision_menu
if errorlevel 2 goto run_dynamic_decrypt
if errorlevel 1 goto run_dynamic_encrypt

:run_dynamic_encrypt
cls
".\secure_engine.exe" --interactive-run --action encrypt
pause
goto file_ops_center

:run_dynamic_decrypt
cls
echo ===================================================
echo   KRYPTOMB // DECRYPTION SOURCE SELECTION MATRIX
echo ===================================================
echo   Scanning workspace repository for stored files...
echo ---------------------------------------------------
echo.
setlocal enabledelayedexpansion
set fcount=0
for /f "delims=" %%f in ('dir "%TARGET_DIR%\*" /b 2^>nul') do (
    set /a fcount+=1
    set "file_target[!fcount!]=%%f"
    echo   [!fcount!] %%f
)
echo.
echo ===================================================
if %fcount%==0 (
    echo [!] Notification: No target payloads found inside %TARGET_DIR%
    endlocal
    pause
    goto file_ops_center
)
set /p FILE_NUM="Select Candidate Number to Decrypt [1-%fcount%]: "
if not defined file_target[%FILE_NUM%] (
    echo [ERROR] Invalid index entry.
    endlocal
    pause
    goto run_dynamic_decrypt
)
set "CHOSEN_FILE=!file_target[%FILE_NUM%]!"
cls
echo Launching Core Decryption Target Loop...
echo ---------------------------------------------------
".\secure_engine.exe" --interactive-run --action decrypt --file "%TARGET_DIR%\%CHOSEN_FILE%"
endlocal
pause
goto file_ops_center

:provision_menu
cls
echo ===================================================
echo   KRYPTOMB // PROVISION NEW CRYPTOGRAPHIC MODULE
echo ===================================================
".\secure_engine.exe" --sync-status
echo ===================================================
echo   [1] Create Pure PGP Keys
echo   [2] Create Pure Rolling Code Vault
echo   [3] Create PGP Keys Bound with Rolling Code Envelope
echo   [4] Return to Main Menu
echo ===================================================
echo.
echo Choose generation layout [1-4] (Recommended: 3):
choice /c 1234 /n
if errorlevel 4 goto menu
if errorlevel 3 goto op_gen_both
if errorlevel 2 goto op_gen_rolling
if errorlevel 1 goto op_gen_pgp

:op_gen_pgp
cls
echo [!] PGP KEY CONFIGURATION
set USERID=sovereign_core
set /p USERID="Enter Identity/Email Signature [Default: sovereign_core]: "
echo Select Core Profile: [A (Recommended)]: Ed25519  [B]: RSA (4096)
choice /c AB /n
if errorlevel 2 (set ALGO=rsa) else (set ALGO=ed25519)
".\secure_engine.exe" --gen-key --algo %ALGO% --id "%USERID%" --mode standard
pause
goto file_ops_center

:op_gen_rolling
cls
echo [!] ROLLING CODE VAULT PROVISIONING
set USERID=vault_master
set /p USERID="Enter Target Owner ID [Default: vault_master]: "
echo Select Depth: [1]: 32-bit Standard  [2 (Recommended)]: 64-bit Hardened Deep
choice /c 12 /n
if errorlevel 2 (set DEPTH=hardened_deep) else (set DEPTH=standard)
".\secure_engine.exe" --gen-key --id "%USERID%" --mode rolling_code --depth %DEPTH%
pause
goto file_ops_center

:op_gen_both
cls
echo [!] BOUND CRYPTO PROFILE GENERATION
set USERID=sovereign_vault
set /p USERID="Enter Identity/Email [Default: sovereign_vault]: "
echo Select Core Profile: [A (Recommended)]: Ed25519  [B]: RSA (4096)
choice /c AB /n
if errorlevel 2 (set ALGO=rsa) else (set ALGO=ed25519)
echo Select Depth: [1]: 32-bit Standard  [2 (Recommended)]: 64-bit Hardened Deep
choice /c 12 /n
if errorlevel 2 (set DEPTH=hardened_deep) else (set DEPTH=standard)
".\secure_engine.exe" --gen-key --algo %ALGO% --id "%USERID%" --mode rolling_code --depth %DEPTH%
pause
goto file_ops_center

:view_pgp_keys
cls
echo ===================================================
echo   STORED CRYPTOGRAPHIC KEYS & CERTIFICATES DIRECTORY
echo ===================================================
".\secure_engine.exe" --sync-status
echo ---------------------------------------------------
dir "E:\*.key" "E:\*.asc" "E:\*.pub" "E:\*.pgp" /b /s 2>nul
echo.
echo   === [Workspace Encrypted Payloads] ===
dir "%TARGET_DIR%\*" /b 2>nul
echo ---------------------------------------------------
pause
goto menu

:live_scramble
cls
echo ===================================================
echo   SELECT ROLLING CODE MONITOR MIX PROFILE
echo ===================================================
echo   [1] Standard Go-Baseline Matrix
echo   [2] Python Dense Entropy Mutation
echo   [3] C++ Ultra-Fast Bitwise Shifting
echo   [4] Rust Bound-Safe Linear Splice
echo   [5] Hybrid Matrix Cascade (Mix-All)
echo   [6] Satellite Aerospace Telemetry FEC Matrix
echo ===================================================
echo Select Mutation Architecture [1-6]:
choice /c 123456 /n
set MIXMODE=standard
if errorlevel 6 set MIXMODE=satellite-fec
if errorlevel 5 set MIXMODE=hybrid-all
if errorlevel 4 set MIXMODE=rust-safe
if errorlevel 3 set MIXMODE=cpp-fast
if errorlevel 2 set MIXMODE=python-dense
if errorlevel 1 set MIXMODE=standard
cls
echo Launching High-Fidelity Streaming Engine (%MIXMODE%)... 
timeout /t 1 >nul
".\secure_engine.exe" --live-visual-stream --algo-mix %MIXMODE%
pause
goto menu

:network_tunnel
cls
echo ===================================================
echo   KRYPTOMB // NETWORK CRYPTO TUNNEL (IP/WIFI WRAP)
echo ===================================================
echo   Scanning system for active hardware adapters...
echo ---------------------------------------------------
echo.

:: DYNAMICALLY INDEX PHYSICAL HARDWARE ADAPTERS VIA WMIC
setlocal enabledelayedexpansion
set count=0
for /f "tokens=2 delims==" %%a in ('wmic nic where "PhysicalAdapter=True and NetEnabled=True" get NetConnectionID /value 2^>nul') do (
    set "val=%%a"
    :: Strip trailing carriage returns natively
    set "val=!val:~0,-1!"
    if not "!val!"=="" (
        set /a count+=1
        set "adapter[!count!]=!val!"
        echo   [!count!] !val!
    )
)

echo.
echo ===================================================
if %count%==0 (
    echo [ERROR] No active physical network connections detected.
    echo Please ensure your Wi-Fi or Ethernet is connected.
    endlocal
    pause
    goto menu
)

set /p INT_NUM="Select Interface Number to Wrap [1-%count%]: "

:: AUTO-DETECTION MATRIX: Smoothly intercept if full string names are typed
if /i "%INT_NUM%"=="Wi-Fi" set "INT_NAME=Wi-Fi" & goto launch_tunnel
if /i "%INT_NUM%"=="Ethernet" set "INT_NAME=Ethernet" & goto launch_tunnel

:: Standard fallback index configuration check
if not defined adapter[%INT_NUM%] (
    echo [ERROR] Invalid index selection. Enter the choice number ^(e.g., 1^).
    endlocal
    pause
    goto network_tunnel
)
set "INT_NAME=!adapter[%INT_NUM%]!"

:launch_tunnel
cls
echo ===================================================
echo   SELECTED ADAPTER: %INT_NAME%
echo ===================================================
echo   Choose your rolling code architecture layout:
echo   [1] standard   [2] python-dense   [3] cpp-fast
echo   [4] rust-safe  [5] hybrid-all     [6] satellite-fec
echo ===================================================
echo Choose Layout [1-6]:
choice /c 123456 /n
set TUNMODE=standard
if errorlevel 6 set TUNMODE=satellite-fec
if errorlevel 5 set TUNMODE=hybrid-all
if errorlevel 4 set TUNMODE=rust-safe
if errorlevel 3 set TUNMODE=cpp-fast
if errorlevel 2 set TUNMODE=python-dense
if errorlevel 1 set TUNMODE=standard

cls
echo ===================================================
echo [!] TUNNEL INITIALIZED ON INTERFACE: %INT_NAME%
echo [-] Configuration Strategy: %TUNMODE%
echo [-] Status: Encrypting Outbound Frames via KRYPTOMB Core
echo Press Enter inside the frame to terminate network wrap safely.
echo ===================================================
".\secure_engine.exe" --net-wrap --interface "%INT_NAME%" --algo-mix %TUNMODE%
echo.
echo [+] Interface Hooks Released. Gateway Restored.
endlocal
pause
goto menu

:nuke_center
cls
echo [!] WARNING: PURGING ALL REPOSITORY ASSETS...
timeout /t 2 >nul
del /q "%TARGET_DIR%\*" 2>nul
echo [+] Workspace asset purge complete.
pause
goto menu

:inspect_payload
cls
echo.
echo [-] Current Workspace Payload (%TARGET_DIR%):
".\secure_engine.exe" --sync-status
echo ---------------------------------------------------
dir "%TARGET_DIR%\*" /b 2>nul
echo ---------------------------------------------------
pause
goto menu

:exit_menu
cls
color 07
echo Workspace closed. Sovereign engine standing by.
