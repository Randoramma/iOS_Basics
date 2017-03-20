//
//  Places.m
//  tableviews
//
//  Created by Luis Castillo on 3/19/17.
//  Copyright © 2017 lc. All rights reserved.
//

#import "Place.h"

@implementation Place

- (instancetype)init
{
    self = [super init];
    if (self) {
        title         = @"";
        description   = @"";
        image         = @"";
        year          = @"";
        height        = @"";
        cost          = @"";
        record        = @"";
    }
    return self;
}

-(instancetype)init:(NSString *) titleProvided
description:(NSString *) descriptionProvided
image:(NSString *) imageProvided
year:(NSString *) yearProvided
height:(NSString *) heightProvided
cost:(NSString *) costProvided
record:(NSString *) recordProvided
{
    self = self.init;
    
    self->title         = titleProvided;
    self->description   = descriptionProvided;
    self->image         = imageProvided;
    self->year          = yearProvided;
    self->height        = heightProvided;
    self->cost          = costProvided;
    self->record        = recordProvided;
    
    return self;
}


-(NSString *) getTitle
{
    return title;
}

-(NSString *) getDescription
{
    return description;
}

-(NSString *) getImage
{
    return image;
}

-(NSString *) getYear
{
    return year;
}

-(NSString *) getHeight
{
    return height;
}

-(NSString *) getCost
{
    return cost;
}

-(NSString *) getRecord
{
    return record;
}

@end
