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
    state.Buff.Berserk = buffactive.berserk or false
    state.Buff.Retaliation = buffactive.retaliation or false
	state.WeaponSet = M{['description']='Weapon Set', 'Ukonvasara', 'Chango', 'Bravura', 'Montante', 'Shining_One','Xoanon', 'Naegling', 'Dolichenus', 'Farsha', 'Loxotic', 'Malevolence'}
	
	CombatForm = S{'GreatWeapon','OneHand', 'DW'}
	
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
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @e gs c cycleback WeaponSet')
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
	send_command('unbind @e')
end
 
       
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Augmented gear
	sets.offhand = {}
	sets.offhand.Shield = {sub = "Blurred Shield +1"}
	sets.offhand.DualWield = {sub = "Ikenga's Axe"}
    --DefaultShield = {"Blurred Shield +1"}
    Odyssean = {}
    Odyssean.Legs = {}
    Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'"Triple Atk."+2','"Mag.Atk.Bns."+5','Quadruple Attack +1','Accuracy+17 Attack+17',}}
    Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Weapon skill damage +5%','STR+7','Attack+10',}}
    --Odyssean.Feet = {}
    --Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}
	Odyssean.Hands	= {}
	Odyssean.Hands.WS = { name="Odyssean Gauntlets", augments={'CHR+8','Weapon skill damage +5%','Accuracy+19 Attack+19',}}
	
    Cichols = {}
    Cichols.TP = { name="Cichol's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','Accuracy+8','"Dbl.Atk."+10','Damage taken-5%',}}
    Cichols.WS = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    Cichols.VIT = { name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	Cichols.MAG = { name="Cichol's Mantle", augments={'STR+20','Mag. Acc+10 /Mag. Dmg.+10','Weapon skill damage +10%',}}
	Cichols.Crit = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}
	
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
     sets.precast.JA['Blood Rage'] = { body="Boii Lorica +2" }
     sets.precast.JA['Provoke'] = set_combine(sets.TreasureHunter, { hands="Pummeler's Mufflers +1"})
     sets.precast.JA['Berserk'] = { body="Pummeler's Lorica +3", feet="Agoge Calligae +3", back=Cichols.TP}
     sets.precast.JA['Warcry'] = { head="Agoge Mask +3"}
     sets.precast.JA['Mighty Strikes'] = { head="Agoge Mufflers +1"}
     sets.precast.JA['Retaliation'] = { hands="Pummeler's Mufflers +1", feet="Boii Calligae +1"}
     sets.precast.JA['Aggressor'] = { head="Pummeler's Mask +3", body="Agoge Lorica +3"}
     sets.precast.JA['Restraint'] = { hands="Boii  Mufflers +1"}
     sets.precast.JA["Warrior's Charge"] = { legs="Agoge Cuisses +3"}
	 sets.precast.JA['Tomahawk'] = {ammo = "Throwing Tomahawk", feet="Agoge Calligae +3"}
	 
     sets.CapacityMantle  = { back="Mecistopins Mantle" }
     --sets.Berserker       = { neck="Berserker's Torque" }
     --sets.WSDayBonus      = { head="Gavialis Helm" }
     -- TP ears for night and day, AM3 up and down. 
     --sets.BrutalLugra     = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
    -- sets.Lugra           = { ear1="Lugra Earring +1" }
    -- sets.Brutal          = { ear1="Brutal Earring" }
 
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
		 body="Sacro Breastplate",
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
         ear1="Thrud Earring",
         body="Pummeler's Lorica +3",
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
         hands="Nyame Gauntlets",
        --  ammo="Ginsen",
         --body="Flamma Korazin +2",
        --  head="Valorous Mask",
         --body="Ravenous Breastplate",
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         ear1="Cessance Earring",
     })
    sets.precast.WS['Metaton Torment'] = sets.precast.WS
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
		--neck="Fotia Gorget",
        back=Cichols.WS,
    	ring2="Regal Ring",
		ring1="Niqmaddu Ring",
        waist="Sailfi Belt +1",
    })
    sets.precast.WS['Upheaval'].Mid = set_combine(sets.precast.WS['Upheaval'], {
         back=Cichols.WS,
    })
 
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		head="Boii Mask +2",
        ammo="Yetshila +1",
    	body="Hjarrandi Breastplate",
		hands="Nyame Gauntlets",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        feet="Boii Calligae +2",
		back=Cichols.Crit,
    })
     -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
         head="Agoge Mask +3",
         neck="Warrior's Bead Necklace +2",
		 ear1="Moonshade Earring",
		 ear2="Schere Earring",
         ring1="Niqmaddu Ring",
		 ring2="Regal Ring",
         hands="Sakpata's Gauntlets",
         legs="Agoge's Cuisses +3",
    	 body="Agoge's Lorica +3",
         waist="Fotia Belt",
         feet="Nyame Sollerets",
		 back=Cichols.TP,
     })

     sets.precast.WS['Resolution'].Mid = set_combine(sets.precast.WS.Resolution, {
         --head="Flamma Zucchetto +2",
         ammo="Coiste Bodhar",
         --head="Valorous Mask",
     })
     sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 

    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        waist="Fotia Belt",
        legs="Sakpata's Cuisses",
    })
    sets.precast.WS['Impulse Drive'] = sets.precast.WS['Resolution']
	
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
		head="Agoge Mask +3",
        neck="Warrior's Bead Necklace +2",
		hands="Nyame Gauntlets",
		body="Pummeler's Lorica +3",
        legs="Boii Cuisses +2",
        waist="Sailfi Belt +1",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		feet="Nyame Sollerets",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
    })
	
	sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Cloudsplitter'] = {ammo="Seeth. Bomblet +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear="Thrud Earring",
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back=Cichols.MAG,
     }
	 sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Cloudsplitter']
     -- Sword WS's
     -- SANGUINE BLADE
     -- 50% MND / 50% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = {ammo="Seeth. Bomblet +1",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		ring2="Metamorph Ring +1",
		ring1="Archon Ring",
		back=Cichols.MAG,
     }
	
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)
	 
	 sets.precast.WS['Decimation'] = sets.precast.WS['Resolution']
	 sets.precast.WS['Ruinator'] = sets.precast.WS['Resolution']
     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
         neck="Fotia Gorget",
         back=Cichols.WS,
         waist="Fotia Belt",
     })
     sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
	 
	 sets.precast.WS['Cataclysm'] = sets.precast.WS['Sanguine Blade']
	 sets.precast.WS['Retribution'] = sets.precast.WS['Savage Blade']
     -- Resting sets
     sets.resting = {
         --head="Baghere Salade",
		 body="Sacro Breastplate",
         ring1="Moonbeam Ring",
         ring2="Paguroidea Ring",
     }
 
     -- Idle sets
     sets.idle = {
		---sub=DefaultShield,
		ammo = "Staunch Tathlum +1",
		head = Valorous.Head.Idle,
		neck = "Sanctity Necklace",
		ear1 = "Eabani earring",
		ear2 = "Infused Earring",
		body = "Sakpata's Breastplate",
		hands = "Sakpata's Gauntlets",
		ring2 = "Defending ring",
		ring1 = "Karieyh Ring +1",
		waist = "Flume Belt +1",
		legs = "Sakpata's Cuisses",
		--feet = "Hermes' Sandals",
		feet = "Sakpata's Leggings",
		--back="Solemnity Cape",
		back=Cichols.TP,
	}
     --sets.idle.OneHand = set_combine(sets.idle, {sub=DefaultShield})
 
     sets.idle.Weak = set_combine(sets.idle, {
		body="Sacro Breastplate",
        ring2="Paguroidea Ring",
        waist="Flume Belt +1",
     })
	--sets.idle.OneHand = set_combine(sets.idle, {sub="Blurred Shield +1"})
     -- Defense sets
     sets.defense.PDT = {
         ammo="Staunch Tathlum +1",
         head="Sakpata's Helm", -- no haste
         body="Sakpata's Plate", -- 3% haste
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses", -- 5% haste
         feet="Sakpata's Leggings", -- 3% haste
         neck="Loricate Torque +1",
         ring1="Moonbeam Ring",
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
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		--legs="Pummeler's Cuisses +3",
		--feet="Pummeler's Calligae +3",
		--neck="Lissome Necklace",
		neck="Warrior's Bead Necklace +2",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		ear1="Mache Earring +1",
		--right_ear="Schere Earring",
		ear2="Boii Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
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
         --ammo="Ginsen",
         body="Sakpata's Plate",
         ear1="Telos Earring",
         hands="Sakpata's Gauntlets",
         legs="Sakpata's Cuisses"
        --  back="Grounded Mantle +1",
     })

    sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)
	
	sets.Ukonvasara={main="Ukonvasara",sub="Utu Grip"}
	sets.Chango={main="Chango",sub="Utu Grip"}
	sets.Bravura={main="Bravura",sub="Utu Grip"}
	sets.Montante={main="Montante +1",sub="Utu Grip"}
	sets.Shining_One={main="Shining One",sub="Utu Grip"}
	sets.Xoanon={main="Xoanon",sub="Utu Grip",}
	sets.Naegling={main="Naegling",sub="Blurred Shield +1"}
	sets.Dolichenus={main="Dolichenus",sub="Blurred Shield +1"}
	sets.Farsha={main="Farsha",sub="Blurred Shield +1"}
	sets.Loxotic={main="Loxotic Mace +1",sub="Blurred Shield +1"}

	sets.Malevolence={main={name="Malevolence",bag="Wardobe5"},sub="Blurred Shield +1"}
	
	sets.engaged.DW = set_combine(sets.engaged, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
		--waist="Reiki Yotai"
     })
     sets.engaged.OneHand = set_combine(sets.engaged, sets.offhand.Shield, {head="Boii Mask +2", body="Boii Lorica +2", ear1="Telos Earring", ring2="Moonbeam Ring", legs="Pummeler's Cuisses +3", feet="Pummeler's Calligae +3", ear1="Schere Earring", ammo="Coiste Bodhar"})
	
     sets.engaged.OneHand.PDT = set_combine(sets.engaged.OneHand, sets.Defensive)
     sets.engaged.OneHand.Mid = set_combine(sets.engaged.OneHand, {
         body="Sakpata's Plate",
     })
     sets.engaged.OneHand.Mid.PDT = set_combine(sets.engaged.OneHand.Mid, sets.Defensive)

     sets.engaged.GreatWeapon = set_combine(sets.engaged, {sub="Utu Grip", head="Boii Mask +2", body="Boii Lorica +2", ear1="Telos Earring", ring2="Moonbeam Ring", legs="Pummeler's Cuisses +3", feet="Pummeler's Calligae +3", ear1="Schere Earring", ammo="Coiste Bodhar"})
     sets.engaged.GreatWeapon.Mid = set_combine(sets.engaged.Mid, {
         ear1="Telos Earring",
         --back="Grounded Mantle +1"
         --ring2="K'ayres RIng"
     })
     sets.engaged.GreatWeapon.Acc = set_combine(sets.engaged.Acc, {
     })
	sets.engaged.DW = sets.engaged.OneHand
	
     sets.engaged.Reraise = set_combine(sets.engaged, {
     	--head="Twilight Helm",neck="Twilight Torque",
     	--body="Twilight Mail"
     })
     sets.buff.Berserk = { 
         --feet="Agoge Calligae +3" 
     }
     sets.buff.Retaliation = { 
         --hands="Pummeler's Mufflers +1"
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
		--check_weaponset()
        get_combat_form()
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


function get_custom_wsmode(spell, spellMap, default_wsmode)
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


function get_combat_form()
    
    if S{'NIN', 'DNC'}:contains(player.sub_job) then
		if S{'Naegling', 'Dolichenus', 'Farsha', 'Loxotic Mace +1', "Malevolence"}:contains(player.equipment.main) then
			state.CombatForm:set("DW")
			--equip(sets.offhand.DualWield)
		else
			state.CombatForm:set("GreatWeapon")
		end
	else
		if S{'Naegling', 'Dolichenus', 'Farsha', 'Loxotic Mace +1', "Malevolence"}:contains(player.equipment.main) then
			state.CombatForm:set("OneHand")
			--equip(sets.offhand.Shield)			
			--equip({sub=DefaultShield})
		else
			state.CombatForm:set("GreatWeapon")
		end
	end
end

function job_update(cmdParams, eventArgs) 
	
	get_combat_form()
	check_weaponset()
end


function check_weaponset()
    get_combat_form()
	if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        equip(sets[state.WeaponSet.current].Acc)
    else
        equip(sets[state.WeaponSet.current])
    end  
	
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
		set_macro_page(1, 4)
	end
end