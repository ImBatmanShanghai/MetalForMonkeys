//
//  MyShader.metal
//  Ch1Example2HelloTriangle
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

// vertex input
typedef struct {
    packed_float3 position;
    packed_float3 color;
} VertexInput;

// raster input, interpolate then output to fragment
typedef struct {
    float4 position [[position]]; // tell GPU to do rasterization using [[position]]
    float4 color;
} RasterInput;

typedef struct {
    float brightness;
} RenderUniforms;



vertex RasterInput hello_vertex(const device VertexInput* vertex_array [[ buffer(0) ]],
                                constant RenderUniforms& uniforms [[buffer(1)]], // ch4.change.4 shader g et uniforms
                                unsigned int vid [[ vertex_id ]]) {
    RasterInput out;
    VertexInput in = vertex_array[vid];
    out.position = float4(in.position, 1.0);
    in.color = in.color + float3(uniforms.brightness);
    out.color = float4(in.color, 1.0);
    
    return out;
}
fragment half4 hello_fragment(RasterInput in [[stage_in]]) { //per-pixel input
    return half4(in.color);
}
