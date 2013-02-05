//
//  Fly.m
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 31/01/13.
//
//

#import "Fly.h"

@interface Fly (PrivateMethods)
@end

@implementation Fly
@synthesize speed;

-(id) initWithFlyAnimation
{
    if ((self = [super initWithFile:@"fly1.png"]))
    {
        speed = 0.01;
    }
    if(!self)
        return nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"fly.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"fly.png"];
    [self addChild:spriteSheet];
    
    flies = [NSMutableArray array];
    [flies addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"fly1.png"]];
    [flies addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"fly2.png"]];
    
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"fly1.png"]];
    self.position = ccp( 160,280);
    [self setScale:0.4f];
    moving = [CCAnimation animationWithFrames: flies delay:0.1f];
    move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moving restoreOriginalFrame:NO]];
    [self runAction:move];
    return self;
}

@end
