//
//  ViewController.m
//  cameraApplication
//
//  Created by Luis Andres Castillo Hernandez on 10/29/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    
    //getting image from server
    [self getImage];
    
//    imageSelected.image = [UIImage imageNamed:@"StarWars.jpg"];
    
    [self setupPicker];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupPicker
{
    picker                  = [[UIImagePickerController alloc]init];
    picker.delegate         = self;
    picker.allowsEditing    = YES;
}

#pragma mark - photo functions

- (IBAction)takePhoto:(UIButton *)sender
{
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    [self presentViewController:picker animated:YES completion:NULL];
}//eo-action

- (IBAction)choosePhoto:(UIButton *)sender
{
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [self presentViewController:picker animated:YES completion:NULL];
}//eo-action


#pragma mark - Image Picker Controller delegate methods

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //original image
    //    image = info[UIImagePickerControllerOriginalImage];
    
    //edited image
    image = info[UIImagePickerControllerEditedImage];
    
    //updating imageview
    [self.imageSelected setImage:image];
    
    //
    [self dismissViewControllerAnimated:YES completion:NULL];
}//eom

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}//eom



#pragma mark -

/* sends image to server */
- (IBAction)sendImageToServer:(UIButton *)sender
{
    [self sendImage];

}//eom

#pragma mark - Server Send Functions

-(void)sendImage
{
    
    NSString * serverAddress = @"http://45.55.208.175/Website/jsonPOST_receivedPhoto.php";
    
    NSData *imageData = UIImagePNGRepresentation(self.imageSelected.image);
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[imageData length]];
    
    // Init the URLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:  serverAddress ]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:imageData];
    
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}//eom

-(void)getImage
{
    NSString * serverPhotoAddress = @"http://45.55.208.175/Website/test/StarWars.jpg";
    
    imageSelected.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:serverPhotoAddress]]];
}//eom


#pragma mark - Server Responce Functions

/* responce from server */
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@" responce: %@", httpResponse.description);
    
    NSInteger statusCode = httpResponse.statusCode;
    
    NSLog(@" status Code: %ld", (long)statusCode);
    //    NSString *string = [NSString stringWithFormat:@"%ld", (long)statusCode];
    
}//eo-action

/* data received from server */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    NSDictionary * rawExhibits = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    //            NSLog(@"[1] from server replied: %@",rawExhibits);
    //
    //            NSString *dataResponce = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //            NSLog(@"[2] responce from server %@",dataResponce);
    //
    //            // Get JSON objects into initial array
    //            NSArray *rawExhibits2 = (NSArray *)[NSJSONSerialization JSONObjectWithData:[dataResponce dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    //            NSLog(@"[3] responce from server %@",rawExhibits2);
    
    //processing responce
    [self processingServerResponce:rawExhibits];
}

/* error occurred sending data to server */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@" Failed with error '%@'", error);
}//eom

-(void)processingServerResponce:(NSDictionary *) responce
{

}//eom

@end
