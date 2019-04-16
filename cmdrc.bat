@echo off

doskey d=cd /d $*
doskey ls=dir /b /o:gn $*
doskey f=dir /b /o:gn $*
doskey l=dir /o:gn $*
doskey s=dir /s /b /o:gn $*
doskey t=dir /o:d $*
doskey home=cd /d %USERPROFILE%
doskey e=explorer $*
