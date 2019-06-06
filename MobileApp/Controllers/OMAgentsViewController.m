//
//  OMAgentsViewController.m
//  MobileApp
//
//  Created by Rober on 17/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMAgentsViewController.h"
#import "IGMobileApp.h"
#import "IGTimeoutApplication.h"
#import  "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SWRevealViewController.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@interface OMAgentsViewController ()

@end

@implementation OMAgentsViewController
{
    NSArray *agents;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

   
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self.revealViewController action:@selector(revealToggle:)];
    
    UIBarButtonItem *saveExitButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"out"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self action:@selector(saveExit)];
    
    UITabBarItem *tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:0];
    UIImage *selectedImage = [UIImage imageNamed:@"icon_balance_green"];
    [tabBarItem setSelectedImage: selectedImage];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.rightBarButtonItem = saveExitButtonItem;
    
    //Logo
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [image setContentMode:UIViewContentModeCenter];
    self.navigationItem.titleView = image;
    

    
    self.tableAgents.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self getAgents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    if (IPAD) {
        [self performSegueWithIdentifier:@"agentsBlankSegue" sender:nil];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [agents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    IGAgent *agent = [agents objectAtIndex:indexPath.row];
    
    NSString *image;
    if (IPHONE) {
        image = @"image_pers";
    } else {
        image = @"image_pers_ipad";
    }
    
    UIImageView *agentImageView = (UIImageView *)[cell viewWithTag:100];
    [agentImageView sd_setImageWithURL:[NSURL URLWithString:[agent photo]]
                       placeholderImage:[UIImage imageNamed:image]];
    
    UILabel *agentNameLabel = (UILabel *)[cell viewWithTag:101];
    agentNameLabel.text = [agent name];
    agentNameLabel.textColor = OM_COLOR_NEW_GREEN;
    
    UILabel *agentAgencyLabel = (UILabel *)[cell viewWithTag:102];
    agentAgencyLabel.text = [agent agencyName];
    agentAgencyLabel.textColor = OM_COLOR_GRAY;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveExit{
    [[NSNotificationCenter defaultCenter] postNotificationName:IG_NOTIFICATION_SAFEEXIT object:self];
}

-(void) getAgents
{
    agents = [[NSArray alloc]init];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[IGMobileApp sharedInstance] getAgents:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber withDocType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withBlock:^(NSError *error) {
        
        [self hideHud:window];
        
        if(!error) {
            agents = [IGMobileApp sharedInstance].currentAgents;
            [_tableAgents reloadData];
        }
        else {
            [self showAlertError:OM_MESSAGE_LOGIN_ERRORONSERVICE];
        }
    }];
}

-(void) showAlertError:(NSString *)errorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:errorMessage delegate:self cancelButtonTitle:OM_TXT_ACCEPT otherButtonTitles:nil, nil];
    [alert show];
}

-(void) hideHud:(UIWindow *)actualWindow {
    [MBProgressHUD hideHUDForView:actualWindow animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [IGMobileApp sharedInstance].currentSelectedAgent = [agents objectAtIndex:indexPath.row];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Mis Agentes" action:@"Touch" label:@"Ver detalle agente" value:0] build]];
    [self performSegueWithIdentifier:@"agentsDetailSegue" sender:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return OM_CELL_HEIGHT_BIG;
}

@end
