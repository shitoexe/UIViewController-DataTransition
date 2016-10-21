# UIViewController-DataTransfer

**In source viewController:**

Start transition
```swift
self.segue("segueIdentifier").execute()
```

Start transition with data
```swift
self.segue("segueIdentifier").passData("Passed data string").execute()
```

Start transition with data
```swift
self.segue("segueIdentifier").passData("Passed data string").execute()
```
Start transition with callback
```swift
self.segue("segueIdentifier").passData("Passed data string").onComplete{ parameter in
            print(parameter)
         }.execute()
```
