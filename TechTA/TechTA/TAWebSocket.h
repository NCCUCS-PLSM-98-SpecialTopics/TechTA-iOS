//
//  TAWebSocket.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebSocket.h"
#import "TASUPViewController.h"

@interface TAWebSocket : NSObject<WebSocketDelegate>
{
@private WebSocket* ws;
    UIViewController * parent;
}

@property (nonatomic, readonly) WebSocket* ws;
@property (nonatomic, strong) UIViewController* parent;


- (void) startTAWebSocket:(UIViewController *)parent;
- (void) sendMessage :(NSString*) aMessage;

@end
