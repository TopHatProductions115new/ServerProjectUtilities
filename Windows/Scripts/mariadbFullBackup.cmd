:: Created using MariaDB's official documentation
:: and the sources cited in formattedTimeStamp.cmd

@echo off

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

set formattedTime=%CurrHour%%CurrMinute%%CurrSecond%
set formattedTime=%formattedTime: =%


set foldername=%formattedTime%_%formattedDate%
set folderpath=C:\Path\to\your\MariaDB\backups
set target_dir=%folderpath%%foldername%

echo Starting MariaDB full backup.
echo This may take a while.

mariabackup --backup --target-dir=%target_dir% --user="MariaDB_Backup_Admin" --password="SomethingYouWillNeverKnow."

echo Preparing initial backup for point-in-time consistency.

mariabackup --prepare --target-dir=%target_dir%

echo The backup creation and processing task has terminated.
