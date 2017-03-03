﻿Shader "Shaders101/Basic" {
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondTex("Second Texture", 2D) = "white" {}
		_Tween("Tween", Range(0,1)) = 0 
		_Color("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"PreviewType" = "Plane"
		}
		Pass
		{
			Blend SrcALPha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _MainTex;
			sampler2D _SecondTex;
			float4 _MainTex_ST;
			float4 _SecondTex_ST;
			float _Tween;
			float3 _Color;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv * lerp(_MainTex_ST,_SecondTex_ST,_Tween);
				return o;
			}



			float4 frag(v2f i) : SV_Target
			{
				//float4 colour = tex2D(_MainTex, i.uv) * float4(i.uv.r,i.uv.g,0,1);
				//float4 colour = tex2D(_MainTex, i.uv) * _Color;
				float4 color1 = tex2D(_MainTex, i.uv);
				float4 color2 = tex2D(_SecondTex, i.uv);

				float4 color = lerp(color1, color2, _Tween);
				color = float4(color.x * _Color.x, color.y * _Color.y, color.z * _Color.z, color.w);
				//color = 

				return color;
			}

			ENDCG

		}
	}
}
