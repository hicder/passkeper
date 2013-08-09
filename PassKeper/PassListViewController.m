//
//  PassListViewController.m
//  PassKeper
//
//  Created by Hieu on 8/3/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import "PassListViewController.h"

@interface PassListViewController ()

@end

@implementation PassListViewController
@synthesize username, password, websiteName, accountPass, conn, responseData, passarray, connupdate, itemAdded, itemModified, indexPathsToBeUpdated;
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
    NSLog(@"%@ %@", username, password);
    passarray = [[NSMutableArray alloc]initWithCapacity:0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
	// Add the 2 buttons on top.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(confirmLogout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    
    // Load the lists of accounts and passwords
    responseData = [NSMutableData alloc];
    NSString * url = @"http://web.engr.illinois.edu/~dpham9/retrieve_list.php";
    conn = [self makePOSTrequestwithURL:url withUsername:username andPassword:password];
    if(conn){
        NSLog(@"Connect successfully to retrieve data");
    }
    else{
        NSLog(@"Connect failed to retrieve data");
    }
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"view Will Appear");
    [super viewWillAppear:YES];
    NSLog(@"reconnect....");
    responseData = [NSMutableData alloc];
    NSString * url = @"http://web.engr.illinois.edu/~dpham9/retrieve_list.php";
    connupdate = [self makePOSTrequestwithURL:url withUsername:username andPassword:password];
    if(connupdate){
        NSLog(@"Connect successfully to retrieve data");
    }
    else{
        NSLog(@"Connect failed to retrieve data");
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


-(void) confirmLogout{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Logging out" message:@"You sure you wanna log out"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                            otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if(connection == conn){
        NSError *myError = nil;
        NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&myError];
        NSLog(@"%@", [dic objectForKey:@"status"]);
        passarray = [dic objectForKey:@"results"];
        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc]init];
        for (int i = 0; i < [passarray count]; i++) {
            [insertIndexPaths insertObject: [NSIndexPath indexPathForRow:i inSection:0] atIndex:i];
        }
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
    else if(connection == connupdate){
        NSLog(@"done connect 2nd time");
        NSError *myError = nil;
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&myError];
        passarray = [dic objectForKey:@"results"];
        if(itemModified){
            NSLog(@"have something to update");
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:indexPathsToBeUpdated withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
            itemModified = NO;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModifyAccountViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"modifyaccount"];
    vc.usernameboxtext  = [[passarray objectAtIndex:indexPath.row]objectForKey:@"username"];
    vc.passwordboxtext = [[passarray objectAtIndex:indexPath.row]objectForKey:@"password"];
    vc.websitetext = [[passarray objectAtIndex:indexPath.row]objectForKey:@"website"];
    vc.rowSelected = indexPath;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    //[self presentViewController:vc animated:YES completion:nil];
}

-(void) addItem{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [[cell textLabel]setText:[[passarray objectAtIndex:indexPath.row] objectForKey:@"website"]];
    [[cell detailTextLabel]setText:[[passarray objectAtIndex:indexPath.row] objectForKey:@"username"]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [passarray count];
}

-(NSURLConnection * ) makePOSTrequestwithURL:(NSString*)url withUsername:(NSString *)_username andPassword:(NSString *)_password{
    NSURLConnection * returnedURL;
    NSString * post = [NSString stringWithFormat:@"&username=%@&password=%@",_username, _password];
    NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    returnedURL = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    return returnedURL;
}

- (void) itemModifedWithIndexPath:(NSArray *)indexPaths{
    NSLog(@"changing indexpath");
    itemModified = YES;
    indexPathsToBeUpdated = indexPaths;
}
@end
