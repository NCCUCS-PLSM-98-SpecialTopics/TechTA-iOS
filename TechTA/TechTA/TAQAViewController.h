//
//  TAQAViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/6.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAWebSocket.h"

@interface TAQAViewController : UIViewController

@property (nonatomic,retain) IBOutlet UIButton* aButton;
@property (nonatomic,retain) IBOutlet UIButton* bButton;
@property (nonatomic,retain) IBOutlet UIButton* cButton;
@property (nonatomic,retain) IBOutlet UIButton* dButton;
@property (nonatomic,retain) IBOutlet UILabel* titleLabel;
@property (strong, nonatomic) TAWebSocket* myWS ;
@property (strong, nonatomic) NSMutableDictionary* QADict;
@property (strong, nonatomic) NSMutableDictionary* userInfo;
@property (strong, nonatomic) NSString* chatid;
@property (strong, nonatomic) NSMutableDictionary* classes;




-(IBAction)backToList:(id)sender;

- (void)sendRequests:(NSString*) aMessage;
- (void)sendAnswer:(NSString*) aMessage;
- (BOOL)ReciveMessage:(NSString*) aMessage;
-(void)socketOpened;

-(IBAction)abuttonHandler:(id)sender;
-(IBAction)bbuttonHandler:(id)sender;
-(IBAction)cbuttonHandler:(id)sender;
-(IBAction)dbuttonHandler:(id)sender;

@end
