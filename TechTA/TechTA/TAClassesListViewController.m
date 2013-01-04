//
//  TAClassesListViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 13/1/3.
//  Copyright (c) 2013年 Shih Sunnia. All rights reserved.
//

#import "TAClassesListViewController.h"
#import "TAMenuViewController.h"
#import "TAQAListViewController.h"
#import "TAASKViewController.h"
#import "TAPollViewController.h"
#import "TAViewController.h"
#import "TALogTestViewController.h"
#import "SBJson.h"

@interface TAClassesListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TAClassesListViewController

@synthesize menuTableView=_menuTableView;
@synthesize tabBarController=_tabBarController;
@synthesize classArray;
@synthesize connection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return classArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView
                                               dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        cell.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
        cell.textLabel.clipsToBounds = YES;
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.4
                                                         green:0.6
                                                          blue:0.8
                                                         alpha:1];
        cell.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
        cell.detailTextLabel.clipsToBounds = YES;
    }
    
    
    
    NSMutableDictionary* course=[classArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [course valueForKey:@"name"];
    cell.detailTextLabel.text = @"";
    
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TAASKViewController* askView=[[TAASKViewController alloc]initWithNibName:@"TAASKViewController" bundle:nil];
    askView.connection=self.connection;
    askView.userInfo=self.userInfo;
    askView.classes=[classArray objectAtIndex:indexPath.row];
    askView.currentCourse = self.currentcourse;
    TAQAListViewController* qaView=[[TAQAListViewController alloc]initWithNibName:@"TAQAListViewController" bundle:nil];
    UINavigationController* QAnav = [[UINavigationController alloc] initWithRootViewController:qaView];
    
    TAPollViewController* pollView=[[TAPollViewController alloc]initWithNibName:@"TAPollViewController" bundle:nil];
    TALogTestViewController* logView=[[TALogTestViewController alloc]initWithNibName:@"TALogTestViewController" bundle:nil];
    
    _tabBarController = [[UITabBarController alloc]init];
    _tabBarController.viewControllers =[NSArray arrayWithObjects:askView,QAnav,pollView,logView, nil];
    
    [self.navigationController pushViewController:_tabBarController animated:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //NSMutableURLRequest *request=testrequest;
    //宣告一個 NSURL 並給予記憶體空間、連線位置
    //connection = [[NSURL alloc] initWithString:@"http://jackliit.dyndns.info:8080/"];
    //宣告要post的值
    NSString *httpBodyString=[NSString stringWithFormat:@""];
    //NSLog(@"httpBodyString = %@",httpBodyString);
    //設定連線位置
    [request setURL:[connection URLByAppendingPathComponent:@"TechTA/api/GetAccountInfo"]];
    //設定連線方式
    [request setHTTPMethod:@"GET"];
    //將編碼改為UTF8
    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //轉換為NSData傳送
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* data2 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSMutableDictionary* getuserinfo = [data2 JSONValue];
    self.userInfo=[data2 JSONValue];
    //NSLog(@"getAcInfo data : %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}





- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logoutButtonPressed:(id)sender
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //宣告一個 NSURL 並給予記憶體空間、連線位置
    //NSURL *connection = [[NSURL alloc] initWithString:@"http://jackliit.dyndns.info:8080/TechTA/api/logout"];
    //宣告要post的值
    NSString *httpBodyString=[NSString stringWithFormat:@""];
    //NSLog(@"httpBodyString = %@",httpBodyString);
    //設定連線位置
    [request setURL:[connection URLByAppendingPathComponent:@"TechTA/api/Logout"]];
    //設定連線方式
    [request setHTTPMethod:@"GET"];
    //將編碼改為UTF8
    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //轉換為NSData傳送
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //看request出來的值
    NSLog(@"data :%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    
    TAViewController* loginView =[[TAViewController alloc]initWithNibName:@"TAViewController" bundle:nil];
    [self.navigationController pushViewController:loginView animated:NO];
    
}

-(void) setConnection:(NSURL *)theConnection
{
    connection=theConnection;
}

@end
