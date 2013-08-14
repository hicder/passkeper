//
//  PassListViewController.h
//  PassKeper
//
//  Created by Hieu on 8/3/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModifyAccountViewController.h"
#import "CreateAccountViewController.h"

@interface PassListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ItemModifiedProtocol, AccountAdded>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * websiteName;
@property (strong, nonatomic) NSDictionary * accountPass;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSURLConnection *connupdate;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray * passarray;
@property BOOL itemAdded;
@property BOOL itemModified;
@property (strong, nonatomic) NSArray * indexPathsToBeUpdated;

-(NSURLConnection * ) makePOSTrequestwithURL:(NSString*)url withUsername:(NSString *)_username andPassword:(NSString *)_password;

@end
