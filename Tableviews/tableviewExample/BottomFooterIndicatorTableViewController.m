//
//  BottomFooterIndicatorTableViewController.m
//  tableviewExample
//
//  Created by Luis Castillo on 2/26/17.
//  Copyright © 2017 DevBros. All rights reserved.
//

#import "BottomFooterIndicatorTableViewController.h"

@interface BottomFooterIndicatorTableViewController ()
    @property (nonatomic, strong) NSMutableArray *quotes;
    @property (nonatomic, strong) UIActivityIndicatorView *indicatorFooter;
@end

@implementation BottomFooterIndicatorTableViewController

@synthesize quotes;
@synthesize indicatorFooter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    quotes = [[NSMutableArray alloc] initWithObjects:
              @"impossible is nothing",
              @"do or do not there is no try",
              @"Whether you think you can or you think you can't, you're right.",
              @"Excuses sound best to those making them",
              @"Although the world is full of suffering, it is also full of the overcoming of it.",
              @"The struggle ends when the gratitude begins.",
              @"The future depends on what we do in the present.",
              @"If you don`t like something, change it. If you can`t change it, change your attitude. Don`t complain.",
              @"If you’re going through hell, keep going.",
              @"I know where I’m going and I know the truth, and I don’t have to be what you want me to be. I’m free to be what I want.",
              @"Never be afraid to try something new. Remember, amateurs built the ark; professionals built the Titanic.",
               nil];
    
    [self initializeRefreshControl];
}//eom
    
#pragma mark - Refresh Control
-(void)initializeRefreshControl
{
    indicatorFooter = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 44)];
    [indicatorFooter setColor:[UIColor blackColor]];
    [indicatorFooter startAnimating];
    [self.tableView setTableFooterView:indicatorFooter];
}//eom
    
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}//eom

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return quotes.count;
}//eom

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"quoteBottomCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [quotes objectAtIndex:indexPath.row];
    
    return cell;
}//eom
    
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL reachedBottomOfData = scrollView.contentOffset.y < scrollView.frame.size.height == scrollView.contentSize.height;
    if (reachedBottomOfData)
    {
        [self refreshTableViewList];
    }
}//eom
    
#pragma mark - refresh data
-(void)refreshTableViewList
{
    static BOOL fetchInProgress = FALSE;
    
    if (fetchInProgress)
    return;
    
    typeof(self) __weak weakSelf = self;
    
    fetchInProgress = TRUE;
    
        // this simulates a background fetch; I'm just going to delay for a second
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            NSArray *indexPaths = [strongSelf addSomeObjects];
            [strongSelf.tableView beginUpdates];
            [strongSelf.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            fetchInProgress = FALSE;
            [strongSelf.tableView endUpdates];
        }
    });
}//eom

- (NSArray *)addSomeObjects {
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    NSMutableArray * moreQuotes = [[NSMutableArray alloc] initWithObjects:
              @"impossible is nothing",
              @"do or do not there is no try",
              @"Whether you think you can or you think you can't, you're right.",
              @"Excuses sound best to those making them",
              @"Although the world is full of suffering, it is also full of the overcoming of it.",
              @"The struggle ends when the gratitude begins.",
              @"The future depends on what we do in the present.",
              @"If you don`t like something, change it. If you can`t change it, change your attitude. Don`t complain.",
              @"If you’re going through hell, keep going.",
              @"I know where I’m going and I know the truth, and I don’t have to be what you want me to be. I’m free to be what I want.",
              @"Never be afraid to try something new. Remember, amateurs built the ark; professionals built the Titanic.",
              nil];
    
    for (NSInteger i = 0; i < moreQuotes.count; i++)
    {
        //quotes added
        NSString * currQuote = [moreQuotes objectAtIndex:i];
        [self.quotes addObject:currQuote];
    
        //tableview updated
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:(self.quotes.count - 1) inSection:0];
        [indexPaths addObject:currPath];
    }//eofl
    
    return indexPaths;
}//eom
        
#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
    
@end
