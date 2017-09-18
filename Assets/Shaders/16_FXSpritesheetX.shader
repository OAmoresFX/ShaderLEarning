// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LearningShaders/Basic/16_FXSpritesheetX" {

//Input Variables

Properties{
//_VariableName("InspectorName, Type) = defaultValue Types 2D|Color|Float|Int|Range|Vector|Cube|3D
_MainTex("MainTex",2D) = ""{}
_Color("Color", Color) = (1,1,1,1)
_TexWidth ("Sheet Width",float) = 0.0
_CellAmount ("Cell Amount",float) = 0.0
_Speed("Speed",Range(0.01,32)) = 12









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
#include "UnityCG.cginc" 


uniform float4 _Color;
uniform sampler2D _MainTex;
float4 _MainTex_ST; 
float _TexWidth;
float _CellAmount;
float _Speed;



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

float cellPixelWidth = _TexWidth/_CellAmount;
float cellUVPercentage = cellPixelWidth/_TexWidth;
float timeVal = fmod(_Time.y * _Speed, _CellAmount);
timeVal = ceil(timeVal);
float xValue = spriteUV.x;
xValue += cellUVPercentage * timeVal * _CellAmount;
xValue *= cellUVPercentage;

spriteUV = float2(xValue, spriteUV.y);




float4 texCol = tex2D( _MainTex, spriteUV)* _Color ;


return texCol ; //return the final result that will be drawn
}

ENDCG
}

}
}