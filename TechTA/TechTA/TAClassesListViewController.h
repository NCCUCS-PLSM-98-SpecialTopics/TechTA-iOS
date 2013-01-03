//
//  TAClassesListViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 13/1/3.
//  Copyright (c) 2013年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASUPViewController.h"
#import "TAQAViewController.h"
#import "TAASKViewController.h"
#import "TAPollViewController.h"

@interface TAClassesListViewController : UIViewController



@property (strong, nonatomic) IBOutlet UITableView *menuTableView;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray* classArray;
@property (nonatomic, retain) NSMutableDictionary* currentcourse;
@property (strong, nonatomic) NSMutableDictionary* userInfo;
@property(nonatomic,strong)NSURL *connection;



-(IBAction)logoutButtonPressed:(id)sender;
-(void) setConnection:(NSURL *)theConnection;


@end
