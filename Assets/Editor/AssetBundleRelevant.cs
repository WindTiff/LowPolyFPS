using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class AssetBundleRelevant
{
    [MenuItem("Assets/BuildAllAssetBundles")]
    static void CreateAllAssetBundles() {
        BuildPipeline.BuildAssetBundles("Assets/StreamingAssets/AssetBundles", BuildAssetBundleOptions.None, BuildTarget.Android);

    }
}
