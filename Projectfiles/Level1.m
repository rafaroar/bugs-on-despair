/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "Level1.h"
#import "Level2.h"
#import "Level3.h"
#import "GameOverLayer.h"
#import "StartLayer.h"
#import "CongratsLayer.h"
#import "Plant.h"
#import "Missile.h"
#import "MissilePlant.h"
#import "Bee.h"

@interface Level1 (PrivateMethods)
@end

@implementation Level1

Bee *fly;
CCSprite *scissors;
Missile *mm;
Plant *newplant;
MissilePlant *newmiss;
CCTexture2D* redclosedscissors;
CCTexture2D* blueclosedscissors;
CCAction *move;
CCAnimation *moving;
CCProgressTimer* powerBar;

NSMutableArray *flies;
NSMutableArray *carnivores;
NSMutableArray *throwers;
NSMutableArray *carnplants;
NSMutableArray *missplants;
NSMutableArray *allplants;
NSMutableArray *missiles;

int counte;
float ranx;
float rany;
int weapon;
int nplant;
int nmiss;

#define Y_OFF_SET 80
#define WIDTH_WINDOW 320
#define HEIGHT_WINDOW 480
#define CELL_WIDTH 80
#define DIFFICULTY 20
#define INITIAL_TIME 600
#define WIDTH_GAME WIDTH_WINDOW
#define HEIGHT_GAME (HEIGHT_WINDOW - Y_OFF_SET)
#define NUM_ROWS (HEIGHT_GAME / CELL_WIDTH)
#define NUM_COLUMNS (WIDTH_GAME / CELL_WIDTH)
#define PLANTS 20
#define MISSES 5
#define TOTAL (PLANTS + MISSES)

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
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, nil];
        menuItem1.position = ccp(80,50);
        menuItem2.position = ccp(80,20);
        menuItem3.position = ccp(200,35);
        menuItem4.position = ccp(280,35);
        myMenu.position = ccp(0,0);
        [menuItem1 setScale:0.3f];
        [menuItem2 setScale:0.3f];
        [menuItem3 setScale:0.1f];
        [menuItem4 setScale:0.1f];
        [self addChild: myMenu z:1];
        
        redclosedscissors= [[CCTextureCache sharedTextureCache] addImage:@"scissors.png"];
        blueclosedscissors= [[CCTextureCache sharedTextureCache] addImage:@"redscissors.png"];
        
        fly = [[Bee alloc] initWithBeeAnimation];
        [self addChild:fly z:3];
        
        counte=0;
        ranx=0;
        rany=0;
        weapon=0;
        nplant=0;
        nmiss=0;
        
        allplants = [[NSMutableArray alloc] init];
        carnplants = [[NSMutableArray alloc] init];
        missplants = [[NSMutableArray alloc] init];
        carnivores = [[NSMutableArray alloc] init];
        throwers = [[NSMutableArray alloc] init];
        missiles = [[NSMutableArray alloc] init];
        
        powerBar= [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"ship.png"]];
        powerBar.type = kCCProgressTimerTypeBar;
        powerBar.midpoint = ccp(0,0); // starts from left
        powerBar.barChangeRate = ccp(1,0); // grow only in the "x"-horizontal direction
        powerBar.percentage = 0; // (0 - 100)
        powerBar.position = ccp(200,200);
        [self addChild:powerBar z:3];
        
        [self scheduleUpdate];
	}
	return self;
}


/*+(id) scene1
{
    CCScene *scene1 = [CCScene node];
	Level1 *layer = [Level1 node];
	[scene1 addChild: layer];
	return scene1;
}

+(id) scene2
{
    CCScene *scene2 = [CCScene node];
	Level2 *layer = [Level2 node];
	[scene2 addChild: layer];
	return scene2;
}

+(id) scene3
{
    CCScene *scene3 = [CCScene node];
	Level3 *layer = [Level3 node];
	[scene3 addChild: layer];
	return scene3;
}

+(id) scene4
{
    CCScene *scene4 = [CCScene node];
    GameOverLayer *layer = [GameOverLayer node];
	[scene4 addChild: layer];
	return scene4;
}

+(id) scene5
{
    CCScene *scene5 = [CCScene node];
	StartLayer *layer = [StartLayer node];
	[scene5 addChild: layer];
	return scene5;
}

+(id) scene6
{
    CCScene *scene6 = [CCScene node];
	CongratsLayer *layer = [CongratsLayer node];
	[scene6 addChild: layer];
	return scene6;
}*/

