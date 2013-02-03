//
//  Bee.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "Bee.h"

@interface Bee (PrivateMethods)
@end

@implementation Bee
@synthesize speed;

-(id) initWithBeeAnimation
{
    if ((self = [super initWithFile:@"bee1.png"]))
    {
        speed = 0.005;
    }
    if(!self)
        return nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"bee.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
    [self addChild:spriteSheet];
    
    bees = [NSMutableArray array];
    [bees addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"bee1.png"]];
    [bees addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"bee2.png"]];
    
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"bee1.png"]];
    self.position = ccp( 160,280);
    [self setScale:0.4f];
    moving = [CCAnimation animationWithFrames: bees delay:0.1f];
    move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moving restoreOriginalFrame:NO]];
    [self runAction:move];
    return self;
}

@end
