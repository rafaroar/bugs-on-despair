//
//  Level3.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 24/01/13.
//
//

#import "Level3.h"
#import "GameOverLayer.h"
#import "CongratsLayer2.h"
#import "CongratsLayer3.h"
#import "Plant.h"
#import "Missile.h"
#import "MissilePlant.h"
#import "Bee.h"
#import "Fly.h"
#import "Bomb.h"

@interface Level3 (PrivateMethods)
@end

@implementation Level3

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
#define PLANTS 0
#define MISSES 20
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
        
        CCMenuItemImage *menuItem4 = [CCMenuItemImage itemWithNormalImage:@"bomb.png"
                                                            selectedImage: @"bomb_sel.png"
                                                                   target:self
                                                                 selector:@selector(setWeapon2)];
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, nil];
        menuItem1.position = ccp(240,30);
        menuItem2.position = ccp(40,35);
        menuItem3.position = ccp(90,35);
        menuItem4.position = ccp(140,35);
        myMenu.position = ccp(0,0);
        [menuItem1 setScale:0.4f];
        [menuItem2 setScale:0.1f];
        [menuItem3 setScale:0.1f];
        [menuItem4 setScale:0.1f];
        [self addChild: myMenu z:1];
        
        redclosedscissors= [[CCTextureCache sharedTextureCache] addImage:@"redscissors_closed.png"];
        blueclosedscissors= [[CCTextureCache sharedTextureCache] addImage:@"scissors_closed.png"];
        explosion = [[CCTextureCache sharedTextureCache] addImage:@"explosion.png"];
        plantremains = [[CCTextureCache sharedTextureCache] addImage:@"dark.png"];
        
        bee = [[Bee alloc] initWithBeeAnimation];
        [bee setPosition:ccp(160,310)];
        [self addChild:bee z:3];
        
        fly = [[Fly alloc] initWithFlyAnimation];
        [fly setPosition:ccp(160,250)];
        [self addChild:fly z:3];
        
        counte=0;
        ranx=0;
        rany=0;
        beex=0;
        beey=0;
        weapon=0;
        nplant=0;
        nmiss=0;
        
        allplants = [[NSMutableArray alloc] init];
        carnplants = [[NSMutableArray alloc] init];
        catchingplants = [[NSMutableArray alloc] init];
        releasingplants = [[NSMutableArray alloc] init];
        missplants = [[NSMutableArray alloc] init];
        carnivores = [[NSMutableArray alloc] init];
        throwers = [[NSMutableArray alloc] init];
        missiles = [[NSMutableArray alloc] init];
        darkplants = [[NSMutableArray alloc] init];
        bugs = [[NSMutableArray alloc] init];
        [bugs addObject:fly];
        [bugs addObject:bee];
        allplantsandbugs = [[NSMutableArray alloc] init];
        [allplantsandbugs addObject:fly];
        [allplantsandbugs addObject:bee];
        
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
        [selscissors setPosition:ccp(40,35)];
        [selscissors setScale:0.1f];
        redselscissors = [CCSprite spriteWithFile:@"redscissors_sel.png"];
        [redselscissors setPosition:ccp(90,35)];
        [redselscissors setScale:0.1f];
        selbomb = [CCSprite spriteWithFile:@"bomb_sel.png"];
        [selbomb setPosition:ccp(140,35)];
        [selbomb setScale:0.1f];
        [self addChild:selscissors z:1];
        
        announcement = [CCSprite spriteWithFile:@"an_level3.png"];
        [announcement setPosition:ccp(160,280)];
        [announcement setScale:0.6f];
        [self addChild:announcement z:5];
        
        announcement2 = [CCSprite spriteWithFile:@"trythebomb.png"];
        [announcement2 setPosition:ccp(140,60)];
        [announcement2 setScale:0.3f];
        [self addChild:announcement2 z:5];
        
        [self scheduleUpdate];
	}
	return self;
}

