//
//  CreateAccountViewController.h
//  PassKeper
//
//  Created by Hieu on 8/9/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountViewController : UIViewController
- (IBAction)createAccount:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *passwordbox;
@property (weak, nonatomic) IBOutlet UITextField *websitebox;
@property (weak, nonatomic) IBOutlet UITextField *usernamebox;

@end
