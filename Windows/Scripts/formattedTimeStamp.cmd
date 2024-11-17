@echo off

:: Created with snippets from
:: https://stackoverflow.com/a/33402280
:: https://mike-ward.net/2007/06/07/getting-the-current-date-and-time-in-batch-files/


for /F "skip=1 delims=" %%F in ('
    wmic PATH Win32_LocalTime GET Day^,Month^,Year /FORMAT:TABLE
') do (
    for /F "tokens=1-3" %%L in ("%%F") do (
        set CurrDay=0%%L
        set CurrMonth=0%%M
        set CurrYear=%%N
    )
)
set CurrDay=%CurrDay:~-2%
set CurrMonth=%CurrMonth:~-2%

set formattedDate=%CurrMonth%-%CurrDay%-%CurrYear%

set CurrHour=%TIME:~0,2%
set CurrMinute=%TIME:~3,2%
set CurrSecond=%TIME:~6,2%

set formattedTime=%CurrHour%:%CurrMinute%:%CurrSecond%

set formattedTimeStamp=%formattedTime% %formattedDate%

echo %formattedTimeStamp%
