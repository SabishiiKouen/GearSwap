-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle luzafring -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    Acc on offense mode (which is intended for melee) will currently use .Acc weaponskill
    mode for both melee and ranged weaponskills.  Need to fix that in core.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
	-- Detect Triple Shot
	state.Buff['Triple Shot'] = buffactive['Triple Shot'] or false
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
	state.Obi = 'OFF' -- Turn Default Obi ON or OFF Here --

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Decimating Bullet"
    gear.WSbullet = "Decimating Bullet"
    gear.MAbullet = "Decimating Bullet"
    gear.QDbullet = "Animikii Bullet"
	gear.WScape = {name="Camulus's Mantle"}
	gear.PRcape = {name="Camulus's Mantle"}
    options.ammo_warning_limit = 15

	cor_sub_weapons = S{"Fettering Blade", "Demersal Degen", "Arendsi Fleuret", "Vanir Knife", "Sabebus", "Aphotic Kukri", "Atoyac", "Surcouf's Jambiya"}
    -- Additional local binds
	send_command('bind ^` input //gs c toggle luzafring')
	
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()

	send_command('unbind ^`')

end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
	
		sets.Obi = {}
	sets.Obi.Thunder = {waist='Hachirin-no-Obi'}
	sets.Obi.Water = {waist='Hachirin-no-Obi'}
	sets.Obi.Fire = {waist='Hachirin-no-Obi'}
	sets.Obi.Ice = {waist='Hachirin-no-Obi'}
	sets.Obi.Wind = {waist='Hachirin-no-Obi'}
	sets.Obi.Earth = {waist='Hachirin-no-Obi'}
	sets.Obi.Light = {waist='Hachirin-no-Obi'}
	sets.Obi.Dark = {waist='Hachirin-no-Obi'}

	
	sets.precast.CorsairRoll = {head="Lanun Tricorne +1",hands="Chasseur's Gants +1", ring2="Barataria Ring", back=gear.PRcape}
	
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
	
	sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
	sets.precast.FoldDoubleBust = {hands="Chasseur's Gants +1"}
	
	sets.precast.CorsairShot = {head=""}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",
		body="Iuitl Vest",hands="Iuitl Wristbands",
		legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {head="Carmine Mask +1", ear1="Loquac. earring",ear2="Enchanter's Earring +1",
					 body="Lanun frac +1", hands="Leyline Gloves", ring1="Prolix ring", ring2="Weatherspoon ring",
					 waist="Witful Belt", legs="Carmine Cuisses +1", feet="Carmine Greaves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	sets.precast.RA = {ammo=gear.RAbullet,
		head="Chasseur's Tricorne +1",neck="Sanctity Necklace", ear1="Volley Earring",ear2="Clearview Earring",
		body="Pursuer's Doublet",hands="Carmine Finger Gauntlets",ring1="Garuda Ring",ring2="Garuda Ring",
		back=gear.WScape,waist="Impulse Belt",legs="Adhemar Kecks",feet="Pursuer's Gaiters"}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Chasseur's Tricorne +1",body="Adhemar Jacket",hands={ name="Herculean Gloves", augments={'Rng.Acc.+30','"Subtle Blow"+10','AGI+5','Rng.Atk.+12',}},legs="Adhemar Kecks",
		feet="Pursuer's Gaiters",neck="Fotia Gorget",waist="Fotia belt",ear1="Moonshade Earring",
		ear2="Brutal Earring",ring1="Garuda Ring",ring2="Garuda Ring",back="Gunslinger's Cape"}	


	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = sets.precast.WS

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Adhemar Kecks"})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {legs="Adhemar Kecks"})

	sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
		head="Chasseur's Tricorne +1", neck="Fotia Gorget", ear1="Ishvara earring", ear2="Moonshade earring",
		body="Pursuer's Doublet", hands={ name="Herculean Gloves", augments={'Rng.Acc.+30','"Subtle Blow"+10','AGI+5','Rng.Atk.+12',}},ring1="Garuda ring", ring2="Garuda ring",
		back="Gunslinger's Cape", waist="Fotia belt", legs="Pursuer's Pants", feet="Pursuer's Gaiters"}

	sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
		head="Chasseur's Tricorne +1", neck="Sanctity Necklace", ear1="Ishvara earring", ear2="Moonshade earring",
		body="Pursuer's Doublet", hands={ name="Herculean Gloves", augments={'Rng.Acc.+30','"Subtle Blow"+10','AGI+5','Rng.Atk.+12',}},ring1="Garuda ring", ring2="Garuda ring",
		back="Gunslinger's Cape", waist="Fotia belt", legs="Adhemar Kecks", feet="Pursuer's Gaiters"}

	sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
		head="Herculean Helm", neck="Sanctity Necklace", ear1="Friomisi earring", ear2="Moonshade earring",
		body="Samnuha Coat", hands="Leyline Gloves", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		back="Gunslinger's cape", waist="Fotia belt",
		legs={ name="Herculean Trousers", augments={'"Fast Cast"+1','"Store TP"+3','Quadruple Attack +2','Accuracy+2 Attack+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}

	sets.precast.WS['Wildfire'].Brew = {ammo=gear.MAbullet,
		head="Herculean Helm", neck="Sanctity Necklace", ear1="Friomisi earring", ear2="Moonshade earring",
		body="Samnuha Coat", hands="Leyline Gloves", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
		back="Gunslinger's cape", waist="Eschan Stone",
		legs={ name="Herculean Trousers", augments={'"Fast Cast"+1','"Store TP"+3','Quadruple Attack +2','Accuracy+2 Attack+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}
	
	sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Archon Ring",
		back=gear.WScape,waist="Eschan Stone",
		legs={ name="Herculean Trousers", augments={'"Fast Cast"+1','"Store TP"+3','Quadruple Attack +2','Accuracy+2 Attack+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}
		
	sets.precast.WS['Aeolian Edge'] = {ammo=gear.QDbullet,
		head="Herculean Helm",neck="Sanctity Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=gear.WScape,waist="Fotia Belt",
		legs={ name="Herculean Trousers", augments={'"Fast Cast"+1','"Store TP"+3','Quadruple Attack +2','Accuracy+2 Attack+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Carmine Mask +1", ear1="Loquac. earring",ear2="Enchanter's Earring +1",
		body="Lanun frac +1", hands="Leyline Gloves", ring1="Prolix ring", ring2="Weatherspoon ring",
		waist="Witful Belt", legs="Carmine Cuisses +1", feet="Carmine Greaves"}
		
	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	sets.midcast.CorsairShot = {ammo=gear.QDbullet,
		head="Herculean Helm",neck="Deviant Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=gear.WScape,waist="Eschan Stone",
		legs={ name="Herculean Trousers", augments={'"Fast Cast"+1','"Store TP"+3','Quadruple Attack +2','Accuracy+2 Attack+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},feet="Chass. Bottes +1"}

	sets.midcast.CorsairShot.Acc = {ammo=gear.QDbullet,
		head="Herculean Helm",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back=gear.WScape,waist="Eschan Stone",legs={ name="Herculean Trousers", augments={'"Fast Cast"+1','"Store TP"+3','Quadruple Attack +2','Accuracy+2 Attack+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		feet="Chass. Bottes +1"}

	sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
		head="Herculean Helm",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Garuda Ring",ring2="Garuda Ring",
		back=gear.WScape,waist=gear.ElementalObi,
		legs={ name="Herculean Trousers", augments={'"Fast Cast"+1','"Store TP"+3','Quadruple Attack +2','Accuracy+2 Attack+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},feet="Chass. Bottes +1"}

	sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


	-- Ranged gear
	sets.midcast.RA = {ammo=gear.RAbullet,
		head="Chass. Tricorne +1",neck="Marked Gorget",ear1="Volley Earring",ear2="Enervating Earring",
		body="Pursuer's Doublet",hands={ name="Herculean Gloves", augments={'Rng.Acc.+30','"Subtle Blow"+10','AGI+5','Rng.Atk.+12',}},ring1="Hajduk ring",ring2="Cacoethic Ring +1",
		back=gear.WScape,waist="Yemaya Belt", legs="Adhemar Kecks", feet="Pursuer's Gaiters"}
		
	sets.midcast.TS = {ammo=gear.RAbullet,
		head="Chass. Tricorne +1",neck="Marked Gorget",ear1="Volley Earring",ear2="Enervating Earring",
		body="Pursuer's Doublet",hands={ name="Herculean Gloves", augments={'Rng.Acc.+30','"Subtle Blow"+10','AGI+5','Rng.Atk.+12',}},ring1="Hajduk ring",ring2="Cacoethic Ring +1",
		back=gear.WScape,waist="Yemaya Belt",legs="Adhemar Kecks",feet="Pursuer's Gaiters"}

	sets.midcast.RA.Acc = {ammo=gear.RAbullet,
		head="Chass. Tricorne +1",neck="Marked Gorget",ear1="Volley Earring",ear2="Enervating Earring",
		body="Pursuer's Doublet",hands={ name="Herculean Gloves", augments={'Rng.Acc.+30','"Subtle Blow"+10','AGI+5','Rng.Atk.+12',}},ring1="Hajduk Ring",ring2="Cacoethic Ring +1",
		back=gear.WScape,waist="Eschan Stone",legs="Adhemar Kecks",feet="Pursuer's Gaiters"}
	


	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets
	sets.idle = {ammo=gear.RAbullet,
		head="Rawhide Mask",neck="Sanctity Necklace",ear1="Volley Earring",ear2="Enervating Earring",
		body="Mekosu. Harness",
		hands={ name="Herculean Gloves", augments={'Pet: Accuracy+4 Pet: Rng. Acc.+4','Pet: INT+6','"Refresh"+1','Accuracy+2 Attack+2',}},ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back=gear.WScape,waist="Flume Belt",legs="Carmine Cuisses +1",feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}
		

	-- Defense sets
	sets.defense.PDT = {
		head="Lithelimb Cap",neck="Twilight Torque",
		body="Emet Harness",hands={ name="Herculean Gloves", augments={'Pet: Accuracy+4 Pet: Rng. Acc.+4','Pet: INT+6','"Refresh"+1','Accuracy+2 Attack+2',}},ring1="Defending Ring",ring2="Archon Ring",
		back="Solemnity Cape",waist="Flume Belt",legs={ name="Herculean Trousers", augments={'Accuracy+22 Attack+22','"Store TP"+1','STR+6','Accuracy+10',}},feet="Lanun Bottes +1"}

	sets.defense.MDT = {
		head="Lithelimb Cap",neck="Twilight Torque",
		body="Emet Harness",hands={ name="Herculean Gloves", augments={'Pet: Accuracy+4 Pet: Rng. Acc.+4','Pet: INT+6','"Refresh"+1','Accuracy+2 Attack+2',}},ring1="Defending Ring",ring2="Archon Ring",
		back="Solemnity Cape",waist="Flume Belt",legs={ name="Herculean Trousers", augments={'Accuracy+22 Attack+22','"Store TP"+1','STR+6','Accuracy+10',}},feet="Lanun Bottes +1"}
	

	sets.Kiting = {feet="Carmine Cuisses +1"}
	-- buff sets
	 sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"}
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	
	sets.engaged = {ammo=gear.RAbullet,
		head="Chass. Tricorne +1",neck="Marked Gorget",ear1="Volley Earring",ear2="Enervating Earring",
		body="Pursuer's Doublet",hands="Herculean Gloves",ring1="Cacoethic ring +1",ring2="Hajduk ring",
		back=gear.WScape,waist="Yemaya Belt", legs="Adhemar Kecks", feet="Pursuer's Gaiters"}
	sets.engaged.Melee = {ammo=gear.RAbullet,
		head="Dampening Tam",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Cacoethic ring +1",ring2="Petrov Ring",
		back="Bleating Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
	
	sets.engaged.Acc = {ammo=gear.RAbullet,
		head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Mekosu. Harness",hands="Adhemar Wristbands",ring1="Cacoethic ring +1",ring2="Ramuh Ring +1",
		back="Bleating Mantle",waist="Kentarch Belt",legs="Carmine Cuisses +1",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}

	sets.engaged.DW = set_combine(sets.engaged.Melee, {ammo=gear.RAbullet,
		head="Dampening Tam",neck="Sanctity Necklace",ear1="Cessance Earring",ear2="Suppanomimi",
		body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Cacoethic ring +1",ring2="Petrov Ring",
		back="Bleating Mantle",waist="Kentarch Belt",legs="Carmine Cuisses +1",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},})

	sets.engaged.DW.Acc = set_combine(sets.engaged.Melee.DW, {ammo=gear.RAbullet,
		head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Zennaroi Earring",ear2="Suppanomimi",
		body="Lanun Frac +1",hands="Floral Gauntlets",ring1="Cacoethic ring +1",ring2="Ramuh Ring +1",
		back="Bleating Mantle",waist="Kentarch Belt",legs="Carmine Cuisses +1",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},})

		
	sets.engaged.TS = {ammo=gear.RAbullet,
		head="Chass. Tricorne +1",neck="Marked Gorget",ear1="Volley Earring",ear2="Enervating Earring",
		body="Pursuer's Doublet",hands="Herculean Gloves",ring1="Cacoethic ring +1",ring2="Hajduk ring",
		back=gear.WScape,waist="Yemaya Belt", legs="Adhemar Kecks", feet="Pursuer's Gaiters"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end
    -- Define proper defaults for weaponskills that use obis
    if spell.english == 'Leaden Salute' then
        gear.default.obi_waist = "Eschan Stone"
		gear.default.obi_ring = "Arvina Ringlet +1"
    elseif spell.english == 'Wildfire' then
        gear.default.obi_waist = "Eschan Stone"
		gear.default.obi_ring = "Garuda Ring"
	elseif spell.type == 'CorsairShot' then
        gear.default.obi_waist = "Eschan Stone"
		gear.default.obi_ring = "Fenrir Ring +1"
	end
    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
	
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


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
end

function job_self_command(cmdParams, eventArgs)
	if command == 'coffer' then
		cycle = 0
		invCount = windower.ffxi.get_bag_info(0).count
		if invCount == 80 then
			add_to_chat(140,'Inv. full. Ending cycle')
		elseif player.inventory["Velkk Coffer"] then
			send_command('input /item "Velkk Coffer"')
			cycle = 1
		else
			add_to_chat(140,'No Coffers found in inv.')
			send_command('findall Velkk Coffer')
		end
		if cycle == 1 then
			send_command('wait 2;gc c coffer')
		end
	end
end

function get_combat_form()
    if cor_sub_weapons:contains(player.equipment.main) then
        if S{'NIN', 'DNC'}:contains(player.sub_job) and cor_sub_weapons:contains(player.equipment.sub) then
            state.CombatForm:set("DW")
        else
            state.CombatForm:reset()
        end
    else
        state.CombatForm:set('Normal')
    end
end
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. (state.LuzafRing.value and 'Large') or 'Small'
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
        ["Runeist's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Evasion"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
	
	if spell.type == 'CorsairShot' and player.inventory["Trump Card"] and player.inventory["Trump Card"].count < 10 then
			add_to_chat(104, 'Low on trump cards!')
	end
	
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end