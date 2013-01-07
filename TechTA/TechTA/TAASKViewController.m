//
//  TAASKViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/6.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TAASKViewController.h"
#import "SBJson.h"

@interface TAASKViewController ()<UITextViewDelegate>

@end

@implementation TAASKViewController

@synthesize questionField=_questionField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"問問題", @"問問題");
        
         if(self.myWS == nil){
            TAWebSocket *ws =  [[TAWebSocket alloc] init];
            [ws  startTAWebSocket:self];
            self.myWS = ws;
        }
         
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //設定連線位置
    NSString* test = [[NSString alloc]initWithFormat:@"http://jackliit.dyndns.tv:80/TechTA/api/GetMessageByClass?clid=%@",[self.classes valueForKey:@"clid"]];
    [request setURL:[NSURL URLWithString:test]];
    //設定連線方式
    [request setHTTPMethod:@"GET"];
    
    //轉換為NSData傳送
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* data2 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",data2);
    //NSMutableDictionary* getuserinfo = [data2 JSONValue];
    NSMutableArray* logarr=[data2 JSONValue];
    for (int i=0;i<[logarr count] ; i++) {
        if ([[[logarr objectAtIndex:i]valueForKey:@"role"]isEqualToString:@"student"]) {
            self.inputQ.text = [NSString stringWithFormat:@"匿名:%@\n%@",[[logarr objectAtIndex:i] valueForKey:@"content"],self.inputQ.text];
        }else{
        self.inputQ.text = [NSString stringWithFormat:@"%@ : %@\n%@",[[logarr objectAtIndex:i] valueForKey:@"account"],[[logarr objectAtIndex:i] valueForKey:@"content"],self.inputQ.text];
        }
    }
    
    
    NSArray *images = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"00001.png"],
                       [UIImage imageNamed:@"00002.png"],
                       [UIImage imageNamed:@"00003.png"],
                       [UIImage imageNamed:@"00004.png"],
                       [UIImage imageNamed:@"00005.png"],
                       [UIImage imageNamed:@"00006.png"],
                       [UIImage imageNamed:@"00007.png"],
                       [UIImage imageNamed:@"00008.png"],
                       [UIImage imageNamed:@"00009.png"],
                       [UIImage imageNamed:@"00010.png"],
                       [UIImage imageNamed:@"00011.png"],
                       [UIImage imageNamed:@"00012.png"],
                       [UIImage imageNamed:@"00013.png"],
                       [UIImage imageNamed:@"00014.png"],
                       [UIImage imageNamed:@"00015.png"],
                       [UIImage imageNamed:@"00016.png"],
                       [UIImage imageNamed:@"00017.png"],
                       [UIImage imageNamed:@"00018.png"],
                       [UIImage imageNamed:@"00019.png"],
                       [UIImage imageNamed:@"00020.png"],
                       [UIImage imageNamed:@"00021.png"],
                       [UIImage imageNamed:@"00022.png"],
                       [UIImage imageNamed:@"00023.png"],
                       [UIImage imageNamed:@"00024.png"],
                       [UIImage imageNamed:@"00025.png"],
                       [UIImage imageNamed:@"00026.png"],
                       [UIImage imageNamed:@"00027.png"],
                       [UIImage imageNamed:@"00028.png"],
                       [UIImage imageNamed:@"00029.png"],
                       [UIImage imageNamed:@"00030.png"],
                       [UIImage imageNamed:@"00031.png"],
                       [UIImage imageNamed:@"00032.png"],
                       [UIImage imageNamed:@"00033.png"],
                       [UIImage imageNamed:@"00034.png"],nil];
    self.coinImageView.animationImages=images;
    self.coinImageView.animationDuration = 0.7;
    self.coinImageView.animationRepeatCount = 1; // 0 = nonStop repeat
    //[self.coinImageView startAnimating];
    

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) textFieldShouldReturn:(UITextField *)theTextField
{
    NSLog(@"textFieldShouldReturn Fired :)");
    [_inputQ resignFirstResponder];
    //[textBoxLittle resignFirstResponder];
    return YES;
}

-(IBAction)editingEnded:(id)sender{
    [sender resignFirstResponder];
}


-(IBAction)dismissTheKeyBoard:(id)sender{
    [_questionField resignFirstResponder];
}

- (IBAction)buttonSendClickHandler:(id)sender
{
    //NSLog(@"classes : %@\nCourse : %@",[self.classes JSONRepresentation],[self.currentCourse JSONRepresentation]);
    if([[self.classes valueForKey:@"active"] isEqual:@"1"]){
        //NSString* roomid=[self.userInfo valueForKey:@"roomid"];
        NSArray* ks =[[NSArray alloc]initWithObjects:@"type",@"clid",@"account",@"role",@"content", nil];
        NSArray* obs = [[NSArray alloc] initWithObjects:@"message",[self.classes valueForKey:@"clid"],[self.userInfo valueForKey:@"account"],[self.userInfo valueForKey:@"role"],self.questionField.text, nil];
        NSMutableDictionary* megdict=[[NSMutableDictionary alloc] initWithObjects:obs forKeys:ks];
        NSString* message = [megdict JSONRepresentation];
        
        NSLog(@"message : %@ \n roomid = %@",message, [self.classes valueForKey:@"roomid"]);
        
        ks =[[NSArray alloc]initWithObjects:@"command",@"room",@"msg", nil];
        obs = [[NSArray alloc] initWithObjects:@"room",[self.classes valueForKey:@"roomid"],message, nil];
        NSMutableDictionary* inputDict = [[NSMutableDictionary alloc] initWithObjects:obs forKeys:ks];
        NSString *inputText = [inputDict JSONRepresentation];
        [self.myWS sendMessage:inputText];
        //NSLog(@"input : %@",inputText);
        self.inputQ.text = [NSString stringWithFormat:@"me :%@\n%@",self.questionField.text,self.inputQ.text];
    }
    else
        self.inputQ.text=[NSString stringWithFormat:@"Receive:chat room not open.\n%@",self.inputQ.text];
    
}



- (BOOL)ReciveMessage:(NSString*) aMessage
{
    NSMutableDictionary* msgdict = [aMessage JSONValue];
    if (msgdict!=nil) {
        if([[msgdict valueForKey:@"message"] isEqualToString:@"Message"]){
            NSString* datastr = [msgdict objectForKey:@"data"];
            NSMutableDictionary* datadict = [datastr JSONValue];
            if ([[datadict valueForKey:@"type"]isEqualToString:@"message"]) {
                if ([[datadict valueForKey:@"role"]isEqualToString:@"student"]) {
                    self.inputQ.text = [NSString stringWithFormat:@"匿名:%@\n%@",[datadict valueForKey:@"content"],self.inputQ.text];
                }else{
                self.inputQ.text = [NSString stringWithFormat:@"%@:%@\n%@",[datadict valueForKey:@"account"],[datadict valueForKey:@"content"],self.inputQ.text];
                }
            }else if([[datadict valueForKey:@"type"]isEqualToString:@"bonus"]){
                [self.coinImageView startAnimating];
            }
        }
    }
    return true;
}


@end
