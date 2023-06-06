using System.IO;
using Unity.IO;
using UnityEditor;

public class CreateAssetBundle
{
    [MenuItem("Assets/build����ab��")]
    public static void BuildAllAB()
    {
        string dir = "AssetBundles";
        if (!Directory.Exists(dir))
        {
            Directory.CreateDirectory(dir);
        }

        // ���������е�ab�������
        BuildPipeline.BuildAssetBundles(dir, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);

    }
}
