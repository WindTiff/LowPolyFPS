using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

/// <summary>
/// 区块控制脚本
/// 挂载位置：单个区块预制体
/// </summary>

public class BlockControl : MonoBehaviour
{

    /// <summary>
    ///        大门排布方式
    ///             0
    ///     3               1
    ///             2 
    /// </summary>

    //B区块宽度
    public int BlockWidth;

    //区块可用的大门
    public List<GameObject> AvailableGates;
    //区块内的敌人列表
    public List<GameObject> EnemiesList;

    public GameObject Boss;

    private NavMeshSurface surface;

    private int blockEnemyCount = 0;

    void Start()
    {
        surface = GetComponent<NavMeshSurface>();
        surface.BuildNavMesh();
        GatesOnOff(true);
    }

    void Update()
    {
        EnemiesStateControl();
    }

    /// <summary>
    /// 区块内敌人状态控制
    /// </summary>
    public void EnemiesStateControl() {
        if (blockEnemyCount != EnemiesList.Count) {
            blockEnemyCount = EnemiesList.Count;
            if (EnemiesList.Count == 0)
            {
                if (SceneControl.currentLevelAttributes.blockAlreadyClear+1 < SceneControl.currentLevelAttributes.blockNeedToClear)//如果清理的区域不足以产生BOSS
                {

                    GatesOnOff(true);
                    GamePlayingUIControl.BlockClearHintOnce();
                    SceneControl.currentLevelAttributes.blockAlreadyClear++;

                }
                else {
                    //在区域中生成BOSS
                    Boss.SetActive(true);
                }
            }
        }


    }

    /// <summary>
    /// 敌人死亡后从敌人列表中移除
    /// </summary>
    /// <param name="enemy"></param>
    public void RemoveEnemyFromList(GameObject enemy) {

        EnemiesList.Remove(enemy);
    }


    /// <summary>
    /// 区块大门控制
    /// </summary>
    /// <param name="toOpen"></param>
    public void GatesOnOff(bool toOpen) {
        if (toOpen)
        {
            for (int i = 0; i < AvailableGates.Count; i++)
            {
                AvailableGates[i].SetActive(false);
            }
        }
        else {
            for (int i = 0; i < AvailableGates.Count; i++)
            {
                AvailableGates[i].SetActive(true);
            }
        }

    }

    private void OnTriggerEnter(Collider other)
    {

        if (other.tag == "Player"&&EnemiesList.Count>0) {//如果没有来过该区域
            GatesOnOff(false);
            for (int i = 0; i < EnemiesList.Count; i++)
            {
                EnemiesList[i].SetActive(true);

            }

        }
    }
}
