//
//  Level2.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "Level2.h"
#import "Congrats.h"
#import "Plant.h"
#import "Fly.h"
#import "Global.h"

@interface Level2 (PrivateMethods)
@end

@implementation Level2

#define Y_OFF_SET 80
#define WIDTH_WINDOW 320
#define HEIGHT_WINDOW 480
#define CELL_WIDTH 80
#define DIFFICULTY 18
#define INITIAL_TIME 600
#define WIDTH_GAME WIDTH_WINDOW
#define HEIGHT_GAME (HEIGHT_WINDOW - Y_OFF_SET)
#define NUM_ROWS (HEIGHT_GAME / CELL_WIDTH)
#define NUM_COLUMNS (WIDTH_GAME / CELL_WIDTH)
#define PLANTS 22
#define MISSES 0
#define TOTAL (PLANTS + MISSES)

-(id) init
{
	if ((self = [super init]))
	{
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"pause.png"
                                                            selectedImage: @"pause_sel.png"
                                                                   target:self
                                                                 selector:@selector(pauseGame)];
        
        CCMenuItemImage *menuItem2 = [CCMenuItemImage itemWithNormalImage:@"scissors.png"
                                                            selectedImage: @"scissors_sel.png"
                                                                   target:self
                                                                 selector:@selector(setWeapon0)];
        
        CCMenuItemImage *menuItem3 = [CCMenuItemImage itemWithNormalImage:@"redscissors.png"
                                                            selectedImage: @"redscissors_sel.png"
                                                                   target:self
                                                                 selector:@selector(setWeapon1)];
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
        menuItem1.position = ccp(240,30);
        menuItem2.position = ccp(50,35);
        menuItem3.position = ccp(110,35);
        myMenu.position = ccp(0,0);
        [menuItem1 setScale:0.4f];
        [menuItem2 setScale:0.1f];
        [menuItem3 setScale:0.1f];
        [self addChild: myMenu z:1];
        
        redclosedscissors= [[CCTextureCache sharedTextureCache] addImage:@"redscissors_closed.png"];
        blueclosedscissors= [[CCTextureCache sharedTextureCache] addImage:@"scissors_closed.png"];
        
        fly = [[Fly alloc] initWithFlyAnimation];
        [fly setBugSpeed:fly.speed];
        [self addChild:fly z:3];
        
        counte=0;
        ranx=0;
        rany=0;
        weapon=0;
        nplant=0;
        
        allplants = [[NSMutableArray alloc] init];
        carnplants = [[NSMutableArray alloc] init];
        catchingplants = [[NSMutableArray alloc] init];
        carnivores = [[NSMutableArray alloc] init];
        
        powerBar= [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"powerbar.png"]];
        powerBar.type = kCCProgressTimerTypeBar;
        powerBar.midpoint = ccp(0,0); // starts from left
        powerBar.barChangeRate = ccp(1,0); // grow only in the "x"-horizontal direction
        powerBar.percentage = 0; // (0 - 100)
        [powerBar setScale:0.4f];
        powerBar.position = ccp(160,70);
        [self addChild:powerBar z:2];
        
        connt = [CCSprite spriteWithFile:@"powerbarcontainer.png"];
        [connt setPosition:ccp(160,70)];
        [connt setScale:0.4f];
        [self addChild:connt z:1];
        
        selscissors = [CCSprite spriteWithFile:@"scissors_sel.png"];
        [selscissors setPosition:ccp(50,35)];
        [selscissors setScale:0.1f];
        redselscissors = [CCSprite spriteWithFile:@"redscissors_sel.png"];
        [redselscissors setPosition:ccp(110,35)];
        [redselscissors setScale:0.1f];
        [self addChild:selscissors z:1];
        
        announcement = [CCSprite spriteWithFile:@"an_level2.png"];
        [announcement setPosition:ccp(160,280)];
        [announcement setScale:0.6f];
        [self addChild:announcement z:5];
        
        [self scheduleUpdate];
	}
	return self;
}

-(void) draw
{
    //big green rectangle
    CGPoint c = ccp(0,0 + Y_OFF_SET - 20); //lower-left corner
    CGPoint d = ccp(WIDTH_GAME,HEIGHT_GAME + Y_OFF_SET); //upper-right corner
    ccColor4F color = ccc4f(0.1, 0.4, 0.5, 1);
    ccDrawSolidRect(c, d, color);
    
    //lower rectangles
    CGPoint f = ccp(0,0);
    CGPoint g = ccp(WIDTH_WINDOW,70);
    ccColor4F color2 = ccc4f(0.5, 0.1, 0.5, 1);
    ccDrawSolidRect(f, g, color2);
}

