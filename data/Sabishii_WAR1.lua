--[[     
 === Notes ===
 this is incomplete. my war just hit 99
 Using warcry = Upheaval
 Using bloodrage = Ukko's
--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	--DefaultGrip = "Utu Grip"
	--DefaultShield = "Blurred Shield +1"
	--DefaultOffhand = "Ikenga's Axe"
    --state.Buff.Souleater = buffactive.souleater or false
    state.Buff.Berserk = buffactive.berserk or false
    state.Buff.Retaliation = buffactive.retaliation or false
    --state.WeaponSet = M{['description']='Weapon Set', 'GreatAxe', 'GreatSword', 'Polearm', 'Sword', 'Axe'}
	--state.SubWeaponSet = M{['description']='Weapon Set', 'Grip', 'Sword', 'Axe',}
    --wsList = S{ 'Savage Blade', 'Impulse Drive', 'Torcleaver', 'Ukko\'s Fury', 'Upheaval'}
	state.WeaponSet = M{['description']='Weapon Set', 'Lycurgos', 'Montante', 'Kaja_Lance', 'Naegling', 'Dolichenus'}
	war_main_weapons = {}
	war_main_weapons.Current = state.WeaponSet
	war_main_weapons.GreatWeapon= S{'Lycurgos',  'Lycurgos', 'Montante', 'Kaja_Lance'}
	war_main_weapons.OneHand = S{'Naegling', 'Dolichenus'}
    gsList = S{'Lycurgos', 'Montante +1', 'Kaja Lance'}
    war_sub_weapons = S{"Ikenga's Axe", "Blurred Shield +1", "Utu Grip"}
	--CombatForm = S{'OneHand', 'GreatWeapon', 'DW'}
	--subWeapon = M('Blurred Shield +1', 'Daybreak', "Sakpata's sword", "Gleti's Knife", 'Ibushi Shinai')
    get_combat_form()
    --get_combat_weapon()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    --war_sj = player.sub_job == 'WAR' or false
    state.drain = M(false)
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind @r gs c cycle WeaponSet')
    select_default_macro_book()
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
	send_command('unbind @r')
end
 
       
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Augmented gear
    
    Odyssean = {}
    Odyssean.Legs = {}
    Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'"Triple Atk."+2','"Mag.Atk.Bns."+5','Quadruple Attack +1','Accuracy+17 Attack+17',}}
    Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Weapon skill damage +5%','STR+7','Attack+10',}}
    --Odyssean.Feet = {}
    --Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}

    Cichols = {}
    Cichols.TP = { name="Cichol's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','Accuracy+8','"Dbl.Atk."+10','Damage taken-5%',}}
    Cichols.WS = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    Cichols.VIT = { name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	Cichols.MAG = { name="Cichol's Mantle", augments={'STR+20','Mag. Acc+10 /Mag. Dmg.+10','Weapon skill damage +10%',}}
	
    Valorous = {}
    Valorous.Feet = {}
    Valorous.Body = {}
	Valorous.Head = {}
	Valorous.Head.Idle = { name="Valorous Mask", augments={'Attack+20','"Store TP"+7','Accuracy+12',}}
	
    Valorous.Feet.TH = { name="Valorous Greaves", augments={'CHR+13','INT+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
    Valorous.Feet.TP = { name="Valorous Greaves", augments={'Accuracy+27','"Store TP"+6','INT+1',}}
    Valorous.Feet.WS ={ name="Valorous Greaves", augments={'Weapon skill damage +5%','STR+9','Accuracy+15','Attack+11',}}
    
    Valorous.Body.STP = { name="Valorous Mail", augments={'Accuracy+30','"Store TP"+6','DEX+3','Attack+14',}}
    Valorous.Body.DA = { name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Dbl.Atk."+4','VIT+4','Attack+6',}}
    
    sets.TreasureHunter = { 
        waist="Chaac Belt",
     }

     -- Precast Sets
     -- Precast sets to enhance JAs
     --sets.precast.JA['Mighty Strikes'] = {hands="Fallen's Finger Gauntlets +1"}
     sets.precast.JA['Blood Rage'] = { body="Boii Lorica +1" }
     sets.precast.JA['Provoke'] = set_combine(sets.TreasureHunter, { hands="Pummeler's Mufflers +1"})
     sets.precast.JA['Berserk'] = { body="Pummeler's Lorica +2", hands="Agoge Calligae", back=Cichols.TP, feet="Agoge Calligae"}
     sets.precast.JA['Warcry'] = { head="Agoge Mask +3"}
     sets.precast.JA['Mighty Strikes'] = { head="Agoge Mufflers"}
     sets.precast.JA['Retaliation'] = { hands="Pummeler's Mufflers +1", feet="Ravager's Calligae +2"}
     sets.precast.JA['Aggressor'] = { head="Pummeler's Mask +1", body="Agoge Lorica +2"}
     sets.precast.JA['Restraint'] = { hands="Ravager's Mufflers +2"}
     sets.precast.JA["Warrior's Charge"] = { legs="Agoge Cuisses +3"}

     sets.CapacityMantle  = { back="Mecistopins Mantle" }
     --sets.Berserker       = { neck="Berserker's Torque" }
     sets.WSDayBonus      = { head="Gavialis Helm" }
     -- TP ears for night and day, AM3 up and down. 
     sets.BrutalLugra     = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
     sets.Lugra           = { ear1="Lugra Earring +1" }
     sets.Brutal          = { ear1="Brutal Earring" }
 
     sets.reive = {neck="Ygnas's Resolve +1"}
     -- Waltz set (chr and vit)
     sets.precast.Waltz = {
        -- head="Yaoyotl Helm",
     }
            
     -- Fast cast sets for spells
     sets.precast.FC = {
         ammo="Impatiens",
         head="Sakpata's Helm",
         ear1="Loquacious Earring",
         hands="Leyline Gloves",
        -- ring1="Weatherspoon Ring", -- 10 macc
         ring2="Prolix Ring",
         legs="Eschite Cuisses",
         feet="Odyssean Greaves"
     }
     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

     -- Midcast Sets
     sets.midcast.FastRecast = {
         ammo="Impatiens",
        -- head="Otomi Helm",
         feet="Odyssean Greaves"
     }
            
     -- Specific spells
     sets.midcast.Utsusemi = {
         --head="Otomi Helm",
         feet="Odyssean Greaves"
     }
 
     -- Ranged for xbow
     sets.precast.RA = {
     }
     sets.midcast.RA = {
         head="Nyame Helm",
        --  neck="Iqabi Necklace",
         ear2="Crepuscular Earring",
         hands="Nyame Gauntlets",
         body="Nyame Mail",
         ring1="Cacoethic Ring +1",
         ring2="Crepuscular Ring",
         waist="Chaac Belt",
         legs="Nyame Flanchard",
         feet="Nyame Sollerets"
     }

     -- WEAPONSKILL SETS
     -- General sets
     sets.precast.WS = {
         ammo="Knobkierrie",
         head="Agoge Mask +3",
         neck="Warrior's Bead Necklace +2",
		 --neck="Fotia Gorget",
         ear2="Ishvara Earring",
         ear1="Moonshade Earring",
         body="Pummeler's Lorica +2",
         hands="Nyame Gauntlets",
         ring1="Niqmaddu Ring",
         ring2="Regal Ring",
		 back=Cichols.WS,
         --back=Cichols.WS,
         waist="Sailfi Belt +1",
         legs=Odyssean.Legs.WS,
         feet="Nyame Sollerets",
     }

     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
         hands="Odyssean Gauntlets",
        --  ammo="Ginsen",
         --body="Flamma Korazin +2",
        --  head="Valorous Mask",
         --body="Ravenous Breastplate",
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         ear1="Cessance Earring",
     })
    
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
         neck="Fotia Gorget",
         back=Cichols.WS,
    	--body=Valorous.Body.DA, 
        waist="Fotia Belt",
    })
    sets.precast.WS['Upheaval'].Mid = set_combine(sets.precast.WS['Upheaval'], {
         back=Cichols.WS,
    })
 
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
    	body="Hjarrandi Breastplate",
        neck="Fotia Gorget",
        waist="Sailfi Belt +1",
        feet="Nyame Sollerets"
    })
     -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
         head="Nyame Helm",
         neck="Fotia Gorget",
         ear1="Schere Earring",
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses",
    	 body="Sakpata's Plate'",
         waist="Fotia Belt",
         feet="Nyame Sollerets"
     })

     sets.precast.WS['Resolution'].Mid = set_combine(sets.precast.WS.Resolution, {
         head="Flamma Zucchetto +2",
         ammo="Coiste Bodhar",
         --head="Valorous Mask",
     })
     sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 



    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        waist="Fotia Belt",
        legs="Sakpata's Cuisses",
    })
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        head="Valorous Mask",
        neck="Fotia Gorget",
        ear1="Thrud Earring",
        waist="Sailfi Belt +1",
        feet="Nyame Sollerets"
    })
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Impulse Drive'], {
        ammo="Knobkierrie",
        neck="Warrior's Bead Necklace +2",
        legs="Sakpata's Cuisses",
        waist="Sailfi Belt +1",
    })
	
	 sets.precast.WS['Cloudsplitter'] = {ammo="Seeth. Bomblet +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear="Ishvara Earring",
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back=Cichols.MAG,
     }
     -- Sword WS's
     -- SANGUINE BLADE
     -- 50% MND / 50% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = {ammo="Seeth. Bomblet +1",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear="Ishvara Earring",
		right_ear="Friomisi Earring",
		ring2="Karieyh Ring +1",
		ring1="Archon Ring",
		back=Cichols.MAG,
     }
	
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)
	 
	 sets.precast.WS['Decimation'] = sets.precast.WS['Resolution']
     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
         neck="Fotia Gorget",
         back=Cichols.WS,
         waist="Fotia Belt",
     })
     sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
     -- Resting sets
     sets.resting = {
         --head="Baghere Salade",
         ring1="Dark Ring",
         ring2="Paguroidea Ring",
     }
 
     -- Idle sets
     sets.idle = {
		ammo = "Staunch Tathlum +1",
		head = Valorous.Head.Idle,
		neck = "Sanctity Necklace",
		ear1 = "Eabani earring",
		ear2 = "Infused Earring",
		body = "Sakpata's Plate",
		hands = "Sakpata's Gauntlets",
		ring2 = "Defending ring",
		ring1 = "Karieyh Ring +1",
		waist = "Flume Belt",
		legs = "Sakpata's Cuisses",
		--feet = "Hermes' Sandals",
		feet = "Sakpata's Leggings",
		--back="Solemnity Cape",
		back=Cichols.TP,
	}
     
 
     sets.idle.Weak = set_combine(sets.idle.Field, {
         ring2="Paguroidea Ring",
         waist="Flume Belt",
     })

     -- Defense sets
     sets.defense.PDT = {
         ammo="Staunch Tathlum +1",
         head="Sakpata's Helm", -- no haste
         body="Sakpata's Plate", -- 3% haste
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses", -- 5% haste
         feet="Sakpata's Leggings", -- 3% haste
         neck="Loricate Torque +1",
         ring1="Dark Ring",
         ring2="Defending Ring",
         waist="Sailfi Belt +1",
		 back=Cichols.TP,
     }
     sets.defense.Reraise = sets.idle.Weak
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Loricate Torque +1",
         ear1="Telos Earring",
     })
 
     sets.Kiting = {feet="Hermes' Sandals"}
 
     sets.Reraise = {head="Nyame Helm",body="Nyame Mail"}

     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
         ammo="Staunch Tathlum +1",
         head="Sakpata's Helm", -- no haste
         body="Sakpata's Plate", -- 3% haste
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses", -- 5% haste
         feet="Sakpata's Leggings", -- 3% haste
         neck="Loricate Torque +1",
         ring2="Defending Ring",
         waist="Sailfi Belt +1",
     }
     sets.Defensive_Acc = set_combine(sets.Defensive, {
         neck="Warrior's Bead Necklace +2",
         ring2="Regal Ring",
     })
 
     -- Engaged set, assumes Liberator
     sets.engaged = {
        ammo="Aurgelmir Orb +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Agoge Cuisses +3",
		feet="Pummeler's Calligae +2",
		--neck="Lissome Necklace",
		neck="Warrior's Bead Necklace +2",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Brutal Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back=Cichols.TP,
	}
     sets.engaged.Mid = set_combine(sets.engaged, {
         head="Hjarrandi Helm",
         ammo="Coiste Bodhar",
         neck="Warrior's Bead Necklace +2",
         ear1="Schere Earring",
         ear2="Brutal Earring",
         body="Sakpata's Plate'",
         --hands="Flamma Manopolas +2",
         hands="Sakpata's Gauntlets",
         ring1="Niqmaddu Ring",
         ring2="Flamma Ring",
         waist="Ioskeha Belt",
         legs="Tatenashi Haidate +1",
         feet="Tatenashi Sune-ate +1"
    	 --body="Flamma Korazin +2"
     })
     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
         ammo="Ginsen",
         body="Sakpata's Plate",
         ear1="Telos Earring",
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses"
        --  back="Grounded Mantle +1",
     })

    sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)
	
	--sets.DefaultGrip = {sub="Utu Grip"}
	--sets.DefaultShield = {sub="Blurred Shield +1"}
	sets.Lycurgos={main="Lycurgos"}
	sets.Montante={main="Montante +1"}
	sets.Kaja_Lance={main="Kaja Lance"}
	sets.Naegling={main="Naegling"}
	sets.Dolichenus={main="Dolichenus"}
	sets.DefaultGrip={sub="Utu Grip"}
	sets.DefaultShield={sub="Blurred Shield +1"}
	sets.DefaultOffhand={sub="Ikenga's Axe"}
	
     sets.engaged.DW = set_combine(sets.engaged, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
		waist="Reiki Yotai"
     })
     sets.engaged.OneHand = set_combine(sets.engaged, {
         ear1="Telos Earring",
         ear2="Cessance Earring",
         waist="Ioskeha Belt",

         --ring2="Hetairoi Ring"
        --ring1="Hetairoi Ring",
     })
	
     sets.engaged.OneHand.PDT = set_combine(sets.engaged.OneHand, sets.Defensive)
     sets.engaged.OneHand.Mid = set_combine(sets.engaged.OneHand, {
         body="Sakpata's Plate",
     })
     sets.engaged.OneHand.Mid.PDT = set_combine(sets.engaged.OneHand.Mid, sets.Defensive)

     sets.engaged.GreatWeapon = set_combine(sets.engaged, {sub="Utu Grip"})
     sets.engaged.GreatWeapon.Mid = set_combine(sets.engaged.Mid, {
         ear1="Telos Earring",
         --back="Grounded Mantle +1"
         --ring2="K'ayres RIng"
     })
     sets.engaged.GreatWeapon.Acc = set_combine(sets.engaged.Acc, {
     })

     sets.engaged.Reraise = set_combine(sets.engaged, {
     	--head="Twilight Helm",neck="Twilight Torque",
     	--body="Twilight Mail"
     })
     sets.buff.Berserk = { 
         --feet="Agoge Calligae +2" 
     }
     sets.buff.Retaliation = { 
         hands="Pummeler's Mufflers +1"
     }

