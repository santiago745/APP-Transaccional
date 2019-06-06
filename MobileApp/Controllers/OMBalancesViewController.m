//
//  OGBalancesViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/25/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMBalancesViewController.h"
#import "SWRevealViewController.h"
#import "IGMobileApp.h"
#import "IGTimeoutApplication.h"
#import "SKSTableViewCell.h"
#import  "MBProgressHUD.h"
#import "IGProduct.h"
#import "OMBalanceDetailViewController.h"

@interface OMBalancesViewController ()

@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSArray *menuItemsImages;



@end

@implementation OMBalancesViewController {
    NSMutableArray *companyBalances;
    NSMutableDictionary *productBalances;
    IGProduct *product;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.SKSTableViewDelegate = self;
    
    [(IGTimeoutApplication *)[UIApplication sharedApplication] resetIdleTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveExitByTimeout)
                                                 name:kApplicationDidTimeoutNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveExit)
                                                 name:IG_NOTIFICATION_SAFEEXIT
                                               object:nil];
    
    //[self.tabBarController.tabBar setTintColor:OM_COLOR_GRAY];
    //[self.navigationController.navigationBar setTintColor:OM_COLOR_GRAY];
    
 
    UIImage *imageen = [[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:imageen
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self.revealViewController action:@selector(revealToggle:)];
    
    UIBarButtonItem *saveExitButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"out"]
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self action:@selector(saveExit)];
    
    //Logo
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [image setContentMode:UIViewContentModeCenter];
    
    if(IPHONE) {
        self.parentViewController.navigationItem.leftBarButtonItem = revealButtonItem;
        self.parentViewController.navigationItem.rightBarButtonItem = saveExitButtonItem;
        self.parentViewController.navigationItem.titleView = image;
    } else {
        self.navigationItem.leftBarButtonItem = revealButtonItem;
        self.navigationItem.rightBarButtonItem = saveExitButtonItem;
        self.navigationItem.titleView = image;
    }
    
    UITabBarItem *tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:2];
    UIImage *selectedImage = [UIImage imageNamed:@"icon_agent_green"];
    [tabBarItem setSelectedImage: selectedImage];
    
    [self.tabBarController.tabBar setTintColor:OM_COLOR_LIGHT_GREEN];
    [self.navigationController.navigationBar setTintColor:OM_COLOR_LIGHT_GREEN];
    
    [self getCompanies];
}

-(void)viewWillAppear:(BOOL)animated {

    if (IPAD) {
        [self performSegueWithIdentifier:@"balancesBlankSegue" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveExit{
    UIAlertView *confirmExitAlert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:OM_TXT_CLOSE_SESION delegate:self cancelButtonTitle:OM_TXT_CANCEL otherButtonTitles:OM_TXT_ACCEPT, nil];
    confirmExitAlert.tag = 0;
    confirmExitAlert.alertViewStyle = UIAlertViewStyleDefault;
    [confirmExitAlert show];
    
    [[IGMobileApp sharedInstance]logout];
}

-(void)saveExitByTimeout{
    UIAlertView *safeExitAlert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:OM_MESSAGE_GENERAL_SESSIONCLOSED delegate:self cancelButtonTitle:OM_TXT_ACCEPT otherButtonTitles:nil, nil];
    safeExitAlert.tag = 1;
    safeExitAlert.alertViewStyle = UIAlertViewStyleDefault;
    [safeExitAlert show];
    
    [[IGMobileApp sharedInstance]logout];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    CellIdentifier = @"SKSTableViewCell";
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    if (!cell) {
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = OM_COLOR_NEW_GREEN;
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    
    IGCompany *company = (IGCompany*)[[IGMobileApp sharedInstance].currentCompanies objectAtIndex:indexPath.row];
    
    if ([company.key isEqualToString:@"FIDU"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_fidu"];
    } else if ([company.key isEqualToString:@"AFPC"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_pen_ces"];
    } else if ([company.key isEqualToString:@"VIDA"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_seg_vid"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"icon_val"];
    }
    
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    cell.detailTextLabel.font = OM_FONT_HELVETICANEUE_MEDIUM;
    cell.detailTextLabel.text = [companyBalances objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        UILabel *dot = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 20.0f, 20.0f, 30.0f)];
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(21.0f, 4.0f, 145.0f, 60.0f)];
        
        lbl.tag = OM_TAG_ONE;
        dot.tag = OM_TAG_TWO;
        [cell.contentView addSubview:lbl];
        [cell.contentView addSubview:dot];
    }
    
    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:OM_TAG_ONE];
    lbl.numberOfLines = 0;
    [lbl setText:[NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]]];
    UILabel *dot = (UILabel *)[cell.contentView viewWithTag:OM_TAG_TWO];
    [dot setText:@"•"];
    lbl.textColor = OM_COLOR_GRAY;
    dot.textColor = OM_COLOR_CELL_SELECTION_GREEN;
    lbl.font = OM_FONT_HELVETICANEUE_MEDIUM;
    
    cell.textLabel.font = OM_FONT_HELVETICANEUE_MEDIUM;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //Product balances are stored as key value dictionary
    IGCompany *comp = [[IGMobileApp sharedInstance].currentCompanies objectAtIndex:indexPath.row];
    NSString *key;
    
    if (USE_TEST_REPOS) {
        product = [MTLJSONAdapter modelOfClass:IGProduct.class fromJSONDictionary:[comp.products objectAtIndex:indexPath.subRow - 1] error:nil];
        key = product.key;
    } else {
        key = ((IGProduct *)[comp.products objectAtIndex:indexPath.subRow - 1]).key;
    }
    
    cell.detailTextLabel.text = [productBalances valueForKey:key];
    cell.detailTextLabel.font = OM_FONT_HELVETICANEUE_MEDIUM;
    cell.detailTextLabel.textColor = OM_COLOR_GRAY;
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return OM_CELL_HEIGHT_BIG;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    return OM_CELL_HEIGHT_BIG;
}


- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{    
    IGCompany *comp = [[IGMobileApp sharedInstance].currentCompanies objectAtIndex:indexPath.row];
    
    if (USE_TEST_REPOS) {
        product = [MTLJSONAdapter modelOfClass:IGProduct.class fromJSONDictionary:[comp.products objectAtIndex:indexPath.subRow - 1] error:nil];
        [IGMobileApp sharedInstance].currentSelectedProduct = product;
    } else {
        [IGMobileApp sharedInstance].currentSelectedProduct = ((IGProduct *)[comp.products objectAtIndex:indexPath.subRow - 1]);
    }
    
    [self performSegueWithIdentifier:@"balancesProductDetail" sender:nil];
}

#pragma mark - Actions

- (void)collapseSubrows
{
    [self.tableView collapseCurrentlyExpandedIndexPaths];
}

- (void)reloadTableViewWithData:(NSMutableArray *)array
{
    self.contents = array;
    
    // Refresh data not scrolling
    //[self.tableView refreshData];
    
    // Refresh data with scrolling
    // [self.tableView refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    [self.tableView refreshData];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self collapseSubrows];
}

-(void)getCompanies
{
    NSMutableArray *formatedArray = [[NSMutableArray alloc] init];
    NSMutableArray *userBalances = [[NSMutableArray alloc] init];
    companyBalances = [[NSMutableArray alloc] init];
    productBalances = [[NSMutableDictionary alloc] init];
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[IGMobileApp sharedInstance] getCompanies:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber withDocType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withBlock:^(NSError *error) {
        [self hideHud:window];
        
        if(!error) {
            
            NSMutableArray *companies = [[IGMobileApp sharedInstance].currentCompanies mutableCopy];
            
            //content of data source should be
            //contentArray[[Company, product 1, product 2, ...], [...]]
            //where product x are expandable cells
            for (id object in companies) {
                
                IGCompany *company = (IGCompany *)object;
                [formatedArray insertObject:company.caption atIndex:0];
                [companyBalances addObject:company.totalBalance];
                
                for (int j = 0; j < company.products.count; j++) {
                    
                    if (USE_TEST_REPOS) {
                        product = [MTLJSONAdapter modelOfClass:IGProduct.class fromJSONDictionary:[company.products objectAtIndex:j] error:nil];
                    } else {
                        product = [company.products objectAtIndex:j];
                    }
                    
                    [formatedArray insertObject:product.caption atIndex:j + 1];
                    [productBalances setValue:product.totalBalance forKey:product.key];
                }
                
                [userBalances addObject:[formatedArray copy]];
                [formatedArray removeAllObjects];
            }
            
            NSMutableArray *dataWithInitializer = [[NSMutableArray alloc]initWithArray:@[userBalances]];
            _contents = dataWithInitializer;
            
            [self reloadTableViewWithData:_contents];
            
        }
        else {
        
            [self showAlertError:OM_MESSAGE_LOGIN_ERRORONSERVICE];
        }
    }];
}

-(void) hideHud:(UIWindow *)actualWindow {
    [MBProgressHUD hideHUDForView:actualWindow animated:YES];
}

-(void) showAlertError:(NSString *)errorMessage{
   
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:errorMessage delegate:self cancelButtonTitle:OM_TXT_ACCEPT otherButtonTitles:nil, nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 0 && buttonIndex == 1){
        
        [[IGMobileApp sharedInstance]logout];
        
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
            [self removeObservers];
        }];
        
    }else if(alertView.tag == 1){
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
            [self removeObservers];
        }];
    }
}

-(void) removeObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kApplicationDidTimeoutNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IG_NOTIFICATION_SAFEEXIT object:nil];
}

@end
