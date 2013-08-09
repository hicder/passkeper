//
//  ModifyAccountViewController.h
//  PassKeper
//
//  Created by Hieu on 8/6/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemModifiedProtocol <NSObject>

-(void) itemModifedWithIndexPath:(NSArray *)indexPaths;

@end


@interface ModifyAccountViewController : UIViewController{
}
- (IBAction)updateInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernamebox;
@property (weak, nonatomic) IBOutlet UITextField *passwordbox;
@property (weak, nonatomic) IBOutlet UITextField *newpasswordbox;
@property (strong, nonatomic) NSString *usernameboxtext;
@property (strong, nonatomic) NSString *passwordboxtext;
@property (strong, nonatomic) NSString *websitetext;
@property (strong, nonatomic) NSURLConnection *conn;
@property (nonatomic, assign) id<ItemModifiedProtocol> delegate;
@property (strong, nonatomic) NSIndexPath * rowSelected;
@end