end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    --elseif spell.target.distance > 8 and player.status == 'Engaged' then
    --    eventArgs.cancel = true
    --    add_to_chat(122,"Outside WS Range! /Canceling")
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end
 
function job_post_precast(spell, action, spellMap, eventArgs)

    -- Make sure abilities using head gear don't swap 
	--if spell.type:lower() == 'weaponskill' then
        -- handle Gavialis Helm
      --  if is_sc_element_today(spell) then
       --     if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
        --    else
                --equip(sets.WSDayBonus)
         --   end
        --end
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        
        -- if player.tp > 2999 then
        --     equip(sets.BrutalLugra)
        -- else -- use Lugra + moonshade
        --     if world.time >= (17*60) or world.time <= (7*60) then
        --         equip(sets.Lugra)
        --     else
        --         equip(sets.Brutal)
        --     end
        -- end
        -- Use SOA neck piece for WS in rieves
        if buffactive['Reive Mark'] then
            equip(sets.reive)
        end
    --end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
        equip(sets.buff.Berserk)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end



function job_post_aftercast(spell, action, spellMap, eventArgs)
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
    	meleeSet = set_combine(meleeSet, sets.buff.Berserk)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        if buffactive.Berserk and not state.Buff.Retaliation then
            equip(sets.buff.Berserk)
        end
		check_weaponset()
		check_weaponset()
        --get_combat_weapon()
    --elseif newStatus == 'Idle' then
    --    determine_idle_group()
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    
    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
    -- Warp ring rule, for any buff being lost
    if S{'Warp', 'Vocation', 'Capacity'}:contains(player.equipment.ring2) then
        if not buffactive['Dedication'] then
            disable('ring2')
        end
    else
        enable('ring2')
    end
    
    if buff == "Berserk" then
        if gain and not buffactive['Retaliation'] then
            equip(sets.buff.Berserk)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end

