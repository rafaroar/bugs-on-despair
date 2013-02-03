//
//  Congrats.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 02/02/13.
//
//

#import "Congrats.h"
#import "Level1.h"
#import "Level2.h"
#import "Level3.h"
#import "Level4.h"
#import "Level5.h"
#import "Bee.h"
#import "Fly.h"
#import "Redbug.h"
#import "Global.h"

@interface Congrats (PrivateMethods)
@end

@implementation Congrats

#define Y_OFF_SET 80
#define WIDTH_WINDOW 320
#define HEIGHT_WINDOW 480
#define CELL_WIDTH 80
#define WIDTH_GAME WIDTH_WINDOW
#define HEIGHT_GAME (HEIGHT_WINDOW - 80)

-(id) init
{
	if ((self = [super init]))
	{
        bugs = [[NSMutableArray alloc] init];
        
        if (levelunlocked == 2)
        {
            color = ccc4f(0.2, 0.6, 0.2, 1);
            height = 10;
            bee = [[Bee alloc] initWithBeeAnimation];
            [bee setBugSpeed:bee.speed];
            [bee setPosition:ccp(160,240)];
            [self addChild:bee z:3];
            [bugs addObject:bee];
        }
        else if (levelunlocked == 3)
        {
            color = ccc4f(0.1, 0.4, 0.5, 1);
            height = 30;
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:fly.speed];
            [fly setPosition:ccp(160,240)];
            [self addChild:fly z:3];
            [bugs addObject:fly];
        }
        else if (levelunlocked == 4)
        {
            color = ccc4f(0.3, 0.7, 0.3, 1);
            height = 50;
            bee = [[Bee alloc] initWithBeeAnimation];
            [bee setBugSpeed:bee.speed];
            [self addChild:bee z:3];
            [bugs addObject:bee];
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:fly.speed];
            [fly setPosition:ccp(160,200)];
            [self addChild:fly z:3];
            [bugs addObject:fly];
        }
        else
        {
            color = ccc4f(0.3, 0.4, 0.5, 1);
            height = 70;
            rbug = [[Redbug alloc] initWithRedbugAnimation];
            [rbug setBugSpeed:rbug.speed];
            [rbug setPosition:ccp(160,240)];
            [self addChild:rbug z:3];
            [bugs addObject:rbug];
        }
        
        congrats = [CCSprite spriteWithFile:@"title.png"];
        congrats.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + Y_OFF_SET*2);
        [congrats setScale:0.5f];
        [self addChild:congrats z:1];
        
        playagain = [CCSprite spriteWithFile:@"selectlevel.png"];
        playagain.position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + height);
        [playagain setScale:0.6f];
        [self addChild:playagain z:1];
        
        CCMenuItemImage *menuItem[levelunlocked+1];
        CCMenu *myMenu = [CCMenu menuWithItems: nil];
        
        for (int i = 1; i <= levelunlocked; i ++)
        {
            menuItem[i] = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"level%d.png",i] selectedImage:[NSString stringWithFormat:@"levels%d.png",i] target:self selector:@selector(gotolevel:)];
            menuItem[i].position = ccp( WIDTH_GAME/2, HEIGHT_WINDOW/2 + height + 10 - i*60);
            menuItem[i].tag = i;
            [menuItem[i] setScale:0.4f];
            [myMenu addChild:menuItem[i]];
        }
        
        myMenu.position = ccp(0, 0);
        [self addChild: myMenu z:1];
        
        levelArray = [[NSMutableArray alloc] init];
        [levelArray addObject: [Congrats alloc]];
        [levelArray addObject: [Level1 alloc]];
        [levelArray addObject: [Level2 alloc]];
        [levelArray addObject: [Level3 alloc]];
        [levelArray addObject: [Level4 alloc]];
        [levelArray addObject: [Level5 alloc]];
        
        counte=0;
        
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
    int nbug = [bugs count];
    for (int i = 0; i < nbug; i ++)
    {
        Bug* bog = [bugs objectAtIndex:i];
        [bog moveBug:counte];
    }
}

-(void) gotolevel: (CCMenuItem  *) menuItem
{
    int val = menuItem.tag;
    CCLayer* lev = [levelArray objectAtIndex:val];
    [[CCDirector sharedDirector] replaceScene: [lev init]];
}

@end
