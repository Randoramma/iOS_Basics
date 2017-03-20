//
//  Places.h
//  tableviews
//
//  Created by Luis Castillo on 3/19/17.
//  Copyright © 2017 lc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject
{
    NSString * title;
    NSString * description;
    NSString * image;
    NSString * year;
    NSString * height;
    NSString * cost;
    NSString * record;
}

-(instancetype)init:(NSString *) titleProvided
description:(NSString *) descriptionProvided
      image:(NSString *) imageProvided
       year:(NSString *) yearProvided
     height:(NSString *) heightProvided
       cost:(NSString *) costProvided
     record:(NSString *) recordProvided;

-(NSString *) getTitle;
-(NSString *) getDescription;
-(NSString *) getImage;
-(NSString *) getYear;
-(NSString *) getHeight;
-(NSString *) getCost;
-(NSString *) getRecord;

@end
