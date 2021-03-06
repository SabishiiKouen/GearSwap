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
--    runes.icons = {
  --      ['Ignis'] = 'spells/00288.png',
 --       ['Gelus'] = 'spells/00289.png',
   --     ['Flabra'] = 'spells/00290.png',
     --   ['Tellus'] = 'spells/00291.png',
       -- ['Sulpor'] = 'spells/00292.png',
        --['Unda'] = 'spells/00293.png',
        --['Lux'] = 'spells/00294.png',
        --['Tenebrae'] = 'spells/00295.png'
--    }
	
	-- Table of entries
    --rune_timers = T{}
    -- entry = rune, index, expires
    
--    if player.main_job_level >= 65 then
--        max_runes = 3
--    elseif player.main_job_level >= 35 then
--        max_runes = 2
--    elseif player.main_job_level >= 5 then
--        max_runes = 1
--    else
--        max_runes = 0
--    end

	blue_magic_maps = {}

	blue_magic_maps.Enmity = S{
        'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific', 'Poison Breath', 'Blitzstrahl',
		'Sheep Song', 'Chaotic Eye'
    }
	blue_magic_maps.Cure = S{
        'Wild Carrot'
    }
	blue_magic_maps.Buffs = S{
		'Cocoon', 'Refueling'
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
    sets.enmity = {ammo="Sapience Orb", head="Rabid Visor", neck="Unmoving Collar", body="Emet Harness", ear1="Friomisi Earring", ear2="Cryptic Earring", 
			ring1="Pernicious Ring", ring2="Petrov Ring", hands="Kurys Gloves",back="Evasionist's Cape"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers +1"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {ammo="Ghastly Tathlum", head="Herculean Helm", neck="Sanctity Necklace", ear1="Hectate's Earring", ear2="Friomisi Earring",
            body="Samnhua Coat", hands="Leyline Gloves", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
            back="Evasionist's Cape", waist="Yamabuki-no-obi", legs="Limbo Trousers",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat 1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {back="Evasionist's Cape"}
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1", neck="Incanter's Torque", legs="Runeist Trousers"}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity

	-- Fast cast sets for spells
    sets.precast.FC = {ammo="Sapience Orb",
            head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Loquacious Earring",ear2="Enchanter's Earring +1",
            body="Taeon Tabard",hands="Leyline gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
            feet="Carmine Greaves"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
    sets.precast.FC['Utsusemi: Ni'] = sets.precast.FC['Utsusemi: Ichi']


	-- Weaponskill sets
	sets.precast.WS = {ammo="Falcon Eye",
		head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal earring",
		body="Herculean Vest",hands="Adhemar Wristbands",ring1="Ifrit ring",ring2="Iftit Ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Adhemar gamashes"}
    sets.precast.WS['Resolution'] = {ammo="Falcon Eye",
		head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal earring",
		body="Herculean Vest",hands="Adhemar Wristbands",ring1="Ifrit ring",ring2="Iftit Ring",
		back="Buquwik Cape",waist="Fotia Belt",legs="Samnuha Tights",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], 
        {ammo="Honed Tathlum", body="Herculean Vest", hands="Adhemar Wristbands", back="Evasionist's Cape", legs="Taeon Tights"})
    sets.precast.WS['Dimidiation'] = {ammo="Falcon Eye",
		head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal earring",
		body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Ramuh ring +1",ring2="Epona's Ring",
		back="Rancorous mantle",waist="Fotia Belt",legs="Samnuha Tights",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], 
        {ammo="Honed Tathlum", head="Dampening Tam",back="Evasionist's Cape"})
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS["Resolution"], {ear2="Ishvara earring"})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'], {legs="Herculean Trousers"})
	sets.precast.WS['Fell Cleave'] = sets.precast.WS['Resolution']
	sets.precast.WS['Sanguine Blade'] = {head="Pixie Hairpin +1", neck="Sanctity Necklace", ear1="Hectate's Earring", ear2="Friomisi Earring",
            body="Samnhua Coat", hands="Leyline Gloves", ring1="Archon Ring", ring2="Shiva Ring +1",
            back="Evasionist's Cape", waist="Yamabuki-no-obi", legs="Limbo Trousers",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
	sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Resolution']
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Resolution'], {ear2="Ishvara earring"})
	sets.precast.WS['Requiescat'] = {ammo="Falcon Eye",
		head="Carmine Mask +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal earring",
		body="Carmine Mail",hands="Carmine Finger Gauntlets",ring1="Leviathan Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Carmine Cuisses +1",feet="Carmine Greaves"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}

    sets.midcast['Enhancing Magic'] = {head="Erilaz Galea +1", neck="Incanter's Torque", hands="Runeist Mitons +1", legs="Carmine Cuisses +1", waist="Siegel Sash", legs="Futhark Trousers +1"}
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast['Regen'] = {neck="Incanter's torque", head="Runeist Bandeau +1", legs="Futhark Trousers +1"}
    sets.midcast['Stoneskin'] = {neck="Incanter's torque", waist="Siegel Sash"}
    sets.midcast.Cure = {neck="Phalaina Locket", hands="Buremte Gloves", ring1="Ephedra Ring", feet="Futhark Boots +1"}
	
	sets.midcast['Blue Magic'] = {}
	sets.midcast['Blue Magic'].Enmity = sets.enmity
	sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
	sets.midcast['Blue Magic'].Buffs = sets.midcast['Enhancing Magic']
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {ammo="Ginsen",
        head="Rawhide Mask",neck="Sanctity Necklace",ear1="Infused Earring",ear2="Ethereal Earring",
        body="Futhark Coat +1",hands={ name="Herculean Gloves", augments={'Pet: Accuracy+4 Pet: Rng. Acc.+4','Pet: INT+6','"Refresh"+1','Accuracy+2 Attack+2',}},ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}
    sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +1", waist="Fucho-no-obi"})
           
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {feet="Carmine Cuisses +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Falcon Eye",
            head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Etheral Earring", ear2="Zennaroi Earring",
            body="Erilaz Surcoat +1", hands="Kurys Gloves", ring1="Defending Ring", ring2="Patricius Ring",
            back="Solemnity Cape", waist="Kentarch Belt", legs="Herculean Trousers",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
    sets.engaged.DD = {ammo="Ginsen",
        head="Dampening Tam",neck="Lissome Necklace",ear1="Cessance Earring",ear2="Zennaroi Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Evasionist's Cape",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
    sets.engaged.Acc = set_combine(sets.engaged.DD, {ammo="Falcon Eye",
            neck="Iqabi Necklace", hands="Adhemar Wristbands", waist="Kentarch Belt", legs="Herculean Trousers"})
    sets.engaged.PDT = {ammo="Falcon Eye",
            head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Zennaroi Earring",
            body="Erilaz Surcoat +1", hands="Kurys Gloves", ring1="Defending Ring", ring2="Patricius Ring",
            back="Solemnity Cape", waist="Flume Belt", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"}
    sets.engaged.MDT = {ammo="Falcon Eye",
            head="Dampening Tam", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Zennaroi Earring",
            body="Erilaz Surcoat +1", hands="Kurys Gloves", ring1="Defending Ring", ring2="Archon Ring",
            back="Solemnity Cape", waist="Flume Belt", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"}
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
--    local expires_time = os.time() + 300
--    local entry_index = rune_count(spell.name) + 1

--    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

--    rune_timers:append(entry)
--    local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
--    cmd_queue = cmd_queue .. trim()

--    add_to_chat(123,'cmd_queue='..cmd_queue)

--    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
--    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) ..'"'
--    local duration = entry.expires - os.time()
--    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down ' .. runes.icons[entry.rune]
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
--    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
--    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
--    local cmd_queue = ''
--    for index,entry in pairs(rune_timers) do
--        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
--    end
--    rune_timers:clear()
--    send_command(cmd_queue)
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
--    local count = 0
--    local current_time = os.time()
--    for _,entry in pairs(rune_timers) do
--        if entry.rune == rune and entry.expires > current_time then
--            count = count + 1
--        end
--    end
--    return count
end

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
--    local cmd_queue = ''
--
--    local to_remove = n or (rune_timers:length() - max_runes)

--    while to_remove > 0 and rune_timers:length() > 0 do
--        local oldest
--        for index,entry in pairs(rune_timers) do
--            if oldest == nil or entry.expires < rune_timers[oldest].expires then
--                oldest = index
--            end
--        end
        
--        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
--        to_remove = to_remove - 1
--    end
    
--    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
--    local cmd_queue = ''
    
--    for index,entry in pairs(rune_timers) do
--        if entry.rune == rune then
--            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
--            entry.index = entry.index - 1
--        end
--    end

--    for index,entry in pairs(rune_timers) do
--        if entry.rune == rune then
--            if entry.index == 0 then
--                rune_timers[index] = nil
--            else
--                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
--            end
--        end
--    end
    
--    return cmd_queue
end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

--windower.raw_register_event('zone change',reset_timers)
--windower.raw_register_event('logout',reset_timers)
--windower.raw_register_event('status change',function(new, old)
--    if gearswap.res.statuses[new].english == 'Dead' then
--        reset_timers()
--    end
--end





