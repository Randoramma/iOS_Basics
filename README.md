# iOS_Basics


#Notes

:black_large_square:  _Atomic vs Non-Atomic_ 
(thread-safe - the guarantee that no one other thread will be touch that value at the same time)  

__Atomic__
 * is the default behavior
 * will ensure the present process is completed by the CPU, before another process accesses the variable
 * is not fast, as it ensures the process is completed entirely
 * use where the instance variable is gonna be accessed in a multithreaded environment

__Non-Atomic__
 * is NOT the default behavior
 * faster (for synthesized code, that is, for variables created using @property and @synthesize)
 * not thread-safe
 * may result in unexpected behavior, when two different process access the same variable at the same time
 * use where the instance variable is not gonna be changed by multiple threads you can use it. It improves the performance



:black_large_square:  _Assign vs Copy vs Retain_

__Assign__
 * In your setter method for the property, there is a simple assignment of your instance variable to the new value
 * assign is the default and simply performs a variable assignment
 * assign is a property attribute that tells the compiler how to synthesize the property's setter implementation
 * Recommended to  use assign for C primitive properties and weak for weak references to Objective-C objects.

```objective-c
//vars
@property (nonatomic, assign) NSString *address;
@synthesize address;


//methods
- (void)setAddressString:(NSString*)newAddressString
{         
   address = newAddressString;
} 
```

__Retain__ (in Non-ARC, for ARC use __Strong__)
 * the retain count increases by one.
 * the instance of the object will be kept in memory until it’s retain count drops to zero.
 * The property will store a reference to this instance and will share the same instance with anyone else who retained it too.
 * it is retained, old value is released and it is assigned retain specifies the new value should be sent
 * retain on assignment and the old value sent -release
 * retain is the same as strong.
 * apple says if you write retain it will auto converted/work like strong only.
 * methods like "alloc" include an implicit "retain"

```objective-c
//vars
@property (nonatomic, retain) NSString *name;
@synthesize name;


//methods
- (void)setString:(NSString*)newString
{          
       [newString retain];          
       [string release];            
       string = newString;         
}
```

__Copy__
 * the object will be cloned with duplicate values. It is not shared with any one else.
```objective-c
- (void)setString:(NSString*)newString
{            
   if(string!=newString)
   {              
      [string release];              
      string = [newString copy];            
   }
}
```

:black_large_square:  _Strong vs Weak_

__Strong__ (in ARC, for NON-ARC use __retain__)
 * it says "keep this in the heap until I don't point to it anymore"
 * in other words " I'am the owner, you cannot dealloc this before i am fine with that same as retain"
 * You use strong only if you need to retain the object.
 * By default all instance variables and local variables are strong pointers.
 * We generally use strong for UIViewControllers (UI item's parents)
 * strong is used with ARC and it basically helps you , by not having to worry about the retain count of an object. ARC automatically releases it for you when you are done with it.Using the keyword strong means that you own the object.

```objective-c
@property (strong, nonatomic) ViewController *viewController;
@synthesize viewController;
``` 

__Weak__
 * it says "keep this as long as someone else points to it strongly"
 * the same thing as assign, no retain or release
 * A "weak" reference is a reference that you do not retain.
 * We generally use weak for IBOutlets (UIViewController's Childs).This works because the child object only needs to exist as long as the parent object does.
 * a weak reference is a reference that does not protect the referenced object from collection by a garbage collector.
 * Weak is essentially assign, a unretained property. Except the when the object is deallocated the weak pointer is automatically set to nil
 * __When to use?__ If you wanted to avoid retain cycles (e.g. the parent retains the child and the child retains the parent so neither is ever released)

```objective-c
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@synthesize myButton;
```


:black_large_square:  _Methods vs Functions_ 

__Methods__ -  are attached to class / instance (object) and you have to tell the class / object to perform them

```objective-c
// declaration
- (int)fooMethod {
    return 0;
}

// call
int a;
a = [someObjectOfThisClass fooMethod];
```

__Functions__ - are code blocks that are unrelated to an object / class

```objective-c
// declaration
int fooFunction() {
    return 0;
}

// call
int a;
a = fooFunction();
```

:black_large_square: _Swizzling_
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

:black_large_square:  _Multi-Threading_

__NSThread__ -  creates a new low-level thread which can be started by calling the start method.

```objective-c
NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                        selector:@selector(myThreadMainMethod:)
                                        object:nil];
[myThread start];
```



__NSOperationQueue__ - allows a pool of threads to be created and used to execute NSOperations in parallel. NSOperations can also be run on the main thread by asking NSOperationQueue for the mainQueue.

```objective-c
NSOperationQueue* myQueue = [[NSOperationQueue alloc] init];
[myQueue addOperation:anOperation]; 
[myQueue addOperationWithBlock:^{
   /* Do something. */
}];
```

__GCD or Grand Central Dispatch__ - is a modern feature of Objective-C that provides a rich set of methods and API's to use in order to support common multi-threading tasks. GCD provides a way to queue tasks for dispatch on either the main thread, a concurrent queue (tasks are run in parallel) or a serial queue (tasks are run in FIFO order).

```objective-c
dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_async(myQueue, ^{
    printf("Do some work here.\n");
});
```



:black_large_square:  _Memory Management_

[Apple Memory Management](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmPractical.html)

[Apple Transitioning to ARC](https://developer.apple.com/library/content/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)

__copy__ Makes a copy of an object, and returns it with retain count of 1. If you copy an object, you own the copy. This applies to any method that contains the word copy where “copy” refers to the object being returned.


__retain__ - Increases the retain count of an object by 1. Takes ownership of an object.

__release__ - Decreases the retain count of an object by 1. Relinquishes ownership of an object.




:black_large_square:  _Core Data_





