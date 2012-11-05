//
//  TASUPViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

//
//all ViewController related to websocket should inherit this controller

#import <UIKit/UIKit.h>

@interface TASUPViewController : UIViewController

- (BOOL)ReciveMessage:(NSString*) aMessage;
    //to define what will act when receive websocket message.

@end
