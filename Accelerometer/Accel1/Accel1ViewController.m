//
//  PROGRAMMER: Luis Castillo
//  PANTHERID: 3607503
//  CLASS:          COP 465501 TR 5:00
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     Par,cipa,on Assignment #3
//  DUE:            Thursday 10/13/15
//  DESC:
//     Modify the Accelerometer code to move the UIBu^on in the direc,on of the iPad is ,lted in.
//     •  The bu^on should wrap around each edge of the screen so as it moves off screen it appears on the other side.
//     •  Implement a filter to reduce movement jitter.


//
//  Accel1ViewController.m
//  Accel1
//
//  Created by Steven Luis on 10/28/11.
//  Copyright 2011 FIU. All rights reserved.
//

#import "Accel1ViewController.h"

#define INTERVAL  0.03 // 30 measurements per second
#define NORMALIZE(x) (x+1.0)/2.0  // normalize accelerometer readings for progress bar: (-1..1) to (0..1)
#define STRINGF(x) [NSString stringWithFormat:@"%f", x] // convert a float to a string
#define STEPFACTOR 8


#define XTAG 0 // UI objects that refer to accellerometer x values
#define YTAG 1 // UI objects that refer to accellerometer y values
#define ZTAG 2 // UI objects that refer to accellerometer z values

@implementation Accel1ViewController
@synthesize progressBar;
@synthesize labelValues;
@synthesize movingButtonOutlet;
@synthesize xInvertSwitch;
@synthesize yInvertSwitch;


- (void)dealloc
{
    [movingButtonOutlet release];
    [progressBar release];
    [labelValues release];
    [xInvertSwitch release];
    [yInvertSwitch release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setMovingButtonOutlet:nil];
    [self setProgressBar:nil];
    [self setLabelValues:nil];
    [self setXInvertSwitch:nil];
    [self setYInvertSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Overide ViewController Delegate Methods

-(void) viewWillAppear: (BOOL) animated {
    
    [super viewWillAppear: (BOOL) animated];
    
    //getting screen size
    CGRect screensize   = [[UIScreen mainScreen] bounds]; //getting sccreen bounds
    screenHeight        =  screensize.size.height;
    screenWidth         =  screensize.size.width;
    NSLog(@"[screensize] height:%f | width:%f", screenHeight, screenWidth);
     
     NSLog (@"Monitoring accelerometer");
    UIAccelerometer *myAccel = [UIAccelerometer sharedAccelerometer ];
    
    [myAccel setUpdateInterval: INTERVAL];
    [myAccel setDelegate:self];
     
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
    
}

#pragma mark - Get Accelerometer data

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {

   // NSLog (@"[before] x = %f | y = %f | z = %f", [acceleration x], [acceleration y], [acceleration z]);//testing
    
    float currentX;
    float currentY;
    
    //check if X needs to be inverted
    if(xInvertSwitch.on)
    {
        //updating X value with filter
        currentX = [acceleration x]*STEPFACTOR*-1;
    }
    else
    {
        //updating X value with filter
        currentX = [acceleration x]*STEPFACTOR;
    }
    
    //check if Y needs to be inverted
    if(yInvertSwitch.on)
    {
        //updating Y value with filter
        currentY = [acceleration y]*STEPFACTOR;
    }
    else
    {
        //updating Y value with filter
        currentY = [acceleration y]*STEPFACTOR*-1;
    }
  
    
   // float currentZ = [acceleration z]*STEPFACTOR;
    
   // NSLog (@"[after] x = %f | y = %f | z = %f", currentX, currentY, currentZ);//testing
    
    CGRect newButtonLocation = movingButtonOutlet.frame;
    
   // NSLog(@"[button curr frame] x = %f | y = %f",newButtonLocation.origin.x  , newButtonLocation.origin.y );//testing
    
    //updating button new locations
    newButtonLocation.origin.x += currentX;
    newButtonLocation.origin.y += currentY;
    
   // NSLog(@"[button new frame] x = %f | y = %f",newButtonLocation.origin.x  , newButtonLocation.origin.y );//testing
    
    
    //checking values are not outside the screen
        //X is outside the screen
        if(newButtonLocation.origin.x < 0)
        {
            newButtonLocation.origin.x = screenWidth;
           // NSLog(@"[updating button X] x = %f ",newButtonLocation.origin.x );//testing
            
            //updating button frame
            movingButtonOutlet.frame = newButtonLocation;
        }
        else if(newButtonLocation.origin.x > screenWidth)
        {
            newButtonLocation.origin.x = 0;
           // NSLog(@"[updating button X] x = %f ",newButtonLocation.origin.x );//testing
            
            //updating button frame
            movingButtonOutlet.frame = newButtonLocation;
        }
        else
        {
            //updating button frame with animation
            [UIView animateWithDuration:0.5 animations:^{
                movingButtonOutlet.frame = newButtonLocation;
            }];
            
        }
        
        //Y is outside the screen
        if(newButtonLocation.origin.y < 0)
        {
            newButtonLocation.origin.y = screenHeight;
          //  NSLog(@"[updating button X] x = %f ",newButtonLocation.origin.y );//testing
            
            //updating button frame
            movingButtonOutlet.frame = newButtonLocation;
        }
        else if(newButtonLocation.origin.y > screenHeight)
        {
            newButtonLocation.origin.y = 0;
          //  NSLog(@"[updating button X] x = %f ",newButtonLocation.origin.y );//testing
            
            //updating button frame
            movingButtonOutlet.frame = newButtonLocation;
        }
        else
        {
            //updating button frame with animation
            [UIView animateWithDuration:0.5 animations:^{
                movingButtonOutlet.frame = newButtonLocation;
            }];
            
        }
    
    
    
   // NSLog(@" ");//testing
    // NSLog(@" ");//testing
    
    

    
    

    
    for (UIProgressView * thisBar in progressBar) {
        
        
        switch (thisBar.tag) {
            case XTAG : 
                thisBar.progress = NORMALIZE([acceleration x]);
                break;
            case YTAG:
                thisBar.progress = NORMALIZE([acceleration y]);
                break;
            case ZTAG:
                thisBar.progress = NORMALIZE([acceleration z]);
                break;
            default:
                break;
        }

    }
    
    for (UILabel *thisLabel in labelValues) {
        switch (thisLabel.tag) {
            case XTAG :
                thisLabel.text = STRINGF([acceleration x]);
                break;
            case YTAG :
                thisLabel.text = STRINGF([acceleration y]);
                break;
            case ZTAG:
                thisLabel.text = STRINGF([acceleration z]);
                break;
            
            default:
                break;
        }
    }
    
}


@end
