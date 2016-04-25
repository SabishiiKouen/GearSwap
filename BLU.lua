-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('Mote-Utility.lua')
end
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
     
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
 
 
    blue_magic_maps = {}
     
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
     
    -- Physical Spells --
     
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }
 
    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }
 
    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave','Sweeping Gouge','Saurian Slide'
    }
         
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive',
    }
         
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
         
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Sudden Lunge','Wild Oats'
    }
 
    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }
 
    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }
 
    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }
 
    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }
     
     
    -- Magical Spells --
 
    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Crashing Thunder','Cursed Sphere',
        'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb','Crashing Thunder','Nectarous Deluge','Molting Plumage','Silent Storm',
		'Searing Tempest','Spectral Floe','Scouring Spate','Anvil Lightning','Entomb','Tearing Gust','Cesspool'
    }
	
	blue_magic_maps.MagicalDarkness = S{
		'Evryone. Grudge','Tenebral Crush','Palling Salvo','Dark Orb','Death Ray'
	}
	
	blue_magic_maps.MagicalLight = S{
		'Diffusion Ray','Rail Cannon','Blinding Fulgor'
	}
    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Magic Hammer','Mind Blast'
    }
 
    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }
 
    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }
 
    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
             
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn','Cruel Joke'
    }
 
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }
 
    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
         
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
     
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Atra. Libations','Blood Drain','Blood Saber','Carcharian Verve','Diamondhide','Digest','Filamented Hold','Magic Barrier','Metallic Body','MP Drainkiss','Nat. Meditation','Occultation','Orcish Counterstance','Pyric Bulwark','Osmosis',}
 
    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle','Mighty Guard'
    }
     
     
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Crashing Thunder',
        'Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar','Pyric Bulwark','Thunderbolt',
        'Tourbillion','Uproot','Mighty Guard','Cruel Joke','Cesspool','Tearing Gust'
    }
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Learning')
    state.WeaponskillMode:options('Normal','Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal','PDT')
 
    --gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
 
    -- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
 
    update_combat_form()
    --select_default_macro_book()
