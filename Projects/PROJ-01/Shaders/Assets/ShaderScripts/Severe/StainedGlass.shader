Shader "Severe/StainedGlass"
{
    Properties
    {
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
        ENDCG
    }
    FallBack "Diffuse"
}