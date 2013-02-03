//
//  StartLayer.m
//  thelifegame1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "StartLayer.h"
#import "Level1.h"
#import "Fly.h"
#import "Bee.h"
#import "Global.h"

@interface StartLayer (PrivateMethods)
@end

@implementation StartLayer

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
    ccColor4F color = ccc4f(0.3, 0.7, 0.3, 1);
    ccDrawSolidRect(c, d, color);
}

-(id) init
{
	if ((self = [super init]))
	{
        levelunlocked = 1;
        
        title = [CCSprite spriteWithFile:@"title.png"];
        title.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET*2);
        [title setScale:0.5f];
        [self addChild:title z:1];
        
        save = [CCSprite spriteWithFile:@"description.png"];
        save.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET - 20);
        [save setScale:0.5f];
        [self addChild:save z:1];
        
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"play.png"
                                                            selectedImage: @"play_sel.png"
                                                                   target:self
                                                                 selector:@selector(startg)];
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, nil];
        menuItem1.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - Y_OFF_SET);
        myMenu.position = ccp(0, 0);
        [menuItem1 setScale:1.2f];
        [self addChild: myMenu z:1];
        
        bee = [[Bee alloc] initWithBeeAnimation];
        [bee setBugSpeed:bee.speed];
        [self addChild:bee z:3];
        
        fly = [[Fly alloc] initWithFlyAnimation];
        [fly setBugSpeed:fly.speed];
        [fly setPosition:ccp(160,200)];
        [self addChild:fly z:3];
        
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
    counte++;
    
    //MOVE FLY
    [fly moveBug:counte];
    
    //MOVE BEE
    [bee moveBug:counte];
}

-(void) startg
{
    [[CCDirector sharedDirector] replaceScene: [[Level1 alloc] init]];
}

@end
