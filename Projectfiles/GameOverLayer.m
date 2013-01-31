/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "GameOverLayer.h"
#import "Level3.h"
CCSprite *gameover;

@interface GameOverLayer (PrivateMethods)
@end

@implementation GameOverLayer

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
    ccColor4F color = ccc4f(0, 0, 0, 1);
    ccDrawSolidRect(c, d, color);
}

-(id) init
{
	if ((self = [super init]))
	{
        gameover = [CCSprite spriteWithFile:@"gameover.png"];
        gameover.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET);
        [gameover setScale:0.9f];
        [self addChild:gameover z:1];
        
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"tryagain.png"
                                                            selectedImage: @"tryagain.png"
                                                            target:self
                                                            selector:@selector(startover:)];
    
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, nil];
        myMenu.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 - Y_OFF_SET);
        [myMenu setScale:0.9f];
        [self addChild: myMenu z:1];
    }
    return self;
}

-(void) startover: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level3 alloc] init]];
}

@end
