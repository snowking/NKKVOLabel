# NKKVOLabel

Key-value observing is a particularly useful technique for communicating between layers in a Model-View-Controller application. When we edit a user's name in a view controller, we need to update the name on all the other view controllers  which is displaying the user's name. We may do this in such ways:

1.Add observer through the NSNotificationCenter in all the view controllers and when editing the name, post a NSNotification.
2.Update the name in view controllers's viewWillAppear: or viewDidAppear:

And if the user's name is displayed in a TableViewCell, we may need to reload the whole table.

With NKKVOLabel, we need to do nothing, just set the user's name.

For more information on KVO, see Apple's [Introduction to Key-Value Observing](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html).

## Usage

Basic usage





## License

This code is distributed under the MIT license. See the `LICENSE` file for more info.