end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
    --war_sj = player.sub_job ~= 'DRG' or false
    get_combat_form()
	check_weaponset()
    --get_combat_weapon()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
    
	
    if S{'NIN', 'DNC'}:contains(player.sub_job) then
		if war_main_weapons.Current == war_main_weapons.OneHand then
			state.CombatForm:set("DW")
			--equip(set.DefaultOffhand)
			windower.add_to_chat(8, 'Player Subjob NIN or DNC and Weapon OneHanded, DWing')
		else
			state.CombatForm:Set("GreatWeapon")
			--equip(set.DefaultGrip)
			windower.add_to_chat(8, 'Player Subjob NIN or DNC and Weapon GreatWeapon')
		--check_weaponset()
		--equip(set.DefaultOffhand)
		end
    else
		if war_main_weapons.Current == war_main_weapons.OneHand then
			state.CombatForm:set("OneHand")
			--equip(set.DefaultShield)
			windower.add_to_chat(8, 'Player Subjob does not have DW and Weapon OneHanded, using Shield')
		else
			state.CombatForm:Set("GreatWeapon")
			--equip(set.DefaultGrip)
			windower.add_to_chat(8, 'Player Subjob does not have DW and Weapon GreatWeapon')
		--check_weaponset()
		--equip(set.DefaultOffhand)
		end
    end

