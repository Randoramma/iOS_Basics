//
//  Created by Luis on 10/27/15.
//  Copyright © 2015 lc. All rights reserved.
//

#import "TableViewHeader.h"

@implementation TableViewHeader


-(id)initWithText:(NSString *)text {
    UIImage *img = [UIImage imageNamed:@"Header.jpg"];
    if(self = [super initWithImage:img])
    {
        label                   = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
        label.textColor         = [UIColor whiteColor];
        label.backgroundColor   = [UIColor clearColor];
        label.font              = [UIFont systemFontOfSize:30];
        label.text              = text;
        label.numberOfLines     = 1;
        [self addSubview:label];
    }
    
    return self;
}


-(void)setText:(NSString *)text {

}

@end
