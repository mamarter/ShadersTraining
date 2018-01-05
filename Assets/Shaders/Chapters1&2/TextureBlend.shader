﻿Shader "CookbookShaders/TextureBlend" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		
		_ColorA ("Color A", Color) = (1,1,1,1)
		_ColorB ("Color B", Color) = (1,1,1,1)
		
		_RTex ("Red Channel Texture", 2D) = "" {}
		_GTex ("Green Channel Texture", 2D) = "" {}
		_BTex ("Blue Channel Texture", 2D) = "" {}
		_ATex ("Alpha Channel Texture", 2D) = "" {}

		_BlendTex ("Blend Texture", 2D) = "" {}		
	}
	
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert 

        float4 _Color;
		float4 _ColorA;
		float4 _ColorB;
		
		sampler2D _RTex;
		sampler2D _GTex;
		sampler2D _BTex;
		sampler2D _ATex;
		sampler2D _BlendTex;

		struct Input {
            float2 uv_BlendTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			
			float4 blendData = tex2D(_BlendTex, IN.uv_BlendTex);

            float4 RData = tex2D(_RTex, IN.uv_BlendTex);
            float4 GData = tex2D(_GTex, IN.uv_BlendTex);
            float4 BData = tex2D(_BTex, IN.uv_BlendTex);
            float4 AData = tex2D(_ATex, IN.uv_BlendTex);
            
            float4 finalColor;
            
            finalColor = lerp(RData, GData, blendData.r);
            finalColor = lerp(finalColor, GData, blendData.g);
            finalColor = lerp(finalColor, BData, blendData.b);
            finalColor.a = 1.0;

            float4 terrainColour = lerp(_ColorA, _ColorB, blendData.a);
            finalColor *= terrainColour;
            finalColor = saturate(finalColor);
            
            o.Albedo = finalColor.rgb * _Color;
            o.Alpha = finalColor.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