-(void) draw
{
    //big green rectangle
    CGPoint c = ccp(0,0 + Y_OFF_SET - 20); //lower-left corner
    CGPoint d = ccp(WIDTH_GAME,HEIGHT_GAME + Y_OFF_SET); //upper-right corner
    ccColor4F color = ccc4f(0.3, 0.7, 0.3, 1);
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
        [self removeChild:announcement2 cleanup:YES];
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
                if (weapon == 2)
                {
                    if ([self.children containsObject:bom])
                    {
                    }
                    else
                    {
                        bom = [[Bomb alloc] initWithBombImage];
                        [bom setPosition:pos];
                        [self addChild:bom z:2];
                        [self performSelector:@selector(explode) withObject:self afterDelay:2.0];
                    }
                }
                else
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
                                [allplantsandbugs removeObject:plantis];
                                [throwers removeObject:plantis];
                                [missplants removeObject:plantis];
                                nallcc--;
                                powerBar.percentage += 100.0f/TOTAL;
                            }
                        }
                    }
                }
            }
        }
        
        int ndark = [darkplants count];
        for (int chu = 0; chu < ndark; chu ++)
        {
            CCSprite* plantis = [darkplants objectAtIndex:chu];
            [plantis setTexture:plantremains];
            [self performSelector:@selector(remov:) withObject:plantis afterDelay:4.0];
            [carnivores removeObject:plantis];
            [carnplants removeObject:plantis];
            [throwers removeObject:plantis];
            [missplants removeObject:plantis];
            [allplants removeObject:plantis];
            [allplantsandbugs removeObject:plantis];
            [darkplants removeObject:plantis];
            ndark--;
            powerBar.percentage += 100.0f/TOTAL;
        }
        
        //CHECK IF BUGS DIE DEVOURED
        int num = [carnivores count];
        int numm = [bugs count];
        for (int cha = 0; cha < numm; cha ++)
        {
            CCSprite* bog = [bugs objectAtIndex:cha];
            for (int chu = 0; chu < num; chu ++)
            {
                Plant* item = [carnivores objectAtIndex:chu];
                float posx = bog.position.x - item.position.x;
                float posy = bog.position.y - (item.position.y+25);
                if ((posx < 35) && (posx > -35) && (posy > -20) && (posy < 20))
                {
                    [catchingplants addObject:item];
                    [bugs removeObject:bog];
                    [allplantsandbugs removeObject:bog];
                    numm--;
                    [self performSelector:@selector(remov:) withObject:bog afterDelay:0.1];
                }
            }
        }
        
        //CHECK IF BUGS DIE BY MISSILE AND MOVE MISSILE
        num = [missiles count];
        for (int chu = 0; chu < num; chu ++)
        {
            Missile* item = [missiles objectAtIndex:chu];
            for (int cha = 0; cha < numm; cha ++)
            {
                CCSprite* bog = [bugs objectAtIndex:cha];
                float posx = bog.position.x - item.position.x;
                float posy = bog.position.y - item.position.y;
                if ((posx < 30) && (posx > -30) && (posy > -20) && (posy < 20))
                {
                    expplos = [CCSprite spriteWithFile:@"explosion.png"];
                    [expplos setPosition:ccp(bog.position.x,bog.position.y)];
                    [expplos setScale:0.2f];
                    [self addChild:expplos z:4];
                    [self performSelector:@selector(remov:) withObject:expplos afterDelay:0.5];
                    [self removeChild:item cleanup:YES];
                    [missiles removeObject:item];
                    num--;
                    numm--;
                    [bugs removeObject:bog];
                    [allplantsandbugs removeObject:bog];
                    [self performSelector:@selector(remov:) withObject:bog afterDelay:0.1];
                }
            }
            //float amp = sqrtf(posx * posx + posy * posy);
            //float ppx = posx / amp / 4;
            //float ppy = posy / amp / 4;
            item.position = ccp( item.position.x + item.direcx, item.position.y + item.direcy);
            if ((item.position.y > 480)||(item.position.y < 80)||(item.position.x > 320)||(item.position.x < 0))
            {
                [self removeChild:item cleanup:YES];
                [missiles removeObject:item];
                num--;
            }
        }
        
        //MOVE BUGS
        if ([self.children containsObject:fly])
        {
            ranx = [fly moveFlyX: counte high: ranx];
            rany = [fly moveFlyY: counte high: rany];
        }
        if ([self.children containsObject:bee])
        {
            beex = [bee moveBeeX: counte high: beex];
            beey = [bee moveBeeY: counte high: beey];
        }
        if (!([self.children containsObject:fly]||[self.children containsObject:bee]))
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
            MissilePlant* item = [throwers objectAtIndex:chu];
            int rrr = arc4random()%400;
            if(rrr == 0)
            {
                if ((item.thrower==0) && (numm > 0))
                {
                    mm = [[Missile alloc] initWithMissileAnimation];
                    [mm setPosition:item.position];
                    [self addChild:mm z:2];
                    [missiles addObject:mm];
                    CCSprite* bogz = [bugs objectAtIndex:0];
                    float posx =bogz.position.x - item.position.x;
                    float posy =bogz.position.y - item.position.y;
                    float amp = sqrtf(posx * posx + posy * posy);
                    mm.direcx = 1 + posx / amp;
                    mm.direcy = posy / amp;
                    item.thrower++;
                }
                else if (item.thrower==1)
                {
                    item.thrower--;
                }
            }
        }
        
        //NEW PLANT APPEARS
        int ntotal = nplantc + nmissc;
        int ntotalib = ntotal + numm;
        int diffty = 5 + DIFFICULTY * ntotal;
        int rando = arc4random()%diffty;
        if((rando == 0) && (nplant < PLANTS))
        {
            int correct = 0;
            int px = 40 + arc4random()%240;
            int py = 120 + arc4random()%320;
            CGPoint randpos = ccp(px, py);
            for (int chu = 0; chu < ntotalib; chu ++)
            {
                CCSprite* item = [allplantsandbugs objectAtIndex:chu];
                if (((randpos.x-item.position.x>70) || (randpos.x-item.position.x<-70)) || ((randpos.y-item.position.y>70) || (randpos.y-item.position.y<-70)))
                {
                    correct++;
                }
            }
            if (correct==ntotalib)
            {
                newplant = [[Plant alloc] initWithPlantImage];
                [newplant setPosition:randpos];
                [newplant setScale:0.125f];
                [self addChild:newplant z:1 tag:nplant];
                [carnplants addObject:newplant];
                [allplants addObject:newplant];
                [allplantsandbugs addObject:newplant];
                nplant++;
            }
        }
        
        //NEW MISSILEPLANT APPEARS
        diffty = 5 + DIFFICULTY * ntotal;
        rando = arc4random()%diffty;
        if((rando == 0) && (nmiss < MISSES))
        {
            int correct = 0;
            int px = 40 + arc4random()%60;
            int py = 120 + arc4random()%320;
            CGPoint randpos = ccp(px, py);
            for (int chu = 0; chu < ntotalib; chu ++)
            {
                CCSprite* item = [allplantsandbugs objectAtIndex:chu];
                if (((randpos.x-item.position.x>70) || (randpos.x-item.position.x<-70)) || ((randpos.y-item.position.y>70) || (randpos.y-item.position.y<-70)))
                {
                    correct++;
                }
            }
            if (correct==ntotalib)
            {
                newmiss = [[MissilePlant alloc] initWithPlantImage];
                [newmiss setPosition:randpos];
                [newmiss setScale:0.125f];
                [self addChild:newmiss z:1 tag:nmiss];
                [missplants addObject:newmiss];
                [allplants addObject:newmiss];
                [allplantsandbugs addObject:newmiss];
                nmiss++;
            }
        }
    }
}

