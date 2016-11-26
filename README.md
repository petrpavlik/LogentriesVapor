# LogentriesVapor
Logging proxy to Logentries log management for Vapor.

![screenshot](https://blog.logentries.com/mstatic/content/uploads/2014/04/LIVE_TAIL.png)



## Integration

- Add Logentries as a dependency to `Package.swift`
```swift
aaa
```

```bash
$ swift package update
$ vapor xcode
```

### As a Provider

- Add configuration file `Config/logentries.json`
```json
{
    "token": "2072e0bd-9812-4625-a01c-1c955d14e16c"
}
```
- Initialize Logentries logger
```swift
import Vapor
import LogentriesVapor

let drop = Droplet()

try drop.addProvider(Logentries.self)

// ...

// This will appear in your Logentries log
// WARNING: Default Vapor configuration limits logs in production environment to errors and fatals.
drop.log.info("Launching the server")

drop.run()
```

## Manually
```swift
let log = Logentries(token: "2072e0bd-9812-4625-a01c-1c955d14e16c")
log.enabled = LogLevel.all

log.info("Info message")
```

## FAQ
**Q: Is the logging blocking?**

A: No, log requests to Logentries are performed asynchronously and all log methods return immediately.

**Q: How does the logging work?**

A: Each log call performs an HTTPS request to logentries API. It should work fine for a reasonable ammount of logs, switching to a streaming approach is planned for a future release.
