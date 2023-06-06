-- for (int i = 0; i < 5; i++)
--         {
--             GameObject go = Instantiate(gold, transform.position + new Vector3(-10f + i * 30, 0, 0), transform.rotation);
--             go.transform.SetParent(cavas);
--             GameObject go1 = Instantiate(diamands, transform.position + new Vector3(0, 30, 0) + new Vector3(-10f + i * 30, 0, 0), transform.rotation);
--             go1.transform.SetParent(cavas);
--         }
print("正在给 Treasour.cs文件下的 CreatePrize 方法添加补丁....")
print("补丁内容：点击宝箱领取的金币钻石太拥挤，分散一点。")
local UnityEngine = CS.UnityEngine
xlua.hotfix(CS.Treasour, 'CreatePrize', function (self)
    for i = 0, 4, 1 do
        local go = UnityEngine.GameObject.Instantiate(self.gold, self.transform.position + UnityEngine.Vector3(-10 + i * 50, 0, 0), self.transform.rotation)
        go.transform.SetParent(go.transform, self.cavas)
        local go1 = UnityEngine.GameObject.Instantiate(self.diamands, self.transform.position + UnityEngine.Vector3(0, 30, 0) + UnityEngine.Vector3(-10 + i * 50, 0, 0), self.transform.rotation)
        go1.transform.SetParent(go1.transform, self.cavas)
    end
end)




-------------------------玩家金币钻石不够时没有相应处理。--------------------------------------------
print("正在给 Gun.cs文件下的 Attack 方法添加补丁....")
print("补丁内容：玩家金币钻石不够时没有相应处理。")
-- if (Input.GetMouseButtonDown(0))
--         {

--             bullectAudio.clip = bullectAudios[gunLevel - 1];
--             bullectAudio.Play();

--             if (Butterfly)
--             {
--                 Instantiate(Bullects[gunLevel - 1], attackPos.position, attackPos.rotation * Quaternion.Euler(0, 0, 20));
--                 Instantiate(Bullects[gunLevel - 1], attackPos.position, attackPos.rotation * Quaternion.Euler(0, 0, -20));
--             }

--             Instantiate(Bullects[gunLevel - 1], attackPos.position, attackPos.rotation);


--             if (!canShootForFree)
--             {
--                 GoldChange(-1 - (gunLevel - 1) * 2);

--             }
--             attackCD = 0;
--             attack = false;
--         }
xlua.hotfix(CS.Gun, 'Attack', function (self)
    if UnityEngine.Input.GetMouseButtonDown(0) then
        if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
            return
        end
        if self.gold == 0 or self.gold < 1 + (self.gunLevel - 1) * 2 then
            return
        end
        self.bullectAudio.clip = self.bullectAudios[self.gunLevel - 1]
        self.bullectAudio:Play()
        if self.Butterfly then
            UnityEngine.GameObject.Instantiate(self.Bullects[self.gunLevel - 1], self.attackPos.position, self.attackPos.rotation * UnityEngine.Quaternion.Euler(0, 0, 20))
            UnityEngine.GameObject.Instantiate(self.Bullects[self.gunLevel - 1], self.attackPos.position, self.attackPos.rotation * UnityEngine.Quaternion.Euler(0, 0, -20))
        end
        UnityEngine.GameObject.Instantiate(self.Bullects[self.gunLevel - 1], self.attackPos.position, self.attackPos.rotation)

        if not self.canShootForFree then
            self:GoldChange(-1 - (self.gunLevel - 1) * 2);
        end

        self.attackCD = 0;
        self.attack = false;
    end
end)





---------------------------------1.2 boss撞击玩家数值变动一样且不是减少是增加。---------------------------------------------------------
---------------------------------使用追加代码的形式。---------------------------------------------------------
local util = require 'util'
-- xlua.private_accessible(CS.Boss)
util.hotfix_ex(CS.Boss, 'Start', function (self)
    self.Start(self)
    self.m_reduceGold = self.m_reduceGold - 20
end)

util.hotfix_ex(CS.DeffendBoss, 'Start', function (self)
    self.Start(self)
    self.m_reduceGold = -30
end)

util.hotfix_ex(CS.InvisibleBoss, 'Start', function (self)
    self.Start(self)
    self.m_reduceDiamond = - 5
end)



------------------------------------------------------2.0.1.增加新鱼-----------------------------------------------------------------
xlua.hotfix(CS.CreateFish,'Start',function(self)
	CS.HotFixScript.LoadResource('level3fish3', 'gameobject/enemy.ab')
end)
xlua.hotfix(CS.CreateFish,'Update',function(self)
	self:CreateALotOfFish()

	--单种鱼的生成
        if self.ItemtimeVal>=0.5 then
        
            --位置随机数
            self.num =UnityEngine.Mathf.Floor(UnityEngine.Random.Range(0, 4)
			) 
            --游戏物体随机数
            self.ItemNum =UnityEngine.Mathf.Floor(UnityEngine.Random.Range(1, 101))

			local halfLength=self.fishList.Length/2

			local littlefishTypeIndex=UnityEngine.Mathf.Floor(UnityEngine.Random.Range(0,halfLength))

			local bigfishTypeIndex=UnityEngine.Mathf.Floor(UnityEngine.Random.Range(halfLength,self.fishList.Length))

			local itemTypeIndex=UnityEngine.Mathf.Floor(UnityEngine.Random.Range(0,self.item.Length))
			
            --产生气泡
            if self.ItemNum<20 then
            
                self:CreateGameObject(self.item[3])
                
            end
         
            if  self.ItemNum <= 42 then
				for i=0,2,1 do
					self:CreateGameObject(self.fishList[littlefishTypeIndex])
				end
				self:CreateGameObject(self.item[itemTypeIndex])
                
            elseif self.ItemNum >= 43 and self.ItemNum < 72 then
				for i=0,1,1 do
					self:CreateGameObject(self.fishList[bigfishTypeIndex])
				end
				self:CreateGameObject(self.item[itemTypeIndex])
--2.0 新鱼
			elseif self.ItemNum >= 73 and self.ItemNum < 83 then

				newFish = CS.HotFixScript.GetGameObjct('level3fish3')
                self:CreateGameObject(newFish)
            
            elseif self.ItemNum >= 84 and self.ItemNum < 86 then
            
				self:CreateGameObject(self.boss)


            elseif self.ItemNum >= 87 and self.ItemNum <= 88 then
            
				self:CreateGameObject(self.boss2)
            

            elseif self.ItemNum==100 then
            

                self:CreateGameObject(self.boss3)

            else
            
                self:CreateGameObject(self.item[0]);         
             
            end
            
			self.ItemtimeVal = 0
        else
        
            self.ItemtimeVal =self.ItemtimeVal+CS.UnityEngine.Time.deltaTime;
        end

end)











