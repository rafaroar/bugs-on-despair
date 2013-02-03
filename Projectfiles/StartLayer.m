//
//  StartLayer.m
//  thelifegame1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "StartLayer.h"
#import "GameLayer.h"
#import "Fly.h"
#import "Bee.h"
#import "Global.h"

@interface StartLayer (PrivateMethods)
@end

@implementation StartLayer

-(id) init
{
	if ((self = [super init]))
	{
        sm = [Global sharedManager];
        counte=0;
        
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
        [menuItem1 setScale:1.2f];
        myMenu.position = ccp(0, 0);
        [self addChild: myMenu z:1];
        
        bee = [[Bee alloc] initWithBeeAnimation];
        [bee setBugSpeed:bee.speed];
        [self addChild:bee z:3];
        
        fly = [[Fly alloc] initWithFlyAnimation];
        [fly setBugSpeed:fly.speed];
        [fly setPosition:ccp(160,200)];
        [self addChild:fly z:3];
        
        if (sm.statu == 0)
        {
            announcement = [CCSprite spriteWithFile:@"tryagain.png"];
            [announcement setPosition:ccp(160,280)];
            [announcement setScale:0.6f];
            [self addChild:announcement z:5];
        }
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) draw
{
    CGPoint c = ccp(0,0); //lower-left corner
    CGPoint d = ccp(WIDTH_GAME,HEIGHT_WINDOW); //upper-right corner
    ccColor4F color = ccc4f(0.3, 0.7, 0.3, 1);
    ccDrawSolidRect(c, d, color);
}

-(void) update: (ccTime) delta
{
    counte++;
    if ([self.children containsObject:announcement])
    {
        if (counte == 100)
        {
            [self removeChild:announcement cleanup:YES];
        }
    }
    else
    {
        [fly moveBug:counte];
        [bee moveBug:counte];
    }
}

-(void) startg
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFlipAngular transitionWithDuration:0.5f scene:[[GameLayer alloc] init]]];
}

@end
