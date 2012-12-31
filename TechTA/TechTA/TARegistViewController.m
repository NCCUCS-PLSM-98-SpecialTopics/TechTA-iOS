//
//  TARegistViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/10.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TARegistViewController.h"
#import "TAMenuViewController.h"
#import "SBJson.h"

@interface TARegistViewController ()
@property NSString* test;

@end

@implementation TARegistViewController

@synthesize AccountLabel=_AccountLabel;
@synthesize PassLabel=_PassLabel;
@synthesize NameField=_NameField;
@synthesize EmailField=_EmailField;
@synthesize AccountName=_AccountName;
@synthesize PassName=_PassName;
@synthesize NameName=_NameName;
@synthesize EmailName=_EmailName;
@synthesize connection;
@synthesize spinner;
@synthesize roleSegmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _AccountLabel.text=_AccountName;
    _EmailField.text=_EmailName;
    [self.spinner stopAnimating];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAccountPassword:(NSString *)Account :(NSString *)Password{
    _AccountName=Account;
    _PassName=Password;
    _EmailName=[[NSString alloc]initWithFormat:@"%@@nccu.edu.tw",Account];
        
    
}
-(IBAction)registbuttonPressed:(id)sender;
{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //宣告要post的值
    NSString *httpBodyString=[NSString stringWithFormat:@"account=%@&password=%@&name=%@&email=%@&department=%@",_AccountName,_PassName,_NameField.text,_EmailField.text,[roleSegmentedControl titleForSegmentAtIndex:roleSegmentedControl.selectedSegmentIndex]];
    NSLog(@"httpBodyString = %@",httpBodyString);
    //設定連線位置
    [request setURL:[connection URLByAppendingPathComponent:@"TechTA/api/CreateAccount"]];
    //設定連線方式
    [request setHTTPMethod:@"POST"];
    //將編碼改為UTF8
    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSLog(@"%@",request);
    
    //轉換為NSData傳送
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //看request出來的值
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSString *data2 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary* registdiction=[data2 JSONValue];
    
    NSString* loginresultstring = [registdiction valueForKey:@"result"];
    NSLog(@"%@",loginresultstring);
    switch ([loginresultstring intValue]) {
    }
    
    TAMenuViewController* menuView =[[TAMenuViewController alloc] initWithNibName:@"TAMenuViewController" bundle:nil];
    [menuView setConnection:connection];
    [self.navigationController pushViewController:menuView animated:true];
}

-(void) setConnection:(NSURL *)theConnection
{
    connection=theConnection;
}

-(IBAction)dismissTheKeyBoard:(id)sender{
    [_NameField resignFirstResponder];
    [_EmailField resignFirstResponder];
}

-(void)threadStartAnimating:(id)data
{
    [spinner startAnimating];
}

@end
