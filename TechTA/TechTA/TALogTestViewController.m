//
//  TALogTestViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/20.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TALogTestViewController.h"
#import "SBJson.h"

@interface TALogTestViewController ()

@end

@implementation TALogTestViewController

@synthesize testtext = _testtext;
@synthesize myWS=_myWS;

-(void) startTest
{
    self.testtext.text = [NSString stringWithFormat:@"Start test."];
    
    self.testtext.text = [NSString stringWithFormat:@"%@\nStart testing HTTPRequest.",self.testtext.text];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //宣告一個 NSURL 並給予記憶體空間、連線位置
    //NSURL *connection = [[NSURL alloc] initWithString:@"http://api.ezcomet.com/write"];
    NSURL *connection = [[NSURL alloc] initWithString:@"http://140.119.164.163:8080/TechTA/api/GetCourse"];
    //宣告要post的值
    NSString *qname=[NSString stringWithFormat:@"q0423546006-my_channel"];
    //NSString *httpBodyString=[NSString stringWithFormat:@"qname=q0423546006-my_channel&api_key=675dc209df5e4ff59e021a1a33547f69&msg=hello"];
    NSString *httpBodyString=[NSString stringWithFormat:@""];
    //NSLog(@"httpBodyString = %@",httpBodyString);
    //設定連線位置
    [request setURL:connection];
    //設定連線方式
    [request setHTTPMethod:@"GET"];
    //[request setHTTPMethod:@"POST"];
    //將編碼改為UTF8
    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //轉換為NSData傳送
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //看request出來的值
    //NSLog(@"data : %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSString *data2 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];    //看request出來的值
    NSMutableArray* item=[data2 JSONValue];
    
    
    NSMutableDictionary* course=[item objectAtIndex:0];
    NSLog(@"key : %@",[course valueForKey:@"cid"]);

    self.testtext.text = [NSString stringWithFormat:@"%@\n code is %@",self.testtext.text,[item valueForKey:@"code"]];
    self.testtext.text = [NSString stringWithFormat:@"%@\nHTTPRequest test finish.\n",self.testtext.text];

    
    self.testtext.text = [NSString stringWithFormat:@"%@\nStart testing WebSocket.",self.testtext.text];
    NSString* testWSstring1 =[[NSString alloc]initWithString:@"text sent"];
    [self.myWS sendMessage:testWSstring1];
    self.testtext.text = [NSString stringWithFormat:@"%@\nSend message : \"%@\"",self.testtext.text,testWSstring1];
    
    
}

-(IBAction)startButtonPushed:(id)sender
{
    [self startTest];
}

- (BOOL)ReciveMessage:(NSString*) aMessage
{
    self.testtext.text = [NSString stringWithFormat:@"\n%@Receive Message : \"%@\"",self.testtext.text,aMessage];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=NSLocalizedString(@"Log", @"Log");
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //[super viewDidLoad];
    if(self.myWS == nil){
        TAWebSocket *ws =  [[TAWebSocket alloc] init];
        [ws  startTAWebSocket:self];
        self.myWS = ws;
    }
    [self startTest];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
