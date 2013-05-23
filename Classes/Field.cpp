//
//  Field.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#include "Field.h"

Field::Field()
: x(0)
, y(0)
, width(0)
, height(0)
{
}

Field::~Field()
{
}

float Field::getX()
{
    return this->x;
}

void Field::setX(float x)
{
    if (this->x == x)
        return;
    
    auto oldValue = this->x;
    auto newValue = x;
    this->x = x;
    this->onPropertyChanged<float>("x", oldValue, newValue);
}

float Field::getY()
{
    return this->y;
}

void Field::setY(float y)
{
    if (this->y == y)
        return;
    
    auto oldValue = this->y;
    auto newValue = y;
    this->y = y;
    this->onPropertyChanged<float>("y", oldValue, newValue);
}

float Field::getWidth()
{
    return this->width;
}

void Field::setWidth(float width)
{
    if (this->width == width)
        return;
    
    auto oldValue = this->width;
    auto newValue = width;
    this->width = width;
    this->onPropertyChanged<float>("width", oldValue, newValue);
}

float Field::getHeight()
{
    return this->height;
}

void Field::setHeight(float height)
{
    if (this->height == height)
        return;
    
    auto oldValue = this->height;
    auto newValue = height;
    this->height = height;
    this->onPropertyChanged<float>("height", oldValue, newValue);
}
