//
//  FieldObjectBase.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#include "FieldObjectBase.h"

FieldObjectBase::FieldObjectBase()
: centerX(0)
, centerY(0)
, width(0)
, height(0)
{
}

FieldObjectBase::~FieldObjectBase()
{
}

float FieldObjectBase::getCenterX()
{
    return this->centerX;
}

void FieldObjectBase::setCenterX(float x)
{
    if (this->centerX == x)
        return;
    
    auto oldValue = this->centerX;
    auto newValue = x;
    this->centerX = x;
    this->onPropertyChanged<float>("centerX", oldValue, newValue);
}

float FieldObjectBase::getCenterY()
{
    return this->centerY;
}

void FieldObjectBase::setCenterY(float y)
{
    if (this->centerY == y)
        return;
    
    auto oldValue = this->centerY;
    auto newValue = y;
    this->centerY = y;
    this->onPropertyChanged<float>("centerY", oldValue, newValue);
}

float FieldObjectBase::getWidth()
{
    return this->width;
}

void FieldObjectBase::setWidth(float width)
{
    if (this->width == width)
        return;
    
    auto oldValue = this->width;
    auto newValue = width;
    this->width = width;
    this->onPropertyChanged<float>("width", oldValue, newValue);
}

float FieldObjectBase::getHeight()
{
    return this->height;
}

void FieldObjectBase::setHeight(float height)
{
    if (this->height == height)
        return;
    
    auto oldValue = this->height;
    auto newValue = height;
    this->height = height;
    this->onPropertyChanged<float>("height", oldValue, newValue);
}

bool FieldObjectBase::intersectsWith(FieldObjectBase *obj)
{
    if (obj == NULL)
        return false;
    
    auto x11 = this->getCenterX() - this->getWidth() * 0.5f;
    auto x12 = this->getCenterX() + this->getWidth() * 0.5f;
    auto y11 = this->getCenterY() - this->getHeight() * 0.5f;
    auto y12 = this->getCenterY() + this->getHeight() * 0.5f;
    
    auto x21 = obj->getCenterX() - obj->getWidth() * 0.5f;
    auto x22 = obj->getCenterX() + obj->getWidth() * 0.5f;
    auto y21 = obj->getCenterY() - obj->getHeight() * 0.5f;
    auto y22 = obj->getCenterY() + obj->getHeight() * 0.5f;
    
    return !(x12 < x21 || y12 < y21 || x22 < x11 || y22 < y11);
}

bool FieldObjectBase::insideOf(Field *field)
{
    auto x1 = this->getCenterX() - this->getWidth() * 0.5f;
    auto x2 = this->getCenterX() + this->getWidth() * 0.5f;
    auto y1 = this->getCenterY() - this->getHeight() * 0.5f;
    auto y2 = this->getCenterY() + this->getHeight() * 0.5f;
    
    auto fx1 = field->getX();
    auto fx2 = field->getX() + field->getWidth();
    auto fy1 = field->getY();
    auto fy2 = field->getY() + field->getHeight();
    
    return fx1 <= x1 && x2 <= fx2 && fy1 <= y1 && y2 <= fy2;
}
