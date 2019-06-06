//
//  OMStatementsViewController.m
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMStatementsViewController.h"
#import "IGMobileApp.h"
#import "IGTimeoutApplication.h"
#import  "MBProgressHUD.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLSessionManager.h"
#import "IGAPIClient.h"
#import "UIView+BK.h"
#import "OMPeriod.h"
#import "SWRevealViewController.h"
#import "IGMobileApp.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"


@implementation OMStatementsViewController
{
    NSArray *years;
    NSDictionary* statementsDictionary;
    IGStatementsRequest *request;
    NSString *filePath;
    UIBarButtonItem *shareButton;
    NSString *reportText;
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    reportText = [[IGMobileApp sharedInstance].currentReportType isEqualToString:@"1"] ? OM_TXT_EXTRACT_NAME : OM_TXT_CERTIFICATE_NAME;
    request = [[IGStatementsRequest alloc]init];
    
    if ([[IGMobileApp sharedInstance].currentReportType isEqualToString:@"1"]){
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Menú principal" action:@"Touch" label:@"Extractos" value:0] build]];
    }else{
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"Menú principal" action:@"Touch" label:@"Certificados tributarios" value:0] build]];
    }
    
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self.revealViewController action:@selector(revealToggle:)];
    
    UIBarButtonItem *saveExitButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"out"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self action:@selector(saveExit)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.rightBarButtonItem = saveExitButtonItem;
    
    //Logo
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [image setContentMode:UIViewContentModeCenter];
    self.navigationItem.titleView = image;
    
    [self.tabBarController.tabBar setTintColor:OM_COLOR_LIGHT_GREEN];
    [self.navigationController.navigationBar setTintColor:OM_COLOR_LIGHT_GREEN];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    
    UITabBarItem *tabBarItem;
    UIImage *selectedImage;
    if ([[IGMobileApp sharedInstance].currentReportType isEqualToString:@"2"]){
        tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:1];
        selectedImage = [UIImage imageNamed:@"icon_certificate_green"];

    }else{
        tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:2];
        selectedImage = [UIImage imageNamed:@"icon_extract_green"];

    }
    [tabBarItem setSelectedImage: selectedImage];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    if (IPAD) {
        [self performSegueWithIdentifier:@"statementsBlankSegue" sender:nil];
    }
    [self getStatements:[IGMobileApp sharedInstance].currentReportType];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [years count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *year = [years objectAtIndex:section];
    
    NSArray *statements = [statementsDictionary objectForKey:year];
    
    return [statements count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *year = [years objectAtIndex:indexPath.section];
    
    NSArray *statements = [statementsDictionary objectForKey:year];

    static NSString *CellIdentifier;
    
    CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    OMPeriod* period = (OMPeriod*)[statements objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", reportText];
    cell.textLabel.textColor = OM_COLOR_NEW_GREEN;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", period.month, period.year];
    cell.detailTextLabel.textColor = OM_COLOR_GRAY;
    cell.textLabel.font = OM_FONT_HELVETICANEUE_BIG;
    cell.imageView.image = [UIImage imageNamed:@"ico-pdf"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    //Set the header value for each section. We return the letter for this group.
    
    NSString *key = [years objectAtIndex:section];
    
    return key;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:OM_COLOR_GRAY];
    header.textLabel.font = OM_FONT_HELVETICANEUE_MEDIUM;
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    //[self performSegueWithIdentifier:@"cancelQuestions" sender:nil];
}

-(void)saveExit{
    [[NSNotificationCenter defaultCenter] postNotificationName:IG_NOTIFICATION_SAFEEXIT object:self];
}

-(void) createAuthRequest:(NSString *)reportType
{
    request.docNumber = [[[IGMobileApp sharedInstance].currentAuthenticationResponse docNumber] integerValue];
    request.docType = [IGMobileApp sharedInstance].currentAuthenticationResponse.docType;
    request.reportType = reportType;
}

-(void) getStatements:(NSString *)reportType
{
    [self createAuthRequest:reportType];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[IGMobileApp sharedInstance] getStatements:request withBlock:^(NSError *error) {
        
        [self hideHud:window];
        
        if(!error) {
            statementsDictionary = [self convertArrayFrom:[IGMobileApp sharedInstance].currentStatements];
            
            NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(localizedCompare:)];
            years = [[statementsDictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            
            //years = [[statementsDictionary allKeys]sortedArrayUsingSelector:@selector(compare:)];
            [_tableView reloadData];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *year = [years objectAtIndex:indexPath.section];
    NSArray *statements = [statementsDictionary objectForKey:year];
    OMPeriod* period = (OMPeriod*)[statements objectAtIndex:indexPath.row];
    
    [IGMobileApp sharedInstance].currentSelectedStatement = period;
                
    [self performSegueWithIdentifier:@"StatementsDetailSegue" sender:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return OM_CELL_HEIGHT_BIG;
}

-(void) hideHud:(UIWindow *)actualWindow {
    [MBProgressHUD hideHUDForView:actualWindow animated:YES];
}

-(NSDictionary*)convertArrayFrom:(NSArray*)array{
    NSArray *groups = [array valueForKeyPath:@"@distinctUnionOfObjects.year"];
    NSMutableDictionary *result = [NSMutableDictionary new];
    
    for (NSString *year in groups)
    {
        NSArray *periods = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"year = %@", year]];
        [result setObject:periods forKey:year];
    }
    
    return result;
}


@end
