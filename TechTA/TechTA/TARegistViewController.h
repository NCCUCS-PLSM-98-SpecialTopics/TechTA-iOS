//
//  TARegistViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 12/11/10.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TARegistViewController : UIViewController{
    IBOutlet UISegmentedControl *roleSegmentedControl;
}

@property(nonatomic,strong)IBOutlet UILabel* AccountLabel;
@property(nonatomic,strong)IBOutlet UILabel* PassLabel;
@property(nonatomic,strong)IBOutlet UITextField* NameField;
@property(nonatomic,strong)IBOutlet  UITextField* EmailField;
@property(nonatomic,strong)NSString* AccountName;
@property(nonatomic,strong)NSString* PassName;
@property(nonatomic,strong)NSString* NameName;
@property(nonatomic,strong)NSString* EmailName;
@property(nonatomic,strong)NSURL *connection;
@property(strong,nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic,retain) IBOutlet UISegmentedControl *roleSegmentedControl;


-(void)setAccountPassword:(NSString*)Account:(NSString*)Password;
-(IBAction)registbuttonPressed:(id)sender;
-(IBAction)dismissTheKeyBoard:(id)sender;
-(void)setConnection:(NSURL *)theConnection;

@end
