//
//  BookViewController.h
//  iOSProgrammingTask
//
//  Created by Omer Janjua on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BookViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSArray *books;

-(void) setupNav;

@end
