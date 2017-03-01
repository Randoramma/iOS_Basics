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
              @"If it ain't fun, don't do it.",
              @"To escape criticism: do nothing, say nothing, be nothing.",
              @"What the caterpillar calls the end, the rest of the world calls a butterfly.",
              @"Failure is success if you learn from it.",
              @"Don't limit your challenges - challenge your limits.",
              @"Change in all things are sweet.",
              @"Insanity: doing the same thing over and over again and expecting different results.",
              @"If a cluttered desk is a sign of a cluttered mind, of what, then, is an empty desk a sign?",
              @"The truth is, everyone is going to hurt you. You just got to find the ones worth suffering for.",
              @"Emancipate yourselves from mental slavery.None but ourselves can free our minds",
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
        [self topIndicator_show];
        [self refreshTableViewList_OnTop];
    }
}//eom
    
#pragma mark - Refresh Data | Helper
    -(NSArray *)getSomeData:(NSInteger) howManyDataToGet{
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
                   @"If you change nothing, nothing will change.",
                   @"A goal without a plan is only a wish.",
                   @"Rules for happiness: something to do, someone to love, something to hope for.",
                   @"When you judge others, you do not define them; you define yourself.",
                   @"Keep your goals away from the trolls.",
                   @"You don't have to live your life the way other people expect you to.",
                   @"Always remember that the future comes one day at a time.",
                   @"It always seems impossible until it's done.",
                   @"Do not wish for an easy life. Wish for the strength to endure a difficult one.",
                   @"If you stand for nothing, you fall for anything",
                   @"When Anger rises, think of consequences.",
                   @"Before you embark on a journey of revenge, dig two caves.",
                   @"Don't cry because it's over, smile because it happened.",
                   @"Today you are You, that is truer than true. There is no one alive who is Youer than You.",
                   @"Sometimes the questions are complicated and the answers are simple.",
                   @"When you want to succeed as bad as you want to breathe, that's when you will be successful.",
                   @"All men are created equal, some work harder in pre-season.",
                   @"When you come to the end of your rope, tie a knot and hang on.",
                   @"Don't make a priority out of someone that has you as an option.",
                   nil];
    
    NSMutableArray * new_data = [NSMutableArray array];
    
    for(NSInteger iter = 0; iter < howManyDataToGet; iter++)
    {
        NSInteger currQuoteIndex = arc4random_uniform(moreQuotes.count);
        NSString * currQuote = [moreQuotes objectAtIndex:currQuoteIndex];
        [new_data addObject:currQuote];
    
        NSLog(@"[%d] quote: %@",iter, currQuote);
    }//eofl
    
    NSLog(@"[new quotes] with '%d' elements ", new_data.count);
    
    return new_data;
}//eom
    
-(NSInteger)numberOfCellsThatFitOnScreen {
    NSInteger numOfCellsThatFitOnScreen = self.tableView.frame.size.height/self.tableView.rowHeight;
    return numOfCellsThatFitOnScreen;
}//eom
    
#pragma mark - Top refresh data
-(void)refreshTableViewList_OnTop
{
    static BOOL topfetchInProgress = FALSE;
    
    if (topfetchInProgress)
    return;
    
    typeof(self) __weak weakSelf = self;
    
    topfetchInProgress = TRUE;
    
    //simulating a background fetch
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            NSLog(@"-------------------------------------------");
            
                //new data
            NSArray * newData               = [strongSelf getSomeData:17];
            
            NSInteger data_limit            = 25;
            NSInteger rows_to_delete        = 0;
            NSInteger rows_to_add           = newData.count;
            NSInteger existing_data_count   = strongSelf.quotes.count;
            NSInteger new_data_count        = newData.count;
            NSInteger updated_data_count    = new_data_count + existing_data_count;
            BOOL removeExcessData           = false;
            
            if (newData.count > 0)
            {
                    //A. would adding the new data exceed the limit?
                NSInteger diff_in_size = data_limit - updated_data_count;
                if (diff_in_size < 0) {
                    rows_to_delete = (-1) * diff_in_size;
                    removeExcessData = true;
                }
                
                    //B. creating indexes for cells to remove/add
                NSArray * indexPathsAdding      = [strongSelf IndexPath_addRows_Top:rows_to_add];
                NSArray * indexPathsRemoving    = [strongSelf IndexPath_removeRows_Bottom:rows_to_delete];
                
                    //C. Update table
                [strongSelf.tableView beginUpdates];
                
                    //D. add new data to existing data
                [strongSelf addData_top:newData andExcessAmount:rows_to_delete];
                
                    //removing cells
                if (indexPathsRemoving.count > 0) {
                    [strongSelf.tableView deleteRowsAtIndexPaths:indexPathsRemoving withRowAnimation:UITableViewRowAnimationNone];
                }
                
                    //adding cells
                [strongSelf.tableView insertRowsAtIndexPaths:indexPathsAdding withRowAnimation:UITableViewRowAnimationNone];
                
                    //moving scrollview back down
                NSInteger estimatedRow = strongSelf.tableView.rowHeight * ( (indexPathsAdding.count) - 2);
                [strongSelf.tableView setContentOffset:CGPointMake(0, estimatedRow)];
                
                NSLog(@"data_limit: %d | updated_data_count: %d | diff_in_size: %d " , data_limit, updated_data_count, diff_in_size );
                NSLog(@"Removing Excess? %d | rows_to_delete: %d | rows_to_add: %d " , removeExcessData, rows_to_delete, rows_to_add );
                NSLog(@"rows: %d | data: %d", ([strongSelf.tableView numberOfRowsInSection:0] - indexPathsRemoving.count + indexPathsAdding.count),
                      strongSelf.quotes.count);
                NSLog(@"estimatedRow: %d ",estimatedRow);
                
                [strongSelf.tableView endUpdates];
        }
            
            topfetchInProgress = FALSE;
            
                //hide indicator
            [strongSelf.tableView.tableHeaderView removeFromSuperview];
            [strongSelf.tableView setTableHeaderView:nil];
        }
    });
}//eom
    
    
#pragma mark - Add data Top/Below
-(NSInteger)addData_top:(NSArray *)new_data andExcessAmount:(NSInteger)excessAmount
{
    NSInteger amountToRemove = excessAmount;
    for (NSInteger iter = 1; iter <= new_data.count; iter++) {
        NSInteger lastIndex = new_data.count - iter;
        id currData = [new_data objectAtIndex:lastIndex];
        [self.quotes insertObject:currData atIndex:0];
        
        NSLog(@"[adding data] on index %d", lastIndex);
        if (amountToRemove > 0) {
            [self.quotes removeLastObject];
            NSLog(@"[removing excess data] on index %d", self.quotes.count);
            amountToRemove = amountToRemove - 1;
        }
        
    }//eofl
    
    NSLog(@"total data: %d", self.quotes.count);
    return self.quotes.count;
}//eom
    
