//
//  RSViewController.m
//  test1
//
//  Created by 郭 輝平 on 2012/08/11.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import "RSViewController.h"
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
    
    
    [self createTwitterAccount];
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



- (void)createTwitterAccount{
    NSString *token = @"264565421-pvseKeYPjHS77rd5uKl78FfFl03qkYVIGbtrGbQz";
    NSString *secret = @"YdUSY9dllObvvQiQKGa9GgIBeQyb73wiih3OXWrjgTk";
    ACAccountStore *store = [[ACAccountStore alloc] init];
    
    //  Each account has a credential, which is comprised of a verified token and secret
    ACAccountCredential *credential =
    [[ACAccountCredential alloc] initWithOAuthToken:token tokenSecret:secret];
    
    //  Obtain the Twitter account type from the store
    ACAccountType *twitterAcctType =
    [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    //  Create a new account of the intended type
    ACAccount *newAccount = [[ACAccount alloc] initWithAccountType:twitterAcctType];
    
    //  Attach the credential for this user
    newAccount.credential = credential;
    
    //  Request access from the user for access to his Twitter accounts
    [store requestAccessToAccountsWithType:twitterAcctType withCompletionHandler:^(BOOL granted, NSError *error) {
        if (!granted) {
            // The user rejected your request
            NSLog(@"User rejected access to his account.");
        }
        else {
            // Grab the available accounts
            NSArray *twitterAccounts =
            [store accountsWithAccountType:twitterAcctType];
            ACAccount *account = [twitterAccounts objectAtIndex:0];
            if ([twitterAccounts count] > 0) {
                NSURL *url = [NSURL URLWithString:@"https://upload.twitter.com/1/statuses/update_with_media.json"];
                
                //  Create a POST request for the target endpoint
                TWRequest *request =
                [[TWRequest alloc] initWithURL:url
                                    parameters:nil
                                 requestMethod:TWRequestMethodPOST];
                
                //  self.accounts is an array of all available accounts;
                //  we use the first one for simplicity
                [request setAccount:account];
                
                //  The "larry.png" is an image that we have locally
                UIImage *image = [UIImage imageNamed:@"angelina.jpg"];
                
                //  Obtain NSData from the UIImage
                NSData *imageData = UIImagePNGRepresentation(image);
                
                //  Add the data of the image with the
                //  correct parameter name, "media[]"
                [request addMultiPartData:imageData
                                 withName:@"media[]"
                                     type:@"multipart/form-data"];
                
                // NB: Our status must be passed as part of the multipart form data
                NSString *status = @"just setting up my twttr #iOS5";
                
                //  Add the data of the status as parameter "status"
                [request addMultiPartData:[status dataUsingEncoding:NSUTF8StringEncoding]
                                 withName:@"status"
                                     type:@"multipart/form-data"];
                
                //  Perform the request.
                //    Note that -[performRequestWithHandler] may be called on any thread,
                //    so you should explicitly dispatch any UI operations to the main thread
                [request performRequestWithHandler:
                 ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                     NSDictionary *dict =
                     (NSDictionary *)[NSJSONSerialization
                                      JSONObjectWithData:responseData options:0 error:nil];
                     
                     // Log the result
                     NSLog(@"%@", dict);
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // perform an action that updates the UI...
                     });
                 }];
                
                
                
                
            } // if ([twitterAccounts count] > 0)
        } // if (granted) 
    }];
}

-(void)createTweetButtonPushed{

    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *composeViewController = [[TWTweetComposeViewController alloc]init];
        [self presentModalViewController:composeViewController animated:YES];
    }
}

-(IBAction)tweetButtonPushed:(id)sender{
    
    TWTweetComposeViewController *twitterSheet = [[TWTweetComposeViewController alloc]init];
    
    [twitterSheet setInitialText:@"test app twitter"];
    
    [self presentModalViewController:twitterSheet animated:YES];
    
    NSLog(@"%@",tweetTextField.text);
}

@end
