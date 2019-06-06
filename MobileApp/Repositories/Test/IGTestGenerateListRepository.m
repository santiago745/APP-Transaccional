//
//  IGTestGenerateListRepository.m
//  MobileApp
//
//  Created by Rober on 17/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTestGenerateListRepository.h"
#import "IGGenerateList.h"

@interface IGTestGenerateListRepository ()

-(NSArray *) loadGenerateListModelFromFile:(NSString *) fileName;

@end

@implementation IGTestGenerateListRepository

static id _sharedInstance;

+ (id) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)getGenerateList:(NSString *)docNumber withDocType:(NSString *)docType withProduct:(NSString *)product withPlan:(NSString *)plan withContract:(NSString *)contract withBlock:(void (^)(NSArray *, NSError *))block
{
    NSArray *generateList = [self loadGenerateListModelFromFile:@"generateList"];
    
    if (block) {
        
        block(generateList, nil);
    }
}

-(NSArray *) loadGenerateListModelFromFile:(NSString *) fileName {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err = nil;
    
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:items.count];
    IGGenerateList *obj;
    
    for (NSDictionary *item in items) {
        obj = [[IGGenerateList alloc] init];
        [obj updateWithDictionary:item];
        [objects addObject:obj];
    }
    
    return [NSArray arrayWithArray:objects];
    
}

@end