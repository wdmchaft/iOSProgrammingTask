//
//  BookViewController.m
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookViewController.h"
#import "BookTableCell.h"
#import "EditBookViewController.h"
#import "IndividualBookViewController.h"
#import "Author+Additions.h"

@implementation BookViewController

@synthesize books = _books;

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.books = [Book findAllSortedBy:@"name" ascending:YES];   
    [self.tableView reloadData];
}

#pragma setupAdd
-(void) setupNav
{
    UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact:)]autorelease];
    self.navigationItem.rightBarButtonItem = button;
}

-(IBAction)addContact:(id)sender
{
    EditBookViewController *controller = [[[EditBookViewController alloc] initWithNibName:@"EditBookView" bundle:nil]autorelease];
    controller.isModal = YES;
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller]autorelease];
    [self.navigationController presentModalViewController:navController animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.books) {
        return [self.books count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //setting the custom cell
    static NSString *CellIdentifier = @"BookCell";
    BookTableCell *cell = (BookTableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (BookTableCell *) [[[NSBundle mainBundle] loadNibNamed:@"BookTableCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Book *book = [self.books objectAtIndex:indexPath.row];
    cell.name.text = book.name;
    cell.price.text = [book.price stringValue];

    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    NSMutableString *mutableString = [NSMutableString string];
    NSArray *array = [book.authors allObjects];
    for (Author *author in array) {
        [mutableString appendFormat:@"%@, %@", author.surname, author.firstName];
    }
    
    cell.author.text = mutableString;
    
    //iterate through the json object and get authors firstname and lastname, convert it into a string and assign the value to the textifeld
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78.0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil]autorelease];
    IndividualBookViewController *controller = [[[IndividualBookViewController alloc] initWithNibName:@"IndividualBookView" bundle:nil]autorelease];
    Book *book = [self.books objectAtIndex:indexPath.row];
    controller.book = book;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - unload
- (void)dealloc
{
    self.books = nil;
    [super dealloc];
}

@end
