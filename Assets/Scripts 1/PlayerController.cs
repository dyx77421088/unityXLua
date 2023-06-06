using UnityEngine;
using XLua;

[Hotfix]
public class PlayerController : MonoBehaviour
{
    private float speed = 4f;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Move();
    }

    [LuaCallCSharp]
    private void Move()
    {
        float v = Input.GetAxis("Vertical");// Horizontal Vertical
        float h = Input.GetAxis("Horizontal");// Horizontal Vertical

        transform.position += new Vector3(h * Time.deltaTime * speed, 0, v * Time.deltaTime * speed);
    }
}
