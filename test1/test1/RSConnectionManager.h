//
//  RSConnectionManager.h
//  test1
//
//  Created by 郭 輝平 on 2012/09/02.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSConnectionManager : NSObject

-(void)request:(NSString *)urlString;

-(void)request:(NSString *)urlString method:(NSString *)method params:(NSDictionary *)params;

-(void)request:(NSString *)urlString method:(NSString *)method params:(NSDictionary *)params header:(NSDictionary *)header;

@end
