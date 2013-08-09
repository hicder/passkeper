//
//  ConnectionDelegate.m
//  PassKeper
//
//  Created by Hieu on 8/9/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import "ConnectionDelegate.h"

@implementation ConnectionDelegate
+(NSURLConnection * ) makePOSTrequestwithURL:(NSString*)url withUsername:(NSString *)_username andPassword:(NSString *)_password{
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
@end
