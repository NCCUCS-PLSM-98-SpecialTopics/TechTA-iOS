//
//  TAMenuViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/6.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASUPViewController.h"

#import "TAQAViewController.h"
#import "TAASKViewController.h"
#import "TAPollViewController.h"

@interface TAMenuViewController : TASUPViewController


@property (strong, nonatomic) IBOutlet UITableView *menuTableView;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray* CourseArray;

@property (nonatomic, retain)  NSMutableURLRequest *testrequest;

-(IBAction)logoutButtonPressed:(id)sender;

-(void)testrequest:(NSMutableURLRequest*) testre;


@end
