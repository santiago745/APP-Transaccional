//
//  OMContractsDetailViewController.m
//  MobileApp
//
//  Created by steven muñoz on 7/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMContractsDetailViewController.h"
#import "IGMobileApp.h"
#import  "MBProgressHUD.h"
#import "IGGroup.h"
#import "IGContractDetailGroups.h"
#import "IGRecordValue.h"
#import "OMChartViewController.h"
#import "MZFormSheetController.h"
#import "SKSTableViewCell.h"
#import "OMGenerateCertificateViewController.h"
#import "IGTimeoutApplication.h"


@implementation OMContractsDetailViewController
{
    NSArray *groups;
    NSMutableArray *groupsFields;
    IGContract *contract;
    IGContractDetailGroups *field;
    UICollectionViewCell *cell;
    UILabel *txtLabel;
    UILabel *txtDetail;
    UILabel *separator;
    NSInteger recordSection, recordRow, recordValueRowCount, recordValueSubRowCount;
    NSInteger xPos, labelWidth;
    NSInteger heightCell;
    int header, index;
    SKSTableView *sksTableView;
    IGRecordValue *recordValue;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeHud)
                                                 name:kApplicationDidTimeoutNotification
                                               object:nil];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon-back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.parentViewController.navigationItem.leftBarButtonItem = backBtn;
    self.parentViewController.navigationItem.hidesBackButton = YES;
    
    //self.parentViewController.title = [[IGMobileApp sharedInstance].currentSelectedProduct.caption stringByReplacingOccurrencesOfString:@"Old Mutual" withString:IGEmptyString];
    self.parentViewController.title = [[IGMobileApp sharedInstance].currentSelectedProduct.caption stringByReplacingOccurrencesOfString:@"Skandia" withString:IGEmptyString];
    
    if(IPHONE) {
        self.parentViewController.title = OM_TXT_CONTRACT_DETAIL_TITLE_LABEL_IPHONE;
        
        self.lblContractNumber.text = [NSString stringWithFormat:OM_TXT_CONTRACT_DETAIL_LABEL_IPHONE, [IGMobileApp sharedInstance].currentSelectedContract.number];
        
        UIBarButtonItem *saveExitButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"out"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(saveExit)];
        
        self.parentViewController.navigationItem.rightBarButtonItem = saveExitButtonItem;
    } else {
        self.lblContractNumber.text = [NSString stringWithFormat:OM_TXT_CONTRACT_DETAIL_LABEL_IPAD, [IGMobileApp sharedInstance].currentSelectedContract.number];
        
        UIBarButtonItem *contractDetailBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_contract_detail_green"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:nil];
        
        UIBarButtonItem *transactionBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_historical"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(transactionsPressed:)];
        
        UIBarButtonItem *certificatesBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_certificate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(certificatesPressed:)];
        
     //   UIBarButtonItem *retirementBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_retirement"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(RetirementPressed:)];
        
        
        
        NSArray *rightButtonsItems = @[certificatesBtn, transactionBtn, contractDetailBtn];
        self.navigationItem.rightBarButtonItems = rightButtonsItems;
        self.navigationItem.leftBarButtonItem = backBtn;
    }
    
    UITabBarItem *tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:0];
    UIImage *selectedImage = [UIImage imageNamed:@"icon_contract_detail_green"];
    [tabBarItem setSelectedImage: selectedImage];
    
    [self.tabBarController.tabBar setTintColor:OM_COLOR_LIGHT_GREEN];
    
    [self getContractsDetail];
    
    if (contract.WithdrawalsAllowed == false){
        
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
    }
}

-(void)closeHud{
    [self hideHud:[[[UIApplication sharedApplication] windows] lastObject]];
}

-(void)saveExit{
    [[NSNotificationCenter defaultCenter] postNotificationName:IG_NOTIFICATION_SAFEEXIT object:self];
}

-(IBAction)backButtonPressed:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)transactionsPressed:(id)sender{
    [self performSegueWithIdentifier:@"transactionsSegue" sender:nil];
}

-(IBAction)certificatesPressed:(id)sender{
    [self performSegueWithIdentifier:@"GenerateCertificateSegue" sender:nil];
}

-(IBAction)RetirementPressed:(id)sender{
    [self performSegueWithIdentifier:@"RetirementIpad" sender:nil];
}

-(void) hideHud:(UIWindow *)actualWindow {
    [MBProgressHUD hideHUDForView:actualWindow animated:YES];
}

