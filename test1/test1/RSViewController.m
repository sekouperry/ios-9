//
//  RSViewController.m
//  test1
//
//  Created by 郭 輝平 on 2012/08/11.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import "RSViewController.h"
#import "RSTweetAccountManager.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface RSViewController ()

@end

@implementation RSViewController

@synthesize tweetTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *createTweetButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(createTweetButtonPushed)];
    [self.navigationController.navigationBar.topItem setRightBarButtonItem:createTweetButton ];
    
    
    [self getTimeLine:[RSTweetAccountManager getAccount]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



-(void)getTimeLine:(ACAccount *)tweetAccount{
    if (tweetAccount) {
        NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
        TWRequest *request = [[TWRequest alloc] initWithURL:url
                                                 parameters:nil
                                              requestMethod:TWRequestMethodGET];
        [request setAccount:tweetAccount];
        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
         {
             if(!responseData){
                 NSLog(@"%@", error);
             }else{
                 NSLog(@"responseData = %@", responseData);
             } 
         }];
    }
}


-(void)createTweetButtonPushed{

    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *composeViewController = [[TWTweetComposeViewController alloc]init];
        [composeViewController setInitialText:@"test app twitter"];
        [self presentModalViewController:composeViewController animated:YES];
    }
}


@end
