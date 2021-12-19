Shader "Holistic/DotProductShader"
{
    Properties
    {
        _color("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            fixed4 _color;

            struct Input { 
                float3 viewDir;
            };

            void surf (Input IN, inout SurfaceOutput o){
                half dotp = 1 - dot(IN.viewDir, o.Normal);
                // o.Albedo = (float3(1, dotp, 1) + _color).rgb;
                // o.Albedo = (float3(dot(IN.viewDir, o.Normal), 1, 1 - dot(IN.viewDir, o.Normal))).rgb;
                // o.Albedo = (float3(1 - dot(IN.viewDir, Normal), 0, 0)).rgb;
                o.Albedo = (float3(0,1 - dot(IN.viewDir, o.Normal), 0)).rgb;

            }

        ENDCG
    }
    FallBack "Diffuse"
}
