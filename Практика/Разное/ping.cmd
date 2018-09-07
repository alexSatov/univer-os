@echo off
set /a x=%1*1000
ping -n %1 -w %x% 126.0.0.0 
