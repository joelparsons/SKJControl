//
//  SKJTargetAction.h
//  SKJControl
//
//  Created by Joel Parsons on 21/04/2014.
//  Copyright (c) 2014 Joel Parsons. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class is a private class that keeps track of target action pairs for SKControl.
 */

@interface SKJTargetAction : NSObject
/**
 The target of the message from the SKJControl
 */
@property (nonatomic, unsafe_unretained) id target;
/**
 The selector the SKJControl should call on the target
 */
@property (nonatomic) SEL action;
/**
 The control events mask that filter when this target action message should be sent.
 */
@property (nonatomic) UIControlEvents controlEvents;
@end