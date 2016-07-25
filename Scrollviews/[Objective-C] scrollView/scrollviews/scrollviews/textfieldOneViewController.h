//
//  textfieldOneViewController.h
//  scrollviews
//
//  Created by Luis Castillo on 1/24/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface textfieldOneViewController : UIViewController<UITextFieldDelegate>
{


}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;



@end
