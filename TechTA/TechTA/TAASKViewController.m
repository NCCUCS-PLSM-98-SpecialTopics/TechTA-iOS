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
                self.inputQ.text = [NSString stringWithFormat:@"%@:%@\n%@",[datadict valueForKey:@"account"],[datadict valueForKey:@"content"],self.inputQ.text];
            }
        }
    }
    return true;
}


@end
