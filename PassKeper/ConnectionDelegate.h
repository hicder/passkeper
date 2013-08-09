//
//  ConnectionDelegate.h
//  PassKeper
//
//  Created by Hieu on 8/9/13.
//  Copyright (c) 2013 Hieu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionDelegate : NSObject
+(NSURLConnection * ) makePOSTrequestwithURL:(NSString*)url withUsername:(NSString *)_username andPassword:(NSString *)_password;
@end