-(void) update: (ccTime) delta
{
    counte++;
    if (counte == 100)
    {
        [self removeChild:announcement cleanup:YES];
    }
    
    else if (counte > 100)
    {
        
        //CHECK IF PLAYER WINS
        if(powerBar.percentage > 99.5)
        {
            [self performSelector:@selector(gotocongrats) withObject:self afterDelay:2.0];
            announcement = [CCSprite spriteWithFile:@"an_welldone.png"];
            [announcement setPosition:ccp(160,280)];
            [announcement setScale:0.6f];
            [self addChild:announcement z:5];
            if (levelunlocked < 3)
            {
                levelunlocked = 3;
            }
            [self pauseSchedulerAndActions];
        }
        
        //KILL PLANTS
        int nallcc = [allplants count];
        if ([[KKInput sharedInput] anyTouchBeganThisFrame])
        {
            KKInput* input = [KKInput sharedInput];
            CGPoint pos = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
            if (pos.y > Y_OFF_SET - 10)
            {
                if (!([self.children containsObject:scissors]))
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
                    [self performSelector:@selector(closeScissors) withObject:self afterDelay:0.1];
                    [self performSelector:@selector(remov:) withObject:scissors afterDelay:0.2];
                    for (int chu = 0; chu < nallcc; chu ++)
                    {
                        CCSprite* plantis = [allplants objectAtIndex:chu];
                        if ([input isAnyTouchOnNode:plantis touchPhase:KKTouchPhaseAny])
                        {
                            [self removeChild:plantis cleanup:YES];
                            [carnivores removeObject:plantis];
                            [carnplants removeObject:plantis];
                            [allplants removeObject:plantis];
                            nallcc--;
                            powerBar.percentage += 100.0f/TOTAL;
                        }
                    }
                }
            }
        }
        
        //CHECK IF FLY DIES DEVOURED
        int num = [carnivores count];
        for (int chu = 0; chu < num; chu ++)
        {
            Plant* item = [carnivores objectAtIndex:chu];
            float posx =fly.position.x - item.position.x;
            float posy =fly.position.y - (item.position.y+25);
            if ((posx < 35) && (posx > -35) && (posy > -20) && (posy < 20))
            {
                [catchingplants addObject:item];
                [self performSelector:@selector(remov:) withObject:fly afterDelay:0.1];
            }
        }
        
        //MOVE BEE
        if ([self.children containsObject:fly])
        {
            [fly moveBug:counte];
        }
        else
        {
            announcement = [CCSprite spriteWithFile:@"an_gameover.png"];
            [announcement setPosition:ccp(160,280)];
            [announcement setScale:0.6f];
            [self addChild:announcement z:5];
            [self performSelector:@selector(gotogameover) withObject:self afterDelay:4.0];
        }
        
        //PLANTS GROW
        int nplantc = [carnplants count];
        for (int chu = 0; chu < nplantc; chu ++)
        {
            int conn = counte%6;
            if(conn == 0)
            {
                Plant* plantis = [carnplants objectAtIndex:chu];
                [plantis growPlant: carnivores];
                [plantis catchFly: catchingplants];
            }
        }
        
        //NEW PLANT APPEARS
        int ntotal = nplantc;
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
    }
}

-(void) gotogameover
{
    [[CCDirector sharedDirector] replaceScene: [[Congrats alloc] init]];
}

-(void) gotocongrats
{
    [[CCDirector sharedDirector] replaceScene: [[Congrats alloc] init]];
}

-(void) exitGame
{
    [[CCDirector sharedDirector] replaceScene: [[Congrats alloc] init]];
}

-(void) pauseGame
{
    [self pauseSchedulerAndActions];
    CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"resume.png"
                                                        selectedImage: @"resume_sel.png"
                                                               target:self
                                                             selector:@selector(resumeGame)];
    
    CCMenuItemImage *menuItem2 = [CCMenuItemImage itemWithNormalImage:@"exit.png"
                                                        selectedImage: @"exit_sel.png"
                                                               target:self
                                                             selector:@selector(exitGame)];
    
    pausemenu = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
    menuItem1.position = ccp(160,320);
    menuItem2.position = ccp(160,240);
    pausemenu.position = ccp(0,0);
    [menuItem1 setScale:0.4f];
    [menuItem2 setScale:0.4f];
    [self addChild: pausemenu z:6];
}

-(void) resumeGame
{
    [self removeChild:pausemenu cleanup:YES];
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

-(void) remov: (CCSprite*) cosi
{
    [self removeChild:cosi cleanup:YES];
}

-(void) setWeapon0
{
    if (weapon != 0)
    {
        weapon = 0;
        [self addChild: selscissors];
        [self removeChild: redselscissors cleanup:YES];
    }
}

-(void) setWeapon1
{
    if (weapon != 1)
    {
        weapon = 1;
        [self addChild: redselscissors];
        [self removeChild: selscissors cleanup:YES];
    }
}

@end