Shader "Custom/BlendTwo"
{
    Properties
    {
        _MainTexA ("MainTex", 2D) = "white" {}
        _MainTexB ("MainTex", 2D) = "white" {}
        [Toggle] _ShowA("Show A?", Float) = 0
        [Toggle] _ShowB("Show B?", Float) = 0
    }
    SubShader
    {
        Tags {
            "Queue" = "Geometry"
        }
        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _MainTexA;
        sampler2D _MainTexB;
        float _ShowA;
        float _ShowB;

        struct Input {
            float2 uv_MainTexA;
        };
        void surf(Input IN, inout SurfaceOutput o){
            fixed4 a = tex2D(_MainTexA, IN.uv_MainTexA);
            fixed4 b = tex2D(_MainTexB, IN.uv_MainTexA);
            o.Albedo = (a.rgb * _ShowA) + (b.rgb * _ShowB);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
