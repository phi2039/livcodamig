call set_env.bat
del "%CD%\job.log"
call %PDI_PATH%\kitchen.bat /file:%1 /level:Basic /logfile:"%CD%\job.log"