//
//  Cake_ListTests.m
//  Cake ListTests
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Cake_ListTests-Swift.h>

@interface Cake_ListTests : XCTestCase

@end

@implementation Cake_ListTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

-(void)testApi{
    XCTestExpectation *expectation = [self expectationWithDescription:@"API test"];
    
    [CakeApi.shared loadCakeDataWithCompletion:^(NSArray<Cake *> * _Nullable cakes, NSError * _Nullable error) {
        XCTAssert(cakes.count > 0);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
