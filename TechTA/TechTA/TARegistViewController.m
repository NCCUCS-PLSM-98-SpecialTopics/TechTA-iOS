//
//  TARegistViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/10.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TARegistViewController.h"
#import "TAMenuViewController.h"

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
    TAMenuViewController* menuView =[[TAMenuViewController alloc] initWithNibName:@"TAMenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuView animated:true];
}

-(IBAction)dismissTheKeyBoard:(id)sender{
    [_NameField resignFirstResponder];
    [_EmailField resignFirstResponder];
}

@end
