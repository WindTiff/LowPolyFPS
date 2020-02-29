using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.SceneManagement;


public class MenuControl : MonoBehaviour
{

    public SceneControl SC;
    public bool HasSavedFile = true;

    private string SavedSceneFilePath;
    /// <summary>
    /// 异步操作类
    /// </summary>
    private AsyncOperation prog;



    private void Awake()
    {
        SavedSceneFilePath =
#if UNITY_ANDROID && !UNITY_EDITOR
               Application.persistentDataPath + "/GameSceneFile.txt";
#elif UNITY_IPHONE && !UNITY_EDITOR
               file:// + Application.dataPath +"/Raw/GameSaveFiles/GameSceneFile.txt"
#elif UNITY_STANDALONE_WIN || UNITY_EDITOR
               "Assets/StreamingAssets/GameSaveFiles/GameSceneFile.txt";
#else
               string.Empty;  
#endif

        FileInfo fi = new FileInfo(SavedSceneFilePath);

        if (!fi.Exists) {
            HasSavedFile = false;
        }

 
    }

    void Start()
    {

    }


    void Update()
    {
        
    }

    public void StartNewGame() {
        //SceneManager.LoadScene("NewGameScene");
        StartCoroutine("LoadAsycLevel", "NewGameScene");
        FileInfo fi = new FileInfo(SavedSceneFilePath);

        if (fi.Exists)
        {
            File.Delete(SavedSceneFilePath);
        }
    }


    public void LoadGame() {
        //SceneManager.LoadScene("OldGameScene");
        StartCoroutine("LoadAsycLevel", "SavedGameScene");
    }

    public void QuitGame() {
        Application.Quit();

    }

    /// <summary>
    /// 异步加载场景
    /// </summary>
    IEnumerator LoadAsycLevel(string sceneName)
    {
        //异步加载场景
        prog = SceneManager.LoadSceneAsync(sceneName);
        //如果加载完成，也不进入场景
        prog.allowSceneActivation = false;

        //最终的进度
        int toProgress = 0;

        //显示的进度
        int showProgress = 0;

        //测试了一下，进度最大就是0.9
        while (prog.progress < 0.9f)
        {
            //toProcess具有随机性
            toProgress = (int)(prog.progress * 100);
            //Debug.Log((int)(prog.progress * 100));
            while (showProgress < toProgress)
            {
                showProgress++;

                //Debug.Log(string.Format("1-------toProgress={0},showProgress={1}", toProgress, showProgress));
                yield return new WaitForEndOfFrame(); //等待一帧
            }
        }
        //计算0.9---1   其实0.9就是加载好了，我估计真正进入到场景是1  
        toProgress = 100;

        while (showProgress < toProgress)
        {
            showProgress++;

            //Debug.Log(string.Format("2-------toProgress={0},showProgress={1}", toProgress, showProgress));
            yield return new WaitForEndOfFrame(); //等待一帧
        }

        prog.allowSceneActivation = true;  //如果加载完成，可以进入场景
    }



}
