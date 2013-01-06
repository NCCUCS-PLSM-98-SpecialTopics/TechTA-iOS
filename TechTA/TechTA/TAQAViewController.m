//
//  TAQAViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/6.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TAQAViewController.h"
#import "SBJson.h"

@interface TAQAViewController ()

@end

@implementation TAQAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"問答", @"問答");
        TAWebSocket *ws =  [[TAWebSocket alloc] init];
        [ws  startTAWebSocket:self];
        self.myWS = ws;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backToList:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendRequests:(NSString*) aMessage
{
    
}
- (void)sendAnswer:(NSString*) aMessage
{
    
}
- (BOOL)ReciveMessage:(NSString*) aMessage
{
    NSMutableDictionary* msgdict = [aMessage JSONValue];
    if (msgdict!=nil) {
        if([[msgdict valueForKey:@"message"] isEqualToString:@"Message"]){
            NSString* datastr = [msgdict objectForKey:@"data"];
            NSMutableDictionary* datadict = [datastr JSONValue];
        }
    }
    
}

-(IBAction)abuttonHandler:(id)sender
{
    [self sendRequests:@"A"];
}
-(IBAction)bbuttonHandler:(id)sender
{
    [self sendRequests:@"B"];
}
-(IBAction)cbuttonHandler:(id)sender
{
    [self sendRequests:@"C"];
}
-(IBAction)dbuttonHandler:(id)sender
{
    [self sendRequests:@"D"];
}

@end
