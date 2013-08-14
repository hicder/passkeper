//
//  CreateAccountViewController.m
//  PassKeper
//
//  Created by Hieu on 8/9/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController
@synthesize websitebox, usernamebox, passwordbox, rowAdded, delegate,currentPassword, currentUsername;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [usernamebox setDelegate:self];
    [passwordbox setDelegate:self];
    [websitebox setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createAccount:(id)sender {
    NSString * websitetext = [websitebox text];
    if([websitetext length] != 0){
        NSLog(@"%@ %@", currentUsername, currentPassword);
        NSString * post = [NSString stringWithFormat:@"&newusername=%@&newpassword=%@&newwebsite=%@&username=%@&password=%@",[usernamebox text], [passwordbox text], websitetext, currentUsername, currentPassword];
        NSLog(@"%@", post);
        NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
        [request setURL:[NSURL URLWithString:@"http://web.engr.illinois.edu/~dpham9/create_account.php"]];
        [request setHTTPMethod:@"POST"];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
        [request setHTTPBody:postData];
        NSURLConnection * conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        if(conn){
            NSLog(@"Successfully connected!");
        }
        else{
            NSLog(@"Connection could not be made");
        }
        NSArray * indexPaths = [NSArray arrayWithObject:rowAdded];
        if ([delegate respondsToSelector:@selector(itemAddedWithIndexPath:)]) {
            [delegate itemAddedWithIndexPath:indexPaths];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
}

@end
