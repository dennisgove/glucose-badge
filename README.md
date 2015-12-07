# glucose-badge

Glucose Badge is an iPhone app written in Swift whose sole purpose is to read values coming from a G5 glucose transmitter (via bluetooth, low energy) and write it to both the app's icon badge value and the phone's lock screen. It is not meant to replace the functionality of the Dexcom app nor act as any kind of approved medical device and/or application. 

glucose-badge is based off of work done by [[Nathan Racklyeft|https://github.com/loudnate]] and makes use of his [[xDripG5|https://github.com/loudnate/xDripG5]] project. At the moment glucose-badge is directly including that raw source but will soon switch to a library based approach.

There is still a lot of work to do. Currently it will write the current glucose value to the badge value but does not write anything to the lock screen. Also, the value cannot be 100% trusted because there are some cases where if we lose connectivity with the transmitter then the most recently read value will continue to be displayed.
