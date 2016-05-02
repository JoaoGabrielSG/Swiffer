//
//  SweetsTableViewController.h
//  Twiter
//
//  Created by Gabriel Santos on and Clinton de Sa 19/04/16.
//  Copyright © 2016 Gabriel Santos and Clinton de Sa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>

@interface SweetsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *sweets;

@property UIRefreshControl* refresh;

@end
