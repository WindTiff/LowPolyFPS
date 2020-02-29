using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuUIControl : MonoBehaviour
{
    [Header("菜单控制脚本")]
    public MenuControl MC;
    [Header("加载游戏按钮")]
    public GameObject LoadGameButton;
    [Header("确认开启新游戏Panel")]
    public GameObject NewGameConfirmPanel;
    [Header("确认离开游戏Panel")]
    public GameObject QuitGameConfirmPanel;
    [Header("游戏设置Panel")]
    public GameObject GameSettigPanel;
    [Header("加载画面")]
    public GameObject LoadingPanel;

    void Start()
    {
        if (MC.HasSavedFile) {
            LoadGameButton.SetActive(true);
        }
    }

  
    void Update()
    {
        
    }

    public void PressStart() {
        if (MC.HasSavedFile)
        {
            NewGameConfirmPanel.SetActive(true);
        }
        else {
            MC.StartNewGame();
            LoadingPanel.SetActive(true);
        }

    }

    public void PressNewGameConfirmPanelConfirm() {
        MC.StartNewGame();
        LoadingPanel.SetActive(true);
    }
    public void PressNewGameConfirmPanelCancel()
    {
        NewGameConfirmPanel.SetActive(false);

    }
    public void PressLoad() {

        MC.LoadGame();
        LoadingPanel.SetActive(true);
    }


    public void PressSetting() {
        GameSettigPanel.SetActive(true);

    }


    public void PressQuit() {
        QuitGameConfirmPanel.SetActive(true);
    }

    public void PressQuitGameConfirm() {
        MC.QuitGame();
    }

    public void PressQuitGameCancel() {
        QuitGameConfirmPanel.SetActive(false);
    }



}
