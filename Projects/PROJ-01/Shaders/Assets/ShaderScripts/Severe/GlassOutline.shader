Shader "Severe/Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (0,0,0,1)
        _Outline ("Outline Width", Range (.002, 1)) = .005

        _RimColorA ("Rim ColorA", Color) = (0,0.5,0.5,0.0)
        _RimColorB ("Rim ColorB", Color) = (0,0.0,0.0,0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
    }
    SubShader
    {
        Tags {"Queue" = "Transparent"}
        
        Pass {
            ZWrite On
            ColorMask 0
        }

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade
        struct Input {
            float3 viewDir;
        };
        float4 _RimColorA;
        float4 _RimColorB;
        float _RimPower;

        void surf (Input IN, inout SurfaceOutput o){

            half dotp = 1 - dot(IN.viewDir, o.Normal);
            float3 shade1 = (float3(dotp, dotp, dotp) + _RimColorA).rgb;
            float3 shade2 = (float3(dotp, dotp, dotp) + _RimColorB).rgb;
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Albedo = _RimColorA.rgb * rim > 0.5 ? shade2 : shade1;
            o.Alpha = pow (rim, _RimPower); 
        }

        // void surf (Input IN, inout SurfaceOutput o){
        //     fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
        //     o.Albedo = c.rgb;
        // }
        ENDCG

        Pass {
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                fixed4 color : COLOR;
            };

            float _Outline;
            float4 _OutlineColor;

            v2f vert(appdata v){
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
                float2 offset = TransformViewToProjection(norm.xy);

                o.pos.xy += offset * o.pos.z *_Outline;
                o.color = _OutlineColor;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target{
                return i.color;
            }    
            ENDCG
        }

    }
    FallBack "Diffuse"
}
