//
//  SKJControl.m
//  SKJControl
//
//  Created by Joel Parsons on 10/03/2014.
//  Copyright (c) 2014 Joel Parsons. All rights reserved.
//

#import "SKJControl.h"
#import "SKJTargetAction.h"
#import <objc/runtime.h>

@interface SKJControl ()
@property (nonatomic, strong) NSMutableArray * targetActions;
@end

@implementation SKJControl

-(instancetype)init{
    self = [super init];
    if (self) {
        _enabled = YES;
        _targetActions = [NSMutableArray array];
    }
    return self;
}

-(UIControlState)state{
    UIControlState state = UIControlStateNormal;
    if ([self isSelected]) {
        state = state | UIControlStateSelected;
    }

    if ([self isHighlighted]) {
        state = state | UIControlStateHighlighted;
    }

    if (![self isEnabled]) {
        state = state | UIControlStateDisabled;
    }

    return state;
}

#pragma mark - target action

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    SKJTargetAction * targetAction = [[SKJTargetAction alloc] init];
    targetAction.target = target;
    targetAction.action = action;
    targetAction.controlEvents = controlEvents;
    [self.targetActions addObject:targetAction];
}

-(void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{

    NSMutableArray * removalArray = [[NSMutableArray alloc] init];

    for (SKJTargetAction * targetAction in self.targetActions) {
        BOOL targetMatch = NO;
        BOOL selectorMatch = NO;
        BOOL controlEventMatch = NO;
        if (target) {
            if (target == targetAction.target) {
                targetMatch = YES;
            }
        }
        else{
            targetMatch = YES;
        }

        if (sel_isEqual(targetAction.action, action)) {
            selectorMatch = YES;
        }
        else if (action == NULL) {
            selectorMatch = YES;
        }

        UIControlEvents xoredEvents = targetAction.controlEvents ^ controlEvents;
        if (xoredEvents == 0) {
            controlEventMatch = YES;
        }

        if (targetMatch && selectorMatch && controlEventMatch) {
            [removalArray addObject:targetAction];
        }
    }
    [self.targetActions removeObjectsInArray:removalArray];
}

-(NSSet *)allTargets{
    NSMutableSet * set = [[NSMutableSet alloc] init];
    for (SKJTargetAction * targetAction in self.targetActions) {
        if (targetAction.target) {
            [set addObject:targetAction.target];
        }
        else{
            [set addObject:[NSNull null]];
        }
    }
    return set;
}

-(UIControlEvents)allControlEvents{
    UIControlEvents allEvents = 0;

    for (SKJTargetAction * targetAction in self.targetActions) {
        allEvents = allEvents | targetAction.controlEvents;
    }

    return allEvents;
}

-(NSArray *)actionsForTarget:(id)target forControlEvent:(UIControlEvents)controlEvent{
    return nil;
}

-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [[UIApplication sharedApplication] sendAction:action
                                               to:target
                                             from:self
                                         forEvent:event];
}

-(void)sendActionsForControlEvents:(UIControlEvents)controlEvents{
    for (SKJTargetAction * targetAction in self.targetActions) {
        [self sendAction:targetAction.action
                      to:targetAction.target
                forEvent:nil];
    }
}

@end
