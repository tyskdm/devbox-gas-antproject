@echo off
REM BASEDIR = Path to where this file is.
REM It should be /[WORKSPACE]/[PROJECT]/tools/docker/

set BASEDIR=%~dp0
for %%P in ( "%BASEDIR%/../.." ) do (
    set PROJECTDIR=%%~fP
    set PROJECTNAME=%%~nP
)
set CONTAINER_NAME=devbox-%PROJECTNAME%

REM execute docker.
set DOCKER_HOST=tcp://192.168.59.103:2376
set DOCKER_CERT_PATH=%HOMEDRIVE%%HOMEPATH%\.boot2docker\certs\boot2docker-vm
set DOCKER_TLS_VERIFY=1
REM docker exec %CONTAINER_NAME% %*
cscript //Nologo %BASEDIR%\exec.js %CONTAINER_NAME% %*
