//
//  SKJTargetActionObject.h
//  SKJControl
//
//  Created by Joel Parsons on 11/03/2014.
//  Copyright (c) 2014 Joel Parsons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKJTargetActionObject : NSObject

-(void)targetAction;

-(void)targetAction:(id)sender;

-(void)targetAction:(id)sender forEvent:(UIEvent *)event;

@end
