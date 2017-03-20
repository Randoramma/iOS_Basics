//
//  BasicViewTableViewCell.h
//  tableviewExample
//
//  Created by Luis Andres Castillo Hernandez on 10/27/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;



@end
