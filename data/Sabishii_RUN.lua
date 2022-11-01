-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    -- Icons for custom timers for Runes.
    runes.icons = {
        ['Ignis'] = 'spells/00288.png',
        ['Gelus'] = 'spells/00289.png',
        ['Flabra'] = 'spells/00290.png',
        ['Tellus'] = 'spells/00291.png',
        ['Sulpor'] = 'spells/00292.png',
        ['Unda'] = 'spells/00293.png',
        ['Lux'] = 'spells/00294.png',
        ['Tenebrae'] = 'spells/00295.png'
    }
	
	-- Table of entries
    rune_timers = T{}
    entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end

	blue_magic_maps = {}

	blue_magic_maps.Enmity = S{
        'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific', 'Poison Breath', 'Blitzstrahl',
		'Sheep Song', 'Chaotic Eye', 'Soporific'
    }
	blue_magic_maps.Cure = S{
        'Wild Carrot', 'Healing Breeze'
    }
	blue_magic_maps.Buffs = S{
		'Cocoon', 'Refueling', 'Metallic Shell'
	}
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'DD', 'Acc', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Regen', 'Refresh')
	
	state.Runes = M{['description']='Runes', "Tellus","Unda","Flabra","Ignis","Gelus","Sulpor","Lux","Tenebrae"}
	
	send_command('bind ^` input //gs c cycle Runes')
	send_command('bind !` input /ja "Vivacious Pulse" <me>')
	send_command('bind @` input //gs c rune')
	--select_default_macro_book()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end