end

function get_combat_weapon()
    if gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("GreatWeapon")
		equip(sets.DefaultGrip)
	else -- use regular set
        state.CombatWeapon:reset()
    end
end
function check_weaponset()
    if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        equip(sets[state.WeaponSet.current].Acc)
    else
        equip(sets[state.WeaponSet.current])
    end
	--if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
	--	if war_main_weapons.Current == war_main_weapons.OneHand then
	--		equip(set.DefaultOffhand)
	--	elseif war_main_weapons.Current == war_main_weapons.GreatWeapon then
	--		equip(set.DefaultGrip)
	--	else
	--		equip({sub=""})
	--	end
	--else
	--	if war_main_weapons.Current == war_main_weapons.OneHand then
	--		equip(set.DefaultShield)
	--	elseif war_main_weapons.Current == war_main_weapons.GreatWeapon then
	--		equip(set.DefaultGrip)
	--	else
	--		equip({sub=""})
	--	end
	--end
		
	--if player.sub_job ~= 'DRG' or player.sub_job ~= 'SAM' or player.sub_job == false then
        
    ---end
	
end
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    --if stateField == 'Look Cool' then
    --    if newValue == 'On' then
    --        send_command('gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
    --        --send_command('wait 1.2;gs c update user')
    --    else
    --        send_command('@input /lockstyle off')
    --    end
    --end
end

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'SAM' then
		set_macro_page(2, 4)
	else
		set_macro_page(2, 4)
	end
end
