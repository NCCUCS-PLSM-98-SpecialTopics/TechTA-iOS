//
//  TAQAListViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 13/1/1.
//  Copyright (c) 2013年 Shih Sunnia. All rights reserved.
//

#import "TAQAListViewController.h"
#import "TAQAViewController.h"

@interface TAQAListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TAQAListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.qaListDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"testobj",@"test", nil];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.qaListDict count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView
                                               dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[NSString stringWithString:@"test"];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.qaListDict setValue:[NSString stringWithFormat:@"test%i",[self.qaListDict count]] forKey:[NSString stringWithFormat:@"test%i",[self.qaListDict count]]];
    
    TAQAViewController* childView = [[TAQAViewController alloc]initWithNibName:@"TAQAViewController" bundle:nil];
    [self.navigationController pushViewController:childView animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self.vc reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
