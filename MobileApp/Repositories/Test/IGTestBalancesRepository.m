//
//  IGTestBalancesRepository.m
//  MobileApp
//
//  Created by steven muñoz on 6/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTestBalancesRepository.h"
#import "IGCompany.h"

@interface IGTestBalancesRepository ()

-(NSArray *) loadBalanceModelFromFile:(NSString *) fileName;

@end

@implementation IGTestBalancesRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getCompanies:(NSString *)docNumber withDocType:(NSString *)docType withBlock:(void (^)(NSArray *, NSError *))block {
    
    NSError *err = nil;
    NSArray *balances = [self loadBalanceModelFromFile:@"balances"];
    
    if (block) {
        block(balances, err);
    }
}

-(NSArray *) loadBalanceModelFromFile:(NSString *) fileName {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = nil;
    
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:items.count];
    IGCompany *obj;
    
    for (NSDictionary *item in items) {
        obj = [[IGCompany alloc] init];
        [obj updateWithDictionary:item];
        [objects addObject:obj];
    }
    
    return [NSArray arrayWithArray:objects];
    
}

@end
