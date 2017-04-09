//
//  MainViewController.h
//  SqliteDBsample
//
//  Created by Luis Castillo on 8/12/16.
//  Copyright © 2016 LC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@interface MainViewController : UIViewController<EditViewControllerDelegate,UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *peopleTable;

- (IBAction)addNewPerson:(id)sender;



@end
