@echo off

cd /d %~dp0

powershell -NoProfile -ExecutionPolicy Unrestricted .\MSBuilsSearch_impl.ps1

pause