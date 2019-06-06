//
//  UIViewMGBadgeView.h
//  salesforce
//
//  Created by Alejandro Orozco Builes on 4/01/15.
//  Copyright (c) 2015 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, MGBadgePosition) {
    MGBadgePositionTopLeft,
    MGBadgePositionTopRight,
    MGBadgeCustomPositionTopRight,
    MGBadgePositionBottomLeft,
    MGBadgePositionBottomRight,
    MGBadgePositionBest
};

@interface UIViewMGBadgeView : UIView

@property (nonatomic) MGBadgePosition position;

@property (nonatomic) NSInteger badgeValue;

@property(strong, nonatomic) UIFont *font;

@property(strong, nonatomic) UIColor *badgeColor;

@property(strong, nonatomic) UIColor *textColor;

@property(strong, nonatomic) UIColor *outlineColor;

@property (nonatomic) float outlineWidth;

@property (nonatomic) float minDiameter;

@property (nonatomic) BOOL displayIfZero;

@end


@interface UIView (UIViewMGBadgeView)

@property(nonatomic) UIViewMGBadgeView *badgeView;


@end
