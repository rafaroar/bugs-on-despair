/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "Level1.h"
#import "GameOverLayer.h"
#import "StartLayer.h"
#import "CongratsLayer.h"
#import "Plant.h"
CCSprite *fly;
Plant *plant1;
Plant *life;
CCTexture2D* transparent;
CCTexture2D* plantex1;
CCTexture2D* plantex2;
CCTexture2D* plantex3;

@interface Level1 (PrivateMethods)
@end

@implementation Level1

CCAction *taunt;

NSMutableArray *tauntingFrames;
NSMutableArray *grid;
NSMutableArray *grow;
NSMutableArray *carnivores;
int counte;
int ranx;
int rany;
int i;

#define Y_OFF_SET 80
#define WIDTH_WINDOW 320
#define HEIGHT_WINDOW 480
#define CELL_WIDTH 80
#define WIDTH_GAME WIDTH_WINDOW
#define HEIGHT_GAME (HEIGHT_WINDOW - Y_OFF_SET)
#define NUM_ROWS (HEIGHT_GAME / CELL_WIDTH)
#define NUM_COLUMNS (WIDTH_GAME / CELL_WIDTH)
#define done true
#define DELAY_IN_SECONDS = 0.15
#define priorX 500
#define priorY 500
#define MAX_NUMBER_OF_PLANTS 20

