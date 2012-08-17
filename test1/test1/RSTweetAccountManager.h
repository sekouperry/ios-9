//
//  RSTweetAccountManager.h
//  test1
//
//  Created by 郭 輝平 on 2012/08/17.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface RSTweetAccountManager : NSObject

+ (ACAccount *)getAccount;

@end
