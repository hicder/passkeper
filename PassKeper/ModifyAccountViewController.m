//
//  ModifyAccountViewController.m
//  PassKeper
//
//  Created by Hieu on 8/6/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import "ModifyAccountViewController.h"

@interface ModifyAccountViewController ()

@end

@implementation ModifyAccountViewController
@synthesize usernamebox, passwordbox, usernameboxtext, passwordboxtext, newpasswordbox, websitetext, conn, rowSelected, delegate;
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
    [usernamebox setText:usernameboxtext];
    [passwordbox setText:passwordboxtext];
    usernamebox.delegate = self;
    newpasswordbox.delegate = self;
    passwordbox.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(goBack)];

}

-(void) goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateInfo:(id)sender {
    NSString * newpass = [newpasswordbox text];
    if ([newpass length] != 0) {
        //update the password
        NSString * post = [NSString stringWithFormat:@"&username=%@&password=%@&website=%@",[usernamebox text], [newpasswordbox text], websitetext];
        NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
        [request setURL:[NSURL URLWithString:@"http://web.engr.illinois.edu/~dpham9/update_account.php"]];
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
        
        NSArray * indexPaths = [NSArray arrayWithObject:rowSelected];
        
        if ([delegate respondsToSelector:@selector(itemModifedWithIndexPath:)]) {
            NSLog(@"hoho");
            [delegate itemModifedWithIndexPath:indexPaths];
        }
        [self.navigationController popViewControllerAnimated:YES];
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
}


@end
