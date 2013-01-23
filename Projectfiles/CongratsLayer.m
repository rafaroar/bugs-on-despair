//
//  CongratsLayer.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "CongratsLayer.h"
#import "Level1.h"
CCSprite *congrats;
CCSprite *fly;
CCAction *taunt;
NSMutableArray *tauntingFrames;
int counte;
int ranx;
int rany;

@interface CongratsLayer (PrivateMethods)
@end

@implementation CongratsLayer

#define Y_OFF_SET 80
#define WIDTH_WINDOW 320
#define HEIGHT_WINDOW 480
#define CELL_WIDTH 80
#define WIDTH_GAME WIDTH_WINDOW
#define HEIGHT_GAME (HEIGHT_WINDOW - 80)

-(void) draw
{
    //big green rectangle
    CGPoint c = ccp(0,0); //lower-left corner
    CGPoint d = ccp(WIDTH_GAME,HEIGHT_WINDOW); //upper-right corner
    ccColor4F color = ccc4f(0.2, 0.6, 0.2, 1);
    ccDrawSolidRect(c, d, color);
}

-(id) init
{
	if ((self = [super init]))
	{
        congrats = [CCSprite spriteWithFile:@"congrats.png"];
        congrats.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET*2);
        [congrats setScale:0.7f];
        [self addChild:congrats z:1];
        
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"playagain.png"
                                                            selectedImage: @"playagain.png"
                                                                   target:self
                                                                 selector:@selector(startg:)];
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, nil];
        myMenu.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - Y_OFF_SET);
        [myMenu setScale:0.9f];
        [self addChild: myMenu z:1];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"fly.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"fly.png"];
        [self addChild:spriteSheet];
        
        tauntingFrames = [NSMutableArray array];
        [tauntingFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"fly1.png"]];
        [tauntingFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"fly2.png"]];
        
        fly = [CCSprite spriteWithSpriteFrameName:@"fly1.png"];
        fly.position = ccp( WIDTH_GAME/2, HEIGHT_GAME/2 + Y_OFF_SET);
        [fly setScale:0.4f];
        CCAnimation *taunting = [CCAnimation animationWithFrames: tauntingFrames delay:0.1f];
        taunt = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:taunting restoreOriginalFrame:NO]];
        [fly runAction:taunt];
        [self addChild:fly z:2];
        
        counte=0;
        ranx=0;
        rany=0;
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) update: (ccTime) delta
{
    //move fly
    counte++;
    int ran = counte % 10;
    ranx = ranx + 10 - arc4random()%21;
    rany = rany + 10 - arc4random()%21;
    if (ran==1)
    {
        ranx = ranx + 50 - arc4random()%101;
        rany = rany + 50 - arc4random()%101;
    }
    ranx = ranx - (fly.position.x - 160)/50;
    rany = rany - (fly.position.y - 280)/50;
    if ((fly.position.x > 140) && (fly.position.x < 180) && (fly.position.y > 260) && (fly.position.y < 300))
    {
        ranx = ranx + (fly.position.x - 160)/5;
        rany = rany + (fly.position.y - 280)/5;
    }
    if ((fly.position.x > 20) && (fly.position.x < 300) && (fly.position.y > 100) && (fly.position.y < 460))
    {
        fly.position = ccp( fly.position.x + ranx*delta, fly.position.y + rany*delta);
    }
    if (fly.position.x >= 300)
    {
        fly.position = ccp( 299, fly.position.y );
        ranx = -20;
    }
    if (fly.position.x <= 20)
    {
        fly.position = ccp( 21, fly.position.y );
        ranx = 20;
    }
    if (fly.position.y <= 100)
    {
        fly.position = ccp( fly.position.x, 101 );
        rany = 20;
    }
    if (fly.position.y >= 460)
    {
        fly.position = ccp( fly.position.x, 459 );
        rany = -20;
    }
}

-(void) startg: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level1 alloc] init]];
}

@end
