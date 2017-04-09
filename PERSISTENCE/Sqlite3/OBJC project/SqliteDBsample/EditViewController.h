//
//  EditViewController.h
//  SqliteDBsample
//
//  Created by Luis Castillo on 8/12/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"


@protocol EditViewControllerDelegate

-(void)editingInfoWasFinished;

@end

@interface EditViewController : UIViewController<UITextFieldDelegate>

//delegate
@property (nonatomic, strong) id<EditViewControllerDelegate> delegate;

//db
@property (nonatomic, strong) DBManager * dbManager;

//textfields
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *age;

@property (nonatomic) int recordIDToEdit;

- (IBAction)saveInfo:(id)sender;

@end
