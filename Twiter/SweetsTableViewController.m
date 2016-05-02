//
//  SweetsTableViewController.m
//  Twiter
//
//  Created by Gabriel Santos on 19/04/16.
//  Copyright © 2016 Gabriel Santos and Clinton. All rights reserved.
//

#import "SweetsTableViewController.h"
#import "Cell.h"

@implementation SweetsTableViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    [self loadData];
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to load sweets"];
    [self.refresh addTarget:self action:NSSelectorFromString(@"loadData") forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refresh];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sweets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (self.sweets.count == 0) {
        return cell;
    }
    
    
    CKRecord *sweet = [self.sweets objectAtIndex:indexPath.row];
    
    NSString *sweetContent = sweet[@"content"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"MM/dd/yyyy";
    NSString *dateString = [dateFormat stringFromDate:sweet.creationDate];
    
    NSLog(@"%@", dateString);
    
    cell.textLabel.text = sweetContent;
    cell.detailTextLabel.text = dateString;
    
    return cell;
    
}

-(void) loadData {
    
    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Sweet" predicate: [NSPredicate predicateWithFormat:@"TRUEPREDICATE" argumentArray:nil]];
    
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO];
    
    NSArray *descriptors = @[sort];
    
    [query setSortDescriptors: descriptors];
    
    [[[CKContainer defaultContainer] publicCloudDatabase] performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        
        self.sweets = results;
        [self.tableView reloadData];
        [self.refresh endRefreshing];
    }];
}

- (IBAction)sendSweet:(id)sender {
//    CKRecordID *artworkRecordID = [[CKRecordID alloc] initWithRecordName:@"Sweet"];
//    CKRecord *artworkRecord = [[CKRecord alloc] initWithRecordType:@"Artwork" recordID:artworkRecordID];
//    artworkRecord[@"title" ] = @"MacKerricher State Park";
//    artworkRecord[@"artist"] = @"Mei Chen";
//    artworkRecord[@"address"] = @"Fort Bragg, CA";
    UIAlertController * alert=   [UIAlertController alertControllerWithTitle:@"New Sweet" message:@"Enter a sweet" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Your sweet";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    UIAlertAction* send = [UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        UITextField * textField = alert.textFields.firstObject;
        
        if (![textField.text  isEqual: @""]) {


            CKRecord *newSweet = [[CKRecord alloc] initWithRecordType:@"Sweet"];
            newSweet[@"content"] = textField.text;
            NSLog(@"%@", textField.text);
            
            //CKContainer *publicData =
            
            [[CKContainer defaultContainer].publicCloudDatabase saveRecord:newSweet completionHandler:^(CKRecord *record, NSError *error) {
                if (error == nil) {
                    NSLog(@"Sweet saved");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView beginUpdates];
                        [self.sweets insertObject:newSweet atIndex:0];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                        NSArray *indexPaths = @[indexPath];
                        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                        [self.tableView endUpdates];

                    });
                }
                else{
                    NSLog(@"Error: %@", error);
                }
            }];
            
        }
    }];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"Cancel" style: UIAlertActionStyleCancel handler:nil]];
    [alert addAction:send];

     [self presentViewController:alert animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
