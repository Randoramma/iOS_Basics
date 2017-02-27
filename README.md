# iOS_Basics


#Notes

:black_large_square: __Generics__




:black_large_square: __enums/structs VS classes__

- enums/structs are value types (stay in the heap- meant to be recreated various times)
- classes are reference type (stay in memory)


:black_large_square: __Protocol (Interface)__

Protocol are interfaces (has no implementation , only declaration of methods. 
They can __adopted__ by a class,struct, or enum and when its adopted, it is required to 
implement the methods and properties defined in protocol.

Note that protocol __can not__ contain default parameters.

```swift

//EXAMPLE 1
protocol Account {
  var value: Double { get set }
  init(initialAmount: Double)
  init?(transferAccount: Account)
}

class BitcoinAccount: Account {
  var value: Double
  required init(initialAmount: Double) {
    value = initialAmount
  }
  required init?(transferAccount: Account) {
    guard transferAccount.value > 0.0 else {
return nil
}
    value = transferAccount.value
  }
}
var accountType: Account.Type = BitcoinAccount.self
let account = accountType.init(initialAmount: 30.00)
let transferAccount = accountType.init(transferAccount: account)!


//EXAMPLE 2 - Protocol inheritance	

protocol WheeledVehicle: Vehicle {
  var numberOfWheels: Int { get }
  var wheelSize: Double { get set }
}
```

__Protocol with associated type__

When using associatedtype in a protocol, you’re simply stating there is a type used in this protocol — without specifying what type this should be. It’s up to the protocol adopter to decide what the exact type should be.

```swift
protocol WeightCalculatable {
  associatedtype WeightType
  func calculateWeight() -> WeightType
}

class HeavyThing: WeightCalculatable {
  // This heavy thing only needs integer accuracy
  typealias WeightType = Int
  func calculateWeight() -> Int {
return 100 }
}
class LightThing: WeightCalculatable {
  // This light thing needs decimal places
  typealias WeightType = Double
  func calculateWeight() -> Double {
    return 0.0025
  }
}
```


:black_large_square: __Hashable Protocol__

The Hashable protocol, a subprotocol of Equatable, is a requirement for any type you want to use as a key to a Dictionary:
Hash values help you quickly find elements in a collection.

```swift
//Hashable Protocol
protocol Hashable : Equatable {
  var hashValue: Int { get }
}

//EXAMPLE
class Student {
  let email: String
  var firstName: String
  var lastName: String
  init(email: String, firstName: String, lastName: String) {
    self.email = email
    self.firstName = firstName
    self.lastName = lastName
} }
extension Student: Equatable {
  static func ==(lhs: Student, rhs: Student) -> Bool {
    return lhs.email == rhs.email
  }
}
extension Student: Hashable {
  var hashValue: Int {
    return email.hashValue
  }
}


//You can now use the Student type as the key in a Dictionary
let john = Student(email: "johnny.appleseed@apple.com", firstName: "Johnny", lastName: "Appleseed")
let lockerMap = [john: "14B"]


```


:black_large_square:  __CustomStringConvertible Protocol__


```swift
//CustomStringConvertible protocol
protocol CustomStringConvertible {
  var description: String { get }
}

//EXAMPLE without CustomStringConvertible
print(john) // Student


//EXAMPLE of CustomStringConvertible
extension Student: CustomStringConvertible {
  var description: String {
    return "\(firstName) \(lastName)"
  }
}

print(john) // Johnny Appleseed

```



:black_large_square: __Swift Types__

* __public__ isn't necessary unless you're writing a library to share with other app developers, we won't use it here.

* __internal__ is the default access control level. Everything is internal unless specified as public or private.

* __fileprivate__ restricts the use of a class, method, or entity to the file where it is defined.


:black_large_square: __Get vs Set__

* __get__  it can only be read and never written (if it's a computed property, it can only have a custom getter).

* __set__  writeable (set).


```swift
protocol PlayingCard {
    var isFaceDown:Bool { get set }
    var shortName:String { get }
}
```

:black_large_square: __try? vs try!__

__try?__ means that the value returned from the function will be optional. If there is an error, the return value will be nil, and there won't be any information about what went wrong

__try!__ If there's an error, 💥 BOOM 💥, the app will crash!


:black_large_square: __map__

The __map()__ function is available as a part of the Swift Standard Library's SequenceType protocol. 
This means that the function can be called on a type that conforms to the SequenceType protocol, such as an array or a dictionary. 
__map()__ is the most efficient way to apply a function to every item in a collection.

```swift
let tripContributions = ["Andy": 25, "Kathleen": 45, "Janhavi": 50, "Sebastian": 10, "Chrisna": 50]
let averageTripCost = (25 + 50 + 45 + 10 + 50)/5

let tripDebts = tripContributions.map({ (key, value) -> String in
    let amountOwed = averageTripCost - value
    if amountOwed > 0 {
        return "\(key) owes $\(amountOwed)"
    } else {
        return "\(key) is owed $\(-amountOwed)"
    }
})
```

:black_large_square: __reduce__

__reduce()__ is another function found in Swift's SequenceType protocol and is generally called by arrays and dictionaries. As its name suggests, this function reduces a collection of values to one value by applying a function to every element in the collection.

```swift
let tripContributions = ["Andy": 25, "Kathleen": 50, "Janhavi": 45, "Sebastian": 10, "Chrisna": 50]
let tripContributionsArray = Array(tripContributions.values)

let totalTripCost = tripContributionsArray.reduce(0, combine: {(subtotal, contribution) -> Int in
    subtotal + contribution
})



let numbers = [7, 89, 48, 20, 38, 89, 29]
let highestNumber = numbers.reduce(0, {(currentMax, number) -> Int in
    return max(currentMax, number)
})
```


:black_large_square:  _Class Terminology_ 

__superclass__  A class that is inherited from
__subclass__  A class that inherits from another class (the superclass)
__parent class__  A class's superclass
__child class__ A class that descended (inherited directly) from a parent class.
__descendant__  A class that inherited from an ancestor
__ancestor__  A class that has child or descendent classes
__root class__  A class with no superclass
__leaf class__  A class with no subclasses
__hierarchy__ A tree of inheritance relationships


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

```swift
var someone = Person(firstName: "Johnny", lastName: "Appleseed")
// Person object has a reference count of 1 (someone variable)

var anotherSomeone: Person? = someone
// Reference count 2 (someone, anotherSomeone)

var lotsOfPeople = [someone, someone, anotherSomeone, someone]
// Reference count 6 (someone, anotherSomeone, 4 references in
lotsOfPeople)

anotherSomeone = nil
// Reference count 5 (someone, 4 references in lotsOfPeople)

lotsOfPeople = []
// Reference count 1 (someone)

someone = Person(firstName: "Johnny", lastName: "Appleseed")
// Reference count 0 for the original Person object!
// Variable someone now references a new object
```

NOTE: once the reference count reaches zero, the __deinitializer__ method would be called.

Swift example::

```swift
class player
{

	init()
        {
		//init vars here
        }

	deinit {
		//free up vars here, close any open files that you may have open on init
	}
}
```

__Memory Leaks__
memory isn’t freed up even though its practical lifecycle has ended. Retain cycles are the most common cause of memory leaks.

EXAMPLE:

```swift
class Student: Person {
  var partner: Student?
deinit {
    print("\(firstName) being deallocated!")
  }
}

var john: Student? = Student(firstName: "Johnny", lastName: "Appleseed")
var jane: Student? = Student(firstName: "Jane", lastName: "Appleseed")
john?.partner = jane
jane?.partner = john

//this would make a memory leak - since both objects have references to each other!!
jane = nil
john = nil
```


HOW CAN IT BE FIXED?

By making variables __weak__ type.

```swift
class Student: Person {
  weak var partner: Student?
deinit {
    print("\(firstName) being deallocated!")
  }
}

var john: Student? = Student(firstName: "Johnny", lastName: "Appleseed")
var jane: Student? = Student(firstName: "Jane", lastName: "Appleseed")
john?.partner = jane
jane?.partner = john

//this would no longer caused a memory leak, as the var is now weak
jane = nil
john = nil
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





