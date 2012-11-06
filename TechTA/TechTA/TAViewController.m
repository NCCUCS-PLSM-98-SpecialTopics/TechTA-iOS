//
//  TAViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TAViewController.h"
#import "TAAppDelegate.h"

@interface TAViewController ()

@end

@implementation TAViewController


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
    TAMenuViewController* menuView =[[TAMenuViewController alloc] initWithNibName:@"TAMenuViewController" bundle:nil];
    [self.navigationController pushViewController:menuView animated:true];
}

@end
