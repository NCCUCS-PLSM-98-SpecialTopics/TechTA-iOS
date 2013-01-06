//
//  TAMenuViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/6.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAClassesListViewController.h"
#import "TASUPViewController.h"
#import "TAQAViewController.h"
#import "TAASKViewController.h"
#import "TAPollViewController.h"
#import "WebSocket.h"

@interface TAMenuViewController : TASUPViewController


@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property(strong,nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray* CourseArray;
@property (nonatomic, retain) NSMutableArray* classArray;
@property (nonatomic, retain) NSString* userid;
@property (strong, nonatomic) NSMutableDictionary* userInfo;
@property(nonatomic,strong)NSURL *connection;
@property (strong, nonatomic) TAWebSocket* myWS ;



-(IBAction)logoutButtonPressed:(id)sender;
-(void) setConnection:(NSURL *)theConnection;




@end
