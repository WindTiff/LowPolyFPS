using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// 关卡信息类
/// </summary>
[System.Serializable]
public class LevelAttributes
{
    //当前关卡
    public int current_level;
    //生成当前场景用到的矩阵
    public int[,] scene_matrix;
    //生成的当前场景用到的BlockPrefab序列
    public int[] used_block_prefab_index;
    //当前场景用到的环境组
    public int currentSceneUsedBlockGroup;

    public int blockNeedToClear;
    public int blockAlreadyClear;

    public LevelAttributes()
    {
        current_level = 0;
        scene_matrix = new int[3, 3];
        used_block_prefab_index = new int[9];
        currentSceneUsedBlockGroup = 0;
        blockNeedToClear = 2;
        blockAlreadyClear = 0;

    }


}