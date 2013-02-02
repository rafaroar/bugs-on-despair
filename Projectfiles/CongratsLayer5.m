//
//  CongratsLayer5.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 01/02/13.
//
//

#import "CongratsLayer5.h"
#import "Level1.h"
#import "Level2.h"
#import "Level3.h"
#import "Level4.h"
#import "Level5.h"

@interface CongratsLayer5 (PrivateMethods)
@end

@implementation CongratsLayer5

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
    ccColor4F color = ccc4f(0.3, 0.4, 0.5, 1);
    ccDrawSolidRect(c, d, color);
}

-(id) init
{
	if ((self = [super init]))
	{
        congrats = [CCSprite spriteWithFile:@"congrats3.png"];
        congrats.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET*2);
        [congrats setScale:0.7f];
        [self addChild:congrats z:1];
        
        playagain = [CCSprite spriteWithFile:@"playagain.png"];
        playagain.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + 100);
        [playagain setScale:0.9f];
        [self addChild:playagain z:1];
        
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"level1.png"
                                                            selectedImage: @"level1.png"
                                                                   target:self
                                                                 selector:@selector(gotolevel1:)];
        
        CCMenuItemImage *menuItem2 = [CCMenuItemImage itemWithNormalImage:@"level2.png"
                                                            selectedImage: @"level2.png"
                                                                   target:self
                                                                 selector:@selector(gotolevel2:)];
        
        CCMenuItemImage *menuItem3 = [CCMenuItemImage itemWithNormalImage:@"level3.png"
                                                            selectedImage: @"level3.png"
                                                                   target:self
                                                                 selector:@selector(gotolevel3:)];
        
        CCMenuItemImage *menuItem4 = [CCMenuItemImage itemWithNormalImage:@"level3.png"
                                                            selectedImage: @"level3.png"
                                                                   target:self
                                                                 selector:@selector(gotolevel4:)];
        
        CCMenuItemImage *menuItem5 = [CCMenuItemImage itemWithNormalImage:@"level3.png"
                                                            selectedImage: @"level3.png"
                                                                   target:self
                                                                 selector:@selector(gotolevel5:)];
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, nil];
        menuItem1.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + 20);
        menuItem2.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 40);
        menuItem3.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 100);
        menuItem4.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 160);
        menuItem5.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 220);
        myMenu.position = ccp(0, 0);
        [menuItem1 setScale:0.9f];
        [menuItem2 setScale:0.9f];
        [menuItem3 setScale:0.9f];
        [menuItem4 setScale:0.9f];
        [menuItem5 setScale:0.9f];
        [self addChild: myMenu z:1];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"fly.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"fly.png"];
        [self addChild:spriteSheet];
        
        flies = [NSMutableArray array];
        [flies addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"fly1.png"]];
        [flies addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"fly2.png"]];
        
        fly = [CCSprite spriteWithSpriteFrameName:@"fly1.png"];
        fly.position = ccp( WIDTH_GAME/2, HEIGHT_GAME/2 + Y_OFF_SET);
        [fly setScale:0.4f];
        CCAnimation *moving = [CCAnimation animationWithFrames: flies delay:0.1f];
        move = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moving restoreOriginalFrame:NO]];
        [fly runAction:move];
        [self addChild:fly z:3];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"bee.plist"];
        CCSpriteBatchNode *spriteSheet2 = [CCSpriteBatchNode batchNodeWithFile:@"bee.png"];
        [self addChild:spriteSheet2];
        
        bees = [NSMutableArray array];
        [bees addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"bee1.png"]];
        [bees addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: @"bee2.png"]];
        
        bee = [CCSprite spriteWithSpriteFrameName:@"bee1.png"];
        bee.position = ccp( WIDTH_GAME/2 + 40, HEIGHT_GAME/2 + Y_OFF_SET);
        [bee setScale:0.4f];
        CCAnimation *moving2 = [CCAnimation animationWithFrames: bees delay:0.1f];
        move2 = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:moving2 restoreOriginalFrame:NO]];
        [bee runAction:move2];
        [self addChild:bee z:3];
        
        counte=0;
        ranx=0;
        rany=0;
        beex=0;
        beey=0;
        
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
    
    //move bee
    beex = beex + 10 - arc4random()%21;
    beey = beey + 10 - arc4random()%21;
    if (ran==6)
    {
        beex = beex + 50 - arc4random()%101;
        beey = beey + 50 - arc4random()%101;
    }
    beex = beex - (bee.position.x - 160)/50;
    beey = beey - (bee.position.y - 280)/50;
    if ((bee.position.x > 140) && (bee.position.x < 180) && (bee.position.y > 260) && (bee.position.y < 300))
    {
        beex = beex + (bee.position.x - 160)/5;
        beey = beey + (bee.position.y - 280)/5;
    }
    if ((bee.position.x > 20) && (bee.position.x < 300) && (bee.position.y > 100) && (bee.position.y < 460))
    {
        bee.position = ccp( bee.position.x + beex*delta/3, bee.position.y + beey*delta/3);
    }
    if (bee.position.x >= 300)
    {
        bee.position = ccp( 299, bee.position.y );
        beex = -20;
    }
    if (bee.position.x <= 20)
    {
        bee.position = ccp( 21, bee.position.y );
        beex = 20;
    }
    if (bee.position.y <= 100)
    {
        bee.position = ccp( bee.position.x, 101 );
        beey = 20;
    }
    if (bee.position.y >= 460)
    {
        fly.position = ccp( bee.position.x, 459 );
        beey = -20;
    }
}

-(void) gotolevel1: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level1 alloc] init]];
}

-(void) gotolevel2: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level2 alloc] init]];
}

-(void) gotolevel3: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level3 alloc] init]];
}

-(void) gotolevel4: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level4 alloc] init]];
}

-(void) gotolevel5: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level5 alloc] init]];
}

@end
