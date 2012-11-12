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

@interface TAViewController ()

@end

@implementation TAViewController

@synthesize AccountField=_AccountField;
@synthesize PassFileld=_PassFileld;

-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
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
    NSNumber* tempwsreturn=[[NSNumber alloc]initWithInt:2];
    switch (tempwsreturn.intValue) {
        case 1:{
            TAMenuViewController* menuView =[[TAMenuViewController alloc] initWithNibName:@"TAMenuViewController" bundle:nil];
            [self.navigationController pushViewController:menuView animated:true];
            break;
        };
        case 2:{
            TARegistViewController* registView=[[TARegistViewController alloc] initWithNibName:@"TARegistViewController" bundle:nil];
            [registView setAccountPassword:_AccountField.text :_PassFileld.text];
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

@end
