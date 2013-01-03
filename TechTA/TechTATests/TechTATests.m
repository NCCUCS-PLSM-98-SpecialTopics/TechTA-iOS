//
//  TechTATests.m
//  TechTATests
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TechTATests.h"
#import "TAQAListViewController.h"


@implementation TechTATests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    UIWindow* window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    TAQAListViewController* qaView=[[TAQAListViewController alloc]initWithNibName:@"TAQAListViewController" bundle:nil];
    UITabBarController* abBarController = [[UITabBarController alloc]init];
    abBarController.viewControllers=[[NSArray alloc]initWithObjects:qaView, nil];
    UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:abBarController];
    
    window.rootViewController=navi;
    [window makeKeyAndVisible];
    
    
}

@end