+(id) scene
{
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Level1 *layer = [Level1 node];
    GameOverLayer *layer2 = [GameOverLayer node];
	StartLayer *layer3 = [StartLayer node];
    CongratsLayer *layer4 = [CongratsLayer node];
    Level2 *layer5 = [Level2 node];
    Level3 *layer6 = [Level3 node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    [scene addChild: layer2];
	[scene addChild: layer3];
    [scene addChild: layer4];
    [scene addChild: layer5];
    [scene addChild: layer6];
    
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
    counte++;
    
    //CHECK IF PLAYER WINS
    if(powerBar.percentage == 100)
    {
        [self performSelector:@selector(gotocongrats) withObject:self afterDelay:2.0];
        [self pauseSchedulerAndActions];
    }

    //KILL PLANTS
    int nplantcc = [carnplants count];
    int nmisscc = [missplants count];
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
            [self performSelector:@selector(closeScissors) withObject:self afterDelay:0.05];
            [self performSelector:@selector(removeScissors) withObject:self afterDelay:0.1];
        }
        for (int chu = 0; chu < nplantcc; chu ++)
        {
            Plant* plantis = [carnplants objectAtIndex:chu];
            if ([input isAnyTouchOnNode:plantis touchPhase:KKTouchPhaseAny])
            {
                [self removeChild:plantis cleanup:YES];
                [carnivores removeObject:plantis];
                [carnplants removeObject:plantis];
                [allplants removeObject:plantis];
                nplantcc--;
                powerBar.percentage += 100.0f/TOTAL;
            }
        }
        for (int chu = 0; chu < nmisscc; chu ++)
        {
            MissilePlant* plantis = [missplants objectAtIndex:chu];
            if ([input isAnyTouchOnNode:plantis touchPhase:KKTouchPhaseAny])
            {
                [self removeChild:plantis cleanup:YES];
                [throwers removeObject:plantis];
                [missplants removeObject:plantis];
                [allplants removeObject:plantis];
                nmisscc--;
                powerBar.percentage += 100.0f/TOTAL;
            }
        }
    }
    
    //CHECK IF FLY DIES DEVOURED
    int num = [carnivores count];
    NSLog(@"Int k is %i", num);
    for (int chu = 0; chu < num; chu ++)
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
    
    //CHECK IF FLY DIES BY MISSILE AND MOVE MISSILE
    num = [missiles count];
    for (int chu = 0; chu < num; chu ++)
    {
        Missile* item = [missiles objectAtIndex:chu];
        int posx =fly.position.x - item.position.x;
        int posy =fly.position.y - item.position.y;
        if ((posx < 30) && (posx > -30) && (posy > -20) && (posy < 20))
        {
            //[self performSelector:@selector(gotogameover) withObject:self afterDelay:2.0];
            //[self pauseSchedulerAndActions];
        }
        item.position = ccp( item.position.x + item.direcx, item.position.y + item.direcy);
        if ((item.position.y > 480)||(item.position.y < 80)||(item.position.x > 320)||(item.position.x < 0))
        {
            [self removeChild:item cleanup:YES];
        }
    }
    
    //MOVE FLY
    ranx = [fly moveBeeX: counte high: ranx];
    rany = [fly moveBeeY: counte high: rany];
    
    //PLANTS GROW
    int nplantc = [carnplants count];
    for (int chu = 0; chu < nplantc; chu ++)
    {
        int conn = counte%6;
        if(conn == 0)
        {
            Plant* plantis = [carnplants objectAtIndex:chu];
            [plantis growPlant: carnivores];
        }
    }
    
    //MISSILEPLANTS GROW
    int nmissc = [missplants count];
    for (int chu = 0; chu < nmissc; chu ++)
    {
        int conn = counte%6;
        if(conn == 1)
        {
            MissilePlant* plantis = [missplants objectAtIndex:chu];
            [plantis growMiss: throwers];
        }
    }

    
    //MISSILEPLANT THROWS MISSILE
    num = [throwers count];
    for (int chu = 0; chu < num; chu ++)
    {
        int rrr = arc4random()%400;
        if(rrr == 0)
        {
            MissilePlant* item = [throwers objectAtIndex:chu];
                if (item.thrower==0)
                {
                    mm = [[Missile alloc] initWithMissileImage];
                    [mm setPosition:item.position];
                    [mm setScale:0.4f];
                    [self addChild:mm z:2];
                    [missiles addObject:mm];
                    int posx =fly.position.x - item.position.x;
                    int posy =fly.position.y - item.position.y;
                    mm.direcx = posx/100.0f;
                    mm.direcy = posy/100.0f;
                    //float amp = sqrtf(mm.direcx * mm.direcx + mm.direcy * mm.direcy);
                    //float kx = mm.direcx;
                    //mm.direcx = kx / amp;
                    //float ky = mm.direcy;
                    //mm.direcy = ky / amp;
                    item.thrower++;
                }
        }
    }
    
    
    //NEW PLANT APPEARS
    int ntotal = nplantc + nmissc;
    int diffty = 5 + DIFFICULTY * ntotal;
    int rando = arc4random()%diffty;
    if((rando == 0) && (nplant < PLANTS))
    {
        int correct = 0;
        int px = 40 + arc4random()%240;
        int py = 120 + arc4random()%320;
        CGPoint randpos = ccp(px, py);
        for (int chu = 0; chu < ntotal; chu ++)
        {
            CCSprite* item = [allplants objectAtIndex:chu];
            if (((randpos.x-item.position.x>70) || (randpos.x-item.position.x<-70)) || ((randpos.y-item.position.y>70) || (randpos.y-item.position.y<-70)))
            {
                correct++;
            }
        }
        if (((randpos.x-fly.position.x>100) || (randpos.x-fly.position.x<-100)) || ((randpos.y-fly.position.y>100) || (randpos.y-fly.position.y<-100)))
        {
            if (correct==ntotal)
            {
                newplant = [[Plant alloc] initWithPlantImage];
                [newplant setPosition:randpos];
                [newplant setScale:0.125f];
                [self addChild:newplant z:1 tag:nplant];
                [carnplants addObject:newplant];
                [allplants addObject:newplant];
                nplant++;
            }
        }
    }
    
    //NEW MISSILEPLANT APPEARS
    diffty = 30 + DIFFICULTY * ntotal;
    rando = arc4random()%diffty;
    if((rando == 0) && (nmiss < MISSES))
    {
        int correct = 0;
        int px = 40 + arc4random()%240;
        int py = 120 + arc4random()%320;
        CGPoint randpos = ccp(px, py);
        for (int chu = 0; chu < ntotal; chu ++)
        {
           CCSprite* item = [allplants objectAtIndex:chu];
            if (((randpos.x-item.position.x>70) || (randpos.x-item.position.x<-70)) || ((randpos.y-item.position.y>70) || (randpos.y-item.position.y<-70)))
            {
                correct++;
            }
        }
        if (((randpos.x-fly.position.x>100) || (randpos.x-fly.position.x<-100)) || ((randpos.y-fly.position.y>100) || (randpos.y-fly.position.y<-100)))
        {
            if (correct==ntotal)
            {
                newmiss = [[MissilePlant alloc] initWithPlantImage];
                [newmiss setPosition:randpos];
                [newmiss setScale:0.125f];
                [self addChild:newmiss z:1 tag:nmiss];
                [missplants addObject:newmiss];
                [allplants addObject:newmiss];
                nmiss++;
            }
        }
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

-(void) pauseGame
{
    [self pauseSchedulerAndActions];
}

-(void) resumeGame
{
    [self resumeSchedulerAndActions];
}

-(void) closeScissors
{
    if (weapon==0)
    {
        [scissors setTexture: blueclosedscissors];
    }
    else if (weapon==1)
    {
        [scissors setTexture: redclosedscissors];
    }
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

@end
