//
//  TAQAListViewController.m
//  TechTA
//
//  Created by Shih Sunnia on 13/1/1.
//  Copyright (c) 2013年 Shih Sunnia. All rights reserved.
//

#import "TAQAListViewController.h"
#import "TAQAViewController.h"
#import "SBJson.h"

@interface TAQAListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TAQAListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.qaListDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"testobj",@"test", nil];
        self.qaListArray = [[NSMutableArray alloc]init];
        if(self.myWS == nil){
            TAWebSocket *ws =  [[TAWebSocket alloc] init];
            [ws  startTAWebSocket:self];
            self.myWS = ws;
        }
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.qaListArray count];
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
    cell.textLabel.text=[[self.qaListArray objectAtIndex:indexPath.row] valueForKey:@"question"];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.qaListDict setValue:[NSString stringWithFormat:@"test%i",[self.qaListDict count]] forKey:[NSString stringWithFormat:@"test%i",[self.qaListDict count]]];
    
    TAQAViewController* childView = [[TAQAViewController alloc]initWithNibName:@"TAQAViewController" bundle:nil];
    childView.QADict=[self.qaListArray objectAtIndex:indexPath.row];
    childView.userInfo=self.userInfo;
    childView.classes=self.classes;
    [self.navigationController pushViewController:childView animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self.qaListTableView reloadData];
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
-(void)socketOpened
{
    if(self.userInfo ==nil){
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                          message:@"Something was Wrong."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        self.chatid = [self.userInfo valueForKey:@"chatid"];
        NSArray* obs = [[NSArray alloc] initWithObjects:@"login",self.chatid, nil];
        NSArray* ks =[[NSArray alloc]initWithObjects:@"command",@"user", nil];
        NSMutableDictionary* inputDict = [[NSMutableDictionary alloc] initWithObjects:obs forKeys:ks];
        NSString *inputText = [inputDict JSONRepresentation];
        [self.myWS sendMessage:inputText];
        NSLog(@"%@",inputText);
        
    }
}

- (BOOL)ReciveMessage:(NSString*) aMessage
{
    NSMutableDictionary* msgdict = [aMessage JSONValue];
    if (msgdict!=nil) {
        if([[msgdict valueForKey:@"message"] isEqualToString:@"Message"]){
            NSString* datastr = [msgdict objectForKey:@"data"];
            NSMutableDictionary* datadict = [datastr JSONValue];
            if ([[datadict valueForKey:@"type"]isEqualToString:@"quiz"]) {
                [self.qaListArray addObject:datadict];
                //[self.qaListDict setObject:datadict forKey:[datadict valueForKey:@"question"]];
            }else if ([[datadict valueForKey:@"type"]isEqualToString:@"quizclose"]){
                for (int i=0; i<[self.qaListArray count]; i++) {
                    if ([[[self.qaListArray objectAtIndex:i] valueForKey:@"qid"] isEqual:[datadict valueForKey:@"qid"]]&&[[[self.qaListArray objectAtIndex:i] valueForKey:@"clid"] isEqual:[datadict valueForKey:@"clid"]]) {
                        [self.qaListArray removeObjectAtIndex:i];
                    }
                }
            }
        }
    }
    [self.qaListTableView reloadData];
}

-(IBAction)reloadQAList
{
    [self.qaListTableView reloadData];
}

@end