-(void) showAlertError:(NSString *)errorMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:OM_DEAR_CLIENT message:errorMessage delegate:self cancelButtonTitle:OM_TXT_ACCEPT otherButtonTitles:nil, nil];
    [alert show];
}

-(void) getContractsDetail
{
    contract = [IGMobileApp sharedInstance].currentSelectedContract;
    
    NSInteger channel;
    
    if (IPHONE) {
        channel = 1;
    } else {
        channel = 2;
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    [[IGMobileApp sharedInstance] getContractDetail:[IGMobileApp sharedInstance].currentAuthenticationResponse.docNumber withDocType:[IGMobileApp sharedInstance].currentAuthenticationResponse.docType withProduct:contract.productCode withPlan:contract.planCode withContract:contract.number withChannel:channel withBlock:^(NSError *error) {
        
        [self hideHud:window];
        
        if(!error) {
            groups = [[NSArray alloc]init];
            groupsFields = [[NSMutableArray alloc]init];
            
            groups = [IGMobileApp sharedInstance].currentContractDetail.groups;
            
            for (int i =0; i < [groups count]; i++){
                [groupsFields addObject:(NSArray *)((IGGroup *)[groups objectAtIndex:i]).fields];
            }
            
            [_collectionView reloadData];
            
        }
        else {
            [self showAlertError:OM_MESSAGE_LOGIN_ERRORONSERVICE];
        }
    }];
    
}

-(void)viewDidLayoutSubviews
{
    self.parentViewController.title = OM_TXT_CONTRACT_DETAIL_TITLE_LABEL_IPHONE;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [groups count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [(NSArray *)((IGGroup *)[groups objectAtIndex:section]).fields count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    field = (IGContractDetailGroups *) [[groupsFields objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                     forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews)
    {
        if ([view isKindOfClass:[UIView class]])
        {
            [view removeFromSuperview];
        }
    }
    
    for (UILabel *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UILabel class]])
        {
            [lbl removeFromSuperview];
        }
    }
    
    if ([field.type integerValue] == 0) {
        
        NSInteger height;
        NSString *text = field.singleValue;
        
        if (IPHONE) {
            height = 15;
            
            if (text.length > 52 && text.length <= 78) {
                height = height * 3;
            } else if (text.length > 78 && text.length <= 104) {
                height = height * 4;
            } else if (text.length > 104 && text.length <= 130) {
                height = height * 5;
            } else if (text.length > 130 && text.length <= 156) {
                height = height * 6;
            } else if (text.length > 156 && text.length <= 182) {
                height = height * 7;
            } else if (text.length > 182) {
                height = height * 8;
            }
            
            if (text.length <= 52) {
                txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, (cell.bounds.size.width / 2) - 20, 40)];
                txtDetail = [[UILabel alloc] initWithFrame:CGRectMake(cell.bounds.size.width / 2, 0, (cell.bounds.size.width / 2) - 8, 40)];
                separator = [[UILabel alloc] initWithFrame:CGRectMake(8, 42, (cell.bounds.size.width - 16), 1)];
            } else {
                [self createTextDetailIphone:height];
            }
            
            txtLabel.font = OM_FONT_HELVETICANEUE_MEDIUM;
            txtLabel.textAlignment = NSTextAlignmentRight;
            
            txtDetail.font = OM_FONT_HELVETICANEUE_MEDIUM;
            
        } else {
            height = 19;
            txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, (cell.bounds.size.width - 16), height)];
            txtLabel.font = OM_FONT_HELVETICANEUE_BIG;
            
            if (text.length > 50 && text.length <= 100) {
                height = height * 2;
            } else if (text.length > 100 && text.length <= 150) {
                height = height * 3;
            } else if (text.length > 150) {
                height = height * 4;
            }
            
            [self createTextDetailIpad:height];
            
            txtDetail.font = OM_FONT_HELVETICANEUE_BIG;
        }
        
        txtLabel.text = field.caption;
        txtLabel.textColor = [UIColor blackColor];
        txtLabel.lineBreakMode = NSLineBreakByWordWrapping;
        txtLabel.numberOfLines = 0;
        
        txtDetail.text = field.singleValue;
        txtDetail.textColor = OM_COLOR_GRAY;
        txtDetail.textAlignment = NSTextAlignmentLeft;
        txtDetail.lineBreakMode = NSLineBreakByWordWrapping;
        txtDetail.numberOfLines = 0;
        
        [cell.contentView addSubview:txtLabel];
        [cell.contentView addSubview:txtDetail];
        
        separator.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:separator];
    } else if ([field.type integerValue] == 2) {
        
        NSArray *groupsField = ((IGGroup *)[groups objectAtIndex:indexPath.section]).fields;
        NSString *key = ((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).key;
        UILabel *lblTitle;
        
        if ([((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue count] > 0) {
            
            if (IPHONE) {
                
                UILabel *lblTitle;
                lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, (cell.bounds.size.width - 126), 40)];
                lblTitle.numberOfLines = 0;
                lblTitle.text = ((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).caption;
                lblTitle.font = OM_FONT_HELVETICANEUE_BIG;
                lblTitle.textAlignment = NSTextAlignmentLeft;
                lblTitle.textColor = [UIColor blackColor];
                
                [cell.contentView addSubview: lblTitle];

                sksTableView = [[SKSTableView alloc] initWithFrame:CGRectMake(8, 40, (cell.bounds.size.width - 16), 416)];
                sksTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                sksTableView.delegate = self;
                sksTableView.dataSource = self;
                sksTableView.SKSTableViewDelegate = self;
                
                recordSection = indexPath.section;
                recordRow = indexPath.row;
                recordValueRowCount = [((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue count];
                
                NSArray *recordVal = [((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue objectAtIndex:0];
                
                recordValueSubRowCount = [recordVal count] - 1;
                
                [cell.contentView addSubview: sksTableView];
                
            } else if (IPAD) {
                
                UILabel *lblTitle;
                lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, (cell.bounds.size.width - 126), 40)];
                lblTitle.numberOfLines = 0;
                lblTitle.text = ((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).caption;
                lblTitle.font = OM_FONT_HELVETICANEUE_BIGGEST;
                lblTitle.textAlignment = NSTextAlignmentLeft;
                lblTitle.textColor = [UIColor blackColor];
                
                NSArray *recordVal = [((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue objectAtIndex:0];
                
                if ([key isEqualToString:@"Asset"]) {
                    
                    [IGMobileApp sharedInstance].currentSelectedGroupsField = [groupsField objectAtIndex:indexPath.row];
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [button addTarget:self
                               action:@selector(showGraphic:)
                     forControlEvents:UIControlEventTouchUpInside];
                    
                    [button setTitle:@"  Ver Gráfica" forState:UIControlStateNormal];
                    [button setTintColor:OM_COLOR_NEW_GREEN];
                    [button setImage:[UIImage imageNamed:@"icon_val.png"] forState:UIControlStateNormal];
                    
                    button.frame = CGRectMake((cell.bounds.size.width - 126), 0, 110, 40);
                    
                    [cell.contentView addSubview:button];
                }
                
                [cell.contentView addSubview: lblTitle];
                
                [self createDynamicTables:cell withGroup:groupsField withRow:recordVal withIndex:indexPath];
            }
            
        } else {
            [cell.contentView addSubview: lblTitle];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger sectionRow = indexPath.row;
    NSInteger sectionEndRow = [(NSArray *)((IGGroup *)[groups objectAtIndex:indexPath.section]).fields count];
    NSArray *groupsField = ((IGGroup *)[groups objectAtIndex:indexPath.section]).fields;
    NSInteger recordValueRow = [((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue count];
    NSInteger height;
    
    field = (IGContractDetailGroups *) [[groupsFields objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSString *text = field.singleValue;
    
    if (IPHONE) {
        
        height = 15;
        
        if ([field.type integerValue] == 0) {
            
            if (text.length <= 52) {
                if (sectionRow == (sectionEndRow - 1)) {
                    return CGSizeMake(self.collectionView.bounds.size.width, 64);
                }
                
                return CGSizeMake(self.collectionView.bounds.size.width, 44);
                
            } else if (text.length > 52 && text.length <= 78) {
                height = height * 3;
            } else if (text.length > 78 && text.length <= 104) {
                height = height * 4;
            } else if (text.length > 104 && text.length <= 130) {
                height = height * 5;
            } else if (text.length > 130 && text.length <= 156) {
                height = height * 6;
            } else if (text.length > 156 && text.length <= 182) {
                height = height * 7;
            } else if (text.length > 182) {
                height = height * 8;
            }
            
            // 6 = 1 del ancho del separador + 5 del padding bottom del separador
            heightCell = height + 6;
            
            if (sectionRow == (sectionEndRow - 1)) {
                return CGSizeMake(self.collectionView.bounds.size.width, heightCell + 20);
            }
            
            return CGSizeMake(self.collectionView.bounds.size.width, heightCell);
            
        } else if ([field.type integerValue] == 2  && recordValueRow > 0) {
            NSArray *recordVal = [((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue objectAtIndex:0];
            
            recordValueSubRowCount = [recordVal count];
            
            return CGSizeMake(self.collectionView.bounds.size.width,((recordValueRow * recordValueSubRowCount) * 44) + 60);
        } else {
            return CGSizeMake(1, 1);
        }
        
    } else {
        
        if ([field.type integerValue] == 0) {
            
            height = 19;
            
            if (text.length > 50 && text.length <= 100) {
                height = height * 2;
            } else if (text.length > 100 && text.length <= 150) {
                height = height * 3;
            } else if (text.length > 150) {
                height = height * 4;
            }
            
            // 33 = 19 del ancho del txtlabel + 8 del padding top del txtlabel + 1 del ancho del separador + 5 del padding bottom del separador
            heightCell = height + 33;
            
            if (sectionRow == (sectionEndRow - 1) ||  (sectionEndRow % 2 == 0 && (sectionRow + 1 == sectionEndRow - 1))) {
                // 30 = padding bottom de la celda
                return CGSizeMake((self.collectionView.bounds.size.width/2)-8, heightCell + 30);
            } else {
                return CGSizeMake((self.collectionView.bounds.size.width/2)-8, heightCell);
            }
        }
        else if ([field.type integerValue] == 2 && recordValueRow > 0) {
            return CGSizeMake(self.collectionView.bounds.size.width, ((recordValueRow * 44) + 84) + 30);
        }
        else {
            return CGSizeMake(1, 1);
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    
    CollectionVieSectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    headerView.titleLabel.text = ((IGGroup *)[groups objectAtIndex:indexPath.section]).caption;
    headerView.titleLabel.textColor = OM_COLOR_LIGHT_GREEN;
    
    reusableview = headerView;
    
    return reusableview;
}

#pragma mark - TableView DataSource Implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return recordValueRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *groupsField = ((IGGroup *)[groups objectAtIndex:recordSection]).fields;
    NSArray *recordVal = [((IGContractDetailGroups *)[groupsField objectAtIndex:recordRow]).recordValue objectAtIndex:indexPath.row];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cellSks = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cellSks) {
        cellSks = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    recordValue = [MTLJSONAdapter modelOfClass:IGRecordValue.class fromJSONDictionary:[recordVal objectAtIndex:0] error:nil];
    
    cellSks.textLabel.text = recordValue.value;
    cellSks.textLabel.textColor = OM_COLOR_NEW_GREEN;
    cellSks.textLabel.font = OM_FONT_HELVETICANEUE_BIG;
    cellSks.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cellSks;
}

-(void) createDynamicTables:(UICollectionViewCell *)cellCollection withGroup:(NSArray *)groupsField withRow:(NSArray *)recordVal withIndex:(NSIndexPath *)indexPath {
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(8, 40, (cellCollection.bounds.size.width - 16), 44)];
    footerView.backgroundColor  = [UIColor lightGrayColor];
    
    index = 0;
    xPos = 0;
    recordSection = indexPath.section;
    recordRow = indexPath.row;
    header = (int)[[((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue objectAtIndex:0] count];
    labelWidth = footerView.bounds.size.width / header;
    recordValueRowCount = [((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue count];
    
    for (int i=0; i < header; i++) {
        
        if (index < 5) {
            recordValue = [MTLJSONAdapter modelOfClass:IGRecordValue.class fromJSONDictionary:[recordVal objectAtIndex:index] error:nil];
            
            UILabel *lblHeader;
            lblHeader = [[UILabel alloc]initWithFrame:CGRectMake(xPos, 0, labelWidth, 44)];
            lblHeader.numberOfLines = 0;
            lblHeader.text = recordValue.caption;
            lblHeader.font = OM_FONT_HELVETICANEUE_BIG;
            lblHeader.textAlignment = NSTextAlignmentCenter;
            lblHeader.textColor = [UIColor whiteColor];
            
            [footerView addSubview:lblHeader];
            
            xPos += labelWidth;
        }
        
        index++;
    }
    
    [cellCollection.contentView addSubview: footerView];
    
    int y = 84;
    for (int h=0; h < recordValueRowCount; h++) {
        
        index = 0;
        xPos = 0;
        
        UIView *footerView2 = [[UIView alloc]initWithFrame:CGRectMake(8, y, (cellCollection.bounds.size.width - 16), 44)];
        footerView2.backgroundColor  = [UIColor whiteColor];
        
        for (int i=0; i < header; i++) {
            
            if (index < 5) {
                recordValue = [MTLJSONAdapter modelOfClass:IGRecordValue.class fromJSONDictionary:[[((IGContractDetailGroups *)[groupsField objectAtIndex:indexPath.row]).recordValue objectAtIndex:h] objectAtIndex:index] error:nil];
                
                UILabel *lblRow;
                lblRow = [[UILabel alloc]initWithFrame:CGRectMake(xPos, 0, labelWidth, 44)];
                lblRow.textAlignment = NSTextAlignmentCenter;
                lblRow.text = recordValue.value;
                lblRow.numberOfLines = 0;
                lblRow.textColor = OM_COLOR_GRAY;
                lblRow.font = OM_FONT_HELVETICANEUE_MEDIUM;
                
                [footerView2 addSubview:lblRow];
                
                xPos += labelWidth;
            }
            
            index++;
        }
        
        UILabel *lblLine;
        lblLine = [[UILabel alloc]initWithFrame:CGRectMake(8, 43, (cellCollection.bounds.size.width - 24), 1)];
        lblLine.backgroundColor = [UIColor lightGrayColor];
        lblLine.font = OM_FONT_HELVETICANEUE_MEDIUM;
        
        [footerView2 addSubview:lblLine];
        
        [cellCollection.contentView addSubview: footerView2];
        
        y = y + 44;
    }
}

-(IBAction)showGraphic:(id)sender{
    
    OMChartViewController *chartViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChartController"];
    chartViewController.delegate = self;
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:chartViewController];
    
    formSheet.shouldDismissOnBackgroundViewTap = NO;
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheet.landscapeTopInset = 60;
    formSheet.presentedFormSheetSize = CGSizeMake(VIEW_WIDTH, VIEW_HEIGTH);
    
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController){
        presentedFSViewController.view.autoresizingMask = presentedFSViewController.view.autoresizingMask | UIViewAutoresizingFlexibleWidth;
    };
    
    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) { }];
}

-(void) createTextDetailIphone:(NSInteger)height {
    txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, (cell.bounds.size.width / 2) - 20, height)];
    txtDetail = [[UILabel alloc] initWithFrame:CGRectMake(cell.bounds.size.width / 2, 0, (cell.bounds.size.width / 2) - 8, height)];
    separator = [[UILabel alloc] initWithFrame:CGRectMake(8, (height + 5), (cell.bounds.size.width - 16), 1)];
}

-(void) createTextDetailIpad:(NSInteger)height {
    txtDetail = [[UILabel alloc] initWithFrame:CGRectMake(8, 27, (cell.bounds.size.width -16), height)];
    separator = [[UILabel alloc] initWithFrame:CGRectMake(8, (height + 27) + 2, (cell.bounds.size.width - 16), 1)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return recordValueSubRowCount;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *groupsField = ((IGGroup *)[groups objectAtIndex:recordSection]).fields;
    NSArray *recordVal = [((IGContractDetailGroups *)[groupsField objectAtIndex:recordRow]).recordValue objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *subCellSks = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!subCellSks) {
        subCellSks = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, (subCellSks.bounds.size.width / 2) - 20, 44)];
        txtDetail = [[UILabel alloc] initWithFrame:CGRectMake(subCellSks.bounds.size.width / 2, 0, (subCellSks.bounds.size.width / 2) - 16, 44)];
        
        txtLabel.tag = OM_TAG_ONE;
        txtDetail.tag = OM_TAG_TWO;
        [subCellSks.contentView addSubview:txtLabel];
        [subCellSks.contentView addSubview:txtDetail];
    }
    
    recordValue = [MTLJSONAdapter modelOfClass:IGRecordValue.class fromJSONDictionary:[recordVal objectAtIndex:indexPath.subRow] error:nil];
    
    subCellSks.selectionStyle = UITableViewCellSelectionStyleNone;
    
    txtLabel = (UILabel *)[subCellSks.contentView viewWithTag:OM_TAG_ONE];
    txtLabel.numberOfLines = 0;
    [txtLabel setText:recordValue.caption];
    txtLabel.textAlignment = NSTextAlignmentRight;
    txtLabel.textColor = [UIColor blackColor];
    txtLabel.font = OM_FONT_HELVETICANEUE_MEDIUM;
    
    txtDetail = (UILabel *)[subCellSks.contentView viewWithTag:OM_TAG_TWO];
    txtDetail.numberOfLines = 0;
    [txtDetail setText:recordValue.value];
    txtDetail.textColor = OM_COLOR_GRAY;
    txtDetail.font = OM_FONT_HELVETICANEUE_MEDIUM;
    
    return subCellSks;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
