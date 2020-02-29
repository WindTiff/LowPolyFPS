using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

/// <summary>
/// 武器相关类
/// </summary>
public enum WeaponType {
    CloseWeapon,
    LongRangeWeapon
}


[Serializable]
/// <summary>
/// 武器基类
/// </summary>
public class Weapon {
    public WeaponType type;
    public string name;
    public string sprite_name;
    public string bullet_name;
    public int damage;
    public int current_bullet;
    public int bullet_capacity;
    public int bullet_rest;
    public float attack_interval;
    public string attack_sound;
    public string attack_animation;
    public int range;

}

/// <summary>
/// 枪械类
/// </summary>
/// 
//public class LongRangeWeapon : Weapon {

//    public int bullet_capacity;
//    public int current_bullet;

//    public string shoot_sound;
//    public string shoot_animation;
//}


/// <summary>
/// 近战武器类
/// </summary>
//public class CloseWeapon:Weapon {
//    public string attack_animation;
//    public string attack_sound;

//}
