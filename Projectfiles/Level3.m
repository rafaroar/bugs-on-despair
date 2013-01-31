//
//  Level3.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 24/01/13.
//
//

#import "Level3.h"
#import "Plant.h"
#import "GameOverLayer.h"
#import "CongratsLayer3.h"

@implementation Level3

CCSprite *fly;
CCSprite *bee;
CCSprite *scissors;
Plant *life;
CCTexture2D* transparent;
CCTexture2D* plantex1;
CCTexture2D* plantex2;
CCTexture2D* plantex3;
CCTexture2D* plantex4;
CCTexture2D* plantex5;
CCTexture2D* plantex6;
CCTexture2D* plantex7;
CCTexture2D* plantex8;
CCTexture2D* plantex9;
CCAction *move;
CCAction *move2;

NSMutableArray *flies;
NSMutableArray *bees;
NSMutableArray *carnivores;
int counte;
int ranx;
int rany;
int beex;
int beey;
int i;
int weapon;

#define Y_OFF_SET 80
#define WIDTH_WINDOW 320
#define HEIGHT_WINDOW 480
#define CELL_WIDTH 80
#define DIFFICULTY 700
#define INITIAL_TIME 600
#define MAX_NUM_LIVES 6
#define WIDTH_GAME WIDTH_WINDOW
#define HEIGHT_GAME (HEIGHT_WINDOW - Y_OFF_SET)
#define NUM_ROWS (HEIGHT_GAME / CELL_WIDTH)
#define NUM_COLUMNS (WIDTH_GAME / CELL_WIDTH)
#define MAX_NUMBER_OF_PLANTS (NUM_ROWS * NUM_COLUMNS)

-(id) init
{
	if ((self = [super init]))
	{
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"pause.png"
                                                            selectedImage: @"pause.png"
                                                                   target:self
                                                                 selector:@selector(pauseGame)];
        
        CCMenuItemImage *menuItem2 = [CCMenuItemImage itemWithNormalImage:@"resume.png"
                                                            selectedImage: @"resume.png"
                                                                   target:self
                                                                 selector:@selector(resumeGame)];
        
        CCMenuItemImage *menuItem3 = [CCMenuItemImage itemWithNormalImage:@"scissors.png"
                                                            selectedImage: @"scissors.png"
                                                                   target:self
                                                                 selector:@selector(setWeapon0)];
        
        CCMenuItemImage *menuItem4 = [CCMenuItemImage itemWithNormalImage:@"redscissors.png"
                                                            selectedImage: @"redscissors.png"
                                                                   target:self
                                                                 selector:@selector(setWeapon1)];
        
        CCMenuItemImage *menuItem5 = [CCMenuItemImage itemWithNormalImage:@"ship.png"
                                                            selectedImage: @"ship.png"
                                                                   target:self
                                                                 selector:@selector(switchBugs)];
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, nil];
        menuItem1.position = ccp(80,50);
        menuItem2.position = ccp(80,20);
        menuItem3.position = ccp(190,35);
        menuItem4.position = ccp(240,35);
        menuItem5.position = ccp(290,35);
        myMenu.position = ccp(0,0);
        [menuItem1 setScale:0.3f];
        [menuItem2 setScale:0.3f];
        [menuItem3 setScale:0.1f];
        [menuItem4 setScale:0.1f];
        [menuItem5 setScale:0.6f];
        [self addChild: myMenu z:1];
        
        transparent = [[CCTextureCache sharedTextureCache] addImage:@"transparent.png"];
        plantex1 = [[CCTextureCache sharedTextureCache] addImage:@"carniv1.png"];
        plantex2 = [[CCTextureCache sharedTextureCache] addImage:@"carniv2.png"];
        plantex3 = [[CCTextureCache sharedTextureCache] addImage:@"carniv3.png"];
        plantex4 = [[CCTextureCache sharedTextureCache] addImage:@"carniv4.png"];
        plantex5 = [[CCTextureCache sharedTextureCache] addImage:@"carniv5.png"];
        plantex6 = [[CCTextureCache sharedTextureCache] addImage:@"carniv6.png"];
        plantex7 = [[CCTextureCache sharedTextureCache] addImage:@"carniv7.png"];
        plantex8 = [[CCTextureCache sharedTextureCache] addImage:@"carniv8.png"];
        plantex9 = [[CCTextureCache sharedTextureCache] addImage:@"carniv9.png"];
        
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
        
        for(int i = 0 ; i < MAX_NUMBER_OF_PLANTS ; i++)
        {
            life = [[Plant alloc] initWithPlantImage];
            [life setPosition:ccp(0,0)];
            [life setScale:5];
            [self addChild:life z:1 tag:i];
        }
        carnivores = [[NSMutableArray alloc] init];
        [self scheduleUpdate];
	}
	return self;
}

