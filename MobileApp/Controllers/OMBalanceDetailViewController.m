//
//  OMBalanceDetailViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 4/7/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//



#import "OMBalanceDetailViewController.h"
#import "IGMobileApp.h"
#import "IGProduct.h"
#import "IGField.h"

@interface OMBalanceDetailViewController (){
    
    NSArray* menuItemsImages;
    NSArray* menuItemsImages2;
    
    NSArray *contracts;
    NSInteger rowLabelWidth, headerLabelWidth;
    NSInteger xPos, xHeaderPos;
    NSInteger parentWidth;

}

@end

@implementation OMBalanceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contracts = [[NSArray alloc]init];
    contracts = [IGMobileApp sharedInstance].currentSelectedProduct.contracts;
    
    xPos = 10;
    xHeaderPos = 10;
    
    if ([self.splitViewController respondsToSelector:@selector(displayModeButtonItem)]) {
        [self.tableView reloadData];
        self.navigationItem.leftBarButtonItem = [self.splitViewController displayModeButtonItem];
    }
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationController.navigationBar.tintColor = OM_COLOR_LIGHT_GREEN;
    
    //self.lblProductName.text = [[IGMobileApp sharedInstance].currentSelectedProduct.caption stringByReplacingOccurrencesOfString:@"Old Mutual" withString:IGEmptyString];
    self.lblProductName.text = [[IGMobileApp sharedInstance].currentSelectedProduct.caption stringByReplacingOccurrencesOfString:@"Skandia" withString:IGEmptyString];
    
    self.lblBalance.text = [NSString stringWithFormat:OM_TXT_BALANCE_CONTRACT_LABEL, [IGMobileApp sharedInstance].currentSelectedProduct.totalBalance];
    ;
    [self createDynamicHeaders:self.headerView withContract:[contracts objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contracts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        [self createDynamicLabels:cell withContract:[contracts objectAtIndex:indexPath.row] withIndex: indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(void) createDynamicHeaders:(UIView *) view withContract:(IGContract *)contract {
        
    headerLabelWidth = 120;
    parentWidth = 600;
    
    int index = 0;
    
    for (IGField* field in contract.fields) {
        
        if (index < 5)
        {
            UILabel *lblHeader;
            
            xHeaderPos = index == 0 ? xHeaderPos : xHeaderPos + 20;
            
            lblHeader = [[UILabel alloc]initWithFrame:CGRectMake(xHeaderPos, 0, headerLabelWidth, 44)];
            lblHeader.numberOfLines = 0;
            lblHeader.text = field.caption;
            
            if (lblHeader.text.length > 35) {
                lblHeader.font = OM_FONT_HELVETICANEUE_MEDIUM;
            } else {
                lblHeader.font = OM_FONT_HELVETICANEUE_BIG;
            }
            
            lblHeader.textAlignment = NSTextAlignmentCenter;
            lblHeader.textColor = [UIColor whiteColor];
            
            [view addSubview:lblHeader];
            
            xHeaderPos += headerLabelWidth;
        }
        
        index++;
    }
    
    xHeaderPos = 10;
}

-(void) createDynamicLabels:(UITableViewCell *) cell withContract:(IGContract *)contract withIndex:(NSUInteger) contractRow {
    
    rowLabelWidth = parentWidth / 5;
    int index = 0;
    
    for (IGField* field in contract.fields) {
        
        if (index < 5)
        {
            UILabel *lblRow;
            xPos = index == 0 ? xPos : xPos + 20;
            
            lblRow = [[UILabel alloc]initWithFrame:CGRectMake(xPos, 0, rowLabelWidth, 84)];
            
            if ([field.key isEqualToString:OM_TXT_KEY_BALANCE_CONTRACT]){
                lblRow.textAlignment = NSTextAlignmentRight;
            } else if ([field.key isEqualToString:OM_TXT_KEY_PRODUCT_CONTRACT]){
                lblRow.textAlignment = NSTextAlignmentLeft;
            } else {
                lblRow.textAlignment = NSTextAlignmentCenter;
            }
            
            lblRow.text = field.value;
            lblRow.numberOfLines = 0;
            lblRow.textColor = OM_COLOR_GRAY;
            lblRow.font = OM_FONT_HELVETICANEUE_BIG;
            
            [cell.contentView addSubview:lblRow];
            xPos += rowLabelWidth;
        }
        
        index ++;
    }
    
    xPos = 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [IGMobileApp sharedInstance].currentSelectedContract = [contracts objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"contractsDetailSegue" sender:nil];
}


@end
