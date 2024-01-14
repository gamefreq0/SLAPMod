print("[Randomizer] Mod loaded\n")

function SkipIntro()
    local PlayerClass = StaticFindObject("/Script/LevelSequence.LevelSequencePlayer")
    local IntroPlayer = FindObject(PlayerClass, nil, "/Game/FirstPersonBP/Maps/Map.Map:PersistentLevel.Intro.AnimationPlayer")
    IntroPlayer.DurationFrames = 1
    local FPCtrl = FindFirstOf("FirstPersonController_C")
    ExecuteWithDelay(1000, function ()
        FPCtrl:EnablePlayerInputActions()
        FPCtrl.MayMove = true
    end)
end

function SetUpHooks()
    Map = FindFirstOf("Map_C")
    if not Map:IsValid() then
        return
    end
    RegisterHook("/Game/FirstPersonBP/Maps/Map.Map_C:PlayIntro", SkipIntro)
end

RegisterHook("/Script/Engine.PlayerController:ClientRestart", SetUpHooks)

RegisterKeyBind(Key.F1, { ModifierKey.CONTROL }, function ()
    print("Key pressed!\n")
    ExecuteInGameThread(GetLookedActor)
end)