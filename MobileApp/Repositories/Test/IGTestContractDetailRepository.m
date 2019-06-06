//
//  IGTestContractDetailRepository.m
//  MobileApp
//
//  Created by Rober on 12/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTestContractDetailRepository.h"
#import "IGContractDetail.h"

@interface IGTestContractDetailRepository ()

-(NSDictionary *) loadContractDetailModelFromFile:(NSString *) fileName;

@end

@implementation IGTestContractDetailRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getContractDetail:(NSString *)docNumber withDocType:(NSString *)docType withProduct:(NSString *)product withPlan:(NSString *)plan withContract:(NSString *)contract withChannel:(NSInteger)channel withBlock:(void (^)(IGContractDetail *, NSError *))block
{
    NSDictionary *contractsDetail = [self loadContractDetailModelFromFile:@"contractsDetail"];
    
    if (block) {
        IGContractDetail *response = [MTLJSONAdapter modelOfClass:[IGContractDetail class] fromJSONDictionary:contractsDetail error:nil];
        
        block(response, nil);
    }
}

-(NSDictionary *) loadContractDetailModelFromFile:(NSString *) fileName {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = nil;
    
    NSDictionary *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    return items;
}

@end
