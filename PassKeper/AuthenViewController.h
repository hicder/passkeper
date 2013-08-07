//
//  AuthenViewController.h
//  PassKeper
//
//  Created by Hieu on 8/4/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassListViewController.h"

@interface AuthenViewController : UIViewController
- (IBAction)Authen:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSURLConnection *conn;
@end
