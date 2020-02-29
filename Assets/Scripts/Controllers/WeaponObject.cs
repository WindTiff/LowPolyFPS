using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
///武器实体类 
/// </summary>

public class WeaponObject : MonoBehaviour
{

    [Header("武器属性")]
    public Weapon weapon;

    //子弹预制体
    public  GameObject bulletPrefab;

    private AudioSource audioSource;

    private float intervalCounter;//攻击间隔计数器




    /// <summary>
    /// 当武器装备之后由PlayerCombatControl Update调用
    /// </summary>
    public void WeaponUpdate() {
        if (intervalCounter < weapon.attack_interval)
        {
            intervalCounter += 0.02f;
        }

        


    }

    /// <summary>
    /// 点击攻击键之后调用
    /// </summary>
    public void WeaponAttack() {
        //播放攻击一次的音效

        
       
        if (intervalCounter >= weapon.attack_interval)
        {
            //如果是近战武器
            if (weapon.type == WeaponType.CloseWeapon)
            {
                print("近战武器攻击一次");
                 //播放攻击一次的动画
                transform.parent.GetComponent<Animator>().SetTrigger("attack");

            }
            else
            {//如果是远程武器

                if (weapon.current_bullet > 0) {
                    transform.parent.GetComponent<Animator>().SetTrigger("attack");
                    GetComponent<AudioSource>().PlayOneShot(GetComponent<AudioSource>().clip);
                    //生成子弹
                    GameObject bullet = Instantiate(bulletPrefab, transform.GetChild(0).position, Quaternion.identity);
                    bullet.GetComponent<BulletObject>().Damage = weapon.damage;
                    bullet.AddComponent<Rigidbody>().AddForce(transform.parent.forward * weapon.range, ForceMode.Force);

  

                    weapon.current_bullet--;

                    
                    print("远程武器攻击一次");

                }
                else if (weapon.current_bullet == 0)
                {
                    ReloadBullet();
                }

            }

            intervalCounter = 0;

        }





    }

    public void ReloadBullet() {

        //如果子弹是满的或者没有剩余的子弹则直接返回
        if (weapon.current_bullet == weapon.bullet_capacity || weapon.bullet_rest == 0) {
            return;
        }

        //播放换弹夹动画



        //播放换弹夹音效



        //换子弹
        int bullet_add = (weapon.bullet_rest >= (weapon.bullet_capacity - weapon.current_bullet)) ? (weapon.bullet_capacity - weapon.current_bullet) : weapon.bullet_rest;
        weapon.bullet_rest = weapon.bullet_rest - bullet_add;
        weapon.current_bullet += bullet_add;


    }

    public void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Enemy")
        {
            collision.gameObject.GetComponent<EnemyCombatControl>().GetHurt(weapon.damage);
        }
    }

    



}
