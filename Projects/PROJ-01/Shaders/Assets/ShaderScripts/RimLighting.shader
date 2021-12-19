Shader "Holistic/RimLighting"
{
    Properties
    {
        _RimColor("Rim Color", Color) = (0,0.5,0.5,0)
        _RimThickness("Rim Thickness", Range(1.0,8.9)) = 1
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            float4 _RimColor;
            float _RimThickness;

            struct Input { 
                float3 viewDir;
            };

            void surf (Input IN, inout SurfaceOutput o){
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                o.Emission = _RimColor.rgb * pow(rim, _RimThickness);
            }

        ENDCG
    }
    FallBack "Diffuse"
}
