//
//  TAQAListViewController.h
//  TechTA
//
//  Created by Shih Sunnia on 13/1/1.
//  Copyright (c) 2013年 Shih Sunnia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAWebSocket.h"

@interface TAQAListViewController : UIViewController{
    
}

@property(retain, nonatomic) IBOutlet UITableView* qaListTableView;
@property(retain, nonatomic) NSMutableDictionary* qaListDict;
@property(retain, nonatomic) NSMutableArray* qaListArray;
@property (strong, nonatomic) NSMutableDictionary* userInfo;
@property (strong, nonatomic) NSString* chatid;
@property (strong, nonatomic) TAWebSocket* myWS ;


- (BOOL)ReciveMessage:(NSString*) aMessage;
-(void)socketOpened;
-(void)reloadQAList;


@end