-(void) draw
{
    //big blue rectangle
    CGPoint c = ccp(0,0 + Y_OFF_SET - 20); //lower-left corner
    CGPoint d = ccp(WIDTH_GAME,HEIGHT_GAME + Y_OFF_SET); //upper-right corner
    ccColor4F color = ccc4f(0.3, 0.7, 0.3, 1);
    ccDrawSolidRect(c, d, color);
    
    //lower rectangles
    CGPoint f = ccp(WIDTH_WINDOW / 2,0);
    CGPoint g = ccp(WIDTH_WINDOW,70);
    ccColor4F color2 = ccc4f(0.5, 0, 0.5, 1);
    ccDrawSolidRect(f, g, color2);
    
    CGPoint h = ccp(0,0);
    CGPoint i = ccp(WIDTH_WINDOW / 2,70);
    ccColor4F color3 = ccc4f(0.1, 0, 0.9, 1);
    ccDrawSolidRect(i, h, color3);
}

-(void) update: (ccTime) delta
{
    //throw grenade and kill plant
    if ([[KKInput sharedInput] anyTouchBeganThisFrame])
    {
        KKInput* input = [KKInput sharedInput];
        CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        if (pos.y > Y_OFF_SET - 10)
        {
            if (weapon == 0)
            {
                scissors = [CCSprite spriteWithFile:@"scissors.png"];
            }
            else if (weapon == 1)
            {
                scissors = [CCSprite spriteWithFile:@"redscissors.png"];
            }
            scissors.position = pos;
            [scissors setScale:0.15f];
            [self addChild:scissors z:2];
            [self performSelector:@selector(removeScissors) withObject:self afterDelay:0.1];
        }
        for (i = 0; i < MAX_NUMBER_OF_PLANTS; i++)
        {
            Plant * plantis = [self getChildByTag:i];
            if ([input isAnyTouchOnNode:plantis touchPhase:KKTouchPhaseAny])
            {
                plantis.position = ccp(0,0);
                [plantis setTexture: transparent];
                plantis.grow=0;
                [carnivores removeObject:plantis];
            }
        }
    }
    
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
    
    //check if fly or bee dies
    int numObjects = [carnivores count];
    for (int chu = 0; chu < numObjects; chu ++)
    {
        Plant* item = [carnivores objectAtIndex:chu];
        int posx =fly.position.x - item.position.x;
        int posy =fly.position.y - (item.position.y+25);
        if ((posx < 35) && (posx > -35) && (posy > -20) && (posy < 20))
        {
            [self performSelector:@selector(gotogameover) withObject:self afterDelay:2.0];
            [self pauseSchedulerAndActions];
        }
        posx =bee.position.x - item.position.x;
        posy =bee.position.y - (item.position.y+25);
        if ((posx < 35) && (posx > -35) && (posy > -20) && (posy < 20))
        {
            [self performSelector:@selector(gotogameover) withObject:self afterDelay:2.0];
            [self pauseSchedulerAndActions];
        }
    }
    
    //plants grow & check if player wins
    int contt = 0;
    for (i = 0; i < MAX_NUMBER_OF_PLANTS; i++)
    {
        Plant * plantis = [self getChildByTag:i];
        if (plantis.grow > 0)
        {
            contt++;
        }
        int rand = arc4random()%DIFFICULTY;
        if((rand == 0) && (plantis.grow==0) && plantis.currentlife < MAX_NUM_LIVES)
        {
            int posx=arc4random()%20+30+(i%4)*80;
            int posy=arc4random()%20+110+(i/4)*80;
            plantis.position = ccp(posx, posy);
            [plantis setTexture: plantex1];
            plantis.grow++;
            plantis.currentlife++;
        }
        else if(rand < 25)
        {
            if (plantis.grow==1)
            {
                [plantis setTexture: plantex2];
                plantis.grow++;
            }
            else if (plantis.grow==2)
            {
                [plantis setTexture: plantex3];
                plantis.grow++;
            }
            else if (plantis.grow==3)
            {
                [plantis setTexture: plantex4];
                plantis.grow++;
            }
            else if (plantis.grow==4)
            {
                [plantis setTexture: plantex5];
                plantis.grow++;
            }
            else if (plantis.grow==5)
            {
                [plantis setTexture: plantex6];
                plantis.grow++;
            }
            else if (plantis.grow==6)
            {
                [plantis setTexture: plantex7];
                plantis.grow++;
            }
            else if (plantis.grow==7)
            {
                [plantis setTexture: plantex8];
                plantis.grow++;
            }
            else if (plantis.grow==8)
            {
                [plantis setTexture: plantex9];
                plantis.grow++;
                [carnivores addObject:plantis];
            }
        }
    }
    if(contt == 0 && counte > INITIAL_TIME)
    {
        [self performSelector:@selector(gotocongrats) withObject:self afterDelay:2.0];
        [self pauseSchedulerAndActions];
    }
}

-(void) gotogameover
{
    [[CCDirector sharedDirector] replaceScene: [[GameOverLayer alloc] init]];
}

-(void) gotocongrats
{
    [[CCDirector sharedDirector] replaceScene: [[CongratsLayer3 alloc] init]];
}

-(void) pauseGame
{
    [self pauseSchedulerAndActions];
}

-(void) resumeGame
{
    [self resumeSchedulerAndActions];
}

-(void) removeScissors
{
    [self removeChild:scissors cleanup:YES];
}

-(void) setWeapon0
{
    weapon = 0;
}

-(void) setWeapon1
{
    weapon = 1;
}

-(void) switchBugs
{
    CGPoint temp = fly.position;
    fly.position = bee.position;
    bee.position = temp;
}

@end

