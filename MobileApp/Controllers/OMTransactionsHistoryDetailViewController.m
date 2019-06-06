//
//  OMTransactionsHistoryDetailViewController.m
//  MobileApp
//
//  Created by Rober on 27/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMTransactionsHistoryDetailViewController.h"
#import "IGMobileApp.h"
#import  "MBProgressHUD.h"
#import "IGField.h"
#import "IGFund.h"
#import "IGDocument.h"

@interface OMTransactionsHistoryDetailViewController ()

@end

@implementation OMTransactionsHistoryDetailViewController
{
    NSInteger fundsNumbers;
    NSInteger band;
    NSMutableArray *fundFields;
    NSArray *transactionHistoryFields;
    NSArray *transactionHistoryFunds;
    NSArray *transactionHistoryDocuments;
    NSString *CellIdentifier;
    UITableViewCell *cell;
    IGField *field;
    IGField *fundField;
    IGDocument *document;
    UILabel *textLabel;
    UILabel *detailLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.lblTransactionHistoryFunds setHidden:YES];
    [self.lblTransactionHistoryDocuments setHidden:YES];
    
    self.navigationController.navigationBar.translucent = NO;

    fundsNumbers = 0;
    band = 0;
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    if(IPHONE) {
        UIBarButtonItem *saveExitButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"out"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(saveExit)];
        
        self.navigationItem.rightBarButtonItem = saveExitButtonItem;
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                      NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                      }];
    
    self.tblTransactionHistoryFields.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tblTransactionHistoryFunds.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tblTransactionHistoryDocuments.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self getTransactionsHistoryDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tblTransactionHistoryFunds) {
        return [transactionHistoryFunds count];
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tblTransactionHistoryFields) {
        return [transactionHistoryFields count];
    } else if (tableView == self.tblTransactionHistoryFunds){
        return [[fundFields objectAtIndex:section] count];
    } else {
        return [transactionHistoryDocuments count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tblTransactionHistoryFields) {
        
        CellIdentifier = @"CellFields";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        field = [transactionHistoryFields objectAtIndex:indexPath.row];
        
        textLabel = (UILabel *)[cell viewWithTag:OM_TAG_ONE];
        textLabel.text = field.caption;
        
        detailLabel = (UILabel *)[cell viewWithTag:OM_TAG_TWO];
        detailLabel.text = field.value;
        
    } else if (tableView == self.tblTransactionHistoryFunds){
        
        [self.lblTransactionHistoryFunds setHidden:NO];
        self.lblTransactionHistoryFunds.textColor = OM_COLOR_LIGHT_GREEN;
        
        if (IPHONE) {
            self.lblTransactionHistoryFunds.font = OM_FONT_HELVETICANEUE_BIGGEST;
        } else {
            self.lblTransactionHistoryFunds.font = OM_FONT_HELVETICANEUE_BIGGEST_IPAD;
        }
        
        CellIdentifier = @"CellFunds";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        fundField = [[fundFields objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        textLabel = (UILabel *)[cell viewWithTag:OM_TAG_THREE];
        textLabel.text = fundField.caption;
        
        detailLabel = (UILabel *)[cell viewWithTag:OM_TAG_FOUR];
        detailLabel.text = fundField.value;

    } else if ((tableView == self.tblTransactionHistoryDocuments) && transactionHistoryDocuments){
        
        [self.lblTransactionHistoryDocuments setHidden:NO];
        self.lblTransactionHistoryDocuments.textColor = OM_COLOR_LIGHT_GREEN;
        
        if (IPHONE) {
            self.lblTransactionHistoryDocuments.font = OM_FONT_HELVETICANEUE_BIGGEST;
        } else {
            self.lblTransactionHistoryDocuments.font = OM_FONT_HELVETICANEUE_BIGGEST_IPAD;
        }
        
        
        CellIdentifier = @"CellDocuments";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        document = [transactionHistoryDocuments objectAtIndex:indexPath.row];
        
        cell.textLabel.text = document.caption;
        cell.textLabel.textColor = OM_COLOR_NEW_GREEN;
        cell.textLabel.font = OM_FONT_HELVETICANEUE_BIG;
        cell.textLabel.numberOfLines = 0;
        cell.imageView.image = [UIImage imageNamed:@"ico-pdf"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
    textLabel.textColor = [UIColor blackColor];
    detailLabel.textColor = OM_COLOR_GRAY;
    
    if (detailLabel.text.length >= 30 && IPHONE) {
        detailLabel.font = OM_FONT_HELVETICANEUE_MEDIUM;
    }else {
        detailLabel.font = OM_FONT_HELVETICANEUE_BIG;
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.tblTransactionHistoryFunds) {
        return ((IGFund *)[transactionHistoryFunds objectAtIndex:section]).fundName;
    } else {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (IPHONE) {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setFont:OM_FONT_HELVETICANEUE_BIG];
    }
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveExit{
    [[NSNotificationCenter defaultCenter] postNotificationName:IG_NOTIFICATION_SAFEEXIT object:self];
}

-(void) getTransactionsHistoryDetail
{
    IGContract *contract = [IGMobileApp sharedInstance].currentSelectedContract;
    IGTransaction *transacction = [IGMobileApp sharedInstance].currentSelectedTransactionsHistory;
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[IGMobileApp sharedInstance] getTransactionsHistoryDetail:contract.productCode withContract:contract.number withEvent:transacction.eventNumber withTransaction:transacction.transactionNumber docNumber:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber docType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withBlock:^(NSError *error) {
        
        [self hideHud:window];
        
        if(!error) {
            
            transactionHistoryFields = [[NSArray alloc] init];
            transactionHistoryFunds = [[NSArray alloc] init];
            fundFields = [[NSMutableArray alloc]init];
            transactionHistoryDocuments = [[NSArray alloc] init];
            
            transactionHistoryFields = [IGMobileApp sharedInstance].currentTransactionsHistoryDetail.fields;
            transactionHistoryFunds = [IGMobileApp sharedInstance].currentTransactionsHistoryDetail.funds;
            transactionHistoryDocuments = [IGMobileApp sharedInstance].currentTransactionsHistoryDetail.documents;
            
            for (int i =0; i < [transactionHistoryFunds count]; i++){
                [fundFields addObject:(NSArray *)((IGFund *)[transactionHistoryFunds objectAtIndex:i]).fields];
                fundsNumbers = [[fundFields objectAtIndex:i] count] + fundsNumbers;
            }
            
            band = 1;
            [self viewDidLayoutSubviews];
            
            [_tblTransactionHistoryFields reloadData];
            [_tblTransactionHistoryFunds reloadData];
            [_tblTransactionHistoryDocuments reloadData];
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
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tblTransactionHistoryDocuments){
        document = (IGDocument*)[transactionHistoryDocuments objectAtIndex:indexPath.row];
        
        [IGMobileApp sharedInstance].currentDownloadDocumentType = OM_TXT_TRANSACTION_DETAIL;
        [IGMobileApp sharedInstance].currentSelectedDocumentHistoryDetail = document;
        self.title = IGEmptyString;
        [self performSegueWithIdentifier:@"DocumentHistoryDetailSegue" sender:nil];
    }
}

-(void)viewDidLayoutSubviews
{
    if (band == 1) {
        self.dynamicTableFaildsHeight.constant = (transactionHistoryFields.count * 44) + 5;
        self.dynamicTableFundsHeight.constant = ((fundsNumbers * 44) + (transactionHistoryFunds.count * 22) + 5);
        self.dynamicTableDocumentsHeight.constant = transactionHistoryDocuments.count * 44;
        band = 0;
        [self.view layoutIfNeeded];
    }else {
        self.title = OM_TXT_TRANSACTION_DETAIL_TITLE;
    }
}

@end
