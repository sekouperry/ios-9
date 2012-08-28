//
//  RSUrlConnectionViewController.m
//  test1
//
//  Created by 郭 輝平 on 2012/08/24.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import "RSUrlConnectionViewController.h"
#import "RSUrlConnectionManager.h"
#import "SBJson.h"

@interface RSUrlConnectionViewController ()

@end

@implementation RSUrlConnectionViewController
{
    CFRunLoopRef currentLoop;
    RSUrlConnectionManager *manager;
}
@synthesize label;

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
    
    if(label.text == @"Label"){
        //创建一个新的线程，其中object:nil部分可以作为selector的参数传递，在这里没有参数，设为nil
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(playerThread) object:nil];
        
        //开启线程，如果是利用NSOperation，只需要加入到NSOperationQueue里面去就好了，queue自己会在合适的时机执行线程，而不需要程序员自己去控制。
        [thread start];
    }else{
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        NSArray *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:@"http://www.google.co.jp"]];
        NSLog(@"cookie:%@",cookies);
        label.text = [cookies description];
    }
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void) playerThread
{
    @autoreleasepool {
     currentLoop = CFRunLoopGetCurrent();//子线程的runloop引用

    //run loop
    [self initPlayer];
    //CFRunLoopRun,Runs the current thread’s CFRunLoop object in its default mode indefinitely.
    CFRunLoopRun();
    }
    
    NSLog(@"conncetion next");

}
// 实现一个timer,用于检查子线程的工作状态，并在合适的时候做任务切换。或者是合适的时候停掉
// 自己的run loop
-(void) initPlayer
{
    manager = [[RSUrlConnectionManager alloc]init];
    
    [manager request];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkState:) userInfo:nil repeats:YES];
           
}
-(void) checkState:(NSTimer*) timer
{
    if(manager.isFinish)
    {
        
        NSLog(@"ok");
    
        [self parse:@"{\"name\": \"John Smith\", \"age\": 33}"];
        //释放子线程里面的资源
        //释放资源的代码....
        /*结束子线程任务 CFRunLoopStop,This function forces rl to stop running and
         return control to the function that called CFRunLoopRun or CFRunLoopRunInMode
         for the current run loop activation. If the run loop is nested with a callout
         from one activation starting another activation running, only the innermost
         activation is exited.*/
        CFRunLoopStop(currentLoop);
        
        
    }
}

-(void)parse:(NSString *)jsonString{
    
    SBJsonParser  *parser = [[SBJsonParser alloc] init];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    writer.humanReadable = YES;
    writer.sortKeys = YES;
    
    id object = [parser objectWithString:jsonString];
    if (object) {
        NSLog(@"%@",[writer stringWithObject:object]);
    } else {
        NSLog(@"An error occurred: %@", parser.error);
    }
}

@end
