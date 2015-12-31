# glucose-badge

Glucose Badge is an iPhone app written in Swift whose sole purpose is to read values coming from a G5 glucose transmitter (via bluetooth, low energy) and write it to both the app's icon badge value and the phone's lock screen. It is not meant to replace the functionality of the Dexcom app nor act as any kind of approved medical device and/or application. 

glucose-badge is based off of work done by [Nathan Racklyeft](https://github.com/loudnate) and makes use of his [xDripG5](https://github.com/loudnate/xDripG5) project. xDripG5 is included as a dependency via Cocoapods. To begin working on this project you'll want to navigate to the root directory and run the following
```
%> pod install
```

This will install the xDripG5 and create a workspace for you. Then open the workspace (**not** the project) via
```
$> open glucose-badge.xcworkspace/
```

There is still a lot of work to do. Currently it will write the current glucose value to the badge value but does not write anything to the lock screen. Also, the value cannot be 100% trusted because there are some cases where if we lose connectivity with the transmitter then the most recently read value will continue to be displayed.
