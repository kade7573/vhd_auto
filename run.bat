@ECHO OFF

::settings

SET vhd_path="%cd%\temp.vhdx"
SET drive_label="TEMP"
SET drive_letter="Q"
SET /a size_GB = 1

SET /a partition = 2
SET diskpart_script_path="%cd%\diskpart.txt"
SET diskpart_log_path="%cd%\diskpart.log"


::create diskpart script

IF EXIST %diskpart_script_path% DEL %diskpart_script_path%
IF EXIST %diskpart_log_path% DEL %diskpart_log_path%
SET /a size_MB = %size_GB% * 1024

ECHO create vdisk file=%vhd_path% maximum=%size_MB% type=expandable > %diskpart_script_path%
ECHO select vdisk file=%vhd_path% >> %diskpart_script_path%
ECHO attach vdisk >> %diskpart_script_path%
ECHO convert gpt >> %diskpart_script_path%
ECHO create partition primary >> %diskpart_script_path%
ECHO select partition %partition% >> %diskpart_script_path%
ECHO format fs=NTFS label=%drive_label% quick >> %diskpart_script_path%
ECHO assign letter=%drive_letter% >> %diskpart_script_path%


::run diskpart script

diskpart /s %diskpart_script_path% > %diskpart_log_path%
