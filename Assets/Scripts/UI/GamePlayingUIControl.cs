using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


/// <summary>
/// 游戏进行时UI控制
/// </summary>
public class GamePlayingUIControl : MonoBehaviour
{

    //脚本引用
    [Header("战斗控制脚本")]
    public PlayerCombatControl PCC;
    [Header("场景控制脚本")]
    public SceneControl SC;

    private static Animator animator;



    //玩家信息控制
    [Header("交互按钮")]
    public Button InteractButton;
    [Header("当前使用武器的图标")]
    public Image CurrentWeaponSprite;
    [Header("角色血量")]
    public Slider HPSlider;
    [Header("子弹数量显示")]
    public Text BulletState;
    [Header("退出确认Panel")]
    public GameObject BackToMenuConfirmPanel;
    [Header("玩家死亡Panel")]
    public GameObject PlayerDeathPanel;
    [Header("通关Panel")]
    public GameObject ClearancePanel;
    [Header("攻击键")]
    public Button AttackButton;
    public bool isAttackPress;

    //敌人信息控制
    [Header("敌人信息显示")]
    public  Slider EnemyState;
    private static float enemyHPpercent = 0;
    private static float enemyStateDisplayTimer = 0;

    private void Awake()
    {
        animator = GetComponent<Animator>();
    }

    void Start()
    {
        
        
    }


    void Update()
    {

 
        InteractButtonControl();
        EnemyStateDisplayControl();
        RoleStateDisplayControl();


        if (isAttackPress) {
            PressAttack();
        }
        
    }

    private void FixedUpdate()
    {
        if (enemyStateDisplayTimer > 0) {
            enemyStateDisplayTimer -= 0.02f;
            if (enemyStateDisplayTimer < 0) {
                enemyStateDisplayTimer = 0;
            }
        }
       
    }


    public static void BlockClearHintOnce() {

        animator.SetTrigger("blockClearOnce");
    }


    /// <summary>
    /// 敌人信息显示控制
    /// </summary>
    public void EnemyStateDisplayControl() {

        EnemyState.value = enemyHPpercent;

        if (enemyStateDisplayTimer > 0)
        {
            EnemyState.gameObject.SetActive(true);
        }
        else {
            EnemyState.gameObject.SetActive(false);
        }

    }


    public static void  RefreshEnemyStateDisplay(float restLife) {
        if (restLife == 0) {
            enemyStateDisplayTimer = 0;
            return;
        }
        enemyHPpercent = restLife;
        enemyStateDisplayTimer = 4;

    }
    /// <summary>
    /// 交互按钮状态控制
    /// </summary>
    public void InteractButtonControl() {
        if (PCC.AimedObject != null)
        {
            if (PCC.AimedObject.tag == "Weapon"|| PCC.AimedObject.tag=="Chest")
            {
                //InteractButton的图片发生变化
                InteractButton.interactable = true;
            }

        }
        else {

            InteractButton.interactable = false;
        }

    }

    /// <summary>
    /// 攻击按键控制
    /// </summary>
    /// <param name="isPressed"></param>
    public void AttackButtonControl(bool isPressed) {
        if (isPressed)
        {
            isAttackPress = true;
        }
        else {
            isAttackPress = false;

              
        }

    }



    /// <summary>
    /// 手持武器状态显示控制
    /// </summary>
    public void RoleStateDisplayControl() {

        //子弹信息显示控制
        if (PCC.CurrentWeapon != null)
        {
            CurrentWeaponSprite.enabled = true;
            if (PCC.CurrentWeapon.weapon.type == WeaponType.CloseWeapon)
            {

                //子弹信息显示控制
                BulletState.enabled = false;
                //武器图片显示控制
                CurrentWeaponSprite.transform.GetChild(0).gameObject.SetActive(true);
                CurrentWeaponSprite.transform.GetChild(1).gameObject.SetActive(false);
            }
            else
            {

                //子弹信息显示控制
                BulletState.enabled = true;
                BulletState.text = "[" + PCC.CurrentWeapon.weapon.current_bullet + "/" + PCC.CurrentWeapon.weapon.bullet_rest + "]";

                //武器图片显示控制
                CurrentWeaponSprite.transform.GetChild(0).gameObject.SetActive(false);
                CurrentWeaponSprite.transform.GetChild(1).gameObject.SetActive(true);
            }

        }
        else {
            CurrentWeaponSprite.enabled = false;
        }

        //角色属性显示控制

        HPSlider.value =(float)PCC.playerAttributes.current_HP / (float)PCC.playerAttributes.max_HP;
        if (HPSlider.value == 0 && !PlayerDeathPanel.activeSelf) {
            PlayerDeathPanel.SetActive(true);
            PauseGame();
        }

    }


    /// <summary>
    /// 按下攻击键
    /// </summary>
    public void PressAttack() {
        //调用PlayerCombatControl  Attack
        PCC.Attack();

    }

    /// <summary>
    /// 按下交互键
    /// </summary>
    public void PressInteract() {
        //调用PlayerCombatControl Interact
        PCC.Interact();
    }

    /// <summary>
    /// 按下更换武器键
    /// </summary>
    public void PressSwap() {
        //根据更换之后的武器更改 容量显示
        PCC.SwapWeapon();


    }
    /// <summary>
    /// 点击头像
    /// </summary>
    public void PressPortrait() {
        //

    }

    /// <summary>
    /// 按下技能键
    /// </summary>
    public void PressSkill() {
       


    }

    public void PressBackToMenu() {
        BackToMenuConfirmPanel.SetActive(true);
        PauseGame();
    }

    public void PressConfirmBackToMenu() {
        ResumeGame();
        //保存场景关卡信息
        SC.SaveCurrentScene();
        //保存角色信息

        //加载到菜单场景

        SC.LoadToStartScene();

    }

    public void PressCancelBackToMenu() {
        ResumeGame();
        BackToMenuConfirmPanel.SetActive(false);
    }

    public void PressDeathPanelReturn() {
        ResumeGame();
        SC.LoadToStartScene();

    }

    public static void PauseGame() {
        Time.timeScale = 0;
    }

    public static void ResumeGame() {
        Time.timeScale = 1;
    }

    public void PressClearancePanelReturn() {

        SC.LoadToStartScene();
    }

    public void ClearancePanelShow() {
        ClearancePanel.SetActive(true);
    }

}
