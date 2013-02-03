//
//  GameLayer.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 03/02/13.
//
//

#import "kobold2d.h"

@class Bee, Fly, Redbug, Missile, Plant, MissilePlant, Bomb, Global;

@interface GameLayer : CCLayer
{
    Bee *bee;
    Fly *fly;
    Redbug *rbug;
    CCSprite *scissors;
    CCSprite *selscissors;
    CCSprite *redselscissors;
    CCSprite *selbomb;
    CCSprite *announcement;
    CCSprite *announcement2;
    CCSprite *connt;
    CCSprite *expplos;
    Missile *mm;
    Plant *newplant;
    MissilePlant *newmiss;
    CCTexture2D* redclosedscissors;
    CCTexture2D* blueclosedscissors;
    CCTexture2D* explosion;
    CCTexture2D* plantremains;
    CCAction *move;
    CCAnimation *moving;
    CCProgressTimer* powerBar;
    Bomb *bom;
    CCMenu *pausemenu;
    ccColor4F color;
    Global *sm;
    
    NSMutableArray *bugs;
    NSMutableArray *carnivores;
    NSMutableArray *throwers;
    NSMutableArray *carnplants;
    NSMutableArray *missplants;
    NSMutableArray *allplants;
    NSMutableArray *missiles;
    NSMutableArray *darkplants;
    NSMutableArray *allplantsandbugs;
    
    int counte;
    int weapon;
    int nplant;
    int nmiss;
    int difficulty;
    int plants;
    int misses;
    int total;
}
-(id) init;
-(void) draw;
-(void)explode;

@end
