//
//  TAViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/5.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASUPViewController.h"


@interface TAViewController :TASUPViewController

@property(strong,nonatomic) IBOutlet UIButton* loginbutton;
//@property(strong,nonatomic) TAMenuViewController* menuView;

-(IBAction)loginButtonPressed:(id)sender;

@end
