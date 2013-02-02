//
//  Missile.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "Missile.h"

@interface Missile (PrivateMethods)

@end

@implementation Missile
@synthesize direcx;
@synthesize direcy;

-(id) initWithMissileAnimation
{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"missile.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"missile.png"];
    [self addChild:spriteSheet];
    
    missys = [NSMutableArray array];
    [missys addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"missile1.png"]];
    [missys addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"missile2.png"]];
    
    if ((self = [super initWithFile:@"missile1.png"]))
    {
        direcx = 0;
        direcy = 0;
    }
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"missile1.png"]];
    [self setScale:0.1f];
    moving = [CCAnimation animationWithFrames: missys delay:0.1f];
    move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moving restoreOriginalFrame:NO]];
    [self runAction:move];
    return self;
    return self;
}

@end
