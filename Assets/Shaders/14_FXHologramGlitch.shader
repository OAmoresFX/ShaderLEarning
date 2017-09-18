// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LearningShaders/Basic/14_FXHologramGlitch" {

//Input Variables

Properties{
//_VariableName("InspectorName, Type) = defaultValue Types 2D|Color|Float|Int|Range|Vector|Cube|3D
_MainTex("MainTex",2D) = ""{}
_Color("Color", Color) = (1,1,1,1)
_CutoutThres("Cutout Threshold",Range(0.0,1.0)) = 0.2
_Transparency("Transparency", Range(0.0,1.0)) = 0.2
_Distance("Distance",Float) = 1
_Amplitude("Amplitude",Float) = 1
_Speed("Speed",Float) = 1
_Amount("Amount",Range(0.0,1.0)) = 1





[Enum(UnityEngine.Rendering.CullMode)] _CullOption ("Cull", Int) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("BlendSource", Int) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("BlendDestination", Int) = 0
}

SubShader{

Tags {"Queue" = "Transparent" "RenderType" = "Transparent"}

ZWrite Off Cull [_CullOption]
Blend [_SrcBlend] [_DstBlend]
//Blend SrcAlpha OneMinusSrcAlpha
//LOD 100 this allows to set different settings using LOD system

Pass{
CGPROGRAM 
#pragma vertex vert 
#pragma fragment frag 
#include "UnityCG.cginc" 

uniform float4 _Color;
uniform sampler2D _MainTex;
float4 _MainTex_ST; 
float _CutoutThres;
float _Transparency;
float _Distance;
float _Amplitude;
float _Speed;
float _Amount;


struct appdata{

fixed4 color: COLOR;
float4 vertex : POSITION; 
half2 uv0 : TEXCOORD0; 
};

struct v2f{

float4 vertex : SV_POSITION; //the SV_ is used for compatibility with DX11
half2 uv0 : TEXCOORD0;
fixed4 color: COLOR;
};

//Vertex function, when the object is built
//2nd struct nameOnPragmaVertex(1st struct anInVariableKey)
v2f vert(appdata v)
{
v2f o; 
v.vertex.x += sin(_Time.y * _Speed + v.vertex.y * _Amplitude) * _Distance *_Amount;
o.vertex = UnityObjectToClipPos(v.vertex); 
o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex); 
o.color = v.color;
return o; 
}



fixed4 frag(v2f i) : SV_Target
{
fixed4 texCol = tex2D( _MainTex, i.uv0)+ _Color ;
texCol.a = _Transparency;
clip(texCol.r - _CutoutThres);
return texCol ; 
}
ENDCG
}

}
}