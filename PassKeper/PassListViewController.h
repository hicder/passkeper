//
//  PassListViewController.h
//  PassKeper
//
//  Created by Hieu on 8/3/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModifyAccountViewController.h"

@interface PassListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * websiteName;
@property (strong, nonatomic) NSDictionary * accountPass;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSURLConnection *connupdate;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray * passarray;
@end
