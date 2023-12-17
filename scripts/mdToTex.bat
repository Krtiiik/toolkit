@echo off
if "%~1"=="" (
    echo Error: No input file specified.
    goto :eof
)

if not exist "%~1" (
    echo Error: The specified file does not exist.
    goto :eof
)

set "name=%~n1"
pandoc.exe "%1" -s -o "%name%.tex" >nul
if %errorlevel% neq 0 (
    echo Error: Pandoc failed to convert the markdown file.
)

