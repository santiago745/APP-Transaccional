//
//  CustomTableViewCell.h
//  MobileApp
//
//  Created by Administrador on 1/23/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblprice;

@property (weak, nonatomic) IBOutlet UILabel *lblcontract;
@property (weak, nonatomic) IBOutlet UILabel *lblnombre;
@end

NS_ASSUME_NONNULL_END
