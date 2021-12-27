Shader "Unlit/VertexShader"
{
    SubShader
    {
        //When you are using vertex and fragments together, then you need to use a pass block
        //You dont need it when you are using a surface shader.
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color: COLOR;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); //Squash to 2D
                // o.color.r = (v.vertex.x + 10) / 20;
                // o.color.g = 0;
                // o.color.b = (v.vertex.z + 10) / 20;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col;
                col.r = i.vertex.x  / 2000;
                col.g = 0;
                col.b = i.vertex.y  / 1000;
                return col;
            }
            ENDCG
        }
    }
}
