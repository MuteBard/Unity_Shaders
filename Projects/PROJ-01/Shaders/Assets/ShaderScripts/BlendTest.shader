Shader "Custom/BlendTest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "White" {}
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        Blend One One
        // Blend SrcAlpha OneMinusSrcAlpha
        // Blend SrcAlpha OneMinusSrcAlpha
        // Blend DstColor Zero

        Pass {
            SetTexture [_MainTex] { combine texture }
        }
    }
}
