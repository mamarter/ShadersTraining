Shader "CookbookShaders/RadiusShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Radius ("Radius", Float) = 0.55
		_RadiusWidth ("Radius Width", Float) = 2
		_Center ("Center", Vector) = (0,0,0,0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0
	
	    sampler2D _MainTex;
	    
		struct Input 
		{
			float2 uv_MainTex;
			float3 worldPos;
		};
        
        fixed4 _Color;
        float _Radius;
        float _RadiusWidth;
        float3 _Center;
        
		void surf (Input IN, inout SurfaceOutputStandard o) {
		
		    float d = distance(_Center, IN.worldPos);
		    if(d > _Radius && d < _Radius + _RadiusWidth)
		    {
		        o.Albedo = _Color.rgb;
		        o.Alpha = _Color.a;
		    }
		    else
		    {
      			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
		        o.Albedo = c.rgb;
		        o.Alpha = c.a;
		    }
		}
		ENDCG
	}
	FallBack "Diffuse"
}
