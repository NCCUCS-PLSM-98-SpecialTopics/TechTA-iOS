//
//  TAMenuViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 12/11/6.
//  Copyright (c) 2012年 Shih Sunnia. All rights reserved.
//

#import "TAMenuViewController.h"
#import "TAQAViewController.h"
#import "TAASKViewController.h"
#import "TAPollViewController.h"
#import "TAViewController.h"
#import "TALogTestViewController.h"
#import "SBJson.h"

@interface TAMenuViewController ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation TAMenuViewController

@synthesize menuTableView=_menuTableView;
@synthesize tabBarController=_tabBarController;
@synthesize CourseArray=_CourseArray;
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
    return _CourseArray.count;
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
    

    
    NSMutableDictionary* course=[_CourseArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [course valueForKey:@"name"];
    cell.detailTextLabel.text = @"";

            
 
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
            TAASKViewController* askView=[[TAASKViewController alloc]initWithNibName:@"TAASKViewController" bundle:nil];
            TAQAViewController* qaView=[[TAQAViewController alloc]initWithNibName:@"TAQAViewController" bundle:nil];

            TAPollViewController* pollView=[[TAPollViewController alloc]initWithNibName:@"TAPollViewController" bundle:nil];
            TALogTestViewController* logView=[[TALogTestViewController alloc]initWithNibName:@"TALogTestViewController" bundle:nil];
            
            _tabBarController = [[UITabBarController alloc]init];
            _tabBarController.viewControllers =[NSArray arrayWithObjects:askView,qaView,pollView,logView, nil];
            
            [self.navigationController pushViewController:_tabBarController animated:YES];
            [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

-(void)viewDidAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
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
    [request setURL:[connection URLByAppendingPathComponent:@"TechTA/api/GetCourse"]];
    //設定連線方式
    [request setHTTPMethod:@"GET"];
    //將編碼改為UTF8
    [request setHTTPBody:[httpBodyString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //轉換為NSData傳送
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //看request出來的值
    NSLog(@"getCourse data : %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSString *data2 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];    //看request出來的值
    
    
    _CourseArray=[data2 JSONValue];
    //如果登入錯誤的話
    
    if ([_CourseArray isKindOfClass:[NSMutableArray class]]){

    }
    else {
        if ([_CourseArray valueForKey:@"error"]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                          message:[_CourseArray valueForKey:@"msg"]
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
        TAViewController* loginView =[[TAViewController alloc]initWithNibName:@"TAViewController" bundle:nil];
        [self.navigationController pushViewController:loginView animated:NO];
    }
    
    }

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
