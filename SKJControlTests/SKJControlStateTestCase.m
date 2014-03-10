//
//  SKJControlStateTestCase.m
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

@interface SKJControlStateTestCase : XCTestCase
@property (nonatomic, strong) SKJControl * control;
@end

@implementation SKJControlStateTestCase

- (void)setUp
{
    [super setUp];
    self.control = [SKJControl node];
}

- (void)tearDown
{
    [super tearDown];
}

-(void)testControlStateNormal{
    expect(self.control.state).to.equal(UIControlStateNormal);
}

-(void)testSelectionTriggersSelectedControlState{
    expect(self.control.state & UIControlStateSelected).to.beFalsy();

    self.control.selected = YES;
    expect([self.control isSelected]).to.beTruthy();
    expect(self.control.state & UIControlStateSelected).to.beTruthy();
    self.control.selected = NO;

    expect([self.control isSelected]).to.beFalsy();
    expect(self.control.state & UIControlStateSelected).to.beFalsy();
}

-(void)testHighlightedTriggersControlState{
    expect(self.control.state & UIControlStateHighlighted).to.beFalsy();
    self.control.highlighted = YES;

    expect([self.control isHighlighted]).to.beTruthy();
    expect(self.control.state & UIControlStateHighlighted).to.beTruthy();

    self.control.highlighted = NO;

    expect([self.control isHighlighted]).to.beFalsy();
    expect(self.control.state & UIControlStateHighlighted).to.beFalsy();
}

-(void)testDisabledTriggersControlState{
    expect(self.control.state & UIControlStateDisabled).to.beFalsy();
    self.control.enabled = NO;

    expect([self.control isEnabled]).to.beFalsy();
    expect(self.control.state & UIControlStateDisabled).to.beTruthy();

    self.control.enabled = YES;

    expect([self.control isEnabled]).to.beTruthy();
    expect(self.control.state & UIControlStateDisabled).to.beFalsy();
}

-(void)testMultipleControlStates{
    self.control.selected = YES;
    self.control.highlighted = YES;

    UIControlState combinedState = UIControlStateSelected | UIControlStateHighlighted;
    expect(self.control.state).to.equal(combinedState);
}

@end
