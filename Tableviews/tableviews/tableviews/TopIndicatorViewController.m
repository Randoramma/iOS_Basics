

#import "TopIndicatorViewController.h"

@interface TopIndicatorViewController ()

@property (nonatomic, strong) NSMutableArray *letterData;
@property (nonatomic) BOOL isAscending;

@end

@implementation TopIndicatorViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.letterData = [@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"U"] mutableCopy];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(sortArray) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.letterData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"topIndicatorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.letterData[indexPath.row];
    
    return cell;
}

- (void)sortArray
{
    // inverse sorting order
    self.isAscending = !self.isAscending;
    
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: self.isAscending];
    NSArray *sortedArray = [self.letterData sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    NSUInteger index = 0;
    
    for (NSString *s in sortedArray)
    {
        self.letterData[index] = s;
        index++;
    }
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

@end
