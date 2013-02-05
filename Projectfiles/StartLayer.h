//
//  StartLayer.h
//  thelifegame1
//
//  Created by Rafael Rodríguez Arguedas on 23/01/13.
//
//

#import "kobold2d.h"

@class Fly, Bee, Global;

@interface StartLayer : CCLayer
{
    CCSprite *title;
    CCSprite *save;
    CCSprite *announcement;
    Fly *fly;
    Bee *bee;
    Global *sm;
    int counte;
}
-(void) draw;
-(id) init;
-(void) startg;
@end
