//
//  OMTransactionsHistoryDetailViewController.h
//  MobileApp
//
//  Created by Rober on 27/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMTransactionsHistoryDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTransactionHistoryFunds;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactionHistoryDocuments;
@property (weak, nonatomic) IBOutlet UITableView *tblTransactionHistoryFields;
@property (strong, nonatomic) IBOutlet UITableView *tblTransactionHistoryFunds;
@property (strong, nonatomic) IBOutlet UITableView *tblTransactionHistoryDocuments;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dynamicTableFaildsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dynamicTableFundsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dynamicTableDocumentsHeight;

@end
