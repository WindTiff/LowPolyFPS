// Polyverse Skies v1.2 - Low poly skybox shaders and textures
// Copyright (c) Cristian Pop, https://boxophobic.com/

#if UNITY_EDITOR

using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(PolyverseSkies))]

public class PolyvesreSkiesInspector : Editor 
{
	private PolyverseSkies targetScript;

	private static readonly string excludeScript = "m_Script";

	private Color bannerColor;
	private Texture2D bannerImage;
	private Texture2D logoImage;

	private GUIStyle boldStyle = new GUIStyle();
	private GUIStyle titleStyle = new GUIStyle();

	void OnEnable(){

		boldStyle.fontStyle = FontStyle.Bold;
		titleStyle.alignment = TextAnchor.MiddleCenter;

		// Check if Light or Dark Unity Skin
		// Set the Banner and Logo Textures
		if (EditorGUIUtility.isProSkin) 
		{

			bannerColor = new Color (1f, 0.411f, 0.745f);
			bannerImage = Resources.Load ("Polyverse Skies - BannerDark") as Texture2D; 
			logoImage = Resources.Load ("Boxophobic - LogoDark") as Texture2D;

		} 
		else 
		{

			bannerColor = new Color (0.250f, 0.250f, 0.250f);
			bannerImage = Resources.Load ("Polyverse Skies - BannerLight") as Texture2D;
			logoImage = Resources.Load ("Boxophobic - LogoLight") as Texture2D;

		}

	}

	public override void OnInspectorGUI(){
		

		DrawBanner ();
		DrawInspector ();
		DrawLogo ();

	}

	void DrawBanner(){
		
		GUILayout.Space(20);
		var bannerRect = GUILayoutUtility.GetRect(0, 0, 40, 0);
		EditorGUI.DrawRect(bannerRect, bannerColor);
		GUI.Label (bannerRect, bannerImage, titleStyle);

		if (GUI.Button(bannerRect, "", new GUIStyle()))
		{
			Application.OpenURL("https://docs.google.com/document/d/1z7A_xKNa2mXhvTRJqyu-ZQsAtbV32tEZQbO1OmPS_-s/edit?usp=sharing");
		}
		GUILayout.Space(20);

	}

	void DrawInspector(){

		serializedObject.Update ();

		DrawPropertiesExcluding (serializedObject, excludeScript);

		serializedObject.ApplyModifiedProperties ();

		GUILayout.Space (20);

	} 

	void DrawLogo(){
		
		GUILayout.BeginHorizontal();
		GUILayout.Label ("");

		if (GUILayout.Button (logoImage, GUI.skin.label)) 
		{
			Application.OpenURL ("https://boxophobic.com/");
		}

		GUILayout.EndHorizontal ();
		GUILayout.Space (20);

	}


}

#endif