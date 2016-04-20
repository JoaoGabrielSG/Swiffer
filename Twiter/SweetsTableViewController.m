//
//  SweetsTableViewController.m
//  Twiter
//
//  Created by Gabriel Santos on 19/04/16.
//  Copyright © 2016 Gabriel Santos and Clinton. All rights reserved.
//

#import "SweetsTableViewController.h"

@implementation SweetsTableViewController

-(void) viewDidLoad{
    [super viewDidLoad];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (IBAction)sendSweet:(id)sender {
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
            
            //CKContainer *publicData =
            
            [[CKContainer defaultContainer].publicCloudDatabase saveRecord:newSweet completionHandler:^(CKRecord *record, NSError *error) {
                if (error == nil) {
                    NSLog(@"Sweet saved");
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
