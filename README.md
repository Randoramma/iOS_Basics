# iOS_Basics


#Notes



####Swizzling
 * allows the implementation of an existing selector to be switched at runtime for a different implementation in a classes dispatch table. 
 * allows you to write code that can be executed before and/or after the original method.

```objective-c
#import "UIViewController+Log.h"
@implementation UIViewController (Log)
    + (void)load {
        static dispatch_once_t once_token;
        dispatch_once(&once_token,  ^{
            SEL viewWillAppearSelector = @selector(viewDidAppear:);
            SEL viewWillAppearLoggerSelector = @selector(log_viewDidAppear:);
            Method originalMethod = class_getInstanceMethod(self, viewWillAppearSelector);
            Method extendedMethod = class_getInstanceMethod(self, viewWillAppearLoggerSelector);
            method_exchangeImplementations(originalMethod, extendedMethod);
        });
    }
    - (void) log_viewDidAppear:(BOOL)animated {
        [self log_viewDidAppear:animated];
        NSLog(@"viewDidAppear executed for %@", [self class]);
    }
@end
```



####Atomic vs Non-Atomic
__Atomic__
 * is the default behavior
 * will ensure the present process is completed by the CPU, before another process accesses the variable
 * is not fast, as it ensures the process is completed entirely
 * use where if the instance variable is gonna be accessed in a multithreaded environment

__Non-Atomic__
 * is NOT the default behavior
 * faster (for synthesized code, that is, for variables created using @property and @synthesize)
 * not thread-safe
 * may result in unexpected behavior, when two different process access the same variable at the same time
 * use where if the instance variable is not gonna be changed by multiple threads you can use it. It improves the performance


####Copy vs Retain
__Copy__
 * the object will be cloned with duplicate values. It is not shared with any one else.

__Retain__
 * the retain count increases by one. 
 * the instance of the object will be kept in memory until it’s retain count drops to zero. 
 * The property will store a reference to this instance and will share the same instance with anyone else who retained it too.

__Assign__
 

__Strong__
  

__Weak__



####Methods vs Functions
__Methods__ -  are attached to class / instance (object) and you have to tell the class / object to perform them

```
// declaration
- (int)fooMethod {
    return 0;
}

// call
int a;
a = [someObjectOfThisClass fooMethod];
```

__Functions__ - are code blocks that are unrelated to an object / class

```
// declaration
int fooFunction() {
    return 0;
}

// call
int a;
a = fooFunction();
```


####Core Data





