//
//  TAASKViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/6.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAWebSocket.h"

@interface TAASKViewController : UIViewController


@property(nonatomic,strong)IBOutlet UITextView* inputQ;
@property (nonatomic, strong) IBOutlet UITextField* questionField;
@property (strong, nonatomic) TAWebSocket* myWS ;
@property (strong, nonatomic) NSMutableDictionary* currentCourse;
@property (strong, nonatomic) NSMutableDictionary* userInfo;
@property (strong, nonatomic) NSString* chatid;
@property (strong, nonatomic) NSMutableDictionary* classes;
@property(nonatomic,strong)NSURL *connection;


- (IBAction)buttonSendClickHandler:(id)sender;

- (void)sendRequests;
- (BOOL)ReciveMessage:(NSString*) aMessage;
-(void)socketOpened;



@end

