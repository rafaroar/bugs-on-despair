//
//  Congrats.m
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 02/02/13.
//
//

#import "Congrats.h"
#import "GameLayer.h"
#import "Bee.h"
#import "Fly.h"
#import "Redbug.h"
#import "Global.h"

@interface Congrats (PrivateMethods)
@end

@implementation Congrats

-(id) init
{
	if ((self = [super init]))
	{
        sm = [Global sharedManager];
        bugs = [[NSMutableArray alloc] init];
        counte=0;
        
        if (sm.levelunlocked == 2)
        {
            color = ccc4f(0.2, 0.6, 0.2, 1);
            height = 10;
            spacing = 80;
            
            bee = [[Bee alloc] initWithBeeAnimation];
            [bee setBugSpeed:bee.speed];
            [bee setPosition:ccp(160,240)];
            [self addChild:bee z:4];
            [bugs addObject:bee];
        }
        else if (sm.levelunlocked == 3)
        {
            color = ccc4f(0.1, 0.4, 0.5, 1);
            height = 30;
            spacing = 70;
            
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:fly.speed];
            [fly setPosition:ccp(160,240)];
            [self addChild:fly z:4];
            [bugs addObject:fly];
        }
        else if (sm.levelunlocked == 4)
        {
            color = ccc4f(0.3, 0.7, 0.3, 1);
            height = 50;
            spacing = 60;
            
            bee = [[Bee alloc] initWithBeeAnimation];
            [bee setBugSpeed:bee.speed];
            [self addChild:bee z:4];
            [bugs addObject:bee];
            
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:fly.speed];
            [fly setPosition:ccp(160,200)];
            [self addChild:fly z:4];
            [bugs addObject:fly];
        }
        else if (sm.levelunlocked == 5)
        {
            color = ccc4f(0.3, 0.4, 0.5, 1);
            height = 70;
            spacing = 55;
            
            for (int chu = 0; chu < 2; chu ++)
            {
                rbug = [[Redbug alloc] initWithRedbugAnimation];
                [rbug setBugSpeed:rbug.speed];
                [rbug setPosition:ccp(160,210+chu*60)];
                [self addChild:rbug z:4 tag:chu];
                [bugs addObject:rbug];
            }
        }
        else if (sm.levelunlocked == 6)
        {
            color = ccc4f(0.6, 0.3, 0.3, 1);
            height = 80;
            spacing = 50;
            
            bee = [[Bee alloc] initWithBeeAnimation];
            [bee setBugSpeed:bee.speed];
            [bee setPosition:ccp(160,290)];
            [self addChild:bee z:4];
            [bugs addObject:bee];
            
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:fly.speed];
            [fly setPosition:ccp(160,240)];
            [self addChild:fly z:4];
            [bugs addObject:fly];
            
            rbug = [[Redbug alloc] initWithRedbugAnimation];
            [rbug setBugSpeed:rbug.speed];
            [rbug setPosition:ccp(160,190)];
            [self addChild:rbug z:4];
            [bugs addObject:rbug];
        }
        else if (sm.levelunlocked == 7)
        {
            color = ccc4f(0.2, 0.8, 0.3, 1);
            height = 90;
            spacing = 45;
            
            for (int chu = 0; chu < 3; chu ++)
            {
                bee = [[Bee alloc] initWithBeeAnimation];
                [bee setBugSpeed:bee.speed];
                [bee setPosition:ccp(160,180+chu*60)];
                [self addChild:bee z:4 tag:chu];
                [bugs addObject:bee];
            }
        }
        else
        {
            sm.levelunlocked = 8;
            color = ccc4f(0.5, 0.6, 0.5, 1);
            height = 95;
            spacing = 40;
            
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:0.004];
            [fly setPosition:ccp(160,240)];
            [self addChild:fly z:4];
            [bugs addObject:fly];
        }
        
        congrats = [CCSprite spriteWithFile:@"title.png"];
        congrats.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET*2);
        [congrats setScale:0.5f];
        [self addChild:congrats z:1];
        
        playagain = [CCSprite spriteWithFile:@"selectlevel.png"];
        playagain.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + height);
        [playagain setScale:0.6f];
        [self addChild:playagain z:1];
        
        CCMenuItemImage *menuItem[sm.levelunlocked+1];
        CCMenu *myMenu = [CCMenu menuWithItems: nil];
        
        for (int i = 1; i <= sm.levelunlocked; i ++)
        {
            menuItem[i] = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"level%d.png",i] selectedImage:[NSString stringWithFormat:@"levels%d.png",i] target:self selector:@selector(gotolevel:)];
            menuItem[i].position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + height + 10 - i*spacing);
            menuItem[i].tag = i;
            [menuItem[i] setScale:0.4f];
            [myMenu addChild:menuItem[i]];
        }
        
        myMenu.position = ccp(0, 0);
        [self addChild: myMenu z:1];
        
        if (sm.statu == 0)
        {
            announcement = [CCSprite spriteWithFile:@"tryagain.png"];
            [announcement setPosition:ccp(160,280)];
            [announcement setScale:0.6f];
            [self addChild:announcement z:5];
        }
        else if ((sm.statu == 1) && (sm.levelunlocked == sm.level + 1))
        {
            announcement = [CCSprite spriteWithFile:[NSString stringWithFormat:@"unlock%d.png",sm.levelunlocked]];
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
    //big green rectangle
    CGPoint c = ccp(0,0); //lower-left corner
    CGPoint d = ccp(WIDTH_GAME,HEIGHT_WINDOW); //upper-right corner
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
        int nbug = [bugs count];
        for (int i = 0; i < nbug; i ++)
        {
            Bug* bog = [bugs objectAtIndex:i];
            [bog moveBug:counte];
        }
    }
}

-(void) gotolevel: (CCMenuItem*) menuItem
{
    int val = menuItem.tag;
    sm.level=val;
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFlipAngular transitionWithDuration:0.5f scene:[[GameLayer alloc] init]]];
}

@end
