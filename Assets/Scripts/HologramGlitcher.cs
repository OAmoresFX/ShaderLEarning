using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HologramGlitcher : MonoBehaviour {

    public float glitchChance = 0.1f;

    private Renderer holoRenderer;
    private WaitForSeconds glitchLoopWait = new WaitForSeconds(.1f);
    private WaitForSeconds glitchDuration = new WaitForSeconds(.1f);

    private void Awake()
    {
        holoRenderer = GetComponent<Renderer>();
    }


    IEnumerator Start()
    {
        while (true)
        {
            float glichtTest = Random.RandomRange(0f, 1f);

            if (glichtTest <= glitchChance)
            {
                StartCoroutine(Glitch());


            }
            yield return glitchLoopWait;
         
        }
        
    }

    IEnumerator Glitch()
    {
        glitchDuration = new WaitForSeconds(Random.Range(.05f, .25f));
        holoRenderer.material.SetFloat("_Amount", .5f);
        holoRenderer.material.SetFloat("_CutoutThres", .29f);
        holoRenderer.material.SetFloat("_Amplitude", Random.Range(100, 250));
        holoRenderer.material.SetFloat("_Speed", Random.Range(1, 10));
        yield return glitchDuration;
        holoRenderer.material.SetFloat("_Amount", 0f);
        holoRenderer.material.SetFloat("_CutoutThres", 0f);


    }












}
