//
//  AuthenViewController.m
//  PassKeper
//
//  Created by Hieu on 8/4/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import "AuthenViewController.h"

@interface AuthenViewController ()

@end

@implementation AuthenViewController
@synthesize userName, passWord;
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
    userName.delegate = self;
    passWord.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Authen:(id)sender {
    /*
    NSString *user = [userName text];
    NSString *pass = [passWord text];
    NSString * post = [NSString stringWithFormat:@"&Username=%@&Password=%@",user, pass];
    NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:@"http://www.google.com"]];
    [request setHTTPMethod:@"POST"];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
//    PassListViewController *plvc = [self.storyboard instantiateViewControllerWithIdentifier:@"passlist"];
    
//    [self.navigationController pushViewController:plvc animated:YES];
*/
}

- (void) textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
}
@end
