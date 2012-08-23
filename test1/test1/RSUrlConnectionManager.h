//
//  RSUrlConnectionManager.h
//  test1
//
//  Created by 郭 輝平 on 2012/08/24.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSUrlConnectionManager : NSObject<NSURLConnectionDelegate>

@property NSNumber *isFinish;
-(void)request;


@end
