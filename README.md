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

Start transition with callback
```swift
self.segue("segueIdentifier").passData("Passed data string").onComplete{ parameter in
            if let stringParameter = parameter as? String{
                print(stringParameter)
            }
         }.execute()
```

... without data
```swift
self.segue("segueIdentifier").onComplete{ parameter in
            if let stringParameter = parameter as? String{
                print(stringParameter)
            }
         }.execute()
```
If segue goes to modal viewcontroller with UINavigationControler than data will be passed to first UIViewController

**In destination viewController:**

Process of checking of incoming data
```swift
if let passedData = self.incomingData() as? String {
   print("incoming \(passedData)")
}
```
Passing data to source View Controller
```swift
self.complete("Data for source View Controller")
self.complete() //Just for executing callback
```
