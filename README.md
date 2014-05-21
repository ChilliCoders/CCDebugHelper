![CCDebugHelper logo](http://files.chillicoders.com/ChilliInDebug.jpg)

# CCDebugHelper

CCDebugHelper is a library made to speedup application debug. Instead of clicking interface to get to right view controller you can define all view controllers in your application and easy decide which one should appear on start or list all defined controllers. But, this isn't everything. You can define before actions to prepare your controller to show. There are two version of before action synchronized and asynchronized.


## WARNING
This library is made for debugging, so **NEVER** leave it in your AppStore Version **!!!**

## How To Get Started

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like CCDebugHelper in your projects.

#### Podfile

```ruby
platform :ios, '7.0'
pod "CCDebugHelper", "~> 1.0.0"
```

## Usage

After install, first of all you need to do is create subclass of our ```CCDebugHelper``` class. You can name it what ever you want. In this example I will use ```MyDebugHelper``` class.

You must override method called ```- (NSArray *)viewControllersConfigs;``` end return array of ```CCViewControllerConfig``` class objects.

On single ```CCViewControllerConfig``` object you can specify things to setup view controller and add before action.

To simply use list view you need add few lines in AppDelegate ```application:didFinishLaunchingWithOptions:``` method:

```objective-c
// initialize CCDebugHelper with application window
MyDebugHelper *viewDebuger = [[MyDebugHelper alloc] initWithWindow:self.window];

// tell CCDebugHelper to show list of controllers
[viewDebuger showControllersList];
```

If you want show specific controller you can use method:
```objective-c
// this method will show first view controller from config list
[viewDebuger showControllerWithConfigIndex:0];
```

### CCViewControllerConfig

**With storyborad:**
```objective-c
+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass
          storyboardIdentifier:(NSString *)storyboardIdentifier
                    storyboard:(UIStoryboard *)storyboard;
```

**With XIB:**
```objective-c
// When controller name is the same like XIB name
+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass;

// for custom XIB name uose this method
+ (instancetype)configWithName:(NSString *)name
                 forController:(Class)controllerClass
                       xibName:(NSString *)xibName;
```

**Example:**
```objective-c
CCViewControllerConfig *config = [CCViewControllerConfig configWithName:@"Profile"
                                                          forController:[ProfileViewController class]
                                                   storyboardIdentifier:@"ProfileViewController"
                                                             storyboard:[UIStoryboard storyboardWithName:@"Main" bundle:nil]];
                                                             
// wrap controller with navigation controller
[config setShouldWrapControllerWithNavigationController:YES];

// set custom navigation controller class
[config setNavigationControllerClass:[MyCustomNavigationControllerClass class]];
```

To wrap your controller with navigation controller set property ```shouldWrapControllerWithNavigationController```

To use custom navigationcontroller class set property: ```navigationControllerClass```

### CCBeforeAction

**Add synchronized action (like prepare for segue):**

```objective-c
CCBeforeAction *preapareProfileViewControllerAction = [[CCBeforeAction alloc] initSyncActionWithName:@"Setting username" actionBlock:^(ProfileViewController *controller) {
	controller.username = @"chillicoder";
}];
[config addBeforeAction:preapareProfileViewControllerAction];
```

**Add asynchronized action:**

```
CCBeforeAction *loginAction = [[CCBeforeAction alloc] initAsyncActionWithName:@"Login" actionBlock:^(id controller, CCViewControllerConfigComplete complete) {
	
	// do async stuff for login
	
	// you need call complete callback for asynchronized actions
	complete();
}];
[config addBeforeAction:preapareProfileViewControllerAction];
```

## TODO

* [x] XIB Example
* [ ] Support for controllers without XIB or StoryBorad
* [ ] Support for iPad (loading controller and list view layout)
* [ ] Add option to setup CCDebugHelper with data source delegation instead of subclassing




