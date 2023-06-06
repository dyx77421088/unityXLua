using System.IO;
using Unity.IO;
using UnityEditor;

public class CreateAssetBundle
{
    [MenuItem("Assets/build所有ab包")]
    public static void BuildAllAB()
    {
        string dir = "AssetBundles";
        if (!Directory.Exists(dir))
        {
            Directory.CreateDirectory(dir);
        }

        // 工程下所有的ab包都打包
        BuildPipeline.BuildAssetBundles(dir, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);

    }
}
