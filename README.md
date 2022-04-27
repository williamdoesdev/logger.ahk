# logger.ahk
A simple debug log for AutoHotKey using the ListVars window.

# Usage
The intended way of using Logger is by creating a new Logger instance. The log method of this object can then be called to send a message to the log.

```
myLogger := new logger({})

myLogger.log("Hello World!")
```

# Options

Both the Logger constructor and the log method both have options that can be passed to them.

Options for the Logger constructor are passed as an object:

| Option | Description | Default |
| --- | --- | --- |
| levelsToLog | An array representing which log levels should be included in the log. | All levels |
| showLevel | Whether or not the log level should be included in each log message. | true |
| showTimestamp | Whether or not a timestamp should be included in each log message. | false |
| timestampFormat | How timestamps should be formatted. https://www.autohotkey.com/docs/commands/FormatTime.htm | "MM/dd/yy hh:mm" |
| pauseOnError | Whether or not the script should pause when it reaches a log entry with the log level of "error". | false |
| exitOnError | Whether or not the script should exit when it reaches a log entry with the log level of "error". | false |
| exceptionOnError | Whether or not the script should throw an exception when it reaches a log entry with the log level of "error". | false |
| logToFile | Whether or not log messages should also be saved to a file. | false |
| logFilePath | The file path to the file log messages should be added to. | log.log (In script dir.) |
| silent | If true, all logs are supressed. | false |

As an example:

```
myLogger := new logger({levelsToLog: ["error", "warn"], showTimestamp: true})
```

The log method also accepts three options. These can be passed either as an object, or as separate arguments.

| Option | Description | Default |
| --- | --- | --- |
| message | The message to be logged |  |
| level | The log level to use | "debug" |
| exception | Whether or not an exception should be thrown | false |

Example:

```
myLogger.log({level: "error", message: "test error", exception: true})

myLogger.log("test warning", "warn", false)
```

# Log Levels

Valid log levels include:

| Level |
| --- |
| error |
| warn |
| info |
| verbose |
| debug |
| silly |

# Clear

The clear method clears the log.

Example:

```
myLogger.clear()
```
