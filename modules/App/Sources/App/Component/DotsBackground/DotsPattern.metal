//  DotsPattern.metal
//  Created by Vladimir Roganov on 10.03.2024

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 dotsPattern(float2 position, half4 currentColor, float size, float radius, half4 fillColor, float2 offset) {
    float xm = abs(fmod(position.x + offset.x, size)) - size * 0.5;
    float ym = abs(fmod(position.y + offset.y, size)) - size * 0.5;
    return sqrt(xm*xm + ym*ym) < radius ? fillColor : half4(0.0, 0.0, 0.0, 0.0);
}
