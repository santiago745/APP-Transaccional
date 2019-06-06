//
//  OMContractsDetailViewController.h
//  MobileApp
//
//  Created by steven muñoz on 7/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionVieSectionHeader.h"
#import "SKSTableView.h"

@interface OMContractsDetailViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate, SKSTableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblContractNumber;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
