// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LearningShaders/Basic/11_CustomBlend" {

//Input Variables

Properties{
//_VariableName("InspectorName, Type) = defaultValue Types 2D|Color|Float|Int|Range|Vector|Cube|3D
_MainTex("MainTex",2D) = ""{}
_Color("Color", Color) = (1,1,1,1)
//[Enum(Off,0,Front,1,Back,2)] _CullOption ("Cull", Int) = 1
[Enum(UnityEngine.Rendering.CullMode)] _CullOption ("Cull", Int) = 1
//[Enum(SrcAlpha,0,One,1,OneMinusDstColor,2,DstColor,3)] _SrcBlend ("Source",Int) = 0
//[Enum(SrcAlpha,0,One,1,OneMinusDstColor,2,DstColor,3)] _SrcBlend ("Source",Int) = 0
//[Enum(One,0,Zero,1,SrcColor,2,SrcAlpha,3,DstColor,4,DstAlpha,5,OneMinusSrcColort,6,OneMinusDstColor,7,OneMinusDstAlpha,8)] _DstBlend ("Dest",Int) = 0
//[Enum(One,0,Zero,1,SrcColor,2,SrcAlpha,3,DstColor,4,DstAlpha,5,OneMinusSrcColort,6,OneMinusDstColor,7,OneMinusDstAlpha,8)] _SrcBlend ("Src",Int) = 0
//_SrcBlend("SrcBlend",Int) = 0
//_DstBlend("DstBlend",Int) = 0
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("BlendSource", Int) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("BlendDestination", Int) = 0
}

SubShader{

Tags {"Queue" = "Transparent" "RenderType" = "Transparent"}

ZWrite Off Cull [_CullOption]
Blend [_SrcBlend] [_DstBlend]
//Blend SrcAlpha OneMinusSrcAlpha
//LOD 100 this allows to set different settings using LOD system

Pass{//Everytime a pass is applied the shader is modified, several passed can be used, each of one represents a draw call
CGPROGRAM //standard for CG Code CGPROGRAM CGEND
#pragma vertex vert //declaring there is a vertex function in the code
#pragma fragment frag //declaring there is a fragment function in the code
#include "UnityCG.cginc" //librery with useful parameters and functions, always include

//import defined variables from ShaderLab to CG
//uniform is set as a static variable
//variableType _VariableName;
uniform float4 _Color;
uniform sampler2D _MainTex;
float4 _MainTex_ST; //this is needed for the TRANSFORM_TEX op, that modifies the texture with tiling and offset values

//Input structs for vertices and uvs
struct appdata{
//variableType VariableName : Parameter
//variableType float|half|fixed with vector nº of components
//Parameters POSITION|NORMAL|TEXCOORDn|TANGENT|COLOR
fixed4 color: COLOR;
float4 vertex : POSITION; //POSITION uses a float4 (x,y,z,w)
half2 uv0 : TEXCOORD0; //half used for performance, not suitable for Texture Animation
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
v2f o; //struct name and anOutVariableKey
o.vertex = UnityObjectToClipPos(v.vertex); //multiplying the vertex position for a standard parameter UNITY_MATRIX_MVP that bases on the model view projection from the camera
//o.uv0 = v.uv0; with this the tiling and offset does not modify the texture
o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex); //TRANSFORM_TEX modifies the texture with tiling and offset values
o.color = v.color;
return o; //returning the result of the function
}

//Fragment function, when the object is drawn per pixel

fixed4 frag(v2f i) : SV_Target
{
float4 texCol = tex2D( _MainTex, i.uv0)* _Color ;


return texCol ; //return the final result that will be drawn
}

ENDCG
}

}
}