#Include logger.ahk

myLogger := new logger

myLogger.log("Hello world!")

myLogger.log({level: "error", message: "Test error"})

msgbox