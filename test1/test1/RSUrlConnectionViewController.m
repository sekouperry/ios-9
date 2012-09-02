//
//  RSUrlConnectionViewController.m
//  test1
//
//  Created by 郭 輝平 on 2012/08/24.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import "RSUrlConnectionViewController.h"
#import "RSConnectionManager.h"
#import "SBJson.h"

@interface RSUrlConnectionViewController ()

@end

@implementation RSUrlConnectionViewController
{
    RSConnectionManager *connectionManager;
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
    
    connectionManager =[[RSConnectionManager alloc]init];
    
//    [connectionManager request:@"http://www.google.co.jp" method:@"post " params:[NSDictionary dictionaryWithObjectsAndKeys:@"myname",@"name",@"password",@"ps", nil]];
    
    [connectionManager request:@"http://www.google.co.jp" method:@"post " params:nil];

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
