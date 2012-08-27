//
//  RSUrlConnectionManager.m
//  test1
//
//  Created by 郭 輝平 on 2012/08/24.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import "RSUrlConnectionManager.h"

@implementation RSUrlConnectionManager
@synthesize isFinish;


-(void)request{
    
    
    NSString *urlString =@"http://www.google.co.jp";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    isFinish = [NSNumber numberWithBool:NO];
    
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request  delegate:self];
    
    

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:@"http://www.google.co.jp"]];
    NSLog(@"cookie:%@",cookies);

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"conncetion finish");
    isFinish = [NSNumber numberWithBool:YES];
}

@end
