//
//  TALogTestViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/20.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAWebSocket.h"

@interface TALogTestViewController : UIViewController


@property(strong,nonatomic) IBOutlet UITextView* testtext;
@property(strong,nonatomic) IBOutlet UIButton* starttest;
@property (strong, nonatomic) TAWebSocket* myWS ;

-(void) startTest;
-(IBAction)startButtonPushed:(id)sender;
- (BOOL)ReciveMessage:(NSString*) aMessage;


@end
