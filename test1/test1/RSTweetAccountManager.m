//
//  RSTweetAccountManager.m
//  test1
//
//  Created by 郭 輝平 on 2012/08/17.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import "RSTweetAccountManager.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@implementation RSTweetAccountManager

static ACAccount  *account;

//システムtwitterアカウントをゲット
+ (ACAccount *)getAccount{
    
    if(!account){
        
        __block  ACAccount  *firstAccount;
        
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *twitterAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [accountStore requestAccessToAccountsWithType:twitterAccountType
                                withCompletionHandler:^(BOOL granted, NSError *error)
         {
             if (!granted) {
                 NSLog(@"ユーザーがアクセスを拒否しました。");
             }else{
                 NSLog(@"ユーザーがアクセスを許可しました。");
                 NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterAccountType];
                 if ([twitterAccounts count] > 0) {
                    firstAccount = [twitterAccounts objectAtIndex:0];
                 }
             }
         }];
        
        return firstAccount;
    }
    
    return  account;
}

@end
