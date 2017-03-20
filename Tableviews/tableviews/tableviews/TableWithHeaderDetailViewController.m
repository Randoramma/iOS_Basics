//
//  Created by Luis on 10/27/15.
//  Copyright © 2015 lc. All rights reserved.
//

#import "TableWithHeaderDetailViewController.h"

@interface TableWithHeaderDetailViewController ()

@end

@implementation TableWithHeaderDetailViewController

@synthesize currentPlace;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title       = currentPlace.getTitle;
    
    self.detailTitle.text           = currentPlace.getTitle;
    self.detailDescription.text     = currentPlace.getDescription;
    self.detailImageView.image      = [UIImage imageNamed: currentPlace.getImage];
    self.yearBuilt.text             = [@"Year Built: " stringByAppendingString:currentPlace.getYear];
    self.height.text                = [@"Height: " stringByAppendingString:currentPlace.getHeight];
    self.cost.text                  = [@"Cost: " stringByAppendingString:currentPlace.getCost];
    self.record.text                = [@"Record: " stringByAppendingString:currentPlace.getRecord];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
