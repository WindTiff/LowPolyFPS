using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
/// <summary>
/// 角色战斗控制
/// 挂载位置：角色
/// 
/// </summary>

public class PlayerCombatControl : MonoBehaviour
{

    [SerializeField]
    public PlayerAttributes playerAttributes;

    //当前瞄准的物体
    [HideInInspector]
    public GameObject AimedObject;



    public GameObject WeaponHandle;
    //武器槽
    public List<WeaponObject> WeaponSlots = new List<WeaponObject>();
    //当前装备的武器
    public WeaponObject CurrentWeapon;

    //射线可交互层级
    public LayerMask HitLayers;

    //最大瞄准距离
    private int MaxAimDistance = 5;

    [Header("用来替换动画的AnimatorOverrider")]
    public AnimatorOverrideController animatorOverrideController;
    public RuntimeAnimatorController originalAnimatorController;

    private Animator weaponAnimator;

    void Start()
    {
        weaponAnimator = WeaponHandle.GetComponent<Animator>();
    }


    void Update()
    {
        
        RayAimControl();


    }

    private void FixedUpdate()
    {
        
        EquipedWeaponControl();
    }



    /// <summary>
    /// 射线控制
    /// </summary>
    public void RayAimControl()
    {
        Ray ray;
        ray = Camera.main.ScreenPointToRay(new Vector3(Screen.width / 2, Screen.height / 2, 0));
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, MaxAimDistance, HitLayers))
        {
            //如果瞄准的是可交互物体
            if (hit.collider.tag == "Weapon"|| hit.collider.tag == "Chest")
            {
                AimedObject = hit.transform.gameObject;
            }
            else
            {
                AimedObject = null;
            }
        }
        else {
            AimedObject = null;
        }
    }


    public void PlayerGetHurt(int damage) {
        playerAttributes.current_HP -= damage;
        if (playerAttributes.current_HP < 0) {
            playerAttributes.current_HP = 0;

          

        }

    }


    public void EquipedWeaponControl() {
        if (CurrentWeapon == null) return;
        CurrentWeapon.WeaponUpdate();
        

    }

    /// <summary>
    /// 切换武器函数
    /// </summary>
    public void SwapWeapon() {

        if (CurrentWeapon == null) return;

        //找到下一个非空武器，将其设置为当前武器
        int temp_index = WeaponSlots.IndexOf(CurrentWeapon);
        UnloadCurrentWeapon();
        CurrentWeapon = null;
        while (CurrentWeapon == null) {
            temp_index++;
            if (temp_index == WeaponSlots.Count) {
                temp_index = 0;
            }
            CurrentWeapon = WeaponSlots[temp_index];
        }
        //装备武器
        EquipWeapon(CurrentWeapon);

    }



    /// <summary>
    /// 武器攻击
    /// </summary>
    public void Attack() {
        //调用武器的攻击方法
        if (CurrentWeapon == null) return;
        CurrentWeapon.WeaponAttack();

    }


    /// <summary>
    /// 交互
    /// </summary>
    public void Interact() {
        if (AimedObject.tag == "Weapon")
        {
            PickUpWeapon(AimedObject.GetComponent<WeaponObject>());

        }
        else if (AimedObject.tag == "Chest") {
            AimedObject.GetComponentInParent<ChestControl>().ChestOpen();
        }

    }


    /// <summary>
    /// 释放技能
    /// </summary>
    public void ReleaseSkill() {


    }

    /// <summary>
    /// 拾取武器
    /// </summary>
    /// <param name="weaponObject"></param>
    public void PickUpWeapon(WeaponObject weaponObject) {
        
        //如果武器槽已满，则丢弃当前武器
        if (WeaponSlots.Count == 3)
        {
            DropWeapon(CurrentWeapon);
        }
        else
        {
            UnloadCurrentWeapon();//卸下当前武器
        }
        Destroy(weaponObject.gameObject.GetComponent<Rigidbody>());
        weaponObject.GetComponent<Collider>().enabled = false;
        WeaponSlots.Add(weaponObject);//添加武器
        EquipWeapon(weaponObject);//装备武器
    }


    /// <summary>
    /// 丢弃武器方法
    /// </summary>
    /// <param name="weaponObject"></param>
    public void DropWeapon(WeaponObject weaponObject) {
        WeaponSlots.Remove(weaponObject);//从武器槽中移除武器
        weaponObject.transform.parent = null;//丢弃武器
    }

    /// <summary>
    /// 卸下武器
    /// </summary>
    public void UnloadCurrentWeapon() {
        if (CurrentWeapon != null) {
            CurrentWeapon.gameObject.SetActive(false);
            weaponAnimator.runtimeAnimatorController = originalAnimatorController;
        }
    }


    /// <summary>
    /// 装备武器
    /// </summary>
    /// <param name="weaponObject"></param>
    public void EquipWeapon(WeaponObject weaponObject) {
        CurrentWeapon = weaponObject;
        weaponObject.transform.parent = WeaponHandle.transform;
        weaponObject.transform.localPosition = Vector3.zero;
        weaponObject.transform.localRotation = Quaternion.Euler(0, 0, 0);
        weaponObject.gameObject.SetActive(true);


        //装备武器后替换攻击动画
        animatorOverrideController.runtimeAnimatorController = weaponAnimator.runtimeAnimatorController;
        animatorOverrideController["AttackAnimationTemp"] = Resources.Load(CurrentWeapon.weapon.attack_animation) as AnimationClip;
        weaponAnimator.runtimeAnimatorController = animatorOverrideController;

    }



}
