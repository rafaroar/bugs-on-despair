//
//  Congrats.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 02/02/13.
//
//

#import "kobold2d.h"

@class Bee, Fly, Redbug;

@interface Congrats : CCLayer
{
    ccColor4F color;
    CCSprite *congrats;
    CCSprite *playagain;
    Bee *bee;
    Fly *fly;
    Redbug *rbug;
    NSMutableArray *levelArray;
    NSMutableArray *bugs;
    int counte;
    float height;
}
-(void) draw;
-(id) init;
-(void) gotolevel: (CCMenuItem  *) menuItem;
@end

