//
//  BasicView1DetailViewController.m
//  tableviewExample
//
//  Created by Luis Andres Castillo Hernandez on 10/27/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "BasicView1DetailViewController.h"

@interface BasicView1DetailViewController ()

@end

@implementation BasicView1DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = _DetailModal[0];
    
    self.detailTitle.text           = _DetailModal[0];
    self.detailDescription.text     = _DetailModal[1];
    self.detailImageView.image      = [UIImage imageNamed: _DetailModal[2]];
    
    if ([self.detailTitle.text isEqualToString:@"Burj Khalifa"]) {
        self.yearBuilt.text = @"Year Built: 30 december 2009";
        self.height.text = @"Height: 2722 ft";
        self.cost.text = @"Cost: $1.5 billion";
        self.record.text = @"Record: Since 2010";
    }
    
    if ([self.detailTitle.text isEqualToString:@"Eiffel Tower"]) {
        self.yearBuilt.text = @"Year Built: 15 March 1889";
        self.height.text = @"Height: 986 ft";
        self.cost.text = @"Cost: $1.5m";
        self.record.text = @"Record: 1889 to 1930";
    }
    
    if ([self.detailTitle.text isEqualToString:@"Empire State Building"]) {
        self.yearBuilt.text = @"Year Built: April 11, 1931";
        self.height.text = @"Height: 1,454 ft";
        self.cost.text = @"Cost: $40,948,900";
        self.record.text = @"Record: 1931 to 1970";
    }
    
    if ([self.detailTitle.text isEqualToString:@"Kingdom Tower"]) {
        self.yearBuilt.text = @"Year Built: est 2019";
        self.height.text = @"Height: 3,304 ft";
        self.cost.text = @"Cost: $1.23 billion";
        self.record.text = @"Record: N/A";
    }
    
    if ([self.detailTitle.text isEqualToString:@"Taipei 101"]) {
        self.yearBuilt.text = @"Year Built: 31 December 2004";
        self.height.text = @"Height: 1,671 ft";
        self.cost.text = @"Cost: $1.934 billion";
        self.record.text = @"Record: 2004 to 2009";
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
