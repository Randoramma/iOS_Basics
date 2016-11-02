//
//  TableViewHeader.h
//  tableviewExample
//
//  Created by Luis Andres Castillo Hernandez on 10/27/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewHeader : UIImageView
{

    UILabel *label;
}

-(id)initWithText:(NSString *)text;
-(void)setText:(NSString *)text;


@end
