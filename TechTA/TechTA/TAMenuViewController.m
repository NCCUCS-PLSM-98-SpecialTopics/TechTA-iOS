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

@interface TAMenuViewController ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation TAMenuViewController

@synthesize menuTableView=_menuTableView;
@synthesize tabBarController=_tabBarController;



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
    return 4;
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
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"選擇問答";
            cell.detailTextLabel.text = @"Select";
            break;
            
        case 1:
            cell.textLabel.text = @"提問題";
            cell.detailTextLabel.text = @"Select";
            break;
            
        case 2:
            cell.textLabel.text = @"來點名";
            cell.detailTextLabel.text = @"Select";
            break;
            
        case 3:
            cell.textLabel.text = @"Got a picture?";
            cell.detailTextLabel.text = @"Select";
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            TAASKViewController* askView=[[TAASKViewController alloc]initWithNibName:@"TAASKViewController" bundle:nil];
            TAQAViewController* qaView=[[TAQAViewController alloc]initWithNibName:@"TAQAViewController" bundle:nil];

            TAPollViewController* pollView=[[TAPollViewController alloc]initWithNibName:@"TAPollViewController" bundle:nil];
            
            _tabBarController = [[UITabBarController alloc]init];
            _tabBarController.viewControllers =[NSArray arrayWithObjects:askView,qaView,pollView, nil];
            
            [self.navigationController pushViewController:_tabBarController animated:YES];
            [[self navigationController] setNavigationBarHidden:NO animated:NO];
            break;
        }
                    
        default:
            break;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[self navigationController] setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
