//
//  Created by Luis on 10/27/15.
//  Copyright © 2015 lc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewHeader : UIImageView
{
    UILabel *label;
}

-(id)initWithText:(NSString *)text;
-(void)setText:(NSString *)text;


@end
