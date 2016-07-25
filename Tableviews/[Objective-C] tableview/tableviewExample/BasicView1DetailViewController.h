//
//  BasicView1DetailViewController.h
//  tableviewExample
//
//  Created by Luis Andres Castillo Hernandez on 10/27/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicView1DetailViewController : UIViewController

@property (strong, nonatomic) NSArray *DetailModal;

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailDescription;


@property (weak, nonatomic) IBOutlet UILabel *yearBuilt;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UILabel *record;


@end
