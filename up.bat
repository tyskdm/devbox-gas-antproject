@echo off
REM Start up Docker Container of dev-tools in back ground.
REM Usage: run this up.bat afeter waking up boot2docker.

REM BASEDIR = Path to where this file is.
REM It should be /[WORKSPACE]/[PROJECT]/tools/docker/
set BASEDIR=%~dp0
for %%P in ( "%BASEDIR%/../.." ) do (
    set PROJECTDIR=%%~fP
    set PROJECTNAME=%%~nP
)
set CONTAINER_NAME=devbox-%PROJECTNAME%

if "%1"=="" (
    for %%G in ( "%PROJECTDIR%/../.gas-manager" ) do (
      set GAS_CONFIG_DIR=%%~fG
    )
) else (
    set GAS_CONFIG_DIR=%1
)

REM change path-string : from win-style to linux-style
for %%P in ( "%PROJECTDIR%/" ) do (
    set PROJECT_DRIVE=%%~dP
    set PROJECT_PATH=%%~pP
)
set PROJECT_DRIVE=%PROJECT_DRIVE:~0,-1%
for %%I in (a b c d e f g h i j k l m n o p q r s t u v w x y z) ^
do call set PROJECT_DRIVE=%%PROJECT_DRIVE:%%I=%%I%%
set PROJECTDIR=/%PROJECT_DRIVE%%PROJECT_PATH%
set PROJECTDIR=%PROJECTDIR:\=/%

REM change path-string : from win-style to linux-style
for %%P in ( "%GAS_CONFIG_DIR%/" ) do (
    set GAS_CONFIG_DRIVE=%%~dP
    set GAS_CONFIG_PATH=%%~pP
)
set GAS_CONFIG_DRIVE=%GAS_CONFIG_DRIVE:~0,-1%
for %%I in (a b c d e f g h i j k l m n o p q r s t u v w x y z) ^
do call set GAS_CONFIG_DRIVE=%%GAS_CONFIG_DRIVE:%%I=%%I%%
set GAS_CONFIG_DIR=/%GAS_CONFIG_DRIVE%%GAS_CONFIG_PATH%
set GAS_CONFIG_DIR=%GAS_CONFIG_DIR:\=/%

REM execute docker.
set DOCKER_HOST=tcp://192.168.59.103:2376
set DOCKER_CERT_PATH=%HOMEDRIVE%%HOMEPATH%\.boot2docker\certs\boot2docker-vm
set DOCKER_TLS_VERIFY=1
docker run -it -d ^
  --name="%CONTAINER_NAME%" ^
  -v %PROJECTDIR%:%PROJECTDIR% ^
  -v %GAS_CONFIG_DIR%:%PROJECTDIR%../.gas-manager ^
  -w %PROJECTDIR% ^
  tyskdm/devbox-gas:latest bash
