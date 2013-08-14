//
//  CreateAccountViewController.h
//  PassKeper
//
//  Created by Hieu on 8/9/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AccountAdded <NSObject>
-(void) itemAddedWithIndexPath:(NSArray *) IndexPaths;
@end

@interface CreateAccountViewController : UIViewController
- (IBAction)createAccount:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *passwordbox;
@property (weak, nonatomic) IBOutlet UITextField *websitebox;
@property (weak, nonatomic) IBOutlet UITextField *usernamebox;
@property (nonatomic, assign) id<AccountAdded> delegate;
@property (strong, nonatomic) NSIndexPath * rowAdded;
@property (strong, nonatomic) NSString * currentUsername;
@property (strong, nonatomic) NSString * currentPassword;
@end
