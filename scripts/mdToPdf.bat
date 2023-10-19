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
    goto :deleting
)

pdflatex -synctex=1 -interaction=nonstopmode "./%name%.tex" > nul
if %errorlevel% neq 0 (
    echo Error: pdflatex failed to create the pdf file.
    goto :deleting
)

pdflatex -synctex=1 -interaction=nonstopmode "./%name%.tex" >nul
if %errorlevel% neq 0 (
    echo Error: pdflatex failed to update the pdf file.
    goto :deleting
)

:deleting
del "%name%.aux" 2>nul
del "%name%.log" 2>nul
del "%name%.synctex.gz" 2>nul
del "%name%.tex" 2>nul
del "texput.log" 2>nul
