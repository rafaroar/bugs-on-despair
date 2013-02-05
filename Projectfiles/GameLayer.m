//
//  GameLayer.m
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 03/02/13.
//
//

#import "GameLayer.h"
#import "Congrats.h"
#import "StartLayer.h"
#import "Plant.h"
#import "Missile.h"
#import "MissilePlant.h"
#import "Bee.h"
#import "Fly.h"
#import "Redbug.h"
#import "Bomb.h"
#import "Global.h"

@interface GameLayer (PrivateMethods)
@end

@implementation GameLayer

-(id) init
{
	if ((self = [super init]))
	{
        sm = [Global sharedManager];
        
        redclosedscissors= [[CCTextureCache sharedTextureCache] addImage:@"redscissors_closed.png"];
        blueclosedscissors= [[CCTextureCache sharedTextureCache] addImage:@"scissors_closed.png"];
        explosion = [[CCTextureCache sharedTextureCache] addImage:@"explosion.png"];
        plantremains = [[CCTextureCache sharedTextureCache] addImage:@"dark.png"];
        
        counte=0;
        weapon=0;
        nplant=0;
        nmiss=0;
        
        allplants = [[NSMutableArray alloc] init];
        carnplants = [[NSMutableArray alloc] init];
        missplants = [[NSMutableArray alloc] init];
        carnivores = [[NSMutableArray alloc] init];
        throwers = [[NSMutableArray alloc] init];
        missiles = [[NSMutableArray alloc] init];
        darkplants = [[NSMutableArray alloc] init];
        bugs = [[NSMutableArray alloc] init];
        allplantsandbugs = [[NSMutableArray alloc] init];
        
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
        [selscissors setScale:0.1f];
        [selscissors setPosition:ccp(50,35)];
        redselscissors = [CCSprite spriteWithFile:@"redscissors_sel.png"];
        [redselscissors setScale:0.1f];
        [redselscissors setPosition:ccp(110,35)];
        [self addChild:selscissors z:1];
        
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
        
        CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
        menuItem1.position = ccp(240,30);
        menuItem2.position = ccp(50,35);
        menuItem3.position = ccp(110,35);
        [menuItem1 setScale:0.4f];
        [menuItem2 setScale:0.1f];
        [menuItem3 setScale:0.1f];
        myMenu.position = ccp(0,0);
        [self addChild: myMenu z:1];
        
        if (sm.level > 2)
        {
            menuItem2.position = ccp(40,35);
            menuItem3.position = ccp(90,35);
            menuItem4.position = ccp(140,35);
            [menuItem4 setScale:0.1f];
            [myMenu addChild:menuItem4];
            [selscissors setPosition:ccp(40,35)];
            [redselscissors setPosition:ccp(90,35)];
            selbomb = [CCSprite spriteWithFile:@"bomb_sel.png"];
            [selbomb setPosition:ccp(140,35)];
            [selbomb setScale:0.1f];
        }
    
        if (sm.level == 1)
        {
            color = ccc4f(0.2, 0.6, 0.2, 1);
            difficulty = 20;
            plants = 15;
            misses = 0;
            
            bee = [[Bee alloc] initWithBeeAnimation];
            [bee setBugSpeed:bee.speed];
            [self addChild:bee z:4];
            [bugs addObject:bee];
            [allplantsandbugs addObject:bee];
            
            announcement2 = [CCSprite spriteWithFile:@"cutplants.png"];
            [announcement2 setPosition:ccp(110,60)];
            [announcement2 setScale:0.3f];
            [self addChild:announcement2 z:5];
        }
        else if (sm.level == 2)
        {
            color = ccc4f(0.1, 0.4, 0.5, 1);
            difficulty = 18;
            plants = 22;
            misses = 0;
            
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:fly.speed];
            [self addChild:fly z:4];
            [bugs addObject:fly];
            [allplantsandbugs addObject:fly];
        }
        else if (sm.level == 3)
        {
            color = ccc4f(0.3, 0.7, 0.3, 1);
            difficulty = 18;
            plants = 0;
            misses = 20;
            
            bee = [[Bee alloc] initWithBeeAnimation];
            [bee setBugSpeed:bee.speed];
            [fly setPosition:ccp(160,310)];
            [self addChild:bee z:4];
            [bugs addObject:bee];
            [allplantsandbugs addObject:bee];
            
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:fly.speed];
            [fly setPosition:ccp(160,250)];
            [self addChild:fly z:4];
            [bugs addObject:fly];
            [allplantsandbugs addObject:fly];
            
            announcement2 = [CCSprite spriteWithFile:@"trythebomb.png"];
            [announcement2 setPosition:ccp(140,60)];
            [announcement2 setScale:0.3f];
            [self addChild:announcement2 z:5];
        }
        else if (sm.level == 4)
        {
            color = ccc4f(0.3, 0.4, 0.5, 1);
            difficulty = 18;
            plants = 20;
            misses = 10;
            
            for (int chu = 0; chu < 2; chu ++)
            {
                rbug = [[Redbug alloc] initWithRedbugAnimation];
                [rbug setBugSpeed:rbug.speed];
                [rbug setPosition:ccp(160,250+chu*60)];
                [self addChild:rbug z:4 tag:chu];
                [bugs addObject:rbug];
                [allplantsandbugs addObject:rbug];
            }
        }
        else if (sm.level == 5)
        {
            color = ccc4f(0.6, 0.3, 0.3, 1);
            difficulty = 13;
            plants = 30;
            misses = 20;
            
            bee = [[Bee alloc] initWithBeeAnimation];
            [bee setBugSpeed:bee.speed];
            [bee setPosition:ccp(160,330)];
            [self addChild:bee z:4];
            [bugs addObject:bee];
            [allplantsandbugs addObject:bee];
            
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:fly.speed];
            [self addChild:fly z:4];
            [bugs addObject:fly];
            [allplantsandbugs addObject:fly];
            
            rbug = [[Redbug alloc] initWithRedbugAnimation];
            [rbug setBugSpeed:rbug.speed];
            [rbug setPosition:ccp(160,230)];
            [self addChild:rbug z:4];
            [bugs addObject:rbug];
            [allplantsandbugs addObject:rbug];
        }
        else if (sm.level == 6)
        {
            color = ccc4f(0.2, 0.8, 0.3, 1);
            difficulty = 11;
            plants = 60;
            misses = 0;
            
            for (int chu = 0; chu < 11; chu ++)
            {
                bee = [[Bee alloc] initWithBeeAnimation];
                [bee setBugSpeed:bee.speed];
                [bee setPosition:ccp(160,130+chu*30)];
                [self addChild:bee z:4 tag:chu];
                [bugs addObject:bee];
                //[allplantsandbugs addObject:bee];
            }
        }
        else if (sm.level == 7)
        {
            color = ccc4f(0.5, 0.6, 0.5, 1);
            difficulty = 1;
            plants = 80;
            misses = 0;
            
            fly = [[Fly alloc] initWithFlyAnimation];
            [fly setBugSpeed:0.004];
            [self addChild:fly z:4];
            [bugs addObject:fly];
            [allplantsandbugs addObject:fly];
        }
        else
        {
            color = ccc4f(0.4, 0.6, 0.6, 1);
            difficulty = 8;
            plants = 70;
            misses = 30;
            
            for (int chu = 0; chu < 7; chu ++)
            {
                bee = [[Bee alloc] initWithBeeAnimation];
                [bee setBugSpeed:bee.speed];
                [bee setPosition:ccp(120,190+chu*30)];
                [self addChild:bee z:4 tag:chu];
                [bugs addObject:bee];
                //[allplantsandbugs addObject:bee];
                
                fly = [[Fly alloc] initWithFlyAnimation];
                [fly setBugSpeed:fly.speed];
                [fly setPosition:ccp(160,190+chu*30)];
                [self addChild:fly z:4];
                [bugs addObject:fly];
                //[allplantsandbugs addObject:fly];
                
                rbug = [[Redbug alloc] initWithRedbugAnimation];
                [rbug setBugSpeed:rbug.speed];
                [rbug setPosition:ccp(200,190+chu*30)];
                [self addChild:rbug z:4];
                [bugs addObject:rbug];
                //[allplantsandbugs addObject:rbug];
            }
        }

        total = plants + misses;

        announcement = [CCSprite spriteWithFile:[NSString stringWithFormat:@"an_level%d.png",sm.level]];
        [announcement setPosition:ccp(160,280)];
        [announcement setScale:0.6f];
        [self addChild:announcement z:5];

        [self scheduleUpdate];
	}
	return self;
}

