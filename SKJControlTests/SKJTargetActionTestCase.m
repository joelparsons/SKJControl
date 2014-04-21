//
//  SKJTargetActionTestCase.m
//  SKJControl
//
//  Created by Joel Parsons on 21/04/2014.
//  Copyright (c) 2014 Joel Parsons. All rights reserved.
//

#import <XCTest/XCTest.h>

//UUT
#import "SKJTargetAction.h"
//frameworks
#define EXP_SHORTHAND
#import "Expecta.h"

@interface SKJTargetActionTestCase : XCTestCase
@property (nonatomic, strong) SKJTargetAction * targetAction;
@end

@implementation SKJTargetActionTestCase

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.targetAction = [[SKJTargetAction alloc] init];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testThatDescriptionIncludesActionName{
    self.targetAction.action = @selector(description);
    expect(self.targetAction.description).to.contain(@"description");
}

-(void)testThatDescriptionIncludesTheClassOfTheTarget{
    self.targetAction.target = [NSArray array];
    expect(self.targetAction.description).to.contain(@"NSArray");

    self.targetAction.target = [NSDictionary dictionary];
    expect(self.targetAction.description).to.contain(@"NSDictionary");
}

-(void)testThatDescriptionIndicatesWhenTargetingNil{
    self.targetAction.target = nil;
    expect(self.targetAction.description).to.contain(@"nil");
}

-(void)testThatDescriptionIncludesTargetsPointer{
    NSArray * array = [NSArray array];
    NSString * arrayPointerString = [NSString stringWithFormat:@"%p",array];
    self.targetAction.target = array;
    expect(self.targetAction.description).to.contain(arrayPointerString);
}

-(void)testThatDescriptionIncludesTargetClassAndPointerInRecognizableFormats{
    NSArray * array = [NSArray array];
    NSString * recognizableFormat = [NSString stringWithFormat:@"<%@: %p>",NSStringFromClass(array.class),array];
    self.targetAction.target = array;
    expect(self.targetAction.description).to.contain(recognizableFormat);
}

-(void)testDescriptionDoesntIncludeNilPointerWhenTargetingNil{
    self.targetAction.target = nil;
    expect(self.targetAction.description).toNot.contain(@"0x0");
}

@end
