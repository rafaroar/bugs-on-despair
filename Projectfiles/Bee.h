//
//  Bee.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"
#import "Bug.h"

@interface Bee : Bug
{
    CCAction *move;
    CCAnimation *moving;
    NSMutableArray *bees;
}
@property float speed;
-(id) initWithBeeAnimation;
@end
