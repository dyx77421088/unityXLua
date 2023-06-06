using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;

public class HotFixScript : MonoBehaviour
{
    public static Dictionary<string, GameObject> prefabDict = new Dictionary<string, GameObject>(); 
    private LuaEnv luaEnv;
    private void Awake()
    {
        luaEnv = new LuaEnv();
        luaEnv.AddLoader(MyLoader);
        luaEnv.DoString("require'fish'");
    }
    void Start()
    {
        
    }

    private byte[] MyLoader(ref string filepath)
    {
        //string absPath = @"C:\Users\dyx\Desktop\project\unity\XLuaDemo\Lua\" + filepath + ".lua.txt";
        string absPath = @"C:\Users\dyx\Desktop\project\unity\XLuaDemo\Lua\" + filepath + ".lua";
        return System.Text.Encoding.UTF8.GetBytes(File.ReadAllText(absPath));
    }
    private void OnDisable()
    {
        luaEnv.DoString("require'fishDispose'");
    }
    private void OnDestroy()
    {
        luaEnv.Dispose();
    }

    [LuaCallCSharp]
    public static void LoadResource(string name, string filePath)
    {
        string rootPath = @"C:\Users\dyx\Desktop\project\unity\XLuaDemo\AssetBundles\";
        AssetBundle ab = AssetBundle.LoadFromFile(rootPath + filePath);
        GameObject go = ab.LoadAsset<GameObject>(name);
        prefabDict.Add(name, go);
    }
    [LuaCallCSharp]
    public static GameObject GetGameObjct(string name)
    {
        //return prefabDict.GetValueOrDefault(name);
        return prefabDict[name];
    }
}
