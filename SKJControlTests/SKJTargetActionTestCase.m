//
//  SKJTargetActionTestCase.m
//  SKJControl
//
//  Created by Joel Parsons on 10/03/2014.
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

@interface SKJTargetActionTestCase : XCTestCase
@property (nonatomic, strong) SKJControl * control;
@end

@implementation SKJTargetActionTestCase

- (void)setUp
{
    [super setUp];
    self.control = [SKJControl node];
}

- (void)tearDown
{
    [super tearDown];
}

-(void)testAddTarget{
    id object = [[NSObject alloc] init];
    [self.control addTarget:object
                     action:@selector(description)
           forControlEvents:UIControlEventAllEvents];

    expect(self.control.allTargets).to.contain(object);
}

-(void)testAddMultipleTargets{
    id object1 = [[NSObject alloc] init];
    id object2 = [[NSObject alloc] init];
    [self.control addTarget:object1
                     action:@selector(description)
           forControlEvents:UIControlEventAllEvents];
    [self.control addTarget:object2
                     action:@selector(description)
           forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).to.contain(object1);
    expect(self.control.allTargets).to.contain(object2);
}

-(void)testRemoveTarget{
    id object = [[NSObject alloc] init];
    [self.control addTarget:object
                     action:@selector(description)
           forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).to.contain(object);
    [self.control removeTarget:object
                        action:@selector(description)
              forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).toNot.contain(object);
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