-(NSInteger)addData_bottom:(NSArray *)new_data andExcessAmount:(NSInteger)excessAmount
{
    NSInteger amountToRemove = excessAmount;
    for (NSInteger iter = 0; iter < new_data.count; iter++) {
        id currData = [new_data objectAtIndex:iter];
        [self.quotes addObject:currData];
        
        if (amountToRemove > 0) {
            [self.quotes removeObjectAtIndex:0];
            NSLog(@"[removing excess data] on index %d", 0);
            amountToRemove = amountToRemove - 1;
        }
        
        NSLog(@"[adding data] on index %d", iter);
    }//eofl

    NSLog(@"total data: %d", self.quotes.count);
    return self.quotes.count;
}//eom
    
#pragma mark - Show/Hide Header Indicator
-(void)topIndicator_show
{
    [self.tableView setTableHeaderView:indicatorHeader];
}//eom
    
-(void)topIndicator_hide
{
    [self.tableView.tableHeaderView removeFromSuperview];
    [self.tableView setTableHeaderView:nil];
}//eom
    
#pragma mark - IndexPath Add
-(NSArray *)IndexPath_addRows_Top:(NSInteger)cellsToAdd
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSInteger iter = 0; iter < cellsToAdd; iter++)
    {
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:iter inSection:0];
        [indexPaths addObject:currPath];
        NSLog(@"[adding cell] row: %d | section:0",iter);
    }//eofl
    
    return indexPaths;
}//eom
    
-(NSArray *)IndexPath_addRows_Bottom:(NSInteger)cellsToAdd
{
    NSMutableArray *indexPaths = [NSMutableArray array];

    for (NSInteger iter = 1; iter <= cellsToAdd; iter++)
    {
        NSInteger currRow = (self.quotes.count - iter);
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:currRow inSection:0];
        [indexPaths addObject:currPath];
    
        NSLog(@"[adding cell] row: %d | section:0",iter);
    }//eofl

    return indexPaths;
}//eom

#pragma mark - IndexPath Remove
-(NSArray *)IndexPath_removeRows_Top:(NSInteger)cellsToRemove
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSInteger iter = 0; iter < cellsToRemove; iter++)
    {
        NSInteger currRow = iter;
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:currRow inSection:0];
        [indexPaths addObject:currPath];
        
        NSLog(@"[removing cell] row: %d | section:0",currRow);
    }//eofl
    
    return indexPaths;
}//eom
    
-(NSArray *)IndexPath_removeRows_Bottom:(NSInteger)cellsToRemove
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger iter = 1; iter <= cellsToRemove; iter++)
    {
        NSInteger currRow = (self.quotes.count - iter);
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:currRow inSection:0];
        [indexPaths addObject:currPath];
    
        NSLog(@"[removing cell] row: %d | section:0",currRow);
    }//eofl

    return indexPaths;
}//eom
    
-(NSArray *)IndexPath_Reloading_Top:(NSInteger)numOfCellsShowing
                andNumOfCellsAdding:(NSInteger)numOfCellsAdding
{
    NSInteger starting = numOfCellsAdding - numOfCellsShowing;
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger iter = 1; iter <= numOfCellsShowing; iter++)
    {
        NSInteger currRow = starting + iter;
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:currRow inSection:0];
        [indexPaths addObject:currPath];
        NSLog(@"[reloading cell] row: %d | section:0",currRow);
    }//eofl
    
    return indexPaths;
}//eom
    
-(NSArray *)IndexPath_Reloading_Bottom:(NSInteger)numOfCellsShowing
                  withNumOfCellsAdding:(NSInteger)numOfCellsAdding
                  andTotalData:(NSInteger)totalData
{
    NSInteger starting = totalData - numOfCellsAdding;
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger iter = starting; iter <= numOfCellsShowing; iter++)
    {
        NSInteger currRow = iter;
        NSIndexPath * currPath = [NSIndexPath indexPathForRow:currRow inSection:0];
        [indexPaths addObject:currPath];
        NSLog(@"[reloading cell] row: %d | section:0",currRow);
    }//eofl
    
    return indexPaths;
}//eom
    
#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}//eom

@end
