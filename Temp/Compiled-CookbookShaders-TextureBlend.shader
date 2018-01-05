// Compiled shader for PC, Mac & Linux Standalone

//////////////////////////////////////////////////////////////////////////
// 
// NOTE: This is *not* a valid shader file, the contents are provided just
// for information and for debugging purposes only.
// 
//////////////////////////////////////////////////////////////////////////
// Skipping shader variants that would not be included into build of current scene.

Shader "CookbookShaders/TextureBlend" {
Properties {
 _Color ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _ColorA ("Color A", Color) = (1.000000,1.000000,1.000000,1.000000)
 _ColorB ("Color B", Color) = (1.000000,1.000000,1.000000,1.000000)
 _RTex ("Red Channel Texture", 2D) = "" { }
 _GTex ("Green Channel Texture", 2D) = "" { }
 _BTex ("Blue Channel Texture", 2D) = "" { }
 _ATex ("Alpha Channel Texture", 2D) = "" { }
 _BlendTex ("Blend Texture", 2D) = "" { }
}
SubShader { 
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="FORWARDBASE" "SHADOWSUPPORT"="true" }
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Keywords set in this variant: DIRECTIONAL 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (368 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 112
  Matrix4x4 unity_WorldToObject at 176
  Matrix4x4 unity_MatrixVP at 240
  Vector4 unity_SHAr at 0
  Vector4 unity_SHAg at 16
  Vector4 unity_SHAb at 32
  Vector4 unity_SHBr at 48
  Vector4 unity_SHBg at 64
  Vector4 unity_SHBb at 80
  Vector4 unity_SHC at 96
  Vector4 _RTex_ST at 304
  Vector4 _GTex_ST at 320
  Vector4 _BTex_ST at 336
  Vector4 _BlendTex_ST at 352
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float2 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = fma(u_xlat0.x, u_xlat0.x, (-u_xlat1.x));
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(Globals.unity_SHBr, u_xlat2);
    u_xlat3.y = dot(Globals.unity_SHBg, u_xlat2);
    u_xlat3.z = dot(Globals.unity_SHBb, u_xlat2);
    u_xlat1.xyz = fma(Globals.unity_SHC.xyz, u_xlat1.xxx, u_xlat3.xyz);
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(Globals.unity_SHAr, u_xlat0);
    u_xlat2.y = dot(Globals.unity_SHAg, u_xlat0);
    u_xlat2.z = dot(Globals.unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD4.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    output.TEXCOORD5.xy = float2(0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 4
Set 2D Texture "_RTex" to slot 1
Set 2D Texture "_GTex" to slot 2
Set 2D Texture "_BTex" to slot 3
Set 3D Texture "unity_ProbeVolumeSH" to slot 4 sampler slot 0

Constant Buffer "Globals" (208 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 48
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 unity_OcclusionMaskSelector at 16
  Vector4 unity_ProbeVolumeParams at 32
  Vector3 unity_ProbeVolumeSizeInv at 112
  Vector3 unity_ProbeVolumeMin at 128
  Vector4 _LightColor0 at 144
  Vector4 _Color at 160
  Vector4 _ColorA at 176
  Vector4 _ColorB at 192
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_RTex [[ sampler (1) ]],
    sampler sampler_GTex [[ sampler (2) ]],
    sampler sampler_BTex [[ sampler (3) ]],
    sampler sampler_BlendTex [[ sampler (4) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture (4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat1.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat2.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat3.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = fma(u_xlat0.yyy, u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = fma(u_xlat0.zzz, u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat5.xyz = fma(u_xlat0.www, u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, Globals._ColorA.xyz);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * Globals._Color.xyz;
    u_xlatb15 = Globals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb15){
        u_xlatb15 = Globals.unity_ProbeVolumeParams.y==1.0;
        u_xlat1.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat1.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD3.xxx, u_xlat1.xyz);
        u_xlat1.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD3.zzz, u_xlat1.xyz);
        u_xlat1.xyz = u_xlat1.xyz + Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : input.TEXCOORD3.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-Globals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat1.yzw = u_xlat1.xyz * Globals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat15 = fma(u_xlat1.y, 0.25, 0.75);
        u_xlat6 = fma(Globals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat1.x = max(u_xlat15, u_xlat6);
        u_xlat1 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat1.xzw);
    } else {
        u_xlat1.x = float(1.0);
        u_xlat1.y = float(1.0);
        u_xlat1.z = float(1.0);
        u_xlat1.w = float(1.0);
    }
    u_xlat15 = dot(u_xlat1, Globals.unity_OcclusionMaskSelector);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat1.xyz = float3(u_xlat15) * Globals._LightColor0.xyz;
    u_xlat15 = dot(input.TEXCOORD2.xyz, Globals._WorldSpaceLightPos0.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * input.TEXCOORD4.xyz;
    output.SV_Target0.xyz = fma(u_xlat1.xyz, float3(u_xlat15), u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec2 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(unity_SHBr, u_xlat2);
    u_xlat3.y = dot(unity_SHBg, u_xlat2);
    u_xlat3.z = dot(unity_SHBb, u_xlat2);
    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(unity_SHAr, u_xlat0);
    u_xlat2.y = dot(unity_SHAg, u_xlat0);
    u_xlat2.z = dot(unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec4 u_xlat10_3;
vec3 u_xlat16_4;
vec3 u_xlat16_5;
float u_xlat6;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_1 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_3 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.zzz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb15){
        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
        u_xlat1.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat1.x = max(u_xlat15, u_xlat6);
        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
    } else {
        u_xlat1.x = float(1.0);
        u_xlat1.y = float(1.0);
        u_xlat1.z = float(1.0);
        u_xlat1.w = float(1.0);
    //ENDIF
    }
    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: DIRECTIONAL SHADOWS_SCREEN 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (336 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 80
  Matrix4x4 unity_WorldToObject at 144
  Matrix4x4 unity_MatrixVP at 208
  Vector4 _ProjectionParams at 0
  Vector4 unity_SHBr at 16
  Vector4 unity_SHBg at 32
  Vector4 unity_SHBb at 48
  Vector4 unity_SHC at 64
  Vector4 _RTex_ST at 272
  Vector4 _GTex_ST at 288
  Vector4 _BTex_ST at 304
  Vector4 _BlendTex_ST at 320
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 _ProjectionParams;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat10 = u_xlat1.y * u_xlat1.y;
    u_xlat10 = fma(u_xlat1.x, u_xlat1.x, (-u_xlat10));
    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat1.x = dot(Globals.unity_SHBr, u_xlat2);
    u_xlat1.y = dot(Globals.unity_SHBg, u_xlat2);
    u_xlat1.z = dot(Globals.unity_SHBb, u_xlat2);
    output.TEXCOORD4.xyz = fma(Globals.unity_SHC.xyz, float3(u_xlat10), u_xlat1.xyz);
    u_xlat0.y = u_xlat0.y * Globals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat0.zw;
    output.TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 5
Set 2D Texture "_RTex" to slot 1 sampler slot 2
Set 2D Texture "_GTex" to slot 2 sampler slot 3
Set 2D Texture "_BTex" to slot 3 sampler slot 4
Set 2D Texture "_ShadowMapTexture" to slot 4 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 5 sampler slot 0

Constant Buffer "Globals" (368 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 128
  Matrix4x4 unity_ProbeVolumeWorldToObject at 208
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_SHAr at 32
  Vector4 unity_SHAg at 48
  Vector4 unity_SHAb at 64
  Vector4 unity_OcclusionMaskSelector at 80
  Vector4 _LightShadowData at 96
  Vector4 unity_ShadowFadeCenterAndType at 112
  Vector4 unity_ProbeVolumeParams at 192
  Vector3 unity_ProbeVolumeSizeInv at 272
  Vector3 unity_ProbeVolumeMin at 288
  Vector4 _LightColor0 at 304
  Vector4 _Color at 320
  Vector4 _ColorA at 336
  Vector4 _ColorB at 352
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_RTex [[ sampler (2) ]],
    sampler sampler_GTex [[ sampler (3) ]],
    sampler sampler_BTex [[ sampler (4) ]],
    sampler sampler_BlendTex [[ sampler (5) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture2d<float, access::sample > _ShadowMapTexture [[ texture (4) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture (5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    bool u_xlatb1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    bool u_xlatb7;
    float u_xlat8;
    float2 u_xlat13;
    float u_xlat18;
    bool u_xlatb18;
    u_xlat0 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat1.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat2.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat3.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = fma(u_xlat0.yyy, u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = fma(u_xlat0.zzz, u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat6.xyz = fma(u_xlat0.www, u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, Globals._ColorA.xyz);
    u_xlat0.xyz = u_xlat6.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * Globals._Color.xyz;
    u_xlat1.xyz = (-input.TEXCOORD3.xyz) + Globals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat2.x = Globals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = Globals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = Globals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.xyz = input.TEXCOORD3.xyz + (-Globals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = (-u_xlat18) + u_xlat1.x;
    u_xlat18 = fma(Globals.unity_ShadowFadeCenterAndType.w, u_xlat1.x, u_xlat18);
    u_xlat18 = fma(u_xlat18, Globals._LightShadowData.z, Globals._LightShadowData.w);
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlatb1 = Globals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb1){
        u_xlatb7 = Globals.unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD3.xxx, u_xlat2.xyz);
        u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD3.zzz, u_xlat2.xyz);
        u_xlat2.xyz = u_xlat2.xyz + Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat7.xyz = (bool(u_xlatb7)) ? u_xlat2.xyz : input.TEXCOORD3.xyz;
        u_xlat7.xyz = u_xlat7.xyz + (-Globals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat7.xyz * Globals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat7.x = fma(u_xlat2.y, 0.25, 0.75);
        u_xlat13.x = fma(Globals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat2.x = max(u_xlat13.x, u_xlat7.x);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    }
    u_xlat7.x = dot(u_xlat2, Globals.unity_OcclusionMaskSelector);
    u_xlat7.x = clamp(u_xlat7.x, 0.0f, 1.0f);
    u_xlat13.xy = input.TEXCOORD5.xy / input.TEXCOORD5.ww;
    u_xlat13.x = _ShadowMapTexture.sample(sampler_ShadowMapTexture, u_xlat13.xy).x;
    u_xlat18 = u_xlat18 + u_xlat13.x;
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat7.x = min(u_xlat18, u_xlat7.x);
    u_xlat18 = (u_xlatb1) ? u_xlat7.x : u_xlat18;
    u_xlat7.xyz = float3(u_xlat18) * Globals._LightColor0.xyz;
    if(u_xlatb1){
        u_xlatb18 = Globals.unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD3.xxx, u_xlat2.xyz);
        u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD3.zzz, u_xlat2.xyz);
        u_xlat2.xyz = u_xlat2.xyz + Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : input.TEXCOORD3.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-Globals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * Globals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat18 = u_xlat2.y * 0.25;
        u_xlat1.x = Globals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat8 = fma((-Globals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat18 = max(u_xlat18, u_xlat1.x);
        u_xlat2.x = min(u_xlat8, u_xlat18);
        u_xlat3 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
        u_xlat4.xyz = u_xlat2.xzw + float3(0.25, 0.0, 0.0);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xyz);
        u_xlat2.xyz = u_xlat2.xzw + float3(0.5, 0.0, 0.0);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xyz);
        u_xlat5.xyz = input.TEXCOORD2.xyz;
        u_xlat5.w = 1.0;
        u_xlat3.x = dot(u_xlat3, u_xlat5);
        u_xlat3.y = dot(u_xlat4, u_xlat5);
        u_xlat3.z = dot(u_xlat2, u_xlat5);
    } else {
        u_xlat2.xyz = input.TEXCOORD2.xyz;
        u_xlat2.w = 1.0;
        u_xlat3.x = dot(Globals.unity_SHAr, u_xlat2);
        u_xlat3.y = dot(Globals.unity_SHAg, u_xlat2);
        u_xlat3.z = dot(Globals.unity_SHAb, u_xlat2);
    }
    u_xlat2.xyz = u_xlat3.xyz + input.TEXCOORD4.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat18 = dot(input.TEXCOORD2.xyz, Globals._WorldSpaceLightPos0.xyz);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat1.xyz, float3(u_xlat18), u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec4 vs_TEXCOORD5;
out vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat10 = u_xlat1.y * u_xlat1.y;
    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat1.x = dot(unity_SHBr, u_xlat2);
    u_xlat1.y = dot(unity_SHBg, u_xlat2);
    u_xlat1.z = dot(unity_SHBb, u_xlat2);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat0.zw;
    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler2D _ShadowMapTexture;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
in  vec4 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat16_4;
vec4 u_xlat10_4;
vec4 u_xlat5;
vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat8;
vec2 u_xlat13;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat10_0 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_1 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_3 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.zzz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = (-u_xlat18) + u_xlat1.x;
    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat18;
    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb1){
        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat7.xyz = (bool(u_xlatb7)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat2.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat7.x = u_xlat2.y * 0.25 + 0.75;
        u_xlat13.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat2.x = max(u_xlat13.x, u_xlat7.x);
        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    //ENDIF
    }
    u_xlat7.x = dot(u_xlat2, unity_OcclusionMaskSelector);
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat13.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_ShadowMapTexture, u_xlat13.xy);
    u_xlat18 = u_xlat18 + u_xlat10_2.x;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat7.x = min(u_xlat18, u_xlat7.x);
    u_xlat18 = (u_xlatb1) ? u_xlat7.x : u_xlat18;
    u_xlat7.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    if(u_xlatb1){
        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat18 = u_xlat2.y * 0.25;
        u_xlat1.x = unity_ProbeVolumeParams.z * 0.5;
        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
        u_xlat18 = max(u_xlat18, u_xlat1.x);
        u_xlat2.x = min(u_xlat8, u_xlat18);
        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
        u_xlat5.xyz = vs_TEXCOORD2.xyz;
        u_xlat5.w = 1.0;
        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
    } else {
        u_xlat2.xyz = vs_TEXCOORD2.xyz;
        u_xlat2.w = 1.0;
        u_xlat3.x = dot(unity_SHAr, u_xlat2);
        u_xlat3.y = dot(unity_SHAg, u_xlat2);
        u_xlat3.z = dot(unity_SHAb, u_xlat2);
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD4.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat18 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: DIRECTIONAL VERTEXLIGHT_ON 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (560 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 304
  Matrix4x4 unity_WorldToObject at 368
  Matrix4x4 unity_MatrixVP at 432
  Vector4 unity_4LightPosX0 at 0
  Vector4 unity_4LightPosY0 at 16
  Vector4 unity_4LightPosZ0 at 32
  Vector4 unity_4LightAtten0 at 48
  Vector4 unity_LightColor[8] at 64
  Vector4 unity_SHAr at 192
  Vector4 unity_SHAg at 208
  Vector4 unity_SHAb at 224
  Vector4 unity_SHBr at 240
  Vector4 unity_SHBg at 256
  Vector4 unity_SHBb at 272
  Vector4 unity_SHC at 288
  Vector4 _RTex_ST at 496
  Vector4 _GTex_ST at 512
  Vector4 _BTex_ST at 528
  Vector4 _BlendTex_ST at 544
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 unity_4LightPosX0;
    float4 unity_4LightPosY0;
    float4 unity_4LightPosZ0;
    float4 unity_4LightAtten0;
    float4 unity_LightColor[8];
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float2 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat1.xyz = float3(u_xlat18) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = u_xlat1.xyz;
    output.TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat18 = u_xlat1.y * u_xlat1.y;
    u_xlat18 = fma(u_xlat1.x, u_xlat1.x, (-u_xlat18));
    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat3.x = dot(Globals.unity_SHBr, u_xlat2);
    u_xlat3.y = dot(Globals.unity_SHBg, u_xlat2);
    u_xlat3.z = dot(Globals.unity_SHBb, u_xlat2);
    u_xlat2.xyz = fma(Globals.unity_SHC.xyz, float3(u_xlat18), u_xlat3.xyz);
    u_xlat1.w = 1.0;
    u_xlat3.x = dot(Globals.unity_SHAr, u_xlat1);
    u_xlat3.y = dot(Globals.unity_SHAg, u_xlat1);
    u_xlat3.z = dot(Globals.unity_SHAb, u_xlat1);
    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat3 = (-u_xlat0.yyyy) + Globals.unity_4LightPosY0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat5 = (-u_xlat0.xxxx) + Globals.unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + Globals.unity_4LightPosZ0;
    u_xlat4 = fma(u_xlat5, u_xlat1.xxxx, u_xlat4);
    u_xlat1 = fma(u_xlat0, u_xlat1.zzzz, u_xlat4);
    u_xlat3 = fma(u_xlat5, u_xlat5, u_xlat3);
    u_xlat0 = fma(u_xlat0, u_xlat0, u_xlat3);
    u_xlat0 = max(u_xlat0, float4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = rsqrt(u_xlat0);
    u_xlat0 = fma(u_xlat0, Globals.unity_4LightAtten0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlat0 = float4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * Globals.unity_LightColor[1].xyz;
    u_xlat1.xyz = fma(Globals.unity_LightColor[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(Globals.unity_LightColor[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(Globals.unity_LightColor[3].xyz, u_xlat0.www, u_xlat0.xyz);
    output.TEXCOORD4.xyz = u_xlat2.xyz + u_xlat0.xyz;
    output.TEXCOORD5.xy = float2(0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec2 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat18 = u_xlat1.y * u_xlat1.y;
    u_xlat18 = u_xlat1.x * u_xlat1.x + (-u_xlat18);
    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat3.x = dot(unity_SHBr, u_xlat2);
    u_xlat3.y = dot(unity_SHBg, u_xlat2);
    u_xlat3.z = dot(unity_SHBb, u_xlat2);
    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
    u_xlat1.w = 1.0;
    u_xlat3.x = dot(unity_SHAr, u_xlat1);
    u_xlat3.y = dot(unity_SHAg, u_xlat1);
    u_xlat3.z = dot(unity_SHAb, u_xlat1);
    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat4;
    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat3;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat2.xyz + u_xlat0.xyz;
    vs_TEXCOORD5.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec4 u_xlat10_3;
vec3 u_xlat16_4;
vec3 u_xlat16_5;
float u_xlat6;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_1 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_3 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.zzz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb15){
        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
        u_xlat1.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat1.x = max(u_xlat15, u_xlat6);
        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
    } else {
        u_xlat1.x = float(1.0);
        u_xlat1.y = float(1.0);
        u_xlat1.z = float(1.0);
        u_xlat1.w = float(1.0);
    //ENDIF
    }
    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD4.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Keywords set in this variant: DIRECTIONAL SHADOWS_SCREEN VERTEXLIGHT_ON 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (528 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 272
  Matrix4x4 unity_WorldToObject at 336
  Matrix4x4 unity_MatrixVP at 400
  Vector4 _ProjectionParams at 0
  Vector4 unity_4LightPosX0 at 16
  Vector4 unity_4LightPosY0 at 32
  Vector4 unity_4LightPosZ0 at 48
  Vector4 unity_4LightAtten0 at 64
  Vector4 unity_LightColor[8] at 80
  Vector4 unity_SHBr at 208
  Vector4 unity_SHBg at 224
  Vector4 unity_SHBb at 240
  Vector4 unity_SHC at 256
  Vector4 _RTex_ST at 464
  Vector4 _GTex_ST at 480
  Vector4 _BTex_ST at 496
  Vector4 _BlendTex_ST at 512
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 _ProjectionParams;
    float4 unity_4LightPosX0;
    float4 unity_4LightPosY0;
    float4 unity_4LightPosZ0;
    float4 unity_4LightAtten0;
    float4 unity_LightColor[8];
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD7 [[ user(TEXCOORD7) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xyz = float3(u_xlat18) * u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat2.xyz;
    output.TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3 = (-u_xlat0.xxxx) + Globals.unity_4LightPosX0;
    u_xlat4 = (-u_xlat0.yyyy) + Globals.unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + Globals.unity_4LightPosZ0;
    u_xlat5 = u_xlat2.yyyy * u_xlat4;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat4 = fma(u_xlat3, u_xlat3, u_xlat4);
    u_xlat3 = fma(u_xlat3, u_xlat2.xxxx, u_xlat5);
    u_xlat3 = fma(u_xlat0, u_xlat2.zzzz, u_xlat3);
    u_xlat0 = fma(u_xlat0, u_xlat0, u_xlat4);
    u_xlat0 = max(u_xlat0, float4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat4 = rsqrt(u_xlat0);
    u_xlat0 = fma(u_xlat0, Globals.unity_4LightAtten0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlat0 = float4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat3 = u_xlat3 * u_xlat4;
    u_xlat3 = max(u_xlat3, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat3.xyz = u_xlat0.yyy * Globals.unity_LightColor[1].xyz;
    u_xlat3.xyz = fma(Globals.unity_LightColor[0].xyz, u_xlat0.xxx, u_xlat3.xyz);
    u_xlat0.xyz = fma(Globals.unity_LightColor[2].xyz, u_xlat0.zzz, u_xlat3.xyz);
    u_xlat0.xyz = fma(Globals.unity_LightColor[3].xyz, u_xlat0.www, u_xlat0.xyz);
    u_xlat3.xyz = fma(u_xlat0.xyz, float3(0.305306017, 0.305306017, 0.305306017), float3(0.682171106, 0.682171106, 0.682171106));
    u_xlat3.xyz = fma(u_xlat0.xyz, u_xlat3.xyz, float3(0.0125228781, 0.0125228781, 0.0125228781));
    u_xlat18 = u_xlat2.y * u_xlat2.y;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, (-u_xlat18));
    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat4.x = dot(Globals.unity_SHBr, u_xlat2);
    u_xlat4.y = dot(Globals.unity_SHBg, u_xlat2);
    u_xlat4.z = dot(Globals.unity_SHBb, u_xlat2);
    u_xlat2.xyz = fma(Globals.unity_SHC.xyz, float3(u_xlat18), u_xlat4.xyz);
    output.TEXCOORD4.xyz = fma(u_xlat0.xyz, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat0.x = u_xlat1.y * Globals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat1.zw;
    output.TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD7 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec3 vs_TEXCOORD4;
out vec4 vs_TEXCOORD5;
out vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    vs_TEXCOORD2.xyz = u_xlat2.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat5 = u_xlat2.yyyy * u_xlat4;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat4 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat3 = u_xlat3 * u_xlat4;
    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
    u_xlat18 = u_xlat2.y * u_xlat2.y;
    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat4.x = dot(unity_SHBr, u_xlat2);
    u_xlat4.y = dot(unity_SHBg, u_xlat2);
    u_xlat4.z = dot(unity_SHBb, u_xlat2);
    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD5.zw = u_xlat1.zw;
    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler2D _ShadowMapTexture;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD4;
in  vec4 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec3 u_xlat3;
vec4 u_xlat10_3;
vec3 u_xlat4;
vec3 u_xlat16_4;
vec4 u_xlat10_4;
vec4 u_xlat5;
vec3 u_xlat16_6;
vec3 u_xlat7;
bool u_xlatb7;
float u_xlat8;
vec2 u_xlat13;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlat10_0 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_1 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_3 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.zzz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_6.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.xyz = vs_TEXCOORD3.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = (-u_xlat18) + u_xlat1.x;
    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat18;
    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb1){
        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat7.xyz = (bool(u_xlatb7)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat2.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat7.x = u_xlat2.y * 0.25 + 0.75;
        u_xlat13.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat2.x = max(u_xlat13.x, u_xlat7.x);
        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    //ENDIF
    }
    u_xlat7.x = dot(u_xlat2, unity_OcclusionMaskSelector);
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat13.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
    u_xlat10_2 = texture(_ShadowMapTexture, u_xlat13.xy);
    u_xlat18 = u_xlat18 + u_xlat10_2.x;
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat7.x = min(u_xlat18, u_xlat7.x);
    u_xlat18 = (u_xlatb1) ? u_xlat7.x : u_xlat18;
    u_xlat7.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    if(u_xlatb1){
        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat18 = u_xlat2.y * 0.25;
        u_xlat1.x = unity_ProbeVolumeParams.z * 0.5;
        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
        u_xlat18 = max(u_xlat18, u_xlat1.x);
        u_xlat2.x = min(u_xlat8, u_xlat18);
        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
        u_xlat5.xyz = vs_TEXCOORD2.xyz;
        u_xlat5.w = 1.0;
        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
    } else {
        u_xlat2.xyz = vs_TEXCOORD2.xyz;
        u_xlat2.w = 1.0;
        u_xlat3.x = dot(unity_SHAr, u_xlat2);
        u_xlat3.y = dot(unity_SHAg, u_xlat2);
        u_xlat3.z = dot(unity_SHAb, u_xlat2);
    //ENDIF
    }
    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD4.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat18 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="FORWARDADD" }
  ZWrite Off
  Blend One One
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Keywords set in this variant: POINT 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (256 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _RTex_ST at 192
  Vector4 _GTex_ST at 208
  Vector4 _BTex_ST at 224
  Vector4 _BlendTex_ST at 240
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float2 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD2.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4.xy = float2(0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 5
Set 2D Texture "_RTex" to slot 1 sampler slot 2
Set 2D Texture "_GTex" to slot 2 sampler slot 3
Set 2D Texture "_BTex" to slot 3 sampler slot 4
Set 2D Texture "_LightTexture0" to slot 4 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 5 sampler slot 0

Constant Buffer "Globals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 48
  Matrix4x4 unity_WorldToLight at 160
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 unity_OcclusionMaskSelector at 16
  Vector4 unity_ProbeVolumeParams at 32
  Vector3 unity_ProbeVolumeSizeInv at 112
  Vector3 unity_ProbeVolumeMin at 128
  Vector4 _LightColor0 at 144
  Vector4 _Color at 224
  Vector4 _ColorA at 240
  Vector4 _ColorB at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_LightTexture0 [[ sampler (1) ]],
    sampler sampler_RTex [[ sampler (2) ]],
    sampler sampler_GTex [[ sampler (3) ]],
    sampler sampler_BTex [[ sampler (4) ]],
    sampler sampler_BlendTex [[ sampler (5) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture (4) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture (5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    u_xlat0.xyz = (-input.TEXCOORD3.xyz) + Globals._WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat1 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat2.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat4.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat2.xyz = fma(u_xlat1.yyy, u_xlat5.xyz, u_xlat2.xyz);
    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat2.xyz = fma(u_xlat1.zzz, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat7.xyz = fma(u_xlat1.www, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat2.xyz = fma(u_xlat1.xxx, u_xlat2.xyz, Globals._ColorA.xyz);
    u_xlat1.xyz = u_xlat7.xyz * u_xlat2.xyz;
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0f, 1.0f);
    u_xlat1.xyz = u_xlat1.xyz * Globals._Color.xyz;
    u_xlat2.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, input.TEXCOORD3.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, input.TEXCOORD3.zzz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz + Globals.hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlatb18 = Globals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = Globals.unity_ProbeVolumeParams.y==1.0;
        u_xlat3.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat3.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD3.xxx, u_xlat3.xyz);
        u_xlat3.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD3.zzz, u_xlat3.xyz);
        u_xlat3.xyz = u_xlat3.xyz + Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : input.TEXCOORD3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-Globals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat3.yzw = u_xlat3.xyz * Globals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat18 = fma(u_xlat3.y, 0.25, 0.75);
        u_xlat19 = fma(Globals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat3.x = max(u_xlat18, u_xlat19);
        u_xlat3 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat3.xzw);
    } else {
        u_xlat3.x = float(1.0);
        u_xlat3.y = float(1.0);
        u_xlat3.z = float(1.0);
        u_xlat3.w = float(1.0);
    }
    u_xlat18 = dot(u_xlat3, Globals.unity_OcclusionMaskSelector);
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = _LightTexture0.sample(sampler_LightTexture0, float2(u_xlat19)).x;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat2.xyz = float3(u_xlat18) * Globals._LightColor0.xyz;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler2D _LightTexture0;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec4 u_xlat3;
vec3 u_xlat16_3;
vec4 u_xlat10_3;
vec4 u_xlat10_4;
vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat16_7;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat10_1 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_2 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_4 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat10_4.xyz;
    u_xlat16_7.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat2.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _ColorA.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * u_xlat2.xyz;
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * _Color.xyz;
    u_xlat2.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
        u_xlat3.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat3.x = max(u_xlat18, u_xlat19);
        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
    } else {
        u_xlat3.x = float(1.0);
        u_xlat3.y = float(1.0);
        u_xlat3.z = float(1.0);
        u_xlat3.w = float(1.0);
    //ENDIF
    }
    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10_2 = texture(_LightTexture0, vec2(u_xlat19));
    u_xlat18 = u_xlat18 * u_xlat10_2.w;
    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (256 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _RTex_ST at 192
  Vector4 _GTex_ST at 208
  Vector4 _BTex_ST at 224
  Vector4 _BlendTex_ST at 240
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float2 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD2.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4.xy = float2(0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 4
Set 2D Texture "_RTex" to slot 1
Set 2D Texture "_GTex" to slot 2
Set 2D Texture "_BTex" to slot 3
Set 3D Texture "unity_ProbeVolumeSH" to slot 4 sampler slot 0

Constant Buffer "Globals" (208 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 48
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 unity_OcclusionMaskSelector at 16
  Vector4 unity_ProbeVolumeParams at 32
  Vector3 unity_ProbeVolumeSizeInv at 112
  Vector3 unity_ProbeVolumeMin at 128
  Vector4 _LightColor0 at 144
  Vector4 _Color at 160
  Vector4 _ColorA at 176
  Vector4 _ColorB at 192
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_RTex [[ sampler (1) ]],
    sampler sampler_GTex [[ sampler (2) ]],
    sampler sampler_BTex [[ sampler (3) ]],
    sampler sampler_BlendTex [[ sampler (4) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture (4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float u_xlat6;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat1.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat2.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat3.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = fma(u_xlat0.yyy, u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = fma(u_xlat0.zzz, u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat5.xyz = fma(u_xlat0.www, u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, Globals._ColorA.xyz);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * Globals._Color.xyz;
    u_xlatb15 = Globals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb15){
        u_xlatb15 = Globals.unity_ProbeVolumeParams.y==1.0;
        u_xlat1.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat1.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD3.xxx, u_xlat1.xyz);
        u_xlat1.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD3.zzz, u_xlat1.xyz);
        u_xlat1.xyz = u_xlat1.xyz + Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : input.TEXCOORD3.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-Globals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat1.yzw = u_xlat1.xyz * Globals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat15 = fma(u_xlat1.y, 0.25, 0.75);
        u_xlat6 = fma(Globals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat1.x = max(u_xlat15, u_xlat6);
        u_xlat1 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat1.xzw);
    } else {
        u_xlat1.x = float(1.0);
        u_xlat1.y = float(1.0);
        u_xlat1.z = float(1.0);
        u_xlat1.w = float(1.0);
    }
    u_xlat15 = dot(u_xlat1, Globals.unity_OcclusionMaskSelector);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat1.xyz = float3(u_xlat15) * Globals._LightColor0.xyz;
    u_xlat15 = dot(input.TEXCOORD2.xyz, Globals._WorldSpaceLightPos0.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    output.SV_Target0.xyz = float3(u_xlat15) * u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec4 u_xlat10_3;
vec3 u_xlat16_4;
vec3 u_xlat16_5;
float u_xlat6;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_1 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_3 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.zzz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb15){
        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
        u_xlat1.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD3.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat15 = u_xlat1.y * 0.25 + 0.75;
        u_xlat6 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat1.x = max(u_xlat15, u_xlat6);
        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
    } else {
        u_xlat1.x = float(1.0);
        u_xlat1.y = float(1.0);
        u_xlat1.z = float(1.0);
        u_xlat1.w = float(1.0);
    //ENDIF
    }
    u_xlat15 = dot(u_xlat1, unity_OcclusionMaskSelector);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (256 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _RTex_ST at 192
  Vector4 _GTex_ST at 208
  Vector4 _BTex_ST at 224
  Vector4 _BlendTex_ST at 240
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float2 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD2.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4.xy = float2(0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 6
Set 2D Texture "_RTex" to slot 1 sampler slot 3
Set 2D Texture "_GTex" to slot 2 sampler slot 4
Set 2D Texture "_BTex" to slot 3 sampler slot 5
Set 2D Texture "_LightTexture0" to slot 4 sampler slot 1
Set 2D Texture "_LightTextureB0" to slot 5 sampler slot 2
Set 3D Texture "unity_ProbeVolumeSH" to slot 6 sampler slot 0

Constant Buffer "Globals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 48
  Matrix4x4 unity_WorldToLight at 160
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 unity_OcclusionMaskSelector at 16
  Vector4 unity_ProbeVolumeParams at 32
  Vector3 unity_ProbeVolumeSizeInv at 112
  Vector3 unity_ProbeVolumeMin at 128
  Vector4 _LightColor0 at 144
  Vector4 _Color at 224
  Vector4 _ColorA at 240
  Vector4 _ColorB at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_LightTexture0 [[ sampler (1) ]],
    sampler sampler_LightTextureB0 [[ sampler (2) ]],
    sampler sampler_RTex [[ sampler (3) ]],
    sampler sampler_GTex [[ sampler (4) ]],
    sampler sampler_BTex [[ sampler (5) ]],
    sampler sampler_BlendTex [[ sampler (6) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture (4) ]] ,
    texture2d<float, access::sample > _LightTextureB0 [[ texture (5) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture (6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    bool u_xlatb19;
    float u_xlat20;
    u_xlat0.xyz = (-input.TEXCOORD3.xyz) + Globals._WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat1 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat2.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat4.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat2.xyz = fma(u_xlat1.yyy, u_xlat5.xyz, u_xlat2.xyz);
    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat2.xyz = fma(u_xlat1.zzz, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat7.xyz = fma(u_xlat1.www, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat2.xyz = fma(u_xlat1.xxx, u_xlat2.xyz, Globals._ColorA.xyz);
    u_xlat1.xyz = u_xlat7.xyz * u_xlat2.xyz;
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0f, 1.0f);
    u_xlat1.xyz = u_xlat1.xyz * Globals._Color.xyz;
    u_xlat2 = input.TEXCOORD3.yyyy * Globals.hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat2 = fma(Globals.hlslcc_mtx4x4unity_WorldToLight[0], input.TEXCOORD3.xxxx, u_xlat2);
    u_xlat2 = fma(Globals.hlslcc_mtx4x4unity_WorldToLight[2], input.TEXCOORD3.zzzz, u_xlat2);
    u_xlat2 = u_xlat2 + Globals.hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlatb18 = Globals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = Globals.unity_ProbeVolumeParams.y==1.0;
        u_xlat3.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat3.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD3.xxx, u_xlat3.xyz);
        u_xlat3.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD3.zzz, u_xlat3.xyz);
        u_xlat3.xyz = u_xlat3.xyz + Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : input.TEXCOORD3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-Globals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat3.yzw = u_xlat3.xyz * Globals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat18 = fma(u_xlat3.y, 0.25, 0.75);
        u_xlat19 = fma(Globals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat3.x = max(u_xlat18, u_xlat19);
        u_xlat3 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat3.xzw);
    } else {
        u_xlat3.x = float(1.0);
        u_xlat3.y = float(1.0);
        u_xlat3.z = float(1.0);
        u_xlat3.w = float(1.0);
    }
    u_xlat18 = dot(u_xlat3, Globals.unity_OcclusionMaskSelector);
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlatb19 = 0.0<u_xlat2.z;
    u_xlat19 = u_xlatb19 ? 1.0 : float(0.0);
    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
    u_xlat3.xy = u_xlat3.xy + float2(0.5, 0.5);
    u_xlat20 = _LightTexture0.sample(sampler_LightTexture0, u_xlat3.xy).w;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = _LightTextureB0.sample(sampler_LightTextureB0, u_xlat2.xx).x;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat2.xyz = float3(u_xlat18) * Globals._LightColor0.xyz;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler2D _LightTexture0;
uniform  sampler2D _LightTextureB0;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec4 u_xlat3;
vec3 u_xlat16_3;
vec4 u_xlat10_3;
vec4 u_xlat10_4;
vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat16_7;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat10_1 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_2 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_4 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat10_4.xyz;
    u_xlat16_7.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat2.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _ColorA.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * u_xlat2.xyz;
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * _Color.xyz;
    u_xlat2 = vs_TEXCOORD3.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat2 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD3.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
        u_xlat3.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat3.x = max(u_xlat18, u_xlat19);
        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
    } else {
        u_xlat3.x = float(1.0);
        u_xlat3.y = float(1.0);
        u_xlat3.z = float(1.0);
        u_xlat3.w = float(1.0);
    //ENDIF
    }
    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlatb19 = 0.0<u_xlat2.z;
    u_xlat19 = u_xlatb19 ? 1.0 : float(0.0);
    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat10_3 = texture(_LightTexture0, u_xlat3.xy);
    u_xlat19 = u_xlat19 * u_xlat10_3.w;
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10_2 = texture(_LightTextureB0, u_xlat2.xx);
    u_xlat19 = u_xlat19 * u_xlat10_2.w;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: POINT_COOKIE 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (256 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _RTex_ST at 192
  Vector4 _GTex_ST at 208
  Vector4 _BTex_ST at 224
  Vector4 _BlendTex_ST at 240
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float2 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD2.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4.xy = float2(0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 6
Set 2D Texture "_RTex" to slot 1 sampler slot 3
Set 2D Texture "_GTex" to slot 2 sampler slot 4
Set 2D Texture "_BTex" to slot 3 sampler slot 5
Set 2D Texture "_LightTextureB0" to slot 4 sampler slot 2
Set CUBE Texture "_LightTexture0" to slot 5 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 6 sampler slot 0

Constant Buffer "Globals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 48
  Matrix4x4 unity_WorldToLight at 160
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 unity_OcclusionMaskSelector at 16
  Vector4 unity_ProbeVolumeParams at 32
  Vector3 unity_ProbeVolumeSizeInv at 112
  Vector3 unity_ProbeVolumeMin at 128
  Vector4 _LightColor0 at 144
  Vector4 _Color at 224
  Vector4 _ColorA at 240
  Vector4 _ColorB at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_LightTexture0 [[ sampler (1) ]],
    sampler sampler_LightTextureB0 [[ sampler (2) ]],
    sampler sampler_RTex [[ sampler (3) ]],
    sampler sampler_GTex [[ sampler (4) ]],
    sampler sampler_BTex [[ sampler (5) ]],
    sampler sampler_BlendTex [[ sampler (6) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture2d<float, access::sample > _LightTextureB0 [[ texture (4) ]] ,
    texturecube<float, access::sample > _LightTexture0 [[ texture (5) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture (6) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float4 u_xlat1;
    float3 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    u_xlat0.xyz = (-input.TEXCOORD3.xyz) + Globals._WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat1 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat2.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat4.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat5.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat2.xyz = fma(u_xlat1.yyy, u_xlat5.xyz, u_xlat2.xyz);
    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
    u_xlat2.xyz = fma(u_xlat1.zzz, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat3.xyz = (-u_xlat2.xyz) + u_xlat4.xyz;
    u_xlat7.xyz = fma(u_xlat1.www, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat2.xyz = fma(u_xlat1.xxx, u_xlat2.xyz, Globals._ColorA.xyz);
    u_xlat1.xyz = u_xlat7.xyz * u_xlat2.xyz;
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0f, 1.0f);
    u_xlat1.xyz = u_xlat1.xyz * Globals._Color.xyz;
    u_xlat2.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, input.TEXCOORD3.xxx, u_xlat2.xyz);
    u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, input.TEXCOORD3.zzz, u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz + Globals.hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlatb18 = Globals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = Globals.unity_ProbeVolumeParams.y==1.0;
        u_xlat3.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat3.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD3.xxx, u_xlat3.xyz);
        u_xlat3.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD3.zzz, u_xlat3.xyz);
        u_xlat3.xyz = u_xlat3.xyz + Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : input.TEXCOORD3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-Globals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat3.yzw = u_xlat3.xyz * Globals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat18 = fma(u_xlat3.y, 0.25, 0.75);
        u_xlat19 = fma(Globals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat3.x = max(u_xlat18, u_xlat19);
        u_xlat3 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat3.xzw);
    } else {
        u_xlat3.x = float(1.0);
        u_xlat3.y = float(1.0);
        u_xlat3.z = float(1.0);
        u_xlat3.w = float(1.0);
    }
    u_xlat18 = dot(u_xlat3, Globals.unity_OcclusionMaskSelector);
    u_xlat18 = clamp(u_xlat18, 0.0f, 1.0f);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = _LightTextureB0.sample(sampler_LightTextureB0, float2(u_xlat19)).x;
    u_xlat2.x = _LightTexture0.sample(sampler_LightTexture0, u_xlat2.xyz).w;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat2.xyz = float3(u_xlat18) * Globals._LightColor0.xyz;
    u_xlat0.x = dot(input.TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler2D _LightTextureB0;
uniform  samplerCube _LightTexture0;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat10_1;
vec3 u_xlat2;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec4 u_xlat3;
vec3 u_xlat16_3;
vec4 u_xlat10_3;
vec4 u_xlat10_4;
vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat16_7;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
float u_xlat16_19;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat10_1 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_2 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_4 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat10_3.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat10_4.xyz;
    u_xlat16_7.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat2.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat2.xyz = u_xlat10_1.xxx * u_xlat2.xyz + _ColorA.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * u_xlat2.xyz;
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * _Color.xyz;
    u_xlat2.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
        u_xlat3.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat3.x = max(u_xlat18, u_xlat19);
        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
    } else {
        u_xlat3.x = float(1.0);
        u_xlat3.y = float(1.0);
        u_xlat3.z = float(1.0);
        u_xlat3.w = float(1.0);
    //ENDIF
    }
    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10_3 = texture(_LightTextureB0, vec2(u_xlat19));
    u_xlat10_2 = texture(_LightTexture0, u_xlat2.xyz);
    u_xlat16_19 = u_xlat10_2.w * u_xlat10_3.w;
    u_xlat18 = u_xlat18 * u_xlat16_19;
    u_xlat2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat6.xyz = u_xlat1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (256 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _RTex_ST at 192
  Vector4 _GTex_ST at 208
  Vector4 _BTex_ST at 224
  Vector4 _BlendTex_ST at 240
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float2 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD2.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4.xy = float2(0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 5
Set 2D Texture "_RTex" to slot 1 sampler slot 2
Set 2D Texture "_GTex" to slot 2 sampler slot 3
Set 2D Texture "_BTex" to slot 3 sampler slot 4
Set 2D Texture "_LightTexture0" to slot 4 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 5 sampler slot 0

Constant Buffer "Globals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 48
  Matrix4x4 unity_WorldToLight at 160
  Vector4 _WorldSpaceLightPos0 at 0
  Vector4 unity_OcclusionMaskSelector at 16
  Vector4 unity_ProbeVolumeParams at 32
  Vector3 unity_ProbeVolumeSizeInv at 112
  Vector3 unity_ProbeVolumeMin at 128
  Vector4 _LightColor0 at 144
  Vector4 _Color at 224
  Vector4 _ColorA at 240
  Vector4 _ColorB at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_LightTexture0 [[ sampler (1) ]],
    sampler sampler_RTex [[ sampler (2) ]],
    sampler sampler_GTex [[ sampler (3) ]],
    sampler sampler_BTex [[ sampler (4) ]],
    sampler sampler_BlendTex [[ sampler (5) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture (4) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture (5) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float u_xlat11;
    float u_xlat15;
    bool u_xlatb15;
    u_xlat0 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat1.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat2.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat3.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = fma(u_xlat0.yyy, u_xlat4.xyz, u_xlat1.xyz);
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat2.xyz;
    u_xlat1.xyz = fma(u_xlat0.zzz, u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = (-u_xlat1.xyz) + u_xlat3.xyz;
    u_xlat5.xyz = fma(u_xlat0.www, u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat1.xyz = fma(u_xlat0.xxx, u_xlat1.xyz, Globals._ColorA.xyz);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * Globals._Color.xyz;
    u_xlat1.xy = input.TEXCOORD3.yy * Globals.hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat1.xy = fma(Globals.hlslcc_mtx4x4unity_WorldToLight[0].xy, input.TEXCOORD3.xx, u_xlat1.xy);
    u_xlat1.xy = fma(Globals.hlslcc_mtx4x4unity_WorldToLight[2].xy, input.TEXCOORD3.zz, u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + Globals.hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlatb15 = Globals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb15){
        u_xlatb15 = Globals.unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = input.TEXCOORD3.yyy * Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD3.xxx, u_xlat2.xyz);
        u_xlat2.xyz = fma(Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD3.zzz, u_xlat2.xyz);
        u_xlat2.xyz = u_xlat2.xyz + Globals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : input.TEXCOORD3.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-Globals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * Globals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat15 = fma(u_xlat2.y, 0.25, 0.75);
        u_xlat11 = fma(Globals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat2.x = max(u_xlat15, u_xlat11);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    }
    u_xlat15 = dot(u_xlat2, Globals.unity_OcclusionMaskSelector);
    u_xlat15 = clamp(u_xlat15, 0.0f, 1.0f);
    u_xlat1.x = _LightTexture0.sample(sampler_LightTexture0, u_xlat1.xy).w;
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.xyz = float3(u_xlat15) * Globals._LightColor0.xyz;
    u_xlat15 = dot(input.TEXCOORD2.xyz, Globals._WorldSpaceLightPos0.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    output.SV_Target0.xyz = float3(u_xlat15) * u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.xy = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_OcclusionMaskSelector;
uniform 	vec4 unity_ProbeVolumeParams;
uniform 	vec4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
uniform 	vec3 unity_ProbeVolumeSizeInv;
uniform 	vec3 unity_ProbeVolumeMin;
uniform 	vec4 _LightColor0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler2D _LightTexture0;
uniform  sampler3D unity_ProbeVolumeSH;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
vec4 u_xlat2;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec4 u_xlat10_3;
vec3 u_xlat16_4;
vec3 u_xlat16_5;
float u_xlat11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat10_0 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat10_1 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_3 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat16_4.xyz = (-u_xlat10_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.yyy * u_xlat16_4.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_0.zzz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat10_3.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_0.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD3.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD3.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD3.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb15){
        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = vs_TEXCOORD3.yyy * hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD3.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.zzz + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb15)) ? u_xlat2.xyz : vs_TEXCOORD3.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
        u_xlat15 = u_xlat2.y * 0.25 + 0.75;
        u_xlat11 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
        u_xlat2.x = max(u_xlat15, u_xlat11);
        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    //ENDIF
    }
    u_xlat15 = dot(u_xlat2, unity_OcclusionMaskSelector);
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
    u_xlat10_1 = texture(_LightTexture0, u_xlat1.xy);
    u_xlat15 = u_xlat15 * u_xlat10_1.w;
    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
    u_xlat15 = dot(vs_TEXCOORD2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat15 = max(u_xlat15, 0.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PREPASSBASE" }
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
No keywords set in this variant.
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"

Constant Buffer "Globals" (192 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD1.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    return output;
}


-- Fragment shader for "metal":
Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Mtl_FragmentIn
{
    float3 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    output.SV_Target0.xyz = fma(input.TEXCOORD0.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target0.w = 0.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
out vec3 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

in  vec3 vs_TEXCOORD0;
layout(location = 0) out vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PREPASSFINAL" }
  ZWrite Off
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
No keywords set in this variant.
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (384 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 128
  Matrix4x4 unity_WorldToObject at 192
  Matrix4x4 unity_MatrixVP at 256
  Vector4 _ProjectionParams at 0
  Vector4 unity_SHAr at 16
  Vector4 unity_SHAg at 32
  Vector4 unity_SHAb at 48
  Vector4 unity_SHBr at 64
  Vector4 unity_SHBg at 80
  Vector4 unity_SHBb at 96
  Vector4 unity_SHC at 112
  Vector4 _RTex_ST at 320
  Vector4 _GTex_ST at 336
  Vector4 _BTex_ST at 352
  Vector4 _BlendTex_ST at 368
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 _ProjectionParams;
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.y = u_xlat0.y * Globals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD3.zw = u_xlat0.zw;
    output.TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = fma(u_xlat0.x, u_xlat0.x, (-u_xlat1.x));
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(Globals.unity_SHBr, u_xlat2);
    u_xlat3.y = dot(Globals.unity_SHBg, u_xlat2);
    u_xlat3.z = dot(Globals.unity_SHBb, u_xlat2);
    u_xlat1.xyz = fma(Globals.unity_SHC.xyz, u_xlat1.xxx, u_xlat3.xyz);
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(Globals.unity_SHAr, u_xlat0);
    u_xlat2.y = dot(Globals.unity_SHAg, u_xlat0);
    u_xlat2.z = dot(Globals.unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD5.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 3
Set 2D Texture "_RTex" to slot 1 sampler slot 0
Set 2D Texture "_GTex" to slot 2 sampler slot 1
Set 2D Texture "_BTex" to slot 3 sampler slot 2
Set 2D Texture "_LightBuffer" to slot 4

Constant Buffer "Globals" (48 bytes) on slot 0 {
  Vector4 _Color at 0
  Vector4 _ColorA at 16
  Vector4 _ColorB at 32
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler sampler_RTex [[ sampler (0) ]],
    sampler sampler_GTex [[ sampler (1) ]],
    sampler sampler_BTex [[ sampler (2) ]],
    sampler sampler_BlendTex [[ sampler (3) ]],
    sampler sampler_LightBuffer [[ sampler (4) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture2d<float, access::sample > _LightBuffer [[ texture (4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    u_xlat0.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat1.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat2.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat4 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat2.xyz = fma(u_xlat4.yyy, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = fma(u_xlat4.zzz, u_xlat1.xyz, u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat4.www, u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat1.xyz = fma(u_xlat4.xxx, u_xlat1.xyz, Globals._ColorA.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * Globals._Color.xyz;
    u_xlat1.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat1.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat1.xy).xyz;
    u_xlat1.xyz = log2(u_xlat1.xyz);
    u_xlat1.xyz = (-u_xlat1.xyz) + input.TEXCOORD5.xyz;
    output.SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(unity_SHBr, u_xlat2);
    u_xlat3.y = dot(unity_SHBg, u_xlat2);
    u_xlat3.z = dot(unity_SHBb, u_xlat2);
    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(unity_SHAr, u_xlat0);
    u_xlat2.y = dot(unity_SHAg, u_xlat0);
    u_xlat2.z = dot(unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler2D _LightBuffer;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat16_0;
vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec3 u_xlat16_3;
vec4 u_xlat10_4;
void main()
{
    u_xlat10_0 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_2 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat10_4 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat16_2.xyz = u_xlat10_4.yyy * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = u_xlat10_4.zzz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat10_4.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_4.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1 = texture(_LightBuffer, u_xlat1.xy);
    u_xlat16_1.xyz = log2(u_xlat10_1.xyz);
    u_xlat1.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD5.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: UNITY_HDR_ON 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (384 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 128
  Matrix4x4 unity_WorldToObject at 192
  Matrix4x4 unity_MatrixVP at 256
  Vector4 _ProjectionParams at 0
  Vector4 unity_SHAr at 16
  Vector4 unity_SHAg at 32
  Vector4 unity_SHAb at 48
  Vector4 unity_SHBr at 64
  Vector4 unity_SHBg at 80
  Vector4 unity_SHBb at 96
  Vector4 unity_SHC at 112
  Vector4 _RTex_ST at 320
  Vector4 _GTex_ST at 336
  Vector4 _BTex_ST at 352
  Vector4 _BlendTex_ST at 368
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 _ProjectionParams;
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.y = u_xlat0.y * Globals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD3.zw = u_xlat0.zw;
    output.TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = fma(u_xlat0.x, u_xlat0.x, (-u_xlat1.x));
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(Globals.unity_SHBr, u_xlat2);
    u_xlat3.y = dot(Globals.unity_SHBg, u_xlat2);
    u_xlat3.z = dot(Globals.unity_SHBb, u_xlat2);
    u_xlat1.xyz = fma(Globals.unity_SHC.xyz, u_xlat1.xxx, u_xlat3.xyz);
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(Globals.unity_SHAr, u_xlat0);
    u_xlat2.y = dot(Globals.unity_SHAg, u_xlat0);
    u_xlat2.z = dot(Globals.unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD5.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 3
Set 2D Texture "_RTex" to slot 1 sampler slot 0
Set 2D Texture "_GTex" to slot 2 sampler slot 1
Set 2D Texture "_BTex" to slot 3 sampler slot 2
Set 2D Texture "_LightBuffer" to slot 4

Constant Buffer "Globals" (48 bytes) on slot 0 {
  Vector4 _Color at 0
  Vector4 _ColorA at 16
  Vector4 _ColorB at 32
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler sampler_RTex [[ sampler (0) ]],
    sampler sampler_GTex [[ sampler (1) ]],
    sampler sampler_BTex [[ sampler (2) ]],
    sampler sampler_BlendTex [[ sampler (3) ]],
    sampler sampler_LightBuffer [[ sampler (4) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    texture2d<float, access::sample > _LightBuffer [[ texture (4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    u_xlat0.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat1.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat2.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat4 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat2.xyz = fma(u_xlat4.yyy, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = fma(u_xlat4.zzz, u_xlat1.xyz, u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat4.www, u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat1.xyz = fma(u_xlat4.xxx, u_xlat1.xyz, Globals._ColorA.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * Globals._Color.xyz;
    u_xlat1.xy = input.TEXCOORD3.xy / input.TEXCOORD3.ww;
    u_xlat1.xyz = _LightBuffer.sample(sampler_LightBuffer, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat1.xyz + input.TEXCOORD5.xyz;
    output.SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    output.SV_Target0.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec4 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(unity_SHBr, u_xlat2);
    u_xlat3.y = dot(unity_SHBg, u_xlat2);
    u_xlat3.z = dot(unity_SHBb, u_xlat2);
    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(unity_SHAr, u_xlat0);
    u_xlat2.y = dot(unity_SHAg, u_xlat0);
    u_xlat2.z = dot(unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
uniform  sampler2D _LightBuffer;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec4 vs_TEXCOORD3;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat16_0;
vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec3 u_xlat16_3;
vec4 u_xlat10_4;
void main()
{
    u_xlat10_0 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_2 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat10_4 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat16_2.xyz = u_xlat10_4.yyy * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = u_xlat10_4.zzz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat10_4.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_4.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    u_xlat1.xy = vs_TEXCOORD3.xy / vs_TEXCOORD3.ww;
    u_xlat10_1 = texture(_LightBuffer, u_xlat1.xy);
    u_xlat1.xyz = u_xlat10_1.xyz + vs_TEXCOORD5.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="DEFERRED" }
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
No keywords set in this variant.
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (368 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 112
  Matrix4x4 unity_WorldToObject at 176
  Matrix4x4 unity_MatrixVP at 240
  Vector4 unity_SHAr at 0
  Vector4 unity_SHAg at 16
  Vector4 unity_SHAb at 32
  Vector4 unity_SHBr at 48
  Vector4 unity_SHBg at 64
  Vector4 unity_SHBb at 80
  Vector4 unity_SHC at 96
  Vector4 _RTex_ST at 304
  Vector4 _GTex_ST at 320
  Vector4 _BTex_ST at 336
  Vector4 _BlendTex_ST at 352
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = fma(u_xlat0.x, u_xlat0.x, (-u_xlat1.x));
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(Globals.unity_SHBr, u_xlat2);
    u_xlat3.y = dot(Globals.unity_SHBg, u_xlat2);
    u_xlat3.z = dot(Globals.unity_SHBb, u_xlat2);
    u_xlat1.xyz = fma(Globals.unity_SHC.xyz, u_xlat1.xxx, u_xlat3.xyz);
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(Globals.unity_SHAr, u_xlat0);
    u_xlat2.y = dot(Globals.unity_SHAg, u_xlat0);
    u_xlat2.z = dot(Globals.unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD5.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 3
Set 2D Texture "_RTex" to slot 1 sampler slot 0
Set 2D Texture "_GTex" to slot 2 sampler slot 1
Set 2D Texture "_BTex" to slot 3 sampler slot 2

Constant Buffer "Globals" (48 bytes) on slot 0 {
  Vector4 _Color at 0
  Vector4 _ColorA at 16
  Vector4 _ColorB at 32
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler sampler_RTex [[ sampler (0) ]],
    sampler sampler_GTex [[ sampler (1) ]],
    sampler sampler_BTex [[ sampler (2) ]],
    sampler sampler_BlendTex [[ sampler (3) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    u_xlat0.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat1.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat2.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat4 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat2.xyz = fma(u_xlat4.yyy, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = fma(u_xlat4.zzz, u_xlat1.xyz, u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat4.www, u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat1.xyz = fma(u_xlat4.xxx, u_xlat1.xyz, Globals._ColorA.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * Globals._Color.xyz;
    output.SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * input.TEXCOORD5.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat0.xyz));
    output.SV_Target0.w = 1.0;
    output.SV_Target1 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_Target2.xyz = fma(input.TEXCOORD2.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(unity_SHBr, u_xlat2);
    u_xlat3.y = dot(unity_SHBg, u_xlat2);
    u_xlat3.z = dot(unity_SHBb, u_xlat2);
    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(unity_SHAr, u_xlat0);
    u_xlat2.y = dot(unity_SHAg, u_xlat0);
    u_xlat2.z = dot(unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
layout(location = 1) out vec4 SV_Target1;
layout(location = 2) out vec4 SV_Target2;
layout(location = 3) out vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat16_0;
vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec3 u_xlat16_3;
vec4 u_xlat10_4;
void main()
{
    u_xlat10_0 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_2 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat10_4 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat16_2.xyz = u_xlat10_4.yyy * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = u_xlat10_4.zzz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat10_4.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_4.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
    SV_Target3.xyz = exp2((-u_xlat0.xyz));
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

//////////////////////////////////////////////////////
Keywords set in this variant: UNITY_HDR_ON 
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord"

Constant Buffer "Globals" (368 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 112
  Matrix4x4 unity_WorldToObject at 176
  Matrix4x4 unity_MatrixVP at 240
  Vector4 unity_SHAr at 0
  Vector4 unity_SHAg at 16
  Vector4 unity_SHAb at 32
  Vector4 unity_SHBr at 48
  Vector4 unity_SHBg at 64
  Vector4 unity_SHBb at 80
  Vector4 unity_SHC at 96
  Vector4 _RTex_ST at 304
  Vector4 _GTex_ST at 320
  Vector4 _BTex_ST at 336
  Vector4 _BlendTex_ST at 352
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct Globals_Type
{
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _RTex_ST;
    float4 _GTex_ST;
    float4 _BTex_ST;
    float4 _BlendTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float u_xlat12;
    u_xlat0 = input.POSITION0.yyyy * Globals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + Globals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD3.xyz = fma(Globals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * Globals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(Globals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, Globals._RTex_ST.xy, Globals._RTex_ST.zw);
    output.TEXCOORD0.zw = fma(input.TEXCOORD0.xy, Globals._GTex_ST.xy, Globals._GTex_ST.zw);
    output.TEXCOORD1.xy = fma(input.TEXCOORD0.xy, Globals._BTex_ST.xy, Globals._BTex_ST.zw);
    output.TEXCOORD1.zw = fma(input.TEXCOORD0.xy, Globals._BlendTex_ST.xy, Globals._BlendTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, Globals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12) * u_xlat0.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = fma(u_xlat0.x, u_xlat0.x, (-u_xlat1.x));
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(Globals.unity_SHBr, u_xlat2);
    u_xlat3.y = dot(Globals.unity_SHBg, u_xlat2);
    u_xlat3.z = dot(Globals.unity_SHBb, u_xlat2);
    u_xlat1.xyz = fma(Globals.unity_SHC.xyz, u_xlat1.xxx, u_xlat3.xyz);
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(Globals.unity_SHAr, u_xlat0);
    u_xlat2.y = dot(Globals.unity_SHAg, u_xlat0);
    u_xlat2.z = dot(Globals.unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    output.TEXCOORD5.xyz = max(u_xlat0.xyz, float3(0.0, 0.0, 0.0));
    return output;
}


-- Fragment shader for "metal":
Set 2D Texture "_BlendTex" to slot 0 sampler slot 3
Set 2D Texture "_RTex" to slot 1 sampler slot 0
Set 2D Texture "_GTex" to slot 2 sampler slot 1
Set 2D Texture "_BTex" to slot 3 sampler slot 2

Constant Buffer "Globals" (48 bytes) on slot 0 {
  Vector4 _Color at 0
  Vector4 _ColorA at 16
  Vector4 _ColorB at 32
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct Globals_Type
{
    float4 _Color;
    float4 _ColorA;
    float4 _ColorB;
};

struct Mtl_FragmentIn
{
    float4 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant Globals_Type& Globals [[ buffer(0) ]],
    sampler sampler_RTex [[ sampler (0) ]],
    sampler sampler_GTex [[ sampler (1) ]],
    sampler sampler_BTex [[ sampler (2) ]],
    sampler sampler_BlendTex [[ sampler (3) ]],
    texture2d<float, access::sample > _BlendTex [[ texture (0) ]] ,
    texture2d<float, access::sample > _RTex [[ texture (1) ]] ,
    texture2d<float, access::sample > _GTex [[ texture (2) ]] ,
    texture2d<float, access::sample > _BTex [[ texture (3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    u_xlat0.xyz = _BTex.sample(sampler_BTex, input.TEXCOORD1.xy).xyz;
    u_xlat1.xyz = _GTex.sample(sampler_GTex, input.TEXCOORD0.zw).xyz;
    u_xlat2.xyz = _RTex.sample(sampler_RTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat4 = _BlendTex.sample(sampler_BlendTex, input.TEXCOORD1.zw);
    u_xlat2.xyz = fma(u_xlat4.yyy, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
    u_xlat1.xyz = fma(u_xlat4.zzz, u_xlat1.xyz, u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = fma(u_xlat4.www, u_xlat0.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-Globals._ColorA.xyz) + Globals._ColorB.xyz;
    u_xlat1.xyz = fma(u_xlat4.xxx, u_xlat1.xyz, Globals._ColorA.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0f, 1.0f);
    u_xlat0.xyz = u_xlat0.xyz * Globals._Color.xyz;
    output.SV_Target0.xyz = u_xlat0.xyz;
    output.SV_Target3.xyz = u_xlat0.xyz * input.TEXCOORD5.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_Target2.xyz = fma(input.TEXCOORD2.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3.w = 1.0;
    return output;
}


-- Vertex shader for "glcore":
Shader Disassembly:
#ifdef VERTEX
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RTex_ST;
uniform 	vec4 _GTex_ST;
uniform 	vec4 _BTex_ST;
uniform 	vec4 _BlendTex_ST;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
in  vec4 in_TEXCOORD0;
out vec4 vs_TEXCOORD0;
out vec4 vs_TEXCOORD1;
out vec3 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
out vec4 vs_TEXCOORD4;
out vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RTex_ST.xy + _RTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _GTex_ST.xy + _GTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BTex_ST.xy + _BTex_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BlendTex_ST.xy + _BlendTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.x = u_xlat0.y * u_xlat0.y;
    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat3.x = dot(unity_SHBr, u_xlat2);
    u_xlat3.y = dot(unity_SHBg, u_xlat2);
    u_xlat3.z = dot(unity_SHBb, u_xlat2);
    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
    u_xlat0.w = 1.0;
    u_xlat2.x = dot(unity_SHAr, u_xlat0);
    u_xlat2.y = dot(unity_SHAg, u_xlat0);
    u_xlat2.z = dot(unity_SHAb, u_xlat0);
    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_explicit_attrib_location : require
#extension GL_ARB_shader_bit_encoding : enable

uniform 	vec4 _Color;
uniform 	vec4 _ColorA;
uniform 	vec4 _ColorB;
uniform  sampler2D _BlendTex;
uniform  sampler2D _RTex;
uniform  sampler2D _GTex;
uniform  sampler2D _BTex;
in  vec4 vs_TEXCOORD0;
in  vec4 vs_TEXCOORD1;
in  vec3 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD5;
layout(location = 0) out vec4 SV_Target0;
layout(location = 1) out vec4 SV_Target1;
layout(location = 2) out vec4 SV_Target2;
layout(location = 3) out vec4 SV_Target3;
vec3 u_xlat0;
vec3 u_xlat16_0;
vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat16_1;
vec4 u_xlat10_1;
vec3 u_xlat16_2;
vec4 u_xlat10_2;
vec3 u_xlat16_3;
vec4 u_xlat10_4;
void main()
{
    u_xlat10_0 = texture(_BTex, vs_TEXCOORD1.xy);
    u_xlat10_1 = texture(_GTex, vs_TEXCOORD0.zw);
    u_xlat10_2 = texture(_RTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.xyz);
    u_xlat10_4 = texture(_BlendTex, vs_TEXCOORD1.zw);
    u_xlat16_2.xyz = u_xlat10_4.yyy * u_xlat16_3.xyz + u_xlat10_2.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = u_xlat10_4.zzz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat10_4.www * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat1.xyz = (-_ColorA.xyz) + _ColorB.xyz;
    u_xlat1.xyz = u_xlat10_4.xxx * u_xlat1.xyz + _ColorA.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target3.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    SV_Target2.xyz = vs_TEXCOORD2.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target2.w = 1.0;
    SV_Target3.w = 1.0;
    return;
}

#endif


-- Fragment shader for "glcore":
Shader Disassembly:
// All GLSL source is contained within the vertex program

 }
}
Fallback "Diffuse"
}