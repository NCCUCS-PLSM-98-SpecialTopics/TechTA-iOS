//
//  TARegistViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/10.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TARegistViewController : UIViewController

@property(nonatomic,strong)IBOutlet UILabel* AccountLabel;
@property(nonatomic,strong)IBOutlet UILabel* PassLabel;
@property(nonatomic,strong)IBOutlet UITextField* NameField;
@property(nonatomic,strong)IBOutlet  UITextField* EmailField;
@property(nonatomic,strong)NSString* AccountName;
@property(nonatomic,strong)NSString* PassName;
@property(nonatomic,strong)NSString* NameName;
@property(nonatomic,strong)NSString* EmailName;


-(void)setAccountPassword:(NSString*)Account:(NSString*)Password;
-(IBAction)registbuttonPressed:(id)sender;
-(IBAction)dismissTheKeyBoard:(id)sender;

@end
