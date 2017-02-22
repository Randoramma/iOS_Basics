//
//  Reusable.m
//  Re-UsableUIView
//
//  Created by Luis Castillo on 2/20/17.
//  Copyright © 2017 devbros. All rights reserved.
//

#import "Reusable.h"

@implementation Reusable


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //1. load interface from nib
        [[NSBundle mainBundle] loadNibNamed:@"Reusable"  owner:self options:nil];
        
        [self addSubview:self.view];
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
