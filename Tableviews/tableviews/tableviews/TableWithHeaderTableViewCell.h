//
//  Created by Luis on 10/27/15.
//  Copyright © 2015 lc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface TableWithHeaderTableViewCell : UITableViewCell
{
    Place * current;
}

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

-(void)configureCell:(Place *)currentPlace;

@end
