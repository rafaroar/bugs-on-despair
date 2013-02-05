//
//  Redbug.m
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 31/01/13.
//
//

#import "Redbug.h"

@interface Redbug (PrivateMethods)
@end

@implementation Redbug
@synthesize speed;

-(id) initWithRedbugAnimation
{
    if ((self = [super initWithFile:@"redbug1.png"]))
    {
        speed = 0.02;
    }
    if(!self)
        return nil;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"redbug.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"redbug.png"];
    [self addChild:spriteSheet];
    
    redbugs = [NSMutableArray array];
    [redbugs addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"redbug1.png"]];
    [redbugs addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"redbug2.png"]];
    
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"redbug1.png"]];
    self.position = ccp( 160,280);
    [self setScale:0.4f];
    moving = [CCAnimation animationWithFrames: redbugs delay:0.1f];
    move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moving restoreOriginalFrame:NO]];
    [self runAction:move];
    return self;
}

@end
