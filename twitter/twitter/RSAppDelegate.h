//
//  RSAppDelegate.h
//  twitter
//
//  Created by 郭 輝平 on 2012/08/17.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSViewController;

@interface RSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RSViewController *viewController;

@end
