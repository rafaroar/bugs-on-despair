//
//  CongratsLayer2.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 24/01/13.
//
//

#import "CongratsLayer2.h"
#import "Level1.h"
#import "Level2.h"
#import "Level3.h"
#import "Fly.h"

@interface CongratsLayer2 (PrivateMethods)
@end

@implementation CongratsLayer2

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
    ccColor4F color = ccc4f(0.1, 0.4, 0.5, 1);
    ccDrawSolidRect(c, d, color);
}

-(id) init
{
	if ((self = [super init]))
	{
        congrats = [CCSprite spriteWithFile:@"title.png"];
        congrats.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET*2);
        [congrats setScale:0.5f];
        [self addChild:congrats z:1];
        
        playagain = [CCSprite spriteWithFile:@"selectlevel.png"];
        playagain.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + 30);
        [playagain setScale:0.6f];
        [self addChild:playagain z:1];
        
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"level1.png"
                                                            selectedImage: @"level1_sel.png"
                                                                   target:self
                                                                 selector:@selector(gotolevel1:)];
        
        CCMenuItemImage *menuItem2 = [CCMenuItemImage itemWithNormalImage:@"level2.png"
                                                            selectedImage: @"level2_sel.png"
                                                                   target:self
                                                                 selector:@selector(gotolevel2:)];
        
        CCMenuItemImage *menuItem3 = [CCMenuItemImage itemWithNormalImage:@"level3.png"
                                                            selectedImage: @"level3_sel.png"
                                                                   target:self
                                                                 selector:@selector(gotolevel3:)];
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
        menuItem1.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 40);
        menuItem2.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 100);
        menuItem3.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 160);
        myMenu.position = ccp(0, 0);
        [menuItem1 setScale:0.4f];
        [menuItem2 setScale:0.4f];
        [menuItem3 setScale:0.4f];
        [self addChild: myMenu z:1];
        
        fly = [[Fly alloc] initWithFlyAnimation];
        [fly setPosition:ccp(160,240)];
        [self addChild:fly z:3];
        
        counte=0;
        ranx=0;
        rany=0;
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) update: (ccTime) delta
{
    counte++;
    
    //MOVE FLY
    ranx = [fly moveFlyX: counte high: ranx];
    rany = [fly moveFlyY: counte high: rany];
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

@end
