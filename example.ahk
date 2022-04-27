#Include logger.ahk

myLogger := new logger({showTimestamp: true})

myLogger.log("Hello world!")

myLogger.log({level: "error", message: "Test error"})

myLogger.log({level: "error", message: "Test exception", exception: true})