//
//  SKJCallingActionsTestCase.m
//  SKJControl
//
//  Created by Joel Parsons on 11/03/2014.
//  Copyright (c) 2014 Joel Parsons. All rights reserved.
//

#import <XCTest/XCTest.h>
//UUT
#import "SKJControl.h"
//frameworks
#define EXP_SHORTHAND
#import "Expecta.h"
#import "OCMock.h"
//supporting
#import "SKJTargetActionObject.h"

@interface SKJCallingActionsTestCase : XCTestCase
@property (nonatomic, strong) SKJControl * control;

@end

@implementation SKJCallingActionsTestCase

- (void)setUp
{
    [super setUp];
    self.control = [SKJControl node];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

-(void)testCallsBasicTargetActionMethod{
    id mock = [OCMockObject mockForClass:[SKJTargetActionObject class]];
    [[mock expect] targetAction];

    [self.control addTarget:mock
                     action:@selector(targetAction)
           forControlEvents:UIControlEventAllEvents];

    [self.control sendActionsForControlEvents:UIControlEventAllEvents];

    [mock verify];
}

-(void)testCallsTargetActionMethodWithSender{
    id mock = [OCMockObject mockForClass:[SKJTargetActionObject class]];
    [[mock expect] targetAction:self.control];

    [self.control addTarget:mock
                     action:@selector(targetAction:)
           forControlEvents:UIControlEventAllEvents];

    [self.control sendActionsForControlEvents:UIControlEventAllEvents];

    [mock verify];
}

@end
