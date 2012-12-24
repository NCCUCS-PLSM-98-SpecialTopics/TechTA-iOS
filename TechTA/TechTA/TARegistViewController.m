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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _AccountLabel.text=_AccountName;
    _EmailField.text=_EmailName;
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
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //宣告一個 NSURL 並給予記憶體空間、連線位置
    NSURL *connection = [[NSURL alloc] initWithString:@"http://jackliit.dyndns.tv:8080/TechTA/api/UpdateAccount"];
    //宣告要post的值
    NSString *httpBodyString=[NSString stringWithFormat:@"account=%@&password=%@&name=%@&email=%@",_AccountName,_PassName,_NameField.text,_EmailField.text];
    NSLog(@"httpBodyString = %@",httpBodyString);
    //設定連線位置
    [request setURL:connection];
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
    
    
    TAMenuViewController* menuView =[[TAMenuViewController alloc] initWithNibName:@"TAMenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuView animated:true];
}

-(IBAction)dismissTheKeyBoard:(id)sender{
    [_NameField resignFirstResponder];
    [_EmailField resignFirstResponder];
}

@end
