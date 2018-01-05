Shader "CookbookShaders/Chapter3/ToonShader" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_CelShadingLevels ("Cel Shading Levels", float) = 15
	}
	SubShader {
		CGPROGRAM
		
		#pragma surface surf Toon

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		float _CelShadingLevels;

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		
		half4 LightingToon(SurfaceOutput s, half3 lightDir, half atten)
		{
		    half NdotL = dot(s.Normal, lightDir); 
            half cel = floor(NdotL * _CelShadingLevels)/ (_CelShadingLevels - 0.5);

            fixed4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * cel * atten;
            c.a = s.Alpha;
            
            return c;
		}
		
		ENDCG
	}
	FallBack "Diffuse"
}
