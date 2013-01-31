//
//  MissilePlant.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"

@interface MissilePlant : CCSprite
@property int grow;
@property int thrower;
-(id) initWithPlantImage;
-(void) growMiss: (NSMutableArray*)throwers;
@end
