@echo off
:menu
cls
echo ============================
echo Select an option:
echo 1. Empty the Recycle Bin
echo 2. Delete a folder
echo 3. Uninstall Opera GX
echo 4. Exit
echo ============================
set /p choice=Enter your choice (1/2/3/4): 

if %choice%==1 goto empty_bin
if %choice%==2 goto delete_folder
if %choice%==3 goto uninstall_opera
if %choice%==4 goto exit

goto menu

:empty_bin
echo Emptying Recycle Bin...
powershell -command "Clear-RecycleBin -Force"
echo Recycle Bin has been emptied.
pause
goto menu

:delete_folder
set /p folderpath=Enter the folder path to delete: 
if not exist "%folderpath%" (
    echo The folder does not exist.
    pause
    goto menu
)
echo Deleting the folder: %folderpath%
rmdir /S /Q "%folderpath%"
echo Folder has been deleted.
pause
goto menu

:uninstall_opera
echo ============================
echo Uninstall Opera GX Options
echo ============================
echo 1. Uninstall normally
echo 2. Uninstall with elevated permissions (RUNASINVOKER)
echo ============================
set /p opera_choice=Choose an option (1 or 2): 

REM Check if Opera GX is installed
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /f "Opera GX" >nul 2>&1
if %errorlevel% neq 0 (
    echo Opera GX is not installed.
    pause
    goto menu
)

set "operaGX_GUID={2D4C0633-2F29-46EA-A4D8-1D456A32B462}"

if "%opera_choice%"=="1" (
    echo Uninstalling Opera GX normally...
    start /wait msiexec.exe /x %operaGX_GUID% /qn
    if %errorlevel% == 0 (
        echo Opera GX has been uninstalled successfully!
    ) else (
        echo There was a problem uninstalling Opera GX.
    )
) else if "%opera_choice%"=="2" (
    echo Uninstalling Opera GX with elevated permissions...
    cmd /min /C "set __COMPAT_LAYER=RUNASINVOKER && start "" msiexec.exe /x %operaGX_GUID% /qn"
    if %errorlevel% == 0 (
        echo Opera GX has been uninstalled successfully!
    ) else (
        echo There was a problem uninstalling Opera GX.
    )
) else (
    echo Invalid option, returning to menu.
)

pause
goto menu

:exit
echo Goodbye!
pause
exit
