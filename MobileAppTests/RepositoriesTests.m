//
//  RepositoriesTests.m
//  MobileApp
//
//  Created by Armando Restrepo on 2/23/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IGRepositoryLocator.h"

@interface RepositoriesTests : XCTestCase

@end

@implementation RepositoriesTests
IGRepositoryLocator *context;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    context = [IGRepositoryLocator sharedInstance];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSettings {
    // This is an example of a functional test case.
    
    XCTAssertGreaterThan([[context.settingsRepository getSettings]count], 0, "Debe ser mayor a 0");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
