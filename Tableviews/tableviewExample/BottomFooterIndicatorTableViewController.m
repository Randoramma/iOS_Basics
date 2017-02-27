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
//    NSLog(@"\n\n");
//    NSLog(@"nav - height: %f",self.navigationController.navigationBar.bounds.size.height);
//    NSLog(@"table header - height: %f",self.tableView.tableHeaderView.bounds.size.height);
//    NSLog(@"table row - height: %f",self.tableView.rowHeight);
//    NSLog(@"offset - y: %f",scrollView.contentOffset.y);
//    NSLog(@"frame - height: %f",scrollView.frame.size.height);
//    NSLog(@"content - height: %f",scrollView.contentSize.height);

    BOOL reachedBottomOfData = scrollView.contentOffset.y + scrollView.frame.size.height == scrollView.contentSize.height;
    if (reachedBottomOfData)
    {
        [self.tableView setTableFooterView:indicatorFooter];
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
            
            [strongSelf.tableView.tableFooterView removeFromSuperview];
            [strongSelf.tableView setTableFooterView:nil];
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
    
    for (NSInteger iter = 0; iter < moreQuotes.count; iter++)
    {
        //quotes added
    
        NSInteger currQuoteIndex = arc4random_uniform(moreQuotes.count);
        NSString * currQuote = [moreQuotes objectAtIndex:currQuoteIndex];
        [self.quotes addObject:currQuote];
    
        //tableview updated
        NSInteger currIndex = (self.quotes.count - 1);
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:currIndex inSection:0];
        [indexPaths addObject:currPath];
    
        NSLog(@"[adding quote] in index %d quote: %@ ", iter, currQuote);
    }//eofl
    
    NSLog(@"quotes now has '%d' elements ", self.quotes.count);
    
    return indexPaths;
}//eom
    
-(NSArray *)IndexPathForAddingRows:(NSInteger)numOfCellsToPushOnTable
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSInteger iter = numOfCellsToPushOnTable-1; iter >= 0; iter--)
    {
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:iter inSection:0];
        [indexPaths addObject:currPath];
        NSLog(@"[adding] row: %d | section:0",iter);
    }//eofl
    
    return indexPaths;
}//eom
    
-(NSArray *)IndexPathForRemovingRows:(NSInteger)numOfCellsToRemoveFromTable
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSInteger iter = 1; iter <= numOfCellsToRemoveFromTable; iter++)
    {
        NSInteger currRow = (self.quotes.count - iter);
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:currRow inSection:0];
        [indexPaths addObject:currPath];
        
        
        NSLog(@"[removing] row: %d | section:0",currRow);
    }//eofl
    
    return indexPaths;
}//eom
        
#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
    
@end
