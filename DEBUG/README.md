# DEBUG


##Swift

####Code:
*#if DEBUG*
*    print("Debug mode")*
*#endif*

##### Project Settings:

1. 
* Build Settings
* Preprocessing
* Preprocessor Macros
* under the debug section add the following:
DEBUG=1
$(inherited)

Or 

2.
* Build Settings
* Swift Compiler - Custom Flags
* Other Swift Flags
* under the debug section add the following:
-D DEBUG




##Objective-C

####Code:


##### Project Settings:
* Build Settings
* Preprocessing
* Preprocessor Macros
* under the debug section add the following:
DEBUG=1
$(inherited)
