//
//  TAASKViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/6.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TAASKViewController.h"

@interface TAASKViewController ()<UITextViewDelegate>

@end

@implementation TAASKViewController

@synthesize inputQ=_inputQ;
@synthesize questionField=_questionField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"問問題", @"問問題");
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
