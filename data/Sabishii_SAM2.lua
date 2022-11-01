-- Setup vars that are user-dependent.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
	--include('Mote-TreasureHunter')
	state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false

	
	
end
function user_setup()
    state.OffenseMode:options('Normal','SomeAcc')
    state.HybridMode:options('Normal','PDT','Hybrid')
    state.WeaponskillMode:options('Normal','Acc')
	state.CapacityMode = M(false, 'Capacity Point Mantle')
  --  state.RangedMode:options('Normal', 'Acc')
  --  state.PhysicalDefenseMode:options('PDT')
	--state.MagicalDefenseMode:options('MDT')
	--state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal','Regen')
	--state.CombatWeapon:options('Doji','Masamune','Soboro','ShiningOne','Malevo')
	state.CombatWeapon =  M{['description']='Combat Weapon','Doji','Masamune','Soboro','ShiningOne','Malevolence'}
	
	gear.ws_jse_back = {}
	gear.stp_jse_back = {}
    -- Additional local binds
    
	send_command('bind @r gs c cycle CombatWeapon')
    select_default_macro_book()
	get_combat_weapon()
end
function user_unload()
   
    send_command('unbind @r')
end
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Meditate'] = {
	head="Wakido Kabuto +3",
	hands="Sakonji Kote +3",
	back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +1"}
	sets.precast.JA['Meikyo Shisui'] = {feet="Sakonji Sune-Ate +1"}
	
    sets.precast.Step = {}
    sets.precast.JA['Violent Flourish'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
	ammo="Sapience Orb",
    head="Nyame Helm",
    body="Nyame Mail",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Orunmila's Torque",
    waist="Ioskeha Belt +1",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Rahab Ring",
    right_ring="Prolix Ring",
   -- back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	   
    -- Ranged snapshot gear
    sets.precast.RA = {}
	   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Wakido Haidate +3",
		feet="Nyame Sollerets",
		neck="Samurai's Nodawa +1",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Sakonji Domaru +3",
		hands={ name="Valorous Mitts", augments={'Accuracy+7 Attack+7','Weapon skill damage +4%','STR+4','Accuracy+2','Attack+6',}},
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Lugra Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.Proc = {}
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].Acc = {
		ammo="Knobkierrie",
		head={ name="Sakonji Kabuto +3", augments={'Enhances "Ikishoten" effect',}},
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands="Wakido Kote +3",
		legs="Wakido Haidate +3",
		feet={ name="Sak. Sune-Ate +3", augments={'Enhances "Meikyo Shisui" effect',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Tachi: Fudo'].Normal = sets.precast.WS

	
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Shoha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Shoha'].Acc = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Sakonji Domaru +3",
		hands={ name="Valorous Mitts", augments={'Accuracy+7 Attack+7','Weapon skill damage +4%','STR+4','Accuracy+2','Attack+6',}},
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Flamma Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
    sets.precast.WS['Tachi: Shoha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS['Tachi: Shoha'].Normal = sets.precast.WS

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Rana'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Rana'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS['Tachi: Rana'].Normal = sets.precast.WS

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Kasha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Kasha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Kasha'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS['Tachi: Kasha'].Normal = sets.precast.WS

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Gekko'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Gekko'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Gekko'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS['Tachi: Gekko'].Normal = sets.precast.WS

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Yukikaze'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Yukikaze'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	sets.precast.WS['Tachi: Yukikaze'].Normal = sets.precast.WS
	
	sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Ageha'] = sets.precast.WS
		
    sets.precast.WS['Tachi: Hobaku'] = sets.precast.WS

    sets.precast.WS['Tachi: Jinpu'] = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Samurai's Nodowa +1",
		waist="Orpheus's Sash",
		ear2="Friomisi Earring",
		ear1={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	sets.precast.WS['Tachi: Koki'] = sets.precast.WS['Tachi: Jinpu']
	
	sets.precast.WS['Tachi: Goten'] = sets.precast.WS['Tachi: Jinpu']
	
	sets.precast.WS['Tachi: Kagero'] =sets.precast.WS['Tachi: Jinpu']
	
	sets.precast.WS['Impulse Drive'] = {
	ammo="Knobkierrie",
    head="Mpaca's Cap",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Nyame Gauntlets",
    legs="Wakido Haidate +3",
    feet="Nyame Sollerets",
    neck="Samurai's Nodowa +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Karieyh Ring +1",
    right_ring="Epaminondas's Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
	sets.precast.WS['Stardiver'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Mpaca's Cap",
		body={ name="Tatena. Harama. +1", augments={'Path: A',}},
		hands="Mpaca's Gloves",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Danzo Sune-Ate",
		neck="Samurai's Nodowa +1",
		waist="Fotia Belt",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS['Sonic Thrust'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands="Nyame Gauntlets",
		legs="Wakido Haidate +3",
		feet="Nyame Sollerets",
		neck="Samurai's Nodowa +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.precast.WS['Aeolian Edge'] = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	
    sets.precast.WS['Apex Arrow'] = {}
		
    sets.precast.WS['Apex Arrow'].SomeAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].FullAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {head="Nyame Helm",ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.AccMaxTP = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.AccDayMaxTPWSEars = {ear1="Thrud Earring",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Thrud Earring",ear2="Ishvara Earring"}
	sets.AccDayWSEars = {ear1="Telos Earring",ear2="Moonshade Earring"}
	sets.DayWSEars = {ear1="Thrud Earring",ear2="Moonshade Earring",}
	
    -- Midcast Sets
    sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Ken. Hakama +1",
		feet="Danzo Sune-Ate",
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Lebeche Ring",
		right_ring="Prolix Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
		
    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	
		
    -- Ranged gear
    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		ammo="Staunch Tathlum +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands={ name="Sakonji Kote +3", augments={'Enhances "Blade Bash" effect',}},
		legs="Ken. Hakama +1",
		feet="Danzo Sune-Ate",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	
	sets.CombatWeapon = { }
	sets.CombatWeapon.Doji =  {main="Dojikiri Yasutsuna",sub="Utu Grip"}
	sets.CombatWeapon.Masamune = {main="Masamune",sub="Utu Grip"}
	sets.CombatWeapon.ProcWeapon = {}
	sets.CombatWeapon.Bow = {}
	sets.CombatWeapon.Soboro =  {main="Soboro Sukehiro",sub="Utu Grip"}
	sets.CombatWeapon.ShiningOne= {main="Shining One",sub="Utu Grip"}
	sets.CombatWeapon.Malevolence = {main="Malevolence",sub="Malevolence"}
	
    sets.idle.Normal = {
		ammo="Staunch Tathlum +1",
		head="Wakido Kabuto +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.idle.Reraise = set_combine(sets.idle, sets.Reraise)

    sets.idle.Weak = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
		
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	sets.idle.Regen = {
		ammo="Staunch Tathlum +1",
		head="Mpaca's Cap",
		body="Hiza. Haramaki +2",
		hands={ name="Sakonji Kote +3", augments={'Enhances "Blade Bash" effect',}},
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Infused Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	
	
    
    -- Defense sets
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

    sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.Reraise)
		
    sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.Reraise)
	
    sets.defense.MEVA = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	}
	
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    
	-- Weapons sets
	
	
	
    sets.engaged.Normal = {
		ammo="Aurgelmir orb +1",
		head="Mpaca's cap",
		body="Kasuga Domaru +2",
		hands="Mpaca's Gloves",
		legs="Kasuga Haidate +2",
		feet="Mpaca's Boots",
		neck="Samurai's Nodowa +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    sets.engaged.SomeAcc = {}
	sets.engaged.Zanshin = {
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +1",
		hands="Wakido Kote +3",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Dedition Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.DTLite = {}
	sets.engaged.MEVA = {}

    sets.engaged.Acc = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +2",
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs="Kasuga Haidate +2",
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.FullAcc = { 
		ammo="Aurgelmir Orb +1",
		head="Kasuga Kabuto +2",
		body="Kasuga Domaru +2",
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs="Kasuga Haidate +2",
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.HybridMode = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Kasuga Kabuto +2",
		body="Kasuga Domaru +2",
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs="Kasuga Haidate +2",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    sets.engaged.Fodder = {}
    sets.engaged.PDT = { 
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Kasuga Kabuto +2",
		body="Kasuga Domaru +2",
		hands={ name="Tatena. Gote +1", augments={'Path: A',}},
		legs="Kasuga Haidate +2",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.Subtle = {
		ammo="Aurgelmir Orb +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Mpaca's Hose",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Schere Earring",
		left_ring="Chirich Ring +1",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.SubtleDT = {
		ammo="Aurgelmir Orb +1",
		head="Nyame Helm",
		body="Wakido Domaru +3",
		hands="Wakido Kote +3",
		legs="Mpaca's Hose",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Digni. Earring",
		left_ring="Defending Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	
	
    sets.engaged.SomeAcc.PDT = {}
    sets.engaged.Acc.PDT = {}
    sets.engaged.FullAcc.PDT = {}
    sets.engaged.Fodder.PDT = {}
	sets.engaged.DTLite = {}	
    sets.engaged.SomeAcc.DTLite = {}		
    sets.engaged.Acc.DTLite = {}	
    sets.engaged.FullAcc.DTLite = {}	
    sets.engaged.Fodder.DTLite = {}		

    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)		
    sets.engaged.SomeAcc.Reraise = set_combine(sets.engaged.SomeAcc, sets.Reraise)		
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)		
    sets.engaged.FullAcc.Reraise = set_combine(sets.engaged.FullAcc, sets.Reraise)		
    sets.engaged.Fodder.Reraise = set_combine(sets.engaged.Fodder, sets.Reraise)		
        
 
	
	-- Buff sets
	sets.Cure_Received = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		left_ring="Eshmun's Ring",
		right_ring="Eshmun's Ring",
	})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff.Hasso = {}
	sets.buff['Third Eye'] = {} --legs="Sakonji Haidate +3"
    sets.buff.Sekkanoki = {hands="Kasuga Kote +2"}
    sets.buff.Sengikori = {feet="Kas. Sune-Ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sak. Sune-Ate +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    
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

function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function customize_melee_set()
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
   
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end

--Job Specific Trust Overwrite
function job_precast(spell, action, spellMap, eventArgs)
	
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
    
    if not spell.interrupted then
        if spell.english == 'Spectral Jig' and buffactive['Sneak'] then
            send_command('cancel 71; cancel sneak')
        end
        if spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
            send_command('cancel 37; cancel stoneskin')
        end
        if spell.english == 'Sneak' then
            if spell.target.type == 'SELF' and buffactive['Sneak'] then
                send_command('cancel 71; cancel sneak')
            end
        end
        if spell.english == 'Monomi: Ichi' and buffactive['Sneak'] then
            send_command('cancel 71; cancel sneak')
        end
        if (spell.english == 'Reraise' or spell.english == 'Reraise II' or spell.english == 'Reraise III') then
            send_command('cancel 113; cancel Reraise*')
        end
    end
end

 function job_buff_change(buff, gain)
    
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    
    -- Warp ring rule, for any buff being lost
    if S{'Warp', 'Vocation', 'Capacity'}:contains(player.equipment.ring1) then
        if not buffactive['Dedication'] then
            disable('ring1')
        end
    else
        enable('ring1')
    end
    
    if buff == "Hasso" then
        if gain and not buffactive['Seigan'] then
            equip(sets.buff.Hasso)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
	if buff == "Seigan" then
        if gain and not buffactive['Hasso'] then
            equip(sets.buff.Seigan)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end

end
function get_combat_weapon()
	
end

 function job_handle_equipping_gear(playerStatus, eventArgs)
	check_CombatWeapon()
	--get_combat_form()
    --determine_haste_group()
    --check_moving()
end

function check_CombatWeapon()
	equip(sets[state.CombatWeapon.current])
end


function job_update(cmdParams, eventArgs)

	check_CombatWeapon()
   -- get_combat_weapon()
end

function job_aftercast(spell, action, spellMap, eventArgs)
	check_CombatWeapon()
end

function job_state_change(stateField, newValue, oldValue)
    
    check_CombatWeapon()
end

function customize_melee_set()
    check_CombatWeapon()

end