function init_gear_sets()
    sets.enmity = {ammo="Sapience Orb", head="Halitus Helm", body="Emet Harness +1", ear1="Friomisi Earring", ear2="Cryptic Earring", legs="Erilaz Leg Guards +2",
			ring1="Pernicious Ring", ring2="Petrov Ring", hands="Kurys Gloves",back={ name="Ogma's cape", augments={'Enmity+10',}},feet="Erilaz Greaves +2"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist coat +3", legs="Futhark trousers +2", back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Store TP"+10','Damage taken-5%',}},}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist Boots +2"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +3"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +3"}
    sets.precast.JA['Lunge'] = {ammo="Seeth. Bomblet +1",
		head="",
		body="Cohort Cloak +1",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Ethereal Earring",
		right_ear="Friomisi Earring",
		left_ring="Shiva Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back="Evasionist's Cape",}
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +2"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +3"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {back="Evasionist's Cape"}
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +2", neck="Incanter's Torque", legs="Runeist Trousers +3"}
    sets.precast.JA['One For All'] = sets.enmity
    sets.precast.JA['Provoke'] = sets.enmity

	-- Fast cast sets for spells
	sets.precast.FC = {ammo="Staunch Tathlum +1",
		head="Rune. Bandeau +3",
		body="Erilaz Surcoat +2",
		hands="Nyame Gauntlets",
		legs={ name="Futhark Trousers +2", augments={'Enhances "Inspire" effect',}},
		feet={ name="Carmine Greaves", augments={'Accuracy+10','DEX+10','MND+15',}},
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'"Fast Cast"+10','Damage taken-5%',}}
	}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {head="Erilaz Galea +2", waist="Siegel Sash", legs="Futhark Trousers +2",})
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {body="Passion Jacket",})
    sets.precast.FC['Utsusemi: Ni'] = sets.precast.FC['Utsusemi: Ichi']


	-- Weaponskill sets
	sets.precast.WS = {ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','Weapon skill damage +10%','Damage taken-5%',}},}
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",   
		left_ring="Epona's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	})
    sets.precast.WS['Resolution'].Acc = sets.precast.WS['Resolution']
    sets.precast.WS['Dimidiation'] = sets.precast.WS
    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']
	sets.precast.WS['Fell Cleave'] = sets.precast.WS['Resolution']
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS['Lunge'], {head="Pixie Hairpin +1", ring1="Archon Ring"})
	sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Resolution']
	sets.precast.WS['Savage Blade'] = sets.precast.WS['Dimidation']
	sets.precast.WS['Ground Strike'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Spinning Slash'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Requiescat'] = sets.precast.WS


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}

    sets.midcast['Enhancing Magic'] = {head="Erilaz Galea +2", neck="Incanter's Torque", hands="Runeist's Mitons +2", legs="Carmine Cuisses +1", waist="Siegel Sash", legs="Futhark Trousers +2"}
	sets.midcast.Temper = sets.midcast['Enhancing Magic']
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Taeon Tabard", augments={'Accuracy+20 Attack+20','Potency of "Cure" effect received+7%','Phalanx +3',}},
		hands="Regal Gauntlets",
		legs={ name="Taeon Tights", augments={'Potency of "Cure" effect received+7%','Phalanx +2',}},
		feet={ name="Herculean Boots", augments={'Enmity+2','DEX+6','Phalanx +4','Accuracy+16 Attack+16','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},})
    sets.midcast.Regen = {neck="Incanter's torque", head="Runeist's Bandeau +3",hands="Regal Gauntlets",neck="Sacro Gorget",legs="Futhark Trousers +2"}
    sets.midcast.Stoneskin = {neck="Incanter's torque", waist="Siegel Sash"}
    sets.midcast.Cure = {neck="Phalaina Locket", feet="Futhark Boots +2"}
	sets.midcast.Flash = sets.enmity
	sets.midcast['Blue Magic'] = {}
	sets.midcast['Blue Magic'].Enmity = set_combine(sets.enmity, {head="Erilaz Galea +2", neck="Loricate Torque +1", hands="Regal Gauntlets",})
	sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
	sets.midcast['Blue Magic'].Buffs = sets.midcast['Enhancing Magic']
	sets.midcast.Foil = sets.enmity
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	sets.Kiting = {back="Carmine Cuisses +1"}
    sets.idle = {ammo="Staunch Tathlum +1",
        head="Turms Cap +1",
		body="Futhark Coat +3",
		hands="Turms Mittens +1",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Turms Leggings +1",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Ethereal Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Store TP"+10','Damage taken-5%',}},
	}
    sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +3",})
           
	sets.defense.PDT = set_combine(sets.idle, {hands="Nyame Gauntlets", legs="Nyame Flanchard", feet="Erilaz Greaves +2"})

	sets.defense.MDT = {}

	sets.Kiting = {legs="Carmine Cuisses +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Staunch Tathlum +1",
		head="Futhark Bandeau +3", neck="Loricate Torque +1", ear1="Etheral Earring", ear2="Odnowa Earring +1",
        body="Futhark Coat +3", hands="Turms Mittens +1", ring1="Defending Ring", ring2="Moonbeam Ring",
        back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Store TP"+10','Damage taken-5%',}},
		waist="Flume Belt +1", legs="Erilaz Leg Guards +2",feet="Erilaz Greaves +2"}
    sets.engaged.DD = {ammo="Aurgelmir Orb +1",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Ashera Harness",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
		neck="Anu Torque",
		waist="Flume Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Moonbeam Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Store TP"+10','Damage taken-5%',}},}
    sets.engaged.Acc = sets.engaged.DD
    sets.engaged.PDT = sets.defense.PDT
    sets.engaged.MDT = sets.defense.MDT
    sets.engaged.repulse = {back="Repulse Mantle"}

end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
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
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
	
end


function job_aftercast(spell)
--    if not spell.interrupted then
--        if spell.type == 'Rune' then
--            update_timers(spell)
--        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
--            reset_timers()
--        elseif spell.name == "Swipe" then
--            send_command(trim(1))
--        end
--    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
--function select_default_macro_book()
	-- Default macro set/book
--	if player.sub_job == 'WAR' then
--		set_macro_page(3, 20)
--	elseif player.sub_job == 'NIN' then
--		set_macro_page(1, 20)
--	elseif player.sub_job == 'SAM' then
--		set_macro_page(2, 20)
--	else
--		set_macro_page(5, 20)
--	end
--end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
    local expires_time = os.time() + 300
	local entry_index = rune_count(spell.name) + 1

    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

    rune_timers:append(entry)
	local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
    cmd_queue = cmd_queue .. trim()

    add_to_chat(123,'cmd_queue='..cmd_queue)

    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) ..'"'
    local duration = entry.expires - os.time()
    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down ' .. runes.icons[entry.rune]
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
    local cmd_queue = ''
    for index,entry in pairs(rune_timers) do
        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
    end
    rune_timers:clear()
    send_command(cmd_queue)
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
    local count = 0
    local current_time = os.time()
    for _,entry in pairs(rune_timers) do
        if entry.rune == rune and entry.expires > current_time then
            count = count + 1
        end
    end
    return count
end

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
    local cmd_queue = ''

    local to_remove = n or (rune_timers:length() - max_runes)

    while to_remove > 0 and rune_timers:length() > 0 do
		local oldest
        for index,entry in pairs(rune_timers) do
            if oldest == nil or entry.expires < rune_timers[oldest].expires then
                oldest = index
            end
        end
        
        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
        to_remove = to_remove - 1
    end
    
    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
    local cmd_queue = ''
    
    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
            entry.index = entry.index - 1
        end
    end

    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            if entry.index == 0 then
                rune_timers[index] = nil
            else
                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
            end
        end
    end
    
    return cmd_queue
end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
    if gearswap.res.statuses[new].english == 'Dead' then
        reset_timers()
    end
end)