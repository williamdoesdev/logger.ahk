class Logger{
    options := {showLevel: true, showTimestamp: false, timestampFormat: "MM/dd/yy hh:mm", logToFile: false, pauseOnError: false, exitOnError: false, exceptionOnError: false, silent: false, logToFile: false, logFilePath: A_ScriptDir . "\log.log", levelsToLog: ["error", "warn", "info", "verbose", "debug", "test", "silly"]}

    __New(options){
        if(IsObject(options) = 1){
            for key, value in this.validateOptions(options)
            {
                this.options[key] := value
            }
        }
    }

    log(params*){
        ;return if silent is true
        if(this.options.silent = true){
            return
        }

        logOptions := {}
        if(IsObject(params[1]) = true){
            logOptions := this.validateLogOptions(params[1])
        }else{
            logOptions.message := params[1]
            if(params[2]){
                logOptions.level := params[2]
            }else{
                logOptions.level := "debug"
            }
            logOptions.exception := params[3]
        }

        ;format log message
        if(this.options.showLevel = true || this.validateLevel(logOptions.level) = "verbose"){
             logStr := % this.validateLevel(logOptions.level)
        }
        if(this.options.showTimestamp = true || this.validateLevel(logOptions.level) = "verbose"){
            format := % this.options.timestampFormat
            FormatTime, formatted, A_NOW, %format%
            logStr := % formatted . " " . logStr 
        }
        if(logStr){
            logStr := % logStr ": " . logOptions.message 
        }else{
            logStr := % logOptions.message 
        }
         
        ;pause if pauseOnError is true
        if(this.options.pauseOnError = true){
            Msgbox, % "Pausing on Error:`r`n" .  logOptions.message
        }

        ;exit if exitOnError is true
        if(this.options.exitOnError = true){
            Msgbox, % "Exiting on Error:`r`n" .  logOptions.message
            ExitApp
        }

        ;log entry
        if(this.shouldLogLevel(this.validateLevel(logOptions.level)) = true){
            this.print(logStr)
            if(logOptions.exception = true || this.options.exceptionOnError = true){
                Throw, Exception(logOptions.message, -1)
            }
            if(this.options.logToFile = true){
                FileAppend, % logStr . "`r`n", % this.options.logFilePath
            }
        }
    }

    ;print to ListVars window
    print(str:=""){
        static
        if(lastStr){
            str := lastStr . "`r`n" .  str
        }
        lastStr := str
        If !WinActive("ahk_class AutoHotkey"){
            ListVars
            WinWait ahk_id %A_ScriptHwnd%
        }
        ControlSetText Edit1, %str%, ahk_id %A_ScriptHwnd%
    }

    ;clear ListVars window
    clear(){
        ControlSetText Edit1, , ahk_id %A_ScriptHwnd%
    }

    ;validate options
    validateOptions(options){
        for key, value in options{
            matchingKeyFound := 0
            for ley, lalue in this.options{
                if(key = ley){
                    matchingKeyFound := 1
                }
            }
            if(matchingKeyFound = 0){
                Throw Exception(key . " is not a valid option.", -2)
            }
        }
        return options
    }

    ;validate log options
    validateLogOptions(options){
        validOptions := ["message", "level", "exception"]
        for key, value in options{
            matchingKeyFound := 0
            for i, element in validOptions{
                if(key = element){
                    matchingKeyFound := 1
                }
            }
            if(matchingKeyFound = 0){
                Throw Exception(key . " is not a valid option.", -2)
            }
        }
        return options
    }

    ;validate log level
    validateLevel(level){
        if(level = "error" || level = "warn" || level = "info" || level = "verbose" || level = "debug" || level = "test" || level = "silly"){
            return level
        }else{
            Throw Exception(level . " is not a valid log level.", -2)
        }
    }

    ;check if the level is included in options.levelsToLog
    shouldLogLevel(level){
        for i, element in this.options.levelsToLog{
            if(level = element){
                return true
            }
        }
        return false
    }
}