-(void) draw
{
    CGPoint c = ccp(0,0 + Y_OFF_SET - 20); //lower-left corner
    CGPoint d = ccp(WIDTH_GAME,HEIGHT_GAME + Y_OFF_SET); //upper-right corner
    ccDrawSolidRect(c, d, color);
    
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
            if (sm.levelunlocked <= sm.level)
            {
                sm.levelunlocked = sm.level + 1;
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
                if (weapon == 2)
                {
                    if ([self.children containsObject:bom])
                    {
                    }
                    else
                    {
                        bom = [[Bomb alloc] initWithBombImage];
                        [bom setPosition:pos];
                        [self addChild:bom z:3];
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
                        [self addChild:scissors z:3];
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
                                powerBar.percentage += 100.0f/total;
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
            powerBar.percentage += 100.0f/total;
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
                    item.hunger++;
                    [carnivores removeObject:item];
                    [bugs removeObject:bog];
                    [allplantsandbugs removeObject:bog];
                    numm--;
                    num--;
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
                    [self addChild:expplos z:5];
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
            item.reorder++;
            if (item.reorder == 30)
            {
                [self reorderChild:item z:3];
            }
            item.position = ccp( item.position.x + item.direcx, item.position.y + item.direcy);
            if ((item.position.y > 480)||(item.position.y < 80)||(item.position.x > 320)||(item.position.x < 0))
            {
                [self removeChild:item cleanup:YES];
                [missiles removeObject:item];
                num--;
            }
        }
        
        //MOVE BUGS
        for (int i = 0; i < numm; i ++)
        {
            Bug* bog = [bugs objectAtIndex:i];
            [bog moveBug:counte];
        }
        if (numm == 0)
        {
            [self performSelector:@selector(announcegameover) withObject:self afterDelay:1.0];
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
            if ((item.thrower==11) && (numm > 0))
                item.shoot++;
                if (item.shoot == 1)
                {
                    if (item.side == 0)
                    {
                        mm = [[Missile alloc] initWithMissileAnimation];
                    }
                    else
                    {
                        mm = [[Missile alloc] initWithMissileAnimationLeft];
                    }
                    int k = 1 - 2*item.side;
                    [mm setPosition: ccp(item.position.x+10*k,item.position.y+25)];
                    [self addChild:mm z:1];
                    [missiles addObject:mm];
                    CCSprite* bogz = [bugs objectAtIndex:0];
                    float posx =bogz.position.x - item.position.x;
                    float posy =bogz.position.y - item.position.y;
                    float amp = sqrtf(posx * posx + posy * posy);
                    mm.direcx = k + posx / amp;
                    mm.direcy = posy / amp;
                }
            int rrr = arc4random()%100;
            if(rrr == 0)
            {
                item.thrower++;
            }
        }
        
        //NEW PLANT APPEARS
        int ntotal = nplantc + nmissc;
        int ntotalib = [allplantsandbugs count];
        int diffty = 5 + difficulty * ntotal;
        int rando = arc4random()%diffty;
        if((rando == 0) && (nplant < plants))
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
                [self addChild:newplant z:2 tag:nplant];
                [carnplants addObject:newplant];
                [allplants addObject:newplant];
                [allplantsandbugs addObject:newplant];
                nplant++;
            }
        }
        
        //NEW MISSILEPLANT APPEARS
        diffty = 5 + difficulty * ntotal;
        rando = arc4random()%diffty;
        if((rando == 0) && (nmiss < misses))
        {
            int correct = 0;
            int chan = arc4random()%2;
            int px = 20 + chan*230 + arc4random()%50;
            int py = 120 + arc4random()%320;
            CGPoint randpos = ccp(px, py);
            for (int chu = 0; chu < ntotalib; chu ++)
            {
                CCSprite* item = [allplantsandbugs objectAtIndex:chu];
                if (((randpos.x-item.position.x>70) || (randpos.x-item.position.x<-70)) || ((randpos.y-item.position.y>90) || (randpos.y-item.position.y<-90)))
                {
                    correct++;
                }
            }
            if (correct==ntotalib)
            {
                newmiss = [[MissilePlant alloc] initWithPlantImage];
                newmiss.side = chan;
                [newmiss setPosition:randpos];
                [newmiss setScale:0.125f];
                [self addChild:newmiss z:2 tag:nmiss];
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
    sm.statu = 0;
    if (sm.levelunlocked == 1)
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:[[StartLayer alloc] init]]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:[[Congrats alloc] init]]];
    }
}

-(void) gotocongrats
{
    sm.statu = 1;
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFadeTR transitionWithDuration:0.5f scene:[[Congrats alloc] init]]];
}

-(void) exitGame
{
    sm.statu = 2;
    if (sm.levelunlocked == 1)
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:[[StartLayer alloc] init]]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:[[Congrats alloc] init]]];
    }
}

-(void) announcegameover
{
    announcement = [CCSprite spriteWithFile:@"an_gameover.png"];
    [announcement setPosition:ccp(160,280)];
    [announcement setScale:0.6f];
    [self addChild:announcement z:6];
    [self pauseSchedulerAndActions];
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
    [self addChild: pausemenu z:7];
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
    [bom setScale: 1.4f];
    [self performSelector:@selector(remov:) withObject:bom afterDelay:0.3];
    int num = [allplants count];
    for (int chu = 0; chu < num; chu ++)
    {
        CCSprite* item = [allplants objectAtIndex:chu];
        float posx =bom.position.x - item.position.x;
        float posy =bom.position.y - item.position.y;
        if ((posx < 150) && (posx > -150) && (posy > -150) && (posy < 150))
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
