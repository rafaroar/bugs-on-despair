//
//  Redbug.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "Redbug.h"

@interface Redbug (PrivateMethods)
@end

@implementation Redbug

-(id) initWithRedbugAnimation
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"redbug.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"redbug.png"];
    [self addChild:spriteSheet];
    
    redbugs = [NSMutableArray array];
    [redbugs addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"redbug1.png"]];
    [redbugs addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"redbug2.png"]];
    
    self = [super initWithFile:@"redbug1.png"];
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"redbug1.png"]];
    self.position = ccp( 160,280);
    [self setScale:0.4f];
    moving = [CCAnimation animationWithFrames: redbugs delay:0.1f];
    move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moving restoreOriginalFrame:NO]];
    [self runAction:move];
    return self;
}

-(float) moveRedbugX: (int)counte high: (float)ranx
{
    int ran = counte % 10;
    ranx = ranx + 10 - arc4random()%21;
    if (ran==1)
    {
        ranx = ranx + 50 - arc4random()%101;
    }
    ranx = ranx - (self.position.x - 160)/50.0f;
    if ((self.position.x > 140) && (self.position.x < 180))
    {
        ranx = ranx + (self.position.x - 160)/5.0f;
    }
    if ((self.position.x > 20) && (self.position.x < 300))
    {
        self.position = ccp( self.position.x + ranx*0.02, self.position.y);
    }
    if (self.position.x >= 300)
    {
        self.position = ccp( 299, self.position.y );
        ranx = -20;
    }
    if (self.position.x <= 20)
    {
        self.position = ccp( 21, self.position.y );
        ranx = 20;
    }
    return ranx;
}

-(float) moveRedbugY: (int)counte high: (float)rany
{
    int ran = counte % 10;
    rany = rany + 10 - arc4random()%21;
    if (ran==1)
    {
        rany = rany + 50 - arc4random()%101;
    }
    rany = rany - (self.position.y - 280)/50.0f;
    if ((self.position.y > 260) && (self.position.y < 300))
    {
        rany = rany + (self.position.y - 280)/5.0f;
    }
    if ((self.position.y > 100) && (self.position.y < 460))
    {
        self.position = ccp( self.position.x, self.position.y + rany*0.02);
    }
    if (self.position.y <= 100)
    {
        self.position = ccp( self.position.x, 101 );
        rany = 20;
    }
    if (self.position.y >= 460)
    {
        self.position = ccp( self.position.x, 459 );
        rany = -20;
    }
    return rany;
}

@end
