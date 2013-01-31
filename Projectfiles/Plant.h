//
//  Plant.h
//  thelifegame1
//
//  Created by Andrea Rodríguez Arguedas on 22/01/13.
//
//

#import "kobold2d.h"

@interface Plant : CCSprite
@property int grow;
@property int currentlife;
-(id) initWithPlantImage;
-(void) growPlant: (NSMutableArray*)carnivores;
@end
