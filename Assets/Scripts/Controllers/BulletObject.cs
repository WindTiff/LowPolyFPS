using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// 子弹实体
/// </summary>
public class BulletObject : MonoBehaviour
{

    private int damage;

    public int Damage {
        get {
            return damage;

        }
        set {
            damage = value;
        }

    }

    private void Start()
    {
        Destroy(gameObject, 2);
    }

    /// <summary>
    /// 如果碰撞到其他物体，产生不同效果
    /// </summary>
    /// <param name="collision"></param>
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Enemy") {
            collision.gameObject.GetComponent<EnemyCombatControl>().GetHurt(damage);
            GamePlayingUIControl.RefreshEnemyStateDisplay((float)collision.gameObject.GetComponent<EnemyCombatControl>().enemyAttributes.current_HP / (float)collision.gameObject.GetComponent<EnemyCombatControl>().enemyAttributes.max_HP);

            

        }

        Destroy(gameObject);//销毁自身
    }
}