end
 
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end
 
 
-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +1"}
    sets.buff['Chain Affinity'] = {head="Hashishin Kavuk +1",feet="Assimilator's Charuqs +1"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh +1"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah +1"}
    sets.buff.Efflux = {back="Rosmerta's Cape",legs="Hashishin Tayt +1"}
 
     
    -- Precast Sets
     
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Luhlaza Bazubands +1"}
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Mavi Tathlum",
        head="Telchine Cap",neck="Phalaina Locket",ear1="Lifestorm Earring",ear2="Beatific Earring",
        body="Vrikodara jupon",hands="Telchine Gloves",ring1="Leviathan Ring",ring2="Kunaji Ring",
        back="Solemnity Cape",waist="Chuq'aba Belt",legs="Telchine Braconi",feet="Rawhide Boots"}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
	sets.precast.JA['Lunge'] = {ammo="Ghastly Tathlum",
        head="Amalric Coif",neck="Sanctity Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Cornflower Cape",waist="Yamabuki-no-obi",legs="Amalric Slops",feet="Amalric Nails"}
	
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']	
		
    -- Fast cast sets for spells
     
    sets.precast.FC = {ammo="Sapience Orb", head="Amalric Coif",neck="Voltsurge Torque",ear1="Loquac. Earring",ear2="Enchanter Earring +1",
		body="Taeon Tabard",hands="Leyline Gloves",back="Swith Cape +1",ring1="Weather. Ring",ring2="Prolix Ring", waist="Witful Belt",legs="Enif Cosciales",feet="Carmine Greaves"}
         
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
     
    sets.precast.FC['Ninjutsu'] = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Cheruksi needle",
		head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal earring",
		body="Herculean Vest",hands="Adhemar Wristbands",ring1="Ifrit Ring",ring2="Spiral ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"}
     
    sets.precast.WS.acc = set_combine(sets.precast.WS, {hands={ name="Herculean Gloves", augments={'Accuracy+23 Attack+23','Crit.hit rate+4','STR+4','Attack+13',}},})
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
     
    sets.precast.WS['Chant du Cygne'] = {ammo="Falcon Eye",
		head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal earring",
		body="Herculean Vest", hands={ name="Herculean Gloves", augments={'Accuracy+23 Attack+23','Crit.hit rate+4','STR+4','Attack+13',}},
		ring1="Begrudging Ring",ring2="Epona's Ring",
		back="Rosmerta's Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"}
     
    sets.precast.WS['Expiacion'] = {ammo="Cheruksi needle",
		head="Dampening Tam",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara earring",
		body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Epona's ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"}
     
    sets.precast.WS['Requiescat'] = {ammo="Cheruski needle",
		head="Carmine Mask +1",neck="Fotia Gorget",ear1="Moonshade earring",ear2="Brutal earring",
        body="Carmine Mail",hands="Carmine Finger Gauntlets",ring1="Epona's ring",ring2="Leviathan Ring",
		back="Bleating Mantle",waist="Fotia belt",legs={ name="Telchine Braconi", augments={'Accuracy+12 Attack+12','"Dbl.Atk."+3','STR+4 MND+4',}},feet="Carmine Greaves"}
    
    sets.precast.WS['Sanguine Blade'] = {ammo="Cheruski needle",
        head="Pixie Hairpin +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric gages",ring1="Shiva Ring +1",ring2="Archon Ring",
        back="Cornflower Cape",waist="Fotia belt",legs="Amalric Slops",feet="Amalric Nails"}
     
    sets.precast.WS['Flash Nova'] = {ammo="Cheruski needle",
        head="Amalric Coif",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric gages",ring1="Shiva Ring +1",ring2="Weatherspoon Ring",
        back="Cornflower Cape",waist="Fotia Belt",legs="Gyve Trousers",feet="Amalric Nails"}
	
	sets.precast.WS['Realmrazer'] = {ammo="Cheruski needle",
		head="Carmine Mask +1",neck="Fotia Gorget",ear1="Moonshade earring",ear2="Brutal earring",
        body="Carmine Mail",hands="Carmine Finger Gauntlets",ring1="Leviathan's Ring",ring2="Leviathan Ring",
		back="Bleating Mantle",waist="Fotia belt",legs={ name="Telchine Braconi", augments={'Accuracy+12 Attack+12','"Dbl.Atk."+3','STR+4 MND+4',}},feet="Carmine Greaves"}
     
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Sapience Orb",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Loquacious Earring",ear2="Enchanter Earring +1",
        body="Taeon Tabard",hands="Hashishin Bazubands",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Carmine Cuisses +1",feet="Carmine Greaves"}
         
    sets.midcast['Blue Magic'] = {}
     
    -- Physical Spells --
     
    sets.midcast['Blue Magic'].Physical = {ammo="Cheruski Needle",
        head="Dampening Tam",neck="Caro Necklace",ear1="Flame Pearl",ear2="Flame Pearl",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Ifrit Ring",
        back="Cornflower Cape",waist="Latria Belt",legs="Samnuha Tights",feet="Assimilator's Charuqs +1"}
 
    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Falcon eye",
        head="Dampening Tam",neck="Caro Necklace",ear1="Zannaroi Earring",ear2="Cessance Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Patricius Ring",
        back="Letalis Mantle",waist="Olseni Belt",legs="Samnuha Tights",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
 
    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Adhemar Jacket"})
 
    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Falcon Eye",body="Adhemar Jacket",
		ring1="Ramuh Ring", ring2="Ramuh Ring +1", waist="Chaac Belt"})
 
    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Adhemar Jacket"})
 
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Mavi Tathlum",
        head="Lithelimb Cap",neck="Caro Necklace",ear1="Zannaroi Earring",ear2="Cessance Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Garuda Ring",ring2="Garuda Ring",
        back="Cornflower Cape",legs="Hashishin Tayt +1",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},})
 
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Psystorm Earring",body="Adhemar Jacket",
         ring1="Shiva Ring +1",ring2="Shiva Ring +1",back="Cornflower Cape",feet="Hashishin Basmak +1"})
 
    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Lifestorm Earring",ring1="Leviathan Ring",ring2="Leviathan Ring"})
 
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {waist="Chaac Belt"})
 
    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)
 
 
    -- Magical Spells --
     
    sets.midcast['Blue Magic'].Magical = {ammo="Ghastly Tathlum",
        head="Amalric Coif",neck="Sanctity Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Cornflower Cape",waist="Yamabuki-no-obi",legs="Amalric Slops",feet="Amalric Nails"}
	
	sets.midcast['Blue Magic'].MagicalDarkness = set_combine(sets.midcast['Blue Magic'].Magical,
       {head="Pixie Hairpin +1",ring1="Archon Ring"})
	   
	sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical,
       {ring1="Weatherspoon Ring"})
     
    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
       {ring1="Weatherspoon Ring",feet="Amalric Nails"})
     
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical)        
 
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicAccuracy = {
        ammo="Hydrocera",head="Amalric Coif",neck="Sanctity Necklace",ear1="Lifestorm Earring",
		ear2="Psystorm Earring",body="Amalric Doublet",hands="Rawhide Gloves",ring1="Weatherspoon Ring",ring2="Sangoma Ring",back="Cornflower Cape",waist="Eschan Stone",
		legs="Amalric Slops",feet="Amalric Nails"}
     
    -- Breath Spells --
     
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Iqabi Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Assimilator's Jubbah +1",hands="Rawhide Gloves",ring1="K'ayres Ring",ring2="Beeline Ring",
        back="Cornflower Cape",legs="Hashishin Tayt +1",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
 
    -- Other Types --
     
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {head="Almaric Coif",waist="Eschan Stone"})
         
    sets.midcast['Blue Magic']['White Wind'] = {ammo="Hydrocera",
        head="Telchine Cap",neck="Phalaina Locket",ear1="Mendi. Earring",ear2="Lifestorm Earring",
        body="Vrikodara jupon",hands="Telchine Gloves",ring1="Leviathan Ring",ring2="Kunaji Ring",
        back="Solemnity Cape",waist="Chuq'aba Belt",legs="Gyve Trousers",feet="Telchine Pigaches"}
 
    sets.midcast['Blue Magic'].Healing = {ammo="Hydrocera",
        head="Telchine Cap",neck="Phalaina Locket",ear1="Mendi. Earring",ear2="Lifestorm Earring", 
        body="Vrikodara jupon",hands="Telchine Gloves",ring1="Leviathan Ring",ring2="Kunaji Ring",
        back="Solemnity Cape",waist="Chuq'aba Belt",legs="Gyve Trousers",feet="Telchine Pigaches"}
	
    sets.midcast['Blue Magic']['Sudden Lunge'] = {ammo="Honed Tathlum",
        head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Zennaroi Earring",ear2="Cessance Earring",
        body="Mekosuchinae Harness",hands="Leyline Gloves",ring1="Sangoma Ring",ring2="Etana Ring",
        back="Cornflower Cape",waist="Eschan Stone",legs="Hashishin Tayt +1",feet="Herculean Boots"}
     
    sets.midcast['Blue Magic']['Cannonball'] = {ammo="Honed Tathlum",
        head="Dampening Tam",neck="Caro Necklace",ear1="Zennaroi Earring",ear2="Cessance Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Ifrit Ring",
        back="Cornflower Cape",waist="Chuq'aba Belt",legs="Hashishin Tayt +1",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
         
    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Incanter's torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Assimilator's Jubbah +1",hands="Rawhide Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
        back="Cornflower Cape",waist="Witful Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
         
    sets.midcast['Blue Magic']['Atra. Libations'] = {ammo="Mavi Tathlum",
        head="Pixie Hairpin +1",neck="Incantor's torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Assimilator's Jubbah +1",hands="Rawhide Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
        back="Cornflower Cape",waist="Eschan Stone",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
 
    sets.midcast['Blue Magic'].Buff = {head="Amalric Coif",legs="Carmine Cuisses +1"}
     
    sets.midcast['Elemental Magic'] = sets.midcast['Blue Magic'].Magical
    sets.midcast['Healing Magic'] = sets.midcast['Blue Magic'].Healing 
    sets.midcast['Enfeebling Magic'] = sets.midcast['Blue Magic'].MagicAccuracy
     
    sets.midcast['Dark Magic'] = sets.midcast['Blue Magic'].MagicAccuracy
         
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
    sets.midcast.Stoneskin = {waist="Siegel Sash"}
	
	--sets.self_healing = {ring1="Kunaji Ring"}
 
    -- Sets to return to when not performing an action.
 
    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Incantor's Torque",ear1="Cessance Earring",ear2="Ethereal Earring",
        body="Assimilator's Jubbah +1",hands="Assimilator's Bazubands +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Cornflower Cape",waist="Flume Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
         
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Resting sets
    sets.resting = {}
     
    -- Idle sets
    sets.idle = {ammo="Ginsen",
        head="Rawhide Mask",neck="Sanctity Necklace",ear1="Infused Earring",ear2="Ethereal Earring",
        body="Mekosuchinae Harness",hands={ name="Herculean Gloves", augments={'Pet: Accuracy+4 Pet: Rng. Acc.+4','Pet: INT+6','"Refresh"+1','Accuracy+2 Attack+2',}},ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist="Flume Belt",legs="Carmine Cuisses +1",
		feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}

	sets.idle.PDT = {ammo="Ginsen",
        head="Rawhide Mask",neck="Twilight Torque",ear1="Cessance Earring",ear2="Ethereal Earring",
        body="Mekosuchinae Harness",hands="Umuthi Gloves",ring1="Patricius ring",ring2="Defending Ring",back="Solemnity Cape",
        waist="Flume Belt",legs={ name="Herculean Trousers", augments={'Accuracy+22 Attack+22','"Store TP"+1','STR+6','Accuracy+10',}},
		 feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}
 
 
    sets.idle.Learning = set_combine(sets.idle, sets.Learning)
 
     
    -- Defense sets
    sets.defense.PDT = {ammo="Ginsen",
        head="Lithelimb Cap",neck="Twilight Torque",ear1="Cessance Earring",ear2="Ethereal Earring",
        body="Emet Harness",hands="Umuthi Gloves",ring1="Patricius Ring",ring2="Defending Ring",back="Solemnity Cape",
        waist="Flume Belt",legs={ name="Herculean Trousers", augments={'Accuracy+22 Attack+22','"Store TP"+1','STR+6','Accuracy+10',}},
		feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
     
    sets.defense.MDT = {}
     
    --sets.Kiting = {waist="Chaac Belt"}
    sets.Kiting = {back="Mecistopins Mantle"}
    --sets.Kiting = {neck="Adoulin's Refuge +1"}
     
     
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    -- M.Accuracy = Eosuchus Club
    -- Normal = Buramenk'ah
    -- Nuking = Bolelabunga
    sets.engaged = {ammo="Ginsen",
        head="Dampening Tam",neck="Lissome Necklace",ear1="Cessance Earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Windbuffet Belt +1",legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
    sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Carmine Mask +1",neck="Sanctity Necklace", ear1="Zennaroi Earring",ear2="Cessance Earring",
		body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Ramuh ring +1",ring2="Cacoethic Ring +1",
		back="Rosmerta's Cape",waist="Kentarch Belt",legs="Carmine Cuisses +1",
		feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
	sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
--	sets.engaged.PDT = {ammo="Ginsen",
--        head="Lithelimb Cap",neck="Twilight Torque",ear1="Tripudio Earring",ear2="Ethereal Earring",
--        body="Emet Harness",hands="Umuthi Gloves",ring1="Patricius ring",ring2="Dark Ring",back="Repulse Mantle",
--        waist="Flume Belt",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
-- Cancel Buffs Section
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
 
-- Unbridled Learning
function filtered_action(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not buffactive['Unbridled Learning'] then
        cancel_spell()
        send_command('input /ja "Unbridled Learning" <me>;wait 1;input /ma "'..spell.english..'" '..spell.target.name)
    end
end
 
 
-- Run after the default midcast() is done.
function job_aftercast(spell)
    if not spell.interrupted then  
        if (spell.english == "Dream Flower")
        then -- Sleep Countdown --
            send_command('wait 75;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        end
    end
end
 
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end
 
     
    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
	buff = string.lower(buff)
    if buff == "aftermath: lv.3" then -- AM3 Timer --
        if gain then
            send_command('timers create "Aftermath: Lv.3" 180 down AM3.png;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
        else
            send_command('timers delete "Aftermath: Lv.3"')
            add_to_chat(123,'AM3: [OFF]')
        end
    end
	
    --if buff == "Nat. Meditation ID" then -- ATK Boost Timer --
        --if gain then
            --send_command('timers create "Nat. Meditation commands here with 10 sec remain /echo Nat. Meditation[10s Remaining]' )
        --else
            --send_command('timers delete "Nat. Meditation ID"')
            --add_to_chat(123,'Nat. Meditation[OFF]')
        --end
    --end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end
 
 
-- Select default macro book on initial load or subjob change.
--function select_default_macro_book()
    -- Default macro set/book
--    if player.sub_job == 'DNC' then
--        set_macro_page(2, 4)
--    else
--        set_macro_page(1, 4)
--    end
--end