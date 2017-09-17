﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LearningShaders/Basic/18_FXSprite&UVAnimation" {

//Input Variables

Properties{
//_VariableName("InspectorName, Type) = defaultValue Types 2D|Color|Float|Int|Range|Vector|Cube|3D
_MainTex("MainTex",2D) = ""{}
_Color("Color", Color) = (1,1,1,1)
[Header(UVScroll Animation X Y)]
_Scroll("Scroll", Vector) = (0,0,0,0)
[Header(Spritesheet Animation)]
[Header(X Columns Y Rows Z Frame W Frames Second)]
_SpriteData("Spritesheet values",vector) = (0,0,0,0)

[MyToggle] _Test("Test",Float) = 0


//[Toggle(ENABLE_FANCY)] _Fancy("Fancy?", Float) = 0




[Enum(UnityEngine.Rendering.CullMode)] _CullOption ("Cull", Int) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("BlendSource", Int) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("BlendDestination", Int) = 0
}

SubShader{

Tags {"Queue" = "Transparent" "RenderType" = "Transparent"}

ZWrite Off Cull [_CullOption]
Blend [_SrcBlend] [_DstBlend]


Pass{
CGPROGRAM 
#pragma vertex vert 
#pragma fragment frag 
#pragma multi_compile FANCY_STUFF_OFF FANCY_STUFF_ON
#include "UnityCG.cginc" 


uniform float4 _Color;
uniform sampler2D _MainTex;
float4 _MainTex_ST; 
vector _SpriteData;
float4 _Scroll;




struct appdata{

fixed4 color: COLOR;
float4 vertex : POSITION; 
half2 uv0 : TEXCOORD0; 
};

struct v2f{
float4 vertex : SV_POSITION; 
half2 uv0 : TEXCOORD0;
fixed4 color: COLOR;
};


v2f vert(appdata v)
{
v2f o;
o.vertex = UnityObjectToClipPos(v.vertex); 
o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex); 
o.color = v.color;
return o; 
}

fixed4 frag(v2f i) : SV_Target
{
fixed2 spriteUV = i.uv0;

//Spritesheet animation
#if FANCY_STUFF_ON
float uValue = spriteUV.x;
float vValue = spriteUV.y;


float CellPixelWidth = 1 / _SpriteData.x;
float CellPixelHeight = 1 / _SpriteData.y;

int CellPos = _SpriteData.z;
int FPS = _SpriteData.w;
float TimeVal = FPS * _Time.y;
CellPos += TimeVal;

float uIndexRaw = int(CellPos / _SpriteData.x);
float uIndex = (_SpriteData.y - 1) - uIndexRaw;
float vIndexRaw = CellPos / _SpriteData.x;
float vIndex = (vIndexRaw - uIndex) / CellPixelWidth;

uValue += vIndex;
uValue *= CellPixelWidth ;

vValue += uIndex;
vValue *= CellPixelHeight;


spriteUV = float2(uValue,vValue);
#endif
//UV Animation

fixed2 scrolledUV = i.uv0;

fixed xScrollValue = _Scroll.x * _Time;
fixed yScrollValue = _Scroll.y / _Time;

scrolledUV += fixed2 (xScrollValue, yScrollValue);

fixed UVs = spriteUV + scrolledUV;

float4 texCol = tex2D( _MainTex, UVs)* _Color ;


return texCol ; //return the final result that will be drawn
}

ENDCG
}

}

}