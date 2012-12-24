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
@property(nonatomic,strong)IBOutlet UITextField* AccountField;
@property(nonatomic,strong)IBOutlet UITextField* PassFileld;
@property(strong,nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property(nonatomic,strong) NSMutableDictionary* loginDictionary;



@property(nonatomic, strong)NSMutableURLRequest *request;


-(IBAction)loginButtonPressed:(id)sender;
-(IBAction)dismissTheKeyBoard:(id)sender;

@end
