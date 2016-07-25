//
//  uiviewOneViewController.h
//  scrollviews
//
//  Created by Luis Castillo on 1/24/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface uiviewOneViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UIView *myView;


    //items on view
@property (weak, nonatomic) IBOutlet UISwitch *partySwitch;
@property (weak, nonatomic) IBOutlet UILabel *partyLabel;
@property (weak, nonatomic) IBOutlet UITextField *partyNameTextfield;

@end
