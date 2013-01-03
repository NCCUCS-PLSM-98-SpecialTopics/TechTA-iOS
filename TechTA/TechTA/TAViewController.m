//
//  TAViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TAViewController.h"
#import "TAAppDelegate.h"
#import "TAMenuViewController.h"
#import "TARegistViewController.h"
#import "SBJson.h"

@interface TAViewController ()

@end

@implementation TAViewController

@synthesize AccountField=_AccountField;
@synthesize PassFileld=_PassFileld;
@synthesize loginDictionary=_loginDictionary;
@synthesize spinner;

@synthesize request;

-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [_PassFileld setSecureTextEntry:YES];
    [self.spinner stopAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonPressed:(id)sender
{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    //NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request=[[NSMutableURLRequest alloc] init];
    //宣告一個 NSURL 並給予記憶體空間、連線位置
    NSURL *connection = [[NSURL alloc] initWithString:@"http://jackliit.dyndns.tv:80/"];
    //宣告要post的值
    NSString *httpBodyString=[NSString stringWithFormat:@"account=%@&password=%@",_AccountField.text,_PassFileld.text];
    NSLog(@"httpBodyString = %@",httpBodyString);
    //設定連線位置
    [request setURL:[connection URLByAppendingPathComponent:@"TechTA/api/LoginAccount"]];
    //設定連線方式
    [request setHTTPMethod:@"POST"];
    //將編碼改為UTF8
    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSLog(@"%@",request);
    
    
    //轉換為NSData傳送
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //看request出來的值
    NSLog(@"first : %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSString *data2 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    _loginDictionary=[data2 JSONValue];
    
    
    
    
    NSNumber* tempwsreturn=[[NSNumber alloc]initWithInt:2];
    NSString* loginresultstring = [_loginDictionary valueForKey:@"result"];
    NSLog(@"%@",loginresultstring);
    switch ([loginresultstring intValue]) {
    //switch ([tempwsreturn intValue]) {
        case 0:{
            TAMenuViewController* menuView =[[TAMenuViewController alloc] initWithNibName:@"TAMenuViewController" bundle:nil];
            [menuView setConnection:connection];
            [self.navigationController pushViewController:menuView animated:true];
            break;
        }
        case 1:{
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                              message:@"Wrong account or password."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
        case 2:{
            TARegistViewController* registView=[[TARegistViewController alloc] initWithNibName:@"TARegistViewController" bundle:nil];
            [registView setAccountPassword:_AccountField.text :_PassFileld.text];
            [registView setConnection:connection];
            [self.navigationController pushViewController:registView animated:true];
            break;
        }
        default:
            break;
    }
    
    
    

}

-(IBAction)dismissTheKeyBoard:(id)sender{
    [_AccountField resignFirstResponder];
    [_PassFileld resignFirstResponder];
}

-(void)threadStartAnimating:(id)data
{
    [spinner startAnimating];
}


@end
