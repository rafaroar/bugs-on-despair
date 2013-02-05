//
//  Congrats.h
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 02/02/13.
//
//

#import "kobold2d.h"

@class Bee, Fly, Redbug, Global;

@interface Congrats : CCLayer
{
    ccColor4F color;
    CCSprite *congrats;
    CCSprite *playagain;
    CCSprite *announcement;
    Bee *bee;
    Fly *fly;
    Redbug *rbug;
    Global *sm;
    NSMutableArray *bugs;
    int counte;
    float height;
    float spacing;
}
-(void) draw;
-(id) init;
-(void) gotolevel: (CCMenuItem  *) menuItem;
@end

