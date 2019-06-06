//
//  OMBalancesContractsViewController.m
//  MobileApp
//
//  Created by steven muñoz on 7/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMBalancesContractsViewController.h"
#import "IGMobileApp.h"
#import "IGContract.h"
#import "IGField.h"
#import "MobileApp-Swift.h"
#import "CustomTableViewCell.h"

@implementation OMBalancesContractsViewController
{
    NSArray *contracts;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.hidesBackButton = YES;
    
    if(IPHONE) {
        UIBarButtonItem *saveExitButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"out"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self action:@selector(saveExit)];
    
        self.navigationItem.rightBarButtonItem = saveExitButtonItem;
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                          NSForegroundColorAttributeName : OM_COLOR_NEW_GREEN,
                                                                          NSFontAttributeName: OM_FONT_MONSERRAT_BOLD
                                                                          }];
    }
    
    //self.title = [[IGMobileApp sharedInstance].currentSelectedProduct.caption stringByReplacingOccurrencesOfString:@"Old Mutual" withString:IGEmptyString];
    self.title = [[IGMobileApp sharedInstance].currentSelectedProduct.caption stringByReplacingOccurrencesOfString:@"Skandia" withString:IGEmptyString];
    
    self.lblTotalBalance.text = [NSString stringWithFormat:OM_TXT_BALANCE_CONTRACT_LABEL, [IGMobileApp sharedInstance].currentSelectedProduct.totalBalance];
    
    self.tableContracts.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    contracts = [[NSArray alloc]init];
    contracts = [IGMobileApp sharedInstance].currentSelectedProduct.contracts;
    
    NSException *error = nil;
    @try {
          [self.tableContracts registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:([CustomTableViewCell class])];
    } @catch (NSException *exception) {
        error = exception;
    } @finally {
        
    }
  
    
}

-(void)saveExit{
  [[NSNotificationCenter defaultCenter] postNotificationName:IG_NOTIFICATION_SAFEEXIT object:self];
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contracts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CustomTableViewCell";
    IGContract *contract = [contracts objectAtIndex:indexPath.row];
    
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    NSString *nombreContrato =[NSString stringWithFormat:(@"%@"),[contract.fields[0] valueForKey:@"value"]];
    NSString *numeroContrato = [NSString stringWithFormat:(@"...%@"),[contract.number substringFromIndex:[contract.number length] - 4]];
    NSString *valorContrato =[NSString stringWithFormat:(@"%@"),[contract.fields[3] valueForKey:@"value"]];
    
    cell.lblnombre.text = nombreContrato;
    cell.lblcontract.text = numeroContrato;
    cell.lblprice.text = valorContrato;
    
    
   // Agent *agent = (Agent *)[currChatList objectAtIndex:indexPath.row];
   // NSLog(@"Agent name - %@", agent.name);   // Prints proper data

    /*if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    IGContract *contract = [contracts objectAtIndex:indexPath.row];
 */
    return cell;
}

-(NSString *) findBalanceByKey:(NSString *)key withContract:(IGContract *)contract
{
    NSMutableArray *dic = [contract.fields mutableCopy];
    
    //Iterate over array of fields and find by key
    NSUInteger indexOfField  = [dic indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
         IGField *object = (IGField *)obj;
         return [object.key isEqualToString:key];
     }];
    
    IGField *balanceField = dic[indexOfField];
    return balanceField.value;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [IGMobileApp sharedInstance].currentSelectedContract = [contracts objectAtIndex:indexPath.row];
    
    IGContract *contract1 = [contracts objectAtIndex:indexPath.row];
    
    GetUtilObjects *util = [GetUtilObjects alloc];
    [util GetContratoWithNumber:contract1.number productCode:contract1.productCode planCode:contract1.planCode WithdrawalsAllowed:contract1.WithdrawalsAllowed];
    [self performSegueWithIdentifier:@"contractsDetailSegue" sender:nil];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

@end
