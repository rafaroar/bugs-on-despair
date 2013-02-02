//
//  StartLayer.h
//  thelifegame1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "kobold2d.h"

@class Fly, Bee;

@interface StartLayer : CCLayer
{
    CCSprite *title;
    CCSprite *save;
    Fly *fly;
    Bee *bee;
    int counte;
    float ranx;
    float rany;
    float beex;
    float beey;
}
-(void) draw;
-(id) init;
-(void) startg;
@end
