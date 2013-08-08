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
@synthesize userName, passWord, responseData, conn;
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
    responseData = [[NSMutableData alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Authen:(id)sender {
    
    NSString *user = [userName text];
    NSString *pass = [passWord text];
    NSString * post = [NSString stringWithFormat:@"&username=%@&password=%@",user, pass];
    NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:@"http://web.engr.illinois.edu/~dpham9/db_login.php"]];
    [request setHTTPMethod:@"POST"];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(conn){
        NSLog(@"Successfully connected!");
    }
    else{
        NSLog(@"Connection could not be made");
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if(connection == conn){
        NSError *myError = nil;
        NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&myError];
        NSString *status = [NSString stringWithString:[dic objectForKey:@"result"]];
        NSLog(@"%@", status);
        if([status isEqualToString:@"success"]){
            NSLog(@"We're in");
            PassListViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"passlist"];
            vc.username = [userName text];
            vc.password = [passWord text];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            NSLog(@"Wrong pass");
            UIAlertView *myAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You have entered wrong username and/or password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlert show];
        }
    }
}
- (void) textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
}
@end
