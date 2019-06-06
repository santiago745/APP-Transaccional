//
//  UITextField+IGValidateForms.m
//  MobileApp
//
//  Created by steven muñoz on 31/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "UITextField+IGValidateForms.h"

@implementation UITextField (IGValidateForms)

- (BOOL)isValidField {
    
    if (self.text.length >= 1)
    {
        [self changeViewToValid];
        return true;
    }
    else {
        
        [self changeViewToInvalid];
        return  false;
    }
}

- (BOOL)isValidRegex:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:self.text])
    {
        [self changeViewToValid];
        return true;
        
    } else {
        
        [self changeViewToInvalid];
        return  false;
    }
}

-(void)changeViewToInvalid
{
    if (self){
        /*self.layer.cornerRadius=8.0f;
        self.layer.masksToBounds=YES;
        self.layer.borderColor=[[UIColor redColor]CGColor];
        self.layer.borderWidth= 1.0f;*/
    }
}

-(void)changeViewToValid
{
    if (self){
       self.layer.borderColor=[[UIColor clearColor]CGColor];
    }
}
@end
