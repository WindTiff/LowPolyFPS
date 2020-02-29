// Polyverse Skies v1.2 - Low poly skybox shaders and textures
// Copyright (c) Cristian Pop, https://boxophobic.com/

using UnityEngine;

[HelpURL("https://docs.google.com/document/d/1z7A_xKNa2mXhvTRJqyu-ZQsAtbV32tEZQbO1OmPS_-s/edit?usp=sharing")]
[DisallowMultipleComponent]
[ExecuteInEditMode]
public class PolyverseSkies : MonoBehaviour {

	
	public GameObject sunDirection;
	public GameObject moonDirection;

	private Vector3 GlobalSunDirection = Vector3.zero;
	private Vector3 GlobalMoonDirection = Vector3.zero;

	void Update () {

		if (sunDirection != null) {
			GlobalSunDirection = -sunDirection.transform.forward;
			Shader.SetGlobalVector ("GlobalSunDirection", GlobalSunDirection);
		} else {
			GlobalSunDirection = Vector3.zero;
			Shader.SetGlobalVector ("GlobalSunDirection", GlobalSunDirection);
		}

		if (moonDirection != null) {
			GlobalMoonDirection = -moonDirection.transform.forward;
			Shader.SetGlobalVector ("GlobalMoonDirection", GlobalMoonDirection);
		} else {
			GlobalSunDirection = Vector3.zero;
			Shader.SetGlobalVector ("GlobalMoonDirection", GlobalMoonDirection);
		}


	}


}
