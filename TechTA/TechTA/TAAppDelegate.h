//
//  TAAppDelegate.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TAViewController;

@interface TAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UINavigationController* navController;
@property (strong, nonatomic) TAViewController *viewController;

@end
