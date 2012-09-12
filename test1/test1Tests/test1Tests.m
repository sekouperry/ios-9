//
//  test1Tests.m
//  test1Tests
//
//  Created by 郭 輝平 on 2012/08/11.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import "test1Tests.h"
#import "RSConnectionManager.h"

@implementation test1Tests

RSConnectionManager *connectionManager;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    connectionManager = [[RSConnectionManager alloc]init];
}

- (void)tearDown
{
    // Tear-down code here.
    connectionManager = nil;
    [super tearDown];
}

- (void)testExample
{
    [connectionManager request:@"http://www.google.co.jp"];
    
    STAssertNotNil(connectionManager, @"connection manager must no nil");
}

@end
