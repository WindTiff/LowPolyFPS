using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.SceneManagement;
using System.Runtime.Serialization.Formatters.Binary;   

/// <summary>
/// 场景控制脚本
/// SceneControl 物体
/// </summary>
public class SceneControl : MonoBehaviour
{
    public bool NewGame;
    //当前关卡
    public int CurrentLevel;

    public List<int> AvailableBlockGroup;

    //生成场景可能需要的区块预制体，从文件中加载，随机选取
    public List<GameObject> LevelPossibleBlocks;

    //当前场景的信息
    public static LevelAttributes currentLevelAttributes = new LevelAttributes();

    public GamePlayingUIControl GPUI;
    /// <summary>
    /// 测试用
    /// </summary>
    public GameObject LoadingNextLevelPanel;


    private void Start()
    {
        ObtainSceneInfo(NewGame);
        LoadLevelSceneBlocks();
        GenerateScene();
    }

    public void Update()
    {
        if (Input.GetKeyDown(KeyCode.S)) {
            GoToNextLevel();
        }
    }

    /// <summary>
    /// 获取生成场景需要的信息
    /// </summary>
    /// <param name="newScene"></param>
    public void ObtainSceneInfo(bool newScene)
    {
        //如果想要生成新场景
        if (newScene)
        {
            //设置区域已经清除的敌人为0
            currentLevelAttributes.blockAlreadyClear = 0; 

            //关卡+1
            currentLevelAttributes.current_level++;

            //随机获取环境组
            currentLevelAttributes.currentSceneUsedBlockGroup = AvailableBlockGroup[Random.Range(0, AvailableBlockGroup.Count)];
            AvailableBlockGroup.Remove(currentLevelAttributes.currentSceneUsedBlockGroup);

            //随机获取矩阵（从文件中读取或者写入代码中）

            currentLevelAttributes.scene_matrix = new int[3, 3] { { 1, 0, 0 }, { 1, 1, 1 }, { 1, 0, 0 } };
            //获取生成的当前场景用到的BlockPrefab序列（9个元素）

            List<int> tempList = new List<int>() { 0, 1, 2, 3, 4, 5, 6, 7, 8 };

            for (int i = 0; i < 9; i++)
            {
                int index = Random.Range(0, tempList.Count);
                currentLevelAttributes.used_block_prefab_index[i] = tempList[index];
                tempList.RemoveAt(index);
            }

        }
        else
        {//如果想要加载场景

            string SavedSceneFilePath =
#if UNITY_ANDROID && !UNITY_EDITOR
               Application.persistentDataPath + "/GameSceneFile.txt";
#elif UNITY_IPHONE && !UNITY_EDITOR
               file:// + Application.dataPath +"/Raw/GameSaveFiles/GameSceneFile.txt"
#elif UNITY_STANDALONE_WIN || UNITY_EDITOR
               "Assets/StreamingAssets/GameSaveFiles/GameSceneFile.txt";
#else
               string.Empty;  
#endif


            if (File.Exists(SavedSceneFilePath))
            {
                //反序列化过程——(将字节流转化为对象)
                //创建一个二进制格式化程序
                BinaryFormatter bf = new BinaryFormatter();
                //打开一个文件流
                FileStream fileStream = File.Open(SavedSceneFilePath, FileMode.Open);
                //调用二进制格式化程序的反序列化方法，将文件流转化为对象
                currentLevelAttributes = (LevelAttributes)bf.Deserialize(fileStream);
                //关闭文件流
                fileStream.Close();
                AvailableBlockGroup.Remove(currentLevelAttributes.currentSceneUsedBlockGroup);


            }

        }

    }




    /// <summary>
    /// 生成场景
    /// </summary>
    public bool GenerateScene() {

        int index = 0;
        for (int x = 0; x < 3; x++)
        {
            for (int y = 0; y < 3; y++)
            {
                if (currentLevelAttributes.scene_matrix[x, y] == 1)
                {

                    //生成新的区块
                    GameObject newBlock = Instantiate(LevelPossibleBlocks[currentLevelAttributes.used_block_prefab_index[index]], new Vector3(x * LevelPossibleBlocks[currentLevelAttributes.used_block_prefab_index[index]].GetComponent<BlockControl>().BlockWidth, 0
                        , -y * LevelPossibleBlocks[currentLevelAttributes.used_block_prefab_index[index]].GetComponent<BlockControl>().BlockWidth), Quaternion.identity, transform);
                    index++;


                    //将区块内的敌人加入列表
                    EnemyCombatControl[] enemies_components = newBlock.transform.GetChild(1).GetComponentsInChildren<EnemyCombatControl>(true);

                    for (int k = 0; k < enemies_components.Length; k++)
                    {
                        newBlock.GetComponent<BlockControl>().EnemiesList.Add(enemies_components[k].gameObject);
                    }

                    //加入BOSS
                    newBlock.GetComponent<BlockControl>().Boss = newBlock.transform.GetChild(2).gameObject;



                    if (x < 2)
                    {//右侧判断
                        if (currentLevelAttributes.scene_matrix[x + 1, y] == 1)
                        {
                            newBlock.GetComponent<BlockControl>().AvailableGates.Add(newBlock.transform.GetChild(0).GetChild(1).gameObject);
                        }
                    }
                    if (x > 0)
                    {//左侧判断
                        if (currentLevelAttributes.scene_matrix[x - 1, y] == 1)
                        {
                            newBlock.GetComponent<BlockControl>().AvailableGates.Add(newBlock.transform.GetChild(0).GetChild(3).gameObject);
                        }
                    }

                    if (y < 2)
                    {//下方判断
                        if (currentLevelAttributes.scene_matrix[x, y + 1] == 1)
                        {
                            newBlock.GetComponent<BlockControl>().AvailableGates.Add(newBlock.transform.GetChild(0).GetChild(2).gameObject);
                        }

                    }
                    if (y > 0)//上方判断
                    {
                        if (currentLevelAttributes.scene_matrix[x, y - 1] == 1)
                        {
                            newBlock.GetComponent<BlockControl>().AvailableGates.Add(newBlock.transform.GetChild(0).GetChild(0).gameObject);
                        }

                    }
                }
            }
        }
        return true;

    }


