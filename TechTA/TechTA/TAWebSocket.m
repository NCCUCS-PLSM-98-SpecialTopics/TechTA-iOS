//
//  TAWebSocket.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TAWebSocket.h"

@implementation TAWebSocket

@synthesize ws;
@synthesize parent;

- (void) startTAWebSocket:(UIViewController *)parent
{
    self.parent = parent;
    NSLog(@"Socket is opening");
    
    [self.ws open];
    
    //[self.ws sendText:@"Blue"];
    
    //continue processing other stuff
    //...
}

#pragma mark Lifecycle
- (id)init
{
    self = [super init];
    if (self)
    {
        //make sure to use the right url, it must point to your specific web socket endpoint or the handshake will fail
        //create a connect config and set all our info here
        WebSocketConnectConfig* config = [WebSocketConnectConfig configWithURLString:@"ws://140.119.164.155:8001/websocket/polling" origin:nil protocols:nil tlsSettings:nil headers:nil verifySecurityKey:YES extensions:nil ];
        
        config.closeTimeout = 15.0;
        config.keepAlive = 15.0; //sends a ws ping every 15s to keep socket alive
        
        //open using the connect config, it will be populated with server info, such as selected protocol/etc
        ws = [WebSocket webSocketWithConfig:config delegate:self] ;

    }
    return self;
    
}

- (void) sendMessage :(NSString*) aMessage
{
    [self.ws sendText:aMessage];
}



/**
 * Called when the web socket connects and is ready for reading and writing.
 **/
- (void) didOpen
{
    NSLog(@"Socket is open for business.");
}

/**
 * Called when the web socket closes. aError will be nil if it closes cleanly.
 **/
- (void) didClose:(NSUInteger) aStatusCode message:(NSString*) aMessage error:(NSError*) aError
{
    NSLog(@"WebSocket closed.");
}

/**
 * Called when the web socket receives an error. Such an error can result in the
 socket being closed.
 **/
- (void) didReceiveError:(NSError*) aError
{
    NSLog(@"Oops. An error occurred.");
}

/**
 * Called when the web socket receives a message.
 **/
- (void) didReceiveTextMessage:(NSString*) aMessage
{
    //Hooray! I got a message to print.
    NSLog(@"Did receive message: %@", aMessage);
    TASUPViewController* a =(TASUPViewController*)self.parent;
    [a ReciveMessage:aMessage];
    
}

/**
 * Called when the web socket receives a message.
 **/
- (void) didReceiveBinaryMessage:(NSData*) aMessage
{
    //Hooray! I got a binary message.
}

/**
 * Called when pong is sent... For keep-alive optimization.
 **/
- (void) didSendPong:(NSData*) aMessage
{
    NSLog(@"Yay! Pong was sent!");
}


@end