-(void) gotogameover
{
    [[CCDirector sharedDirector] replaceScene: [[CongratsLayer2 alloc] init]];
}

-(void) gotocongrats
{
    [[CCDirector sharedDirector] replaceScene: [[CongratsLayer3 alloc] init]];
}

-(void) exitGame
{
    [[CCDirector sharedDirector] replaceScene: [[CongratsLayer2 alloc] init]];
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

-(void)explode
{
    [bom setTexture: explosion];
    [bom setScale: 1.7f];
    [self performSelector:@selector(remov:) withObject:bom afterDelay:0.3];
    int num = [allplants count];
    for (int chu = 0; chu < num; chu ++)
    {
        CCSprite* item = [allplants objectAtIndex:chu];
        float posx =bom.position.x - item.position.x;
        float posy =bom.position.y - item.position.y;
        if ((posx < 200) && (posx > -200) && (posy > -200) && (posy < 200))
        {
            [darkplants addObject: item];
        }
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
        [self removeChild: selbomb cleanup:YES];
    }
}

-(void) setWeapon1
{
    if (weapon != 1)
    {
        weapon = 1;
        [self addChild: redselscissors];
        [self removeChild: selscissors cleanup:YES];
        [self removeChild: selbomb cleanup:YES];
    }
}

-(void) setWeapon2
{
    if (weapon != 2)
    {
        weapon = 2;
        [self addChild: selbomb];
        [self removeChild: selscissors cleanup:YES];
        [self removeChild: redselscissors cleanup:YES];
    }
}

@end
