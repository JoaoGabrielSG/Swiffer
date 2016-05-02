//
//  SweetsTableViewController.h
//  Twiter
//
//  Created by Gabriel Santos on 19/04/16.
//  Copyright © 2016 Gabriel Santos and Clinton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudKit/CloudKit.h>

@interface SweetsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *sweets;

@property UIRefreshControl* refresh;

@end
