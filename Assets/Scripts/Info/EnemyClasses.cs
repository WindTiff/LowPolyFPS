using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

/// <summary>
/// 敌人属性
/// </summary>
public enum EnemyType {
    Normal,
    Boss

}

[Serializable]
public class EnemyAttributes {

    public EnemyType type;
    public int level;
    public int max_HP;
    public int current_HP;
    public int move_speed;

    public int attack_damage;
    public int max_armor_value;
    public int current_armor_value;
    public int max_magic_resistance;
    public int current_magic_resistance;



}
