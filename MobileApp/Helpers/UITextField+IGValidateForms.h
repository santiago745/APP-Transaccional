//
//  UITextField+IGValidateForms.h
//  MobileApp
//
//  Created by steven muñoz on 31/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (IGValidateForms)

- (BOOL)isValidField;
- (BOOL)isValidRegex:(NSString *)regex;
- (void)changeViewToInvalid;
-(void)changeViewToValid;

@end
