//
//  Fly.h
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"
#import "Bug.h"

@interface Fly : Bug
{
    CCAction *move;
    CCAnimation *moving;
    NSMutableArray *flies;
}
@property float speed;
-(id) initWithFlyAnimation;
@end