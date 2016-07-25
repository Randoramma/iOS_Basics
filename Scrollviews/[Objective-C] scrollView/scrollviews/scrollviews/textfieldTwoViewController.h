//
//  textfieldTwoViewController.h
//  scrollviews
//
//  Created by Luis Castillo on 1/24/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface textfieldTwoViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *activeField;
}


@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITextField *topicTextfield;

@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;

@property (weak, nonatomic) IBOutlet UITextField *priceTextfield;

@property (weak, nonatomic) IBOutlet UITextField *costTextfield;

@property (weak, nonatomic) IBOutlet UITextField *commentTextfield;








@end
