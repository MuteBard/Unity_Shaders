Shader "Custom/SimpleOutline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _MainTex;

            struct Input
            {
                float2 uv_MainTex;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
                o.Albedo = c.rgb;
            }
        ENDCG
    }
    FallBack "Diffuse"
}
