//
//  CongratsLayer.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "CongratsLayer.h"
#import "Level1.h"
#import "Level2.h"
#import "Bee.h"

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
        congrats = [CCSprite spriteWithFile:@"title.png"];
        congrats.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET*2);
        [congrats setScale:0.5f];
        [self addChild:congrats z:1];
        
        playagain = [CCSprite spriteWithFile:@"selectlevel.png"];
        playagain.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + 10);
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
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
        menuItem1.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 70);
        menuItem2.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - 130);
        myMenu.position = ccp(0, 0);
        [menuItem1 setScale:0.4f];
        [menuItem2 setScale:0.4f];
        [self addChild: myMenu z:1];
        
        bee = [[Bee alloc] initWithBeeAnimation];
        [bee setPosition:ccp(160,240)];
        [self addChild:bee z:3];
        
        counte=0;
        beex=0;
        beey=0;
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) update: (ccTime) delta
{
    counte++;
    
    //MOVE BEE
    beex = [bee moveBeeX: counte high: beex];
    beey = [bee moveBeeY: counte high: beey];
}

-(void) gotolevel1: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level1 alloc] init]];
}

-(void) gotolevel2: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level2 alloc] init]];
}

@end
