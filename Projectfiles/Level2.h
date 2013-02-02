//
//  Level2.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "kobold2d.h"

@class Fly, Plant;

@interface Level2 : CCLayer
{
    Fly *fly;
    CCSprite *scissors;
    CCSprite *selscissors;
    CCSprite *redselscissors;
    CCSprite *announcement;
    CCSprite *connt;
    Plant *newplant;
    CCTexture2D* redclosedscissors;
    CCTexture2D* blueclosedscissors;
    CCProgressTimer* powerBar;
    CCMenu *pausemenu;
    
    NSMutableArray *carnivores;
    NSMutableArray *allplants;
    NSMutableArray *carnplants;
    NSMutableArray *catchingplants;
    
    int counte;
    float ranx;
    float rany;
    int weapon;
    int nplant;
}
-(id) init;
-(void) draw;

@end
