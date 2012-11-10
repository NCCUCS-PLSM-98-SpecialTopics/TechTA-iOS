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
    NSNumber* tempwsreturn=[[NSNumber alloc]initWithInt:1];
    switch (tempwsreturn.intValue) {
        case 1:{
            TAMenuViewController* menuView =[[TAMenuViewController alloc] initWithNibName:@"TAMenuViewController" bundle:nil];
            [self.navigationController pushViewController:menuView animated:true];
            break;
        };
        case 2:{
            
        }
        default:
            break;
    }
    
    
    /*
    UINavigationController* navController;
    navController=[[UINavigationController alloc]initWithRootViewController:menuView];
    [self.view.superview addSubview:navController.view];
    [self.view removeFromSuperview];
     */

}

@end
