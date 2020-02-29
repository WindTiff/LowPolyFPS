using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AreaControl : MonoBehaviour
{
    public string ControlType;

    public void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player") {
            GetComponentInParent<Animator>().SetBool(ControlType, true);

        }
    }

    public void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            GetComponentInParent<Animator>().SetBool(ControlType, false);

        }
    }
}
