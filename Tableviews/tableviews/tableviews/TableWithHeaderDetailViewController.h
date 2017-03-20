//
//  Created by Luis on 10/27/15.
//  Copyright © 2015 lc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface TableWithHeaderDetailViewController : UIViewController

@property (strong, nonatomic) Place * currentPlace;

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailDescription;


@property (weak, nonatomic) IBOutlet UILabel *yearBuilt;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UILabel *record;



@end
