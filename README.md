# NKKVOLabel

Key-value observing is a particularly useful technique for communicating between layers in a Model-View-Controller application. When we edit a user's name in a view controller, we need to update the name on all the other view controllers  which is displaying the user's name. We may do this in such ways:

1.Add observer through the NSNotificationCenter in all the view controllers and when editing the name, post a NSNotification.
2.Update the name in view controllers's viewWillAppear: or viewDidAppear:

And if the user's name is displayed in a TableViewCell, we may need to reload the whole table.

With NKKVOLabel, we need to do nothing, just set the user's name.

For more information on KVO, see Apple's [Introduction to Key-Value Observing](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html).

## Usage

Basic usage

```objective-c

    Person *person = [[Person alloc] init];
    person.name = @"King";
    
    NKKVOLabel *label = [[NKKVOLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:label];
    
    [label bindValueOfModel:person forKeyPath:@"name"];

```
When we edit the name, just set the person's name, and the label will display the new name automatically.

```objective-c

    person.name = @"Another King";

```

If the value if not NSSting, such as NSNumber or some other type, or we want to do some additional things when a new value is set, we can tell the label a renderMethod to tell the label the string we need.

```objective-c

-(void)viewDidLoad{

    Person *person = [[Person alloc] init];
    person.name = @"King";
    person.likeCount = @1;

    NKKVOLabel *likeLabel = [[NKKVOLabel alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:likeLabel];
    
    likeLabel.target = self;
    likeLabel.renderMethod = @selector(stringWithNumber:);
    
    [likeLabel bindValueOfModel:person forKeyPath:@"likeCount"];
}
    
-(NSString*)stringWithNumber:(NSNumber*)number{
    
    if (!number) {
        number = @0;
    }
    NSString *finalString = [NSString stringWithFormat:@"%@", number];
    
    return finalString;
}

```

We can also set the label's frame in the renderMethod if we need.

The NKKVOLabel also provide a singleTapped action

```objective-c


    likeLabel.singleTapped = @selector(like:);
    
    
-(void)like:(id)sender{
    
    NSInteger count = [self.person.likeCount integerValue];
    count++;

    self.person.likeCount = [NSNumber numberWithInteger:count];
}
```

## Prerequisites

- iOS 6 or later.

## License

This code is distributed under the MIT license. See the `LICENSE` file for more info.
