//
//  SegmentedMainViewController.m
//  LoadingViews
//
//  Created by Luis Castillo on 12/24/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

#import "SegmentedMainViewController.h"
#import "SegmentedControlSettings.h"

@interface SegmentedMainViewController ()

@property (weak, nonatomic) IBOutlet UIView * firstContainer;
@property (weak, nonatomic) IBOutlet UIView * secondContainer;
@property (strong, nonatomic) SegmentedControlSettings * settings;

@end

@implementation SegmentedMainViewController


    //MARK: View Loading
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.settings = [SegmentedControlSettings settings];
    self.settings.hobbiesTapped = FALSE;
    self.settings.favMoviesTapped = false;
}//eom

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hobbiesTapped) name:@"hobbiesTapped" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(favMoviesTapped) name:@"favMoviesTapped" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hobbiesTapped" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"favMoviesTapped" object:nil];
}

    //MARK: Observers

-(void)hobbiesTapped
{
    if(self.settings.hobbiesTapped)
    {
        self.firstContainer.hidden  = false;
        self.secondContainer.hidden = true;
    }
    else
    {
        self.firstContainer.hidden  = true;
        self.secondContainer.hidden = false;
    }
    
    //update tap selection
    self.settings.hobbiesTapped = !self.settings.hobbiesTapped;
}//eom

-(void)favMoviesTapped
{
    if(self.settings.favMoviesTapped)
    {
        self.firstContainer.hidden  = true;
        self.secondContainer.hidden = false;
    }
    else
    {
        self.firstContainer.hidden  = false;
        self.secondContainer.hidden = true;
    }
    
    //update tap selection
    self.settings.favMoviesTapped = !self.settings.favMoviesTapped;
}//eom


- (IBAction)segmentedSelectionChanged:(UISegmentedControl *)sender {
    
    if (sender.tag == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hobbiesTapped" object:nil];
    }
    else if (sender.tag == 1)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"favMoviesTapped" object:nil];
    }
    
}//eoa


    //MARK: Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
