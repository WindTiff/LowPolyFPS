using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

/// <summary>
/// 敌人战斗控制
/// 挂载位置：敌人
/// </summary>


public class EnemyCombatControl : MonoBehaviour
{

    [Header("敌人属性")]
    public EnemyAttributes enemyAttributes;


    private GameObject Player;
    //寻路临时测试
    public Transform Des;

    private Animator enemyAnimator;
    private NavMeshAgent agent;



    void Start()
    {
        //寻路临时测试
        agent = GetComponent<NavMeshAgent>();

        
        Player = GameObject.FindGameObjectWithTag("Player");
        enemyAnimator = GetComponent<Animator>();


    }


    void Update()
    {
        AnimatorControl();
    }



    /// <summary>
    /// 敌人动画控制
    /// </summary>
    public void AnimatorControl() {

        if (enemyAnimator.GetBool("close"))//当状态为接近玩家
        {
            transform.LookAt(new Vector3(Player.transform.position.x, transform.position.y, Player.transform.position.z), Vector3.up);//设定朝向为玩家
            agent.speed = 0;

        }
        if (enemyAnimator.GetBool("seen") && !enemyAnimator.GetBool("close"))//当状态为追逐玩家
        {
            agent.SetDestination(Player.transform.position);//设定寻路目标为玩家
            agent.speed = 1;
            //transform.LookAt(new Vector3(Player.transform.position.x, 0, Player.transform.position.z), Vector3.up);
            //transform.position += new Vector3(transform.forward.x, 0, transform.forward.z) * 0.006f;

        }


        if (enemyAttributes.current_HP <= 0 && !enemyAnimator.GetBool("die"))//当状态为死亡
        {
            agent.speed = enemyAttributes.move_speed/10;
            enemyAnimator.SetBool("die", true);
            enemyAnimator.SetBool("seen", false);
            enemyAnimator.SetBool("close", false);
            GetComponent<Collider>().enabled = false;
            Die();


        }

    }


    /// <summary>
    ///敌人攻击
    /// </summary>
    public void ZombieAttack() {
        Player.GetComponent<PlayerCombatControl>().PlayerGetHurt(enemyAttributes.attack_damage);
   

    }

    /// <summary>
    /// 死亡
    /// </summary>
    public void Die() {
        if (enemyAttributes.type == EnemyType.Normal)
        {

            transform.GetComponentInParent<BlockControl>().RemoveEnemyFromList(gameObject);//从区域敌人列表中将自己移除
            Destroy(gameObject, 2.5f);//销毁自身
        }
        else if (enemyAttributes.type == EnemyType.Boss) {
            print("sdsdsd");
            GetComponentInParent<SceneControl>().GoToNextLevel();
        }
    }

    public void GetHurt(int damage) {
        enemyAttributes.current_HP -= damage;
        if (enemyAttributes.current_HP < 0) enemyAttributes.current_HP = 0;

    }

   



}
