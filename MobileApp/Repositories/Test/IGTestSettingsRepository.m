//
//  IGSettingsRepository.m
//  salesforce
//
//  Created by Armando Restrepo on 1/13/15.
//  Copyright (c) 2015 Leonisa. All rights reserved.
//

#import "IGTestSettingsRepository.h"

@implementation IGTestSettingsRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id) init {
    if (_sharedInstance){
        return _sharedInstance;
    }
    else{
        if (self = [super init]){
            //init properties
        }
        return self;
    }
}

-(NSDictionary *) getSettings{
    NSDictionary *settings = [[NSDictionary alloc] initWithObjectsAndKeys:@"2", @"commitmentDays",@"20",@"maxProductsInDetail",@"8",@"orderIdCharacters",@"5",@"orderIdMinCharacters", nil];
    return settings;
}

@end