    /// <summary>
    /// 加载下一关
    /// </summary>
    public void GoToNextLevel() {

        if (currentLevelAttributes.current_level == 1) {
            GPUI.ClearancePanelShow();
            return;
        }

        //显示加载画面
        LoadingNextLevelPanel.SetActive(true);
        //清除SceneControl下所有场景物体
        int child_count = transform.childCount;

        for (int i = 0; i < child_count; i++)
        {
            Destroy(transform.GetChild(0).gameObject);
        }

        StartCoroutine("LoadNewLevel");




       


    }

    IEnumerator LoadNewLevel() {
        //生成新场景
        ObtainSceneInfo(true);

        LoadLevelSceneBlocks();

        GenerateScene();

        yield return new WaitForSeconds(2);
        //关闭加载画面
        LoadingNextLevelPanel.SetActive(false);

    }


    /// <summary>
    /// 加载 Block 预制体到列表当中
    /// </summary>
    public void LoadLevelSceneBlocks() {


        //从AssetBundle加载

//        string BlocksPrefabsFilePath =
//#if UNITY_ANDROID && !UNITY_EDITOR
//              Application.dataPath + "!assets/AssetBundles/blocks/style"+gameSceneAttributes.CurrentSceneUsedBlockGroup+".block";
//#elif UNITY_IPHONE && !UNITY_EDITOR
//               file:// + Application.dataPath +"/Raw/AssetBundles/blocks/test1.block"
//#elif UNITY_STANDALONE_WIN || UNITY_EDITOR
//               "Assets/StreamingAssets/AssetBundles/blocks/style"+ gameSceneAttributes.CurrentSceneUsedBlockGroup + ".block";
//#else
//               string.Empty;  
//#endif

//        AssetBundle blocksBundle = AssetBundle.LoadFromFile(BlocksPrefabsFilePath);

//        Object[] blocksPrefabs =  blocksBundle.LoadAllAssets();

//        LevelPossibleBlocks =new List<GameObject>();

//        for (int i = 0; i < blocksPrefabs.Length; i++)
//        {
//            LevelPossibleBlocks.Add((GameObject)blocksPrefabs[i]);
//        }
        
//        blocksBundle.Unload(false);

        //从Resources加载
        GameObject[] blockPrefabs = Resources.LoadAll<GameObject>("BlockGroups/BlockGroup" + currentLevelAttributes.currentSceneUsedBlockGroup);
        LevelPossibleBlocks = new List<GameObject>();

        for (int i = 0; i < blockPrefabs.Length; i++)
        {
            LevelPossibleBlocks.Add((GameObject)blockPrefabs[i]);
        }




    }

    /// <summary>
    /// 保存场景信息
    /// </summary>
    public void SaveCurrentScene() {

        string SavedSceneFilePath =
#if UNITY_ANDROID && !UNITY_EDITOR
               Application.persistentDataPath + "/GameSceneFile.txt";
#elif UNITY_IPHONE && !UNITY_EDITOR
               file:// + Application.dataPath +"/Raw/GameSaveFiles/GameSceneFile.txt"
#elif UNITY_STANDALONE_WIN || UNITY_EDITOR
               "Assets/StreamingAssets/GameSaveFiles/GameSceneFile.txt";
#else
               string.Empty;  
#endif



        //用二进制存储
        //创建一个二进制格式化程序
        BinaryFormatter bf = new BinaryFormatter();
        //创建一个文件流
        FileStream fileStream = File.Create(SavedSceneFilePath);
        //调用二进制格式化程序的序列化方法来序列化save对象  参数:创建的文件流和需要序列化的对象
        bf.Serialize(fileStream, currentLevelAttributes);
        //关闭流
        fileStream.Close();




    }
    public void LoadToStartScene() {
        SceneManager.LoadScene("MenuScene");

    }


}
