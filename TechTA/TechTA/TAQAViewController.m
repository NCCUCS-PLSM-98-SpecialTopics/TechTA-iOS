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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //設定連線位置
    NSString* test = [[NSString alloc]initWithFormat:@"http://jackliit.dyndns.tv:80/TechTA/api/GetQuizByClass?clid=%@",[self.classes valueForKey:@"clid"]];
    [request setURL:[NSURL URLWithString:test]];
    //設定連線方式
    [request setHTTPMethod:@"GET"];
    
    //轉換為NSData傳送
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* data2 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data2);
    //NSMutableDictionary* getuserinfo = [data2 JSONValue];
    NSMutableArray* logarr=[data2 JSONValue];
    for (int i=0;i<[logarr count] ; i++) {
        NSMutableDictionary* tempDict = [logarr objectAtIndex:i];
        if ([[tempDict valueForKey:@"active"]isEqualToString:@"1"]) {
            self.QADict=tempDict;
            break;
        }
    }
    [self refreshView];
    
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
    ks =[[NSArray alloc]initWithObjects:@"command",@"room",@"msg", nil];
    obs = [[NSArray alloc] initWithObjects:@"room",[self.classes valueForKey:@"roomid"],message, nil];
    NSMutableDictionary* inputDict = [[NSMutableDictionary alloc] initWithObjects:obs forKeys:ks];
    NSString *inputText = [inputDict JSONRepresentation];
    [self.myWS sendMessage:inputText];
    [self refreshView];
}
- (BOOL)ReciveMessage:(NSString*) aMessage
{
    NSMutableDictionary* msgdict = [aMessage JSONValue];
    if (msgdict!=nil) {
        if([[msgdict valueForKey:@"message"] isEqualToString:@"Message"]){
            NSString* datastr = [msgdict objectForKey:@"data"];
            NSMutableDictionary* datadict = [datastr JSONValue];
            if ([[datadict valueForKey:@"type"]isEqualToString:@"quiz"]) {
                self.QADict = datadict;
                [self refreshView];
            }else if ([[datadict valueForKey:@"type"]isEqualToString:@"quizclose"]){
                self.QADict=nil;
            }
            [self refreshView];

        }
    }
    
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
    [self sendAnswer:@"A"];
}
-(IBAction)bbuttonHandler:(id)sender
{
    [self sendAnswer:@"B"];
}
-(IBAction)cbuttonHandler:(id)sender
{
    [self sendAnswer:@"C"];
}
-(IBAction)dbuttonHandler:(id)sender
{
    [self sendAnswer:@"D"];
}

-(void)refreshView
{
    if (self.QADict==nil) {
        self.titleLabel.text=@"尚無問題";
        self.aButton.titleLabel.text=@"";
        self.bButton.titleLabel.text=@"";
        self.cButton.titleLabel.text=@"";
        self.dButton.titleLabel.text=@"";
    }
    else{

    self.titleLabel.text=[self.QADict valueForKey:@"question"];
    NSString* choicestr = [self.QADict valueForKey:@"choice"];
    NSMutableDictionary* choiceDict =[choicestr JSONValue];
    self.aButton.titleLabel.text = [choiceDict valueForKey:@"A"];
    self.bButton.titleLabel.text = [choiceDict valueForKey:@"B"];
    self.cButton.titleLabel.text = [choiceDict valueForKey:@"C"];
    self.dButton.titleLabel.text = [choiceDict valueForKey:@"D"];
        
    }
}

@end
