//
//  OMTransactionsHistoryViewController.m
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMTransactionsHistoryViewController.h"
#import "IGMobileApp.h"
#import "IGTimeoutApplication.h"
#import  "MBProgressHUD.h"
#import "SWRevealViewController.h"
#import "IGField.h"
#import "IGTransaction.h"
#import "SVPullToRefresh.h"

@interface OMTransactionsHistoryViewController ()

@end

@implementation OMTransactionsHistoryViewController
{
    NSMutableArray *transactionsHistory;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self resetDataSource];
    
    IGContract *contract = [IGMobileApp sharedInstance].currentSelectedContract;
    
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    
    __weak typeof(self) weakSelf = self;
    
    if(IPHONE) {
        self.parentViewController.title = OM_TXT_TRANSACTION_TITLE;
        
        self.lblContractNumber.text = [NSString stringWithFormat:OM_TXT_TRANSACTION_LABEL_IPHONE, contract.number];
        
        self.parentViewController.navigationItem.leftBarButtonItem = backBtn;
        self.parentViewController.navigationItem.hidesBackButton = YES;
        
        UIBarButtonItem *saveExitButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"out"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(saveExit)];
        
        self.parentViewController.navigationItem.rightBarButtonItem = saveExitButtonItem;
    } else {
        self.lblContractNumber.text = [NSString stringWithFormat:OM_TXT_TRANSACTION_LABEL_IPAD, contract.number];
        
        UIBarButtonItem *contractDetailBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_contract_detail"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(contractDetailPressed:)];
        
//        UIBarButtonItem *balanceBtn1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_contribute"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:nil];
//        
//        UIBarButtonItem *balanceBtn2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_withdrawal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:nil];
//        
        UIBarButtonItem *transactionBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_historical_green"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:nil];
        
//        UIBarButtonItem *balanceBtn3 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_more_nav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:nil];
        
        NSArray *rightButtonsItems = @[/*balanceBtn3,*/ transactionBtn, /*balanceBtn2, balanceBtn1, */contractDetailBtn];
        self.navigationItem.rightBarButtonItems = rightButtonsItems;
        self.navigationItem.leftBarButtonItem = backBtn;
    }
    
    [self.tabBarController.tabBar setTintColor:OM_COLOR_LIGHT_GREEN];
    self.navigationController.navigationBar.tintColor = OM_COLOR_LIGHT_GREEN;
    
    self.tblTransactionsHistory.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self getTransactionsHistory];
    /*roberm
    // setup pull-to-refresh
    [self.tblTransactionsHistory addPullToRefreshWithActionHandler:^{
        
        [[IGMobileApp sharedInstance] searchTransactionsHistoryPullToRefresh:contract.productCode withContract:contract.number withPlan:contract.planCode docNumber:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber docType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withBlock:^(NSError *error) {
            
            if(!error) {
                transactionsHistory = [[IGMobileApp sharedInstance] currentTransactionsHistory];
                [_tblTransactionsHistory reloadData];
                [weakSelf.tblTransactionsHistory.pullToRefreshView stopAnimating];
            }
            else {
                [self showAlertError:OM_MESSAGE_LOGIN_ERRORONSERVICE];
            }
        }];
        
    }];
    */
    // setup infinite scrolling
    [self.tblTransactionsHistory addInfiniteScrollingWithActionHandler:^{
        [[IGMobileApp sharedInstance] searchTransactionsHistoryNextPage:contract.productCode withContract:contract.number withPlan:contract.planCode docNumber:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber docType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withBlock:^(NSError *error) {
            
            if(!error) {
                transactionsHistory = [[IGMobileApp sharedInstance] currentTransactionsHistory];
                [_tblTransactionsHistory reloadData];
            }
            
            [weakSelf.tblTransactionsHistory.infiniteScrollingView stopAnimating];
        }];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [transactionsHistory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    IGTransaction *transaction = [[IGMobileApp sharedInstance].currentTransactionsHistory objectAtIndex:indexPath.row];
    
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:OM_TAG_ONE];
    dateLabel.text = [transaction effectiveDate];
    dateLabel.textColor = OM_COLOR_GRAY;
    
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:OM_TAG_TWO];
    detailLabel.text = [[transaction descriptionText] capitalizedString];
    detailLabel.textColor = OM_COLOR_NEW_GREEN;
    
    UILabel *netValue = (UILabel *)[cell viewWithTag:OM_TAG_THREE];
    netValue.text = [transaction netValue];
    netValue.textColor = OM_COLOR_GRAY;
    
    if (detailLabel.text.length > 35 && netValue.text.length >= 16 && IPHONE) {
        detailLabel.font = OM_FONT_HELVETICANEUE_MEDIUM;
        netValue.font = OM_FONT_HELVETICANEUE_MEDIUM;
    }else {
        detailLabel.font = OM_FONT_HELVETICANEUE_BIG;
        netValue.font = OM_FONT_HELVETICANEUE_BIG;
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [IGMobileApp sharedInstance].currentSelectedTransactionsHistory = [transactionsHistory objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"transactionDetailSegue" sender:nil];
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveExit{
    [self resetDataSource];
    [[NSNotificationCenter defaultCenter] postNotificationName:IG_NOTIFICATION_SAFEEXIT object:self];
}

-(IBAction)contractDetailPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) getTransactionsHistory
{
    IGContract *contract = [IGMobileApp sharedInstance].currentSelectedContract;
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
     
    [[IGMobileApp sharedInstance] getTransactionsHistory:contract.productCode withContract:contract.number withPlan:contract.planCode withSet:0 docNumber:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber docType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withBlock:^(NSError *error) {
        
        [self hideHud:window];
        
        if(!error) {
            transactionsHistory = [IGMobileApp sharedInstance].currentTransactionsHistory;
            [_tblTransactionsHistory reloadData];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IPHONE) {
        return OM_CELL_HEIGHT_BIG;
    } else {
        return 44;
    }
}

-(void)resetDataSource
{
    [transactionsHistory removeAllObjects];
    [[IGMobileApp sharedInstance] resetDataSource];
    [self.tblTransactionsHistory reloadData];
}

-(void)viewDidLayoutSubviews
{
    if(IPHONE) {
        self.parentViewController.title = OM_TXT_TRANSACTION_TITLE;
    }
}

@end
