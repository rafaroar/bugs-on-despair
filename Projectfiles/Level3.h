//
//  Level3.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 24/01/13.
//
//

#import "kobold2d.h"

@class Bee, Fly, Missile, Plant, MissilePlant, Bomb;

@interface Level3 : CCLayer
{
    Bee *bee;
    Fly *fly;
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
    NSMutableArray *allplantsandbugs;
    
    int counte;
    float ranx;
    float rany;
    float beex;
    float beey;
    int weapon;
    int nplant;
    int nmiss;
}
-(id) init;
-(void) draw;
-(void)explode;

@end