-(id) init
{
	if ((self = [super init]))
	{
        //carnivore plants grid
        /*grid = [[NSMutableArray alloc] init];
        for (int row = 0; row < NUM_ROWS; row++ )
        {
            NSMutableArray* subArr = [[NSMutableArray alloc] init ];
            for (int col = 0; col < NUM_COLUMNS; col++ )
            {
                NSNumber* item = [NSNumber numberWithInt: 0];
                [subArr addObject:item];
            }
            [grid addObject:subArr];
        }
        */
        
        transparent = [[CCTextureCache sharedTextureCache] addImage:@"transparent.png"];
        plantex1 = [[CCTextureCache sharedTextureCache] addImage:@"carnivore_g.png"];
        plantex2 = [[CCTextureCache sharedTextureCache] addImage:@"carnivore_y.png"];
        plantex3 = [[CCTextureCache sharedTextureCache] addImage:@"carnivore.png"];
        
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

+(id) scene
{
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Level1 *layer = [Level1 node];
    GameOverLayer *layer2 = [GameOverLayer node];
	StartLayer *layer3 = [StartLayer node];
    CongratsLayer *layer4 = [CongratsLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    [scene addChild: layer2];
	[scene addChild: layer3];
    [scene addChild: layer4];
    
	// return the scene
	return scene;
}

-(void) draw
{
    //big green rectangle
    CGPoint c = ccp(0,0 + Y_OFF_SET - 20); //lower-left corner
    CGPoint d = ccp(WIDTH_GAME,HEIGHT_GAME + Y_OFF_SET); //upper-right corner
    ccColor4F color = ccc4f(0.2, 0.6, 0.2, 1);
    ccDrawSolidRect(c, d, color);
    
    //lines
    /*ccDrawColor4B(0, 0, 0, 255);
    for(int row = 0; row < HEIGHT_GAME; row += CELL_WIDTH)
    {
        CGPoint a = ccp(0,row + Y_OFF_SET);
        CGPoint b = ccp(WIDTH_GAME,row + Y_OFF_SET);
        ccDrawLine(a, b);
    }
    
    for(int col = 0; col < WIDTH_GAME; col += CELL_WIDTH)
    {
        CGPoint a = ccp(col,0 + Y_OFF_SET);
        CGPoint b = ccp(col,HEIGHT_GAME + Y_OFF_SET);
        ccDrawLine(a, b);
    }
    
    //make grid and display colors
    for(int row = 0; row < NUM_ROWS; row ++)
    {
        for(int col = 0; col < NUM_COLUMNS; col ++)
        {
            NSNumber* num = [[grid objectAtIndex:row] objectAtIndex:col];
            if([num integerValue] == 1)
            {
                ccColor4F colo = ccc4f(0.8, 0.8, 0.3, 1);
                ccDrawSolidRect(ccp(col * CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET), ccp(col * CELL_WIDTH + CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET + CELL_WIDTH), colo);
            }
            else if([num integerValue] == 2)
            {
                ccColor4F colo = ccc4f(0.8, 0.6, 0.2, 1);
                ccDrawSolidRect(ccp(col * CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET), ccp(col * CELL_WIDTH + CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET + CELL_WIDTH), colo);
            }
            else if([num integerValue] == 3)
            {
                ccColor4F colo = ccc4f(0.8, 0.1, 0.1, 1);
                ccDrawSolidRect(ccp(col * CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET), ccp(col * CELL_WIDTH + CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET + CELL_WIDTH), colo);
            }
            else if([num integerValue] == 4)
            {
                ccColor4F colo = ccc4f(0.2, 0.6, 0.2, 1);
                ccDrawSolidRect(ccp(col * CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET), ccp(col * CELL_WIDTH + CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET + CELL_WIDTH), colo);
            }
            else if([num integerValue] == 5)
            {
                ccColor4F colo = ccc4f(0, 0, 0, 1);
                ccDrawSolidRect(ccp(col * CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET), ccp(col * CELL_WIDTH + CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET + CELL_WIDTH), colo);
            }
        }
    }
    */
    
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
        /*CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        if (pos.x != 0 && pos.y != 0)
        {
            int ro = pos.y/CELL_WIDTH;
            int co = pos.x/CELL_WIDTH;
            if (ro != 0)
            {
                ro--;
                NSNumber* numm = [[grid objectAtIndex:ro] objectAtIndex:co];
                if([numm integerValue] != 0)
                {
                    NSMutableArray* array = [grid objectAtIndex:ro];
                    [array replaceObjectAtIndex:co withObject:[NSNumber numberWithInt:4]];
                }
            }
        }
        */
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
    
    /*//check if fly dies using grid
    int roww = fly.position.y/CELL_WIDTH-1;
    int coll = fly.position.x/CELL_WIDTH;
    NSNumber* numm = [[grid objectAtIndex:roww] objectAtIndex:coll];
    if([numm integerValue] == 3)
    {
        NSMutableArray* array = [grid objectAtIndex:roww];
        [array replaceObjectAtIndex:coll withObject:[NSNumber numberWithInt:5]];
        [self performSelector:@selector(gotogameover) withObject:self afterDelay:2.0];
        [self pauseSchedulerAndActions];
    }
     
    //plants grow & check if player wins using grid
    int cont = 0;
    for(int row = 0; row < NUM_ROWS; row ++)
    {
        NSMutableArray* array = [grid objectAtIndex:row];
        for(int col = 0; col < NUM_COLUMNS; col ++)
        {
            NSNumber* num = [[grid objectAtIndex:row] objectAtIndex:col];
            int rann = arc4random()%100000;
            if(rann == 0)
            {
                if ([num integerValue] == 0 ||[num integerValue] == 4)
                {
                    [array replaceObjectAtIndex:col withObject:[NSNumber numberWithInt:1]];
                }
                else if ([num integerValue] == 1)
                {
                    [array replaceObjectAtIndex:col withObject:[NSNumber numberWithInt:2]];
                }
                else if ([num integerValue] == 2)
                {
                    [array replaceObjectAtIndex:col withObject:[NSNumber numberWithInt:3]];
                }
            }
            if ([num integerValue] == 1 ||[num integerValue] == 2 ||[num integerValue] == 3)
            {
                cont++;
            }
        }
    }
    if(cont == 0 && counte > 2000)
    {
        [self performSelector:@selector(gotocongrats) withObject:self afterDelay:2.0];
        [self pauseSchedulerAndActions];
    }
    */
    
    //check if fly dies
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
        int rand = arc4random()%800;
        if(rand == 0)
        {
            if (plantis.grow==0)
            {
                int posx=arc4random()%20+30+(i%4)*80;
                int posy=arc4random()%20+110+(i/4)*80;
                plantis.position = ccp(posx, posy);
                [plantis setTexture: plantex1];
                plantis.grow++;
            }
            else if (plantis.grow==1)
            {
                [plantis setTexture: plantex2];
                plantis.grow++;
            }
            else if (plantis.grow==2)
            {
                [plantis setTexture: plantex3];
                plantis.grow++;
                [carnivores addObject:plantis];
            }
        }
    }
    if(contt == 0 && counte > 800)
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
    [[CCDirector sharedDirector] replaceScene: [[CongratsLayer alloc] init]];
}

@end
