//
//  SKJControl.m
//  SKJControl
//
//  Created by Joel Parsons on 10/03/2014.
//  Copyright (c) 2014 Joel Parsons. All rights reserved.
//

#import "SKJControl.h"

@implementation SKJControl

-(instancetype)init{
    self = [super init];
    if (self) {
        _enabled = YES;
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

@end
