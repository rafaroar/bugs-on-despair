//
//  Level5.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 01/02/13.
//
//

#import "kobold2d.h"

@class Bee, Fly, Redbug, Missile, Plant, MissilePlant, Bomb;

@interface Level5 : CCLayer
{
    Bee *bee;
    Fly *fly;
    Redbug *rbug;
    CCSprite *scissors;
    CCSprite *selscissors;
    CCSprite *redselscissors;
    CCSprite *selbomb;
    CCSprite *announcement;
    CCSprite *connt;
    Missile *mm;
    Plant *newplant;
    MissilePlant *newmiss;
    CCTexture2D* redclosedscissors;
    CCTexture2D* blueclosedscissors;
    CCTexture2D* explosion;
    CCAction *move;
    CCAnimation *moving;
    CCProgressTimer* powerBar;
    Bomb *bom;
    CCMenu *pausemenu;
    
    NSMutableArray *bugs;
    NSMutableArray *carnivores;
    NSMutableArray *throwers;
    NSMutableArray *carnplants;
    NSMutableArray *catchingplants;
    NSMutableArray *releasingplants;
    NSMutableArray *missplants;
    NSMutableArray *allplants;
    NSMutableArray *missiles;
    NSMutableArray *darkplants;
    NSMutableArray *supplants;
    NSMutableArray *allplantsandbugs;
    
    int counte;
    float ranx;
    float rany;
    float beex;
    float beey;
    float rbux;
    float rbuy;
    int weapon;
    int nplant;
    int nmiss;
}
-(id) init;
-(void) draw;
-(void)explode;

@end