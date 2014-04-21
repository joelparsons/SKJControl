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

@interface SKJSettingTargetsTestCase : XCTestCase
@property (nonatomic, strong) SKJControl * control;

-(id)exampleTarget;

@end

@implementation SKJSettingTargetsTestCase

- (void)setUp
{
    [super setUp];
    self.control = [SKJControl node];
}

- (void)tearDown
{
    [super tearDown];
}

-(id)exampleTarget{
    id object = [[NSObject alloc] init];
    [self.control addTarget:object
                     action:@selector(description)
           forControlEvents:UIControlEventAllEvents];
    return object;
}

-(void)testAddTarget{
    id object = [self exampleTarget];
    expect(self.control.allTargets).to.contain(object);
}

-(void)testAddMultipleTargets{
    id object1 = [self exampleTarget];
    id object2 = [self exampleTarget];

    expect(self.control.allTargets).to.contain(object1);
    expect(self.control.allTargets).to.contain(object2);
}

-(void)testAddNilTarget{
    [self.control addTarget:nil
                     action:@selector(description)
           forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).to.contain([NSNull null]);
}

-(void)testRemoveTargetForSameSelectorAndAction{
    id object = [self exampleTarget];
    expect(self.control.allTargets).to.contain(object);

    [self.control removeTarget:object
                        action:@selector(description)
              forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).toNot.contain(object);
}

-(void)testRemoveTargetWithNullSelector{
    id object = [self exampleTarget];

    expect(self.control.allTargets).to.contain(object);
    [self.control removeTarget:object
                        action:NULL
              forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).toNot.contain(object);
}

-(void)testOnlyRemovesCorrectActionForTarget{
    id object = [self exampleTarget];
    expect(self.control.allTargets).to.contain(object);
    [self.control addTarget:object
                     action:@selector(integerValue)
           forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).to.contain(object);
    [self.control removeTarget:object
                        action:@selector(integerValue)
              forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).to.contain(object);
}

-(void)testRemovesAllActionsForTargetAndControlEvents{
    id object = [self exampleTarget];

    [self.control addTarget:object
                     action:@selector(init)
           forControlEvents:UIControlEventAllEvents];

    expect(self.control.allTargets).to.contain(object);
    [self.control removeTarget:object
                        action:NULL
              forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).toNot.contain(object);
}

-(void)testRemovesObjectForSelectorAndControlEvent{
    id object = [self exampleTarget];
    expect(self.control.allTargets).to.contain(object);

    [self.control removeTarget:nil
                        action:@selector(description)
              forControlEvents:UIControlEventAllEvents];
    expect(self.control.allTargets).toNot.contain(object);
}

-(void)testChecksControlEventMatchesOnRemoval{
    id object = [self exampleTarget];
    expect(self.control.allTargets).to.contain(object);

    [self.control removeTarget:object
                        action:@selector(description)
              forControlEvents:UIControlEventTouchDown];
    expect(self.control.allTargets).to.contain(object);
}

-(void)testAllControlEventsWithNoTargets{
    expect(self.control.allControlEvents).to.equal(0);
}

-(void)testAllControlEventsWithOneControlEvent{
    [self.control addTarget:self
                     action:@selector(description)
           forControlEvents:UIControlEventEditingDidBegin];
    expect(self.control.allControlEvents).to.equal(UIControlEventEditingDidBegin);
}

@end
