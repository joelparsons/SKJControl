//
//  SKJTargetAction.m
//  SKJControl
//
//  Created by Joel Parsons on 21/04/2014.
//  Copyright (c) 2014 Joel Parsons. All rights reserved.
//

#import "SKJTargetAction.h"

@implementation SKJTargetAction

-(NSString *)description{
    NSString * actionString = NSStringFromSelector(self.action);
    NSString * targetName = @"nil";
    if (self.target) {
        NSString * className = NSStringFromClass([self.target class]);
        targetName = [NSString stringWithFormat:@"<%@: %p>", className, self.target];
    }

    NSString * returnString = [NSString stringWithFormat:@"%@ -> %@",actionString, targetName];
    return returnString;
}

@end
