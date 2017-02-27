//
//  TopHeaderIndicatorTableViewController.m
//  tableviewExample
//
//  Created by Luis Castillo on 2/26/17.
//  Copyright © 2017 DevBros. All rights reserved.
//

#import "TopHeaderIndicatorTableViewController.h"

@interface TopHeaderIndicatorTableViewController ()

    @property (nonatomic, strong) NSMutableArray *quotes;
    @property (nonatomic, strong) UIActivityIndicatorView *indicatorHeader;
    
@end

@implementation TopHeaderIndicatorTableViewController
@synthesize quotes;
@synthesize indicatorHeader;
    
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
    indicatorHeader = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 44)];
    [indicatorHeader setColor:[UIColor blackColor]];
    [indicatorHeader startAnimating];
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
                             dequeueReusableCellWithIdentifier:@"quoteTopCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [quotes objectAtIndex:indexPath.row];
    
    return cell;
}//eom
    
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"\n");
//    NSLog(@"nav - height: %f",self.navigationController.navigationBar.bounds.size.height);
//    NSLog(@"table header - height: %f",self.tableView.tableHeaderView.bounds.size.height);
//    NSLog(@"table row - height: %f",self.tableView.rowHeight);
//    NSLog(@"offset - y: %f",scrollView.contentOffset.y);
//    NSLog(@"frame - height: %f",scrollView.frame.size.height);
//    NSLog(@"content - height: %f",scrollView.contentSize.height);
    
    BOOL reachedTopOfData = scrollView.contentOffset.y < -(64.0+44.0);
    if (reachedTopOfData)
    {
        [self.tableView setTableHeaderView:indicatorHeader];
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
            NSArray *indexPathsAdding = [strongSelf addObjectsOnTop];
            NSArray *indexPathsRemoving = [strongSelf IndexPathForRemovingRows:indexPathsAdding.count];
            
            [strongSelf.tableView beginUpdates];
            
                //add cells
            [strongSelf.tableView insertRowsAtIndexPaths:indexPathsAdding withRowAnimation:UITableViewRowAnimationNone];
            
                //remove cells
            [strongSelf.tableView deleteRowsAtIndexPaths:indexPathsRemoving withRowAnimation:UITableViewRowAnimationNone];
            
                //reload cells
            [strongSelf.tableView reloadRowsAtIndexPaths:indexPathsAdding withRowAnimation:UITableViewRowAnimationTop];
            
            fetchInProgress = FALSE;
            [strongSelf.tableView endUpdates];
            
            [strongSelf.tableView.tableHeaderView removeFromSuperview];
            [strongSelf.tableView setTableHeaderView:nil];
        }
    });
}//eom
    
- (NSArray *)addObjectsOnTop {
    
    //calculating how many cells need to be pushed on top
    NSInteger numOfCellsThatFitOnScreen = self.tableView.frame.size.height/self.tableView.rowHeight;
    
    //removing one cell so you can see on the bottom
    NSInteger numOfCellsToPushOnTable = numOfCellsThatFitOnScreen-1;
    
    //adding quotes
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
    
    for(NSInteger iter = 1; iter <= numOfCellsToPushOnTable; iter++)
    {
        //adding random quote
        NSInteger currQuoteIndex = arc4random_uniform(moreQuotes.count);
        NSString * currQuote = [moreQuotes objectAtIndex:currQuoteIndex];
        [self.quotes insertObject:currQuote atIndex:0];
    
        //removing last item from data
        [self.quotes removeLastObject];
    
        NSLog(@"[adding quote] in index %d quote: %@ ", iter, currQuote);
    }//eofl
    
    
    NSArray *indexPaths = [self IndexPathForAddingRows:numOfCellsToPushOnTable];
    
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
