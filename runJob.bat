delete "%CD%\job.log"
call set_env.bat
call %PDI_PATH%\kitchen.bat /file:%1 /level:Basic /logfile:"%CD%\job.log"