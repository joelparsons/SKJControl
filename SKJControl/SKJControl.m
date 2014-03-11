//
//  SKJControl.m
//  SKJControl
//
//  Created by Joel Parsons on 10/03/2014.
//  Copyright (c) 2014 Joel Parsons. All rights reserved.
//

#import "SKJControl.h"

@interface SKJTargetAction : NSObject
@property (nonatomic, strong) id target;
@property (nonatomic) SEL action;
@property (nonatomic) UIControlEvents controlEvents;
@end

@implementation SKJTargetAction
@end

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

-(NSSet *)allTargets{
    NSMutableSet * set = [[NSMutableSet alloc] init];
    for (SKJTargetAction * targetAction in self.targetActions) {
        [set addObject:targetAction.target];
    }
    return set;
}

-(void)sendActionsForControlEvents:(UIControlEvents)controlEvents{
    for (SKJTargetAction * targetAction in self.targetActions) {
        NSMethodSignature * methodSigniature = [targetAction.target methodSignatureForSelector:targetAction.action];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSigniature];
        [invocation setSelector:targetAction.action];
        [invocation setTarget:targetAction.target];

        //arguments 0 and 1 are self and _cmd
        if (methodSigniature.numberOfArguments > 2) {
            __unsafe_unretained id selfPointer = self;
            [invocation setArgument:&selfPointer atIndex:2];
        }
        
        [invocation invoke];
    }
}

@end
