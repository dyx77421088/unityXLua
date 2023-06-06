-- float v = Input.GetAxis("Vertical");// Horizontal Vertical
-- float h = Input.GetAxis("Horizontal");// Horizontal Vertical
-- transform.position += new Vector3(h * Time.deltaTime * speed, 0, v * Time.deltaTime * speed);
print("正在销毁 Treasour.cs补丁")
xlua.hotfix(CS.Treasour, 'CreatePrize', nil)

print("正在销毁 Gun.cs补丁")
xlua.hotfix(CS.Gun, 'Attack', nil)

print("正在销毁 Boss.cs补丁")
xlua.hotfix(CS.Boss, 'Start', nil)

print("正在销毁 DeffendBoss.cs补丁")
xlua.hotfix(CS.DeffendBoss, 'Start', nil)

print("正在销毁 InvisibleBoss.cs补丁")
xlua.hotfix(CS.InvisibleBoss, 'Start', nil)


print("正在销毁 CreateFish.cs补丁")
xlua.hotfix(CS.CreateFish, 'Start', nil)
xlua.hotfix(CS.CreateFish, 'Update', nil)