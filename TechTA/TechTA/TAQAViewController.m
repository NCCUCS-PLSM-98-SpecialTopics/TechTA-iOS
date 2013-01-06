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
-(void)viewDidAppear:(BOOL)animated
{
    self.titleLabel.text=[self.QADict valueForKey:@"question"];
    self.aButton.titleLabel.text = [self.QADict valueForKey:@"A"];
    self.bButton.titleLabel.text = [self.QADict valueForKey:@"B"];
    self.cButton.titleLabel.text = [self.QADict valueForKey:@"C"];
    self.dButton.titleLabel.text = [self.QADict valueForKey:@"D"];
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
    NSArray* ks =[[NSArray alloc]initWithObjects:@"type",@"clid",@"qid",@"account",@"content", nil];
    NSArray* obs = [[NSArray alloc] initWithObjects:@"answer",[self.QADict valueForKey:@"clid"],[self.QADict valueForKey:@"qid"],[self.userInfo valueForKey:@"account"],aMessage ,nil];
    NSMutableDictionary* megdict=[[NSMutableDictionary alloc] initWithObjects:obs forKeys:ks];
    NSString* message = [megdict JSONRepresentation];
}
- (BOOL)ReciveMessage:(NSString*) aMessage
{
    
    
}
-(void)socketOpened
{
    if(self.userInfo ==nil){
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                          message:@"Something was Wrong."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        self.chatid = [self.userInfo valueForKey:@"chatid"];
        NSArray* obs = [[NSArray alloc] initWithObjects:@"login",self.chatid, nil];
        NSArray* ks =[[NSArray alloc]initWithObjects:@"command",@"user", nil];
        NSMutableDictionary* inputDict = [[NSMutableDictionary alloc] initWithObjects:obs forKeys:ks];
        NSString *inputText = [inputDict JSONRepresentation];
        [self.myWS sendMessage:inputText];
        NSLog(@"%@",inputText);
        
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
