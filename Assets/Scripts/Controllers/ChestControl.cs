using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChestControl : MonoBehaviour
{



    public WeaponObject WeaponInChest;
    private Animator animator;


    void Start()
    {
        animator = GetComponent<Animator>();

    }

    void Update()
    {
        
    }

    public void ChestOpen() {
        animator.SetBool("open", true);

    }

}
