-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------              
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc', 'SB')
	state.OffenseMode:options('Normal', 'SB')
	
	state.AbrasionBolt = M(false, 'Abrasion Bolt')
	
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"

	DefaultAmmo = {['Fomalhaut'] = "Chrono Bullet", ['Gandiva'] = "Chrono Arrow", ['Gastraphetes'] = "Quelling Bolt", ['Annihilator'] = "Chrono Bullet", ['Anarchy +1'] = "Chrono Bullet"}
	U_Shot_Ammo = {['Fomalhaut'] = "Chrono Bullet", ['Gandiva'] = "Chrono Arrow", ['Gastraphetes'] = "Quelling Bolt", ['Annihilator'] = "Chrono Bullet"}
	Enfeeb_Ammo = {['Gastraphetes'] = "Crossbow Bolt"}

	send_command('bind f9 gs c cycle RangedMode')
	send_command('bind ^f9 gs c cycle OffenseMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
end


-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {hands="Sylvan Glovelettes +1",
		body={ name="Herculean Vest", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','Mag. Acc.+8','"Treasure Hunter"+1','Accuracy+4 Attack+4',}},
		feet={ name="Herculean Boots", augments={'Attack+7','Pet: Mag. Acc.+16','"Treasure Hunter"+2','Accuracy+3 Attack+3',}}, waist="Chaac Belt",}
	--sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	--sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +3"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +3"}
	sets.precast.JA['Velocity Shot'] = {body="Amini Caban +1"}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head={ name="Carmine Mask +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		body="Samnuha Coat",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Gyve Trousers",
		feet="Carmine Greaves",
		neck="Voltsurge Torque",
		waist="Sailfi Belt +1",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
	}
	--sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged sets ()
	
	sets.precast.RA = {
		head="Orion Beret +3",
		body="Oshosi Vest +1",
		hands="Carmine Finger Gauntlets +1",
		legs="Orion Braccae +2",
		feet="Meg. Jam. +2",
		neck={ name="Scout's Gorget +1", augments={'Path: A',}},
		waist="Yemaya Belt",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Crepsecular Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},
	}
	
	sets.precast.RA.Gastraphetes = {
		head="Orion Beret +3",
		body="Oshosi Vest +1",
		hands="Carmine Finger Gauntlets +1",
		legs="Osh. Trousers +1",
		feet="Meg. Jam. +2",
		neck={ name="Scout's Gorget +1", augments={'Path: A',}},
		waist="Yemaya Belt",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Crepsecular Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},
	}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nyame Helm",
		body={ name="Herculean Vest", augments={'Rng.Acc.+22 Rng.Atk.+22','Weapon skill damage +4%','Rng.Atk.+11',}},
		hands="Nyame Gauntlets",
		legs={ name="Herculean Trousers", augments={'Accuracy+13','Weapon skill damage +4%','DEX+1','Attack+11',}},
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Mache Earring +1",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Hot Shot'] = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Scout's Gorget +1",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Regal Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {body="Kyujutsugi",ring1="Hajduk Ring +1",
		back="Lutian Cape",legs="Orion Braccae +3"})
		
	sets.precast.WS['Rampage'] = {
		head="Adhemar Bonnet +1",
		body="Adhemar Jacket +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs="Samnuha Tights",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Hecate's Earring",
		left_ring="Apate Ring",
		right_ring="Pyrosoul Ring",
		back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.precast.WS['Evisceration'] = {
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Mummu Gamash. +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear2="Sherida Earring",
		ear1={ name="Moonshade Earring", augments={'Rng.Acc.+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
	}
	
	sets.precast.WS['Last Stand'] = {
		head="Orion Beret +3",
		body={ name="Herculean Vest", augments={'Rng.Acc.+22 Rng.Atk.+22','Weapon skill damage +4%','Rng.Atk.+11',}},
		hands="Nyame Gauntlets",
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet="Nyame Sollerets",
		neck="Scout's Gorget +1",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Acc.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
	}
		
	sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
	
	sets.precast.WS['Savage Blade'] = {
		--range={ name="Ataktos", augments={'Delay:+60','TP Bonus +1000',}},
		ammo="Chrono Bullet",
		head="Nyame Helm",
		body={ name="Herculean Vest", augments={'Attack+19','Weapon skill damage +3%','STR+3','Accuracy+11',}},
		hands="Nyame Gauntlets",
		legs={ name="Herculean Trousers", augments={'Accuracy+18','MND+9','Weapon skill damage +8%','Accuracy+7 Attack+7','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Rng.Acc.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.precast.WS['Decimation'] = sets.precast.WS['Rampage']
	sets.precast.WS['Trueflight'] = {
		head="",
		body="Cohort Cloak +1",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Scout's Gorget +1",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'Rng.Acc.+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Trueflight'], {left_ear="Ishvara Earring",})
	
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Wildfire']
	
	sets.precast.WS['Coronach'] = {
		head="Orion Beret +3",
		body={ name="Herculean Vest", augments={'Rng.Acc.+22 Rng.Atk.+22','Weapon skill damage +4%','Rng.Atk.+11',}},
		hands="Nyame Gauntlets",
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet="Nyame Sollerets",
		neck="Scout's Gorget +1",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Rng.Acc.+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
	}

	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	-- sets.midcast.FastRecast = {
		-- head="Orion Beret +1",ear1="Loquacious Earring",
		-- ring1="Prolix Ring",
		-- waist="Pya'ekue Belt +1",legs="Orion Braccae +1",feet="Orion Socks +1"}

	-- sets.midcast.Utsusemi = {}

	-- -- Ranged sets

	 sets.midcast.RA = {
		head="Arcadian Beret +3",
		body="Malignance Tabard",
		--body="Arc. Jerkin +3",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		--feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Enervating Earring",
		right_ear="Telos Earring",
		left_ring="Ilabrat Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	
	sets.midcast.RA.Aftermath = sets.midcast.RA
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		head="Orion Beret +3",neck="Iskur Gorget",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
		legs="Orion Braccae +3"})

	sets.midcast.RA.DoubleShot = set_combine(sets.midcast.RA, {
		head="Arc. Beret +3",
		body="Arc. Jerkin +3",
		hands="Carmine Finger Gauntlets +1",
		legs="Osh. Trousers +1",
		feet="Osh. Leggings +1",
	})

	-- sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA)

	-- sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc)

	-- sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {ear2="Clearview Earring",ring2="Rajas Ring",
		-- back="Sylvan Chlamys"})

	-- sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Acc, {ear2="Clearview Earring"})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	-- sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		-- ring1="Sheltered Ring",ring2="Paguroidea Ring"}

	-- Idle sets
	sets.idle = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Infused Earring",
		left_ring="Sheltered Ring",
		right_ring="Defending Ring",
		back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	}
	
	-- -- Defense sets
	-- sets.defense.PDT = {
		-- head="Whirlpool Mask",neck="Twilight Torque",
		-- body="Orion Jerkin +1",hands="Orion Bracers +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
		-- back="Mollusca Mantle",waist="Flume Belt +1",legs="Nahtirah Trousers",feet="Orion Socks +1"}

	-- sets.defense.MDT = {
		-- head="Orion Beret +1",neck="Twilight Torque",
		-- body="Orion Jerkin +1",hands="Orion Bracers +1",ring1="Defending Ring",ring2="Shadow Ring",
		-- back="Mollusca Cape",waist="Flume Belt +1",legs="Nahtirah Trousers",feet="Orion Socks +1"}

	sets.Kiting = {legs="Carmine Cuisses +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head="Malignance Chapeau",
	   -- body="Adhemar Jacket +1",
	    body="Malignance Tabard",
		hands="Malignance Gloves",
		--legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		legs="Malignance Tights",
		--feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
		feet="Malignance Boots",
		neck="Lissome Necklace",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Epona's Ring",
		back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	}

	 sets.engaged.Acc = sets.engaged
	 sets.engaged.SB = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist="Sailfi Belt +1",
		left_ear="Dignitary's Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},
	}
		
	sets.Obi = {
		waist="Hachirin-no-Obi"
	}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Barrage = set_combine(sets.midcast.RA, {hands="Orion Bracers +3"})
	sets.buff.Camouflage = {body="Orion Jerkin +3"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		--state.CombatWeapon:set(player.equipment.range)
	end

	if spell.action_type == 'Ranged Attack' or
	  (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end

	if spell.type == 'WeaponSkill' and spell.english == 'Trueflight' and (buffactive['Aurorastorm'] or world.day_element == "Light" or world.weather_element == "Light") then
		equip(set_combine(sets.precast.WS['Trueflight'], sets.Obi))
		eventArgs.handled = true
	end
	
	if spell.type == 'WeaponSkill' and spell.english == 'Wildfire' and (buffactive['Aurorastorm'] or world.day_element == 'Fire' or world.weather_element == 'Fire') then
		equip(set_combine(sets.precast.WS['Wildfire'], sets.Obi))
		eventArgs.handled = true
	end
	
	if spell.type == 'WeaponSkill' and spell.english == 'Aeolian Edge' and (buffactive['Windstorm'] or world.day_element == 'Wind' or world.weather_element == 'Wind') then
		equip(set_combine(sets.precast.WS['Aeolian Edge'], sets.Obi))
		eventArgs.handled = true
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
		equip(sets.buff.Barrage)
		eventArgs.handled = true
	elseif spell.action_type == 'Ranged Attack' and buffactive['Double Shot'] then
		equip(sets.midcast.RA.DoubleShot)
		eventArgs.handled = true
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.midcast.RA)
		eventArgs.handled = true
	end
	
	if spell.action_type == 'Ranged Attack' and (buffactive['Aftermath: Lv.3'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.1']) and player.equipment.range == 'Gandiva' then
		equip(sets.midcast.RA.Aftermath)
		eventArgs.handled = true
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	state.AbrasionBolt:reset()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] and not state.AbrasionBolt.value then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				elseif player.inventory[DefaultAmmo[player.equipment.range]] and state.AbrasionBolt.value then
					add_to_chat(122, "Using abrasion bolt.")
					equip({ammo=Enfeeb_Ammo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == DefaultAmmo[player.equipment.range] then
			if state.AbrasionBolt.value then
				equip({ammo=Enfeeb_Ammo[player.equipment.range]})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] and not state.AbrasionBolt.value then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				elseif player.inventory[DefaultAmmo[player.equipment.range]] and state.AbrasionBolt.value then
					add_to_chat(122, 'Using abrasion bolt')
					equip({ammo=Enfeeb_Ammo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 1)
end

