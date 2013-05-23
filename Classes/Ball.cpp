//
//  Ball.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#include "Ball.h"

Ball::Ball()
: dx(0)
, dy(0)
{
}

Ball::~Ball()
{
}

float Ball::getDX()
{
    return this->dx;
}

void Ball::setDX(float dx)
{
    if (this->dx == dx)
        return;
    
    float oldValue = this->dx;
    this->dx = dx;
    this->onPropertyChanged<float>("dx", oldValue, this->dx);
}

float Ball::getDY()
{
    return this->dy;
}

void Ball::setDY(float dy)
{
    if (this->dy == dy)
        return;
    
    float oldValue = this->dy;
    this->dy = dy;
    this->onPropertyChanged<float>("dy", oldValue, this->dy);
}
