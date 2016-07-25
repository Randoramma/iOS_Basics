//
//  ViewController.h
//  cameraApplication
//
//  Created by Luis Andres Castillo Hernandez on 10/29/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{

    UIImagePickerController * picker;
    
    UIImage * image;

}


@property (weak, nonatomic) IBOutlet UIImageView *imageSelected;

- (IBAction)takePhoto:(UIButton *)sender;

- (IBAction)choosePhoto:(UIButton *)sender;

- (IBAction)sendImageToServer:(UIButton *)sender;



@